#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Prozessor

Der Prozessor und Speicher sind getrennt und sind durch einen Speicherbus
verbunden. Dieser umfasst:

/ Adressbus: enthält Adresse der Speicherzelle, auf die zugegriffen werden soll
/ Datenbus: enthält Daten, die aus Speicherzelle gelesen wurde bzw. in diese geschrieben werden soll
/ Steuersignale: die z.B. angeben, ob gelesen oder geschrieben werden soll

#table(
  columns: (50%, 50%),
  [Schreibvorgang], [Lesevorgang],
  [
    + Prozessor legt Adresse auf Adressbus
    + Prozessor legt Daten auf Datenbus
    + Prozessor aktiviert Speicherbus zum Schreiben
  ],
  [
    + Prozessor legt Adresse auf Adressbus
    + Prozessor aktiviert Speicherbus zum Lesen
    + Speicher legt Daten auf Datenbus
  ],
)

- Jeder Prozessor enthält eine kleine Menge an Speicher: die _Register_
- Jeder Prozessor besteht aus vielen kleinen Bausteinen, die jeweils eine
  _Operation_ durchführen können
  - Operationen können Register und/oder den Speicherbus lesen und/oder schreiben
  - Operationen können 0 bis n Operanden (Register, Adressen, Daten) haben
  - Die Anzahl und Art von Operationen ist immer prozessor-spezifisch, aber auf den meisten Prozessoren ähnlich

== Instruktionen

Eine _Instruktion_ ist die Kombination einer Operation mit Operanden, z.B.
"Kopiere Wert aus Register x in Register y". #todo(box[```asm
mov x y
```])

=== Codierung

Operationen und Register werden durchnummeriert. Gemeinsam mit Daten- und/oder
Adressoperanden ergibt sich eine Bytesequenz.

#exbox(
  title: ["Addiere 12345678#sub[h] zu Register 1" auf Intel 64 Architektur],
  grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: colors.black,
    inset: .5em,
    gutter: 0pt,
    [Byte 0], [Byte 1], [Byte 2], [Byte 3], [Byte 4], [Byte 5],
    ..(
      [81],
      [C1],
      [78],
      [56],
      [34],
      [12],
    ).map(x => grid.cell(fill: colors.comment, text(size: 1.5em)[#x#sub[h]])),
    grid.cell(colspan: 2, [Opcode]),
    grid.cell(colspan: 4, [12345678#sub[h]]),
  ),
)

Die Gesamtheit aller möglichen (binären) Instruktionscodes eines Prozessors
(Maschine) ist sein Maschinencode und wird vom Hersteller festgelegt.

=== Sequenzen

Die Sequenzen der Instruktionen können an mehreren Orten liegen:
- Hart-codiert im Prozessor: Sequenz kann nach Produktion des Prozessors nie geändert werden
- Im Hauptspeicher: Sequenz kann beliebig geändert werden, muss über den
  Speicherbus abgefragt werden

Der Prozessor hat ein spezielles Register, das die Adresse des nächsten Befehls
im Hauptspeicher enthält (Befehlszeiger / _instruction pointer_ IP / _program counter_ PC).

=== Takt / Zyklus

Der gesamte Computer ist getaktet: Alle Bausteine (auch im Prozessor, im Speicher etc) erhalten ein Takt-Signal (_Clock_)

Über mehrere Takte hinweg führt der Prozessor folgende Schritte aus (_Zyklus_):
+ Prozessor fordert Instruktion ab der Adresse an, die im Befehlszeiger steht
+ Prozessor decodiert Operation und Operanden aus Instruktion
+ Prozessor wählt mit Operation korrespondierenden Baustein aus
+ Aktiver Baustein liest ggf. aus den Registern
+ Aktiver Baustein führt ggf. Berechnung aus
+ Aktiver Baustein schreibt ggf. in die Register
+ Prozessor erhöht Befehlszeiger entsprechend der Länge der Instruktion
Diese Schritte können stark parallelisiert werden (_Pipelining_)
