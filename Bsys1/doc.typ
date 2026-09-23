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
/ Datenbus: enthält Daten, die aus Speicherzelle gelesen wurde bzw. in diese
  geschrieben werden soll
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
  - Operationen können Register und/oder den Speicherbus lesen und/oder
    schreiben
  - Operationen können 0 bis n Operanden (Register, Adressen, Daten) haben
  - Die Anzahl und Art von Operationen ist immer prozessor-spezifisch, aber auf
    den meisten Prozessoren ähnlich

== Instruktionen

Eine _Instruktion_ ist die Kombination einer Operation mit Operanden, z.B.
"Kopiere Wert aus Register x in Register y". #box[```asm mov y, x ```]

=== Codierung

Operationen und Register werden durchnummeriert. Gemeinsam mit Daten- und/oder
Adressoperanden ergibt sich eine Bytesequenz.

#exbox(
  title: ["Addiere 12345678#sub[h] zu Register 1" auf Intel 64 Architektur],

  bytes-tbl(
    big-endian: false,
    smol-byte: false,
    show-addr: false,
    [12],
    [34],
    [56],
    [78],
    [C1],
    [81],
    extra: (
      grid.cell(colspan: 2, [Opcode]),
      grid.cell(colspan: 4, [12345678#sub[h]]),
    ),
  ),
)

Die Gesamtheit aller möglichen (binären) Instruktionscodes eines Prozessors
(Maschine) ist sein Maschinencode und wird vom Hersteller festgelegt.

=== Sequenzen

Die Sequenzen der Instruktionen können an mehreren Orten liegen:
- Hart-codiert im Prozessor: Sequenz kann nach Produktion des Prozessors nie
  geändert werden
- Im Hauptspeicher: Sequenz kann beliebig geändert werden, muss über den
  Speicherbus abgefragt werden

Der Prozessor hat ein spezielles Register, das die Adresse des nächsten Befehls
im Hauptspeicher enthält (Befehlszeiger / _instruction pointer_ IP / _program
counter_ PC).

=== Takt / Zyklus

Der gesamte Computer ist getaktet: Alle Bausteine (auch im Prozessor, im
Speicher etc) erhalten ein Takt-Signal (_Clock_)

Über mehrere Takte hinweg führt der Prozessor folgende Schritte aus (_Zyklus_):
+ Prozessor fordert Instruktion ab der Adresse an, die im Befehlszeiger steht
+ Prozessor decodiert Operation und Operanden aus Instruktion
+ Prozessor wählt mit Operation korrespondierenden Baustein aus
+ Aktiver Baustein liest ggf. aus den Registern
+ Aktiver Baustein führt ggf. Berechnung aus
+ Aktiver Baustein schreibt ggf. in die Register
+ Prozessor erhöht Befehlszeiger entsprechend der Länge der Instruktion
Diese Schritte können stark parallelisiert werden (_Pipelining_)

= Maschinencode

Intel 64 Prozessoren basieren auf einer Little-Endian-Architektur. Es gibt 2
Modi: 32 Bit (Legacy) und 64 Bit, befassen uns hier aber nur mit 64 Bit.

== Intel Terminologie

#deftbl(
  [Byte],
  [8 Bit],
  [Word],
  [2 Byte / 16 Bit],
  [Doubleword],
  [4 Byte / 32 Bit, auch DWord],
  [Quadword],
  [8 Byte / 64 Bit, auch QWord],
  [Double Quadword],
  [16 Byte / 128 Bit, auch DQWord],
)

Intel-Prozessoren verwenden als kleinste Einheiten einzelne Bytes (8 Bit). Ein
einzelnes Bit muss immer mit dem gesamten Byte verarbeitet werden. Dargestellt
werden die Bytes als 2 hexadezimale Stellen $s_0$ und $s_1$, wobei die
höherwertige Ziffer immer links steht ($s_1 s_0$).

Ein Word hat 4 hexadezimale Stellen $s_0$ bis $s_3$, wobei es üblich ist, die
Stellen *von rechts nach links* ($s_3 s_2 s_1 s_0$) zu schreiben.

== Formate

Die Bytes werden im _Big-Endian_ Format *von rechts nach links* und im
_Little-Endian_ Format *von links nach rechts* geschrieben.

#table(
  columns: (1fr, 1fr),
  table-header([Big-Endian], [Little-Endian]), bytes-tbl([CA], [FE]),
  bytes-tbl([CA], [FE], big-endian: false),
  [
    Zahlen beginnen mit dem "grossen Ende", dem _MSByte_ (Most Significant)
  ],

  [
    Zahlen beginnen mit dem "kleinen Ende", dem _LSByte_ (Least Significant)
  ],

  bytes-tbl([87], [65], [43], [21]),
  bytes-tbl([87], [65], [43], [21], big-endian: false),
)

Vorteil von Little-Endian ist, dass man ein DWord mit Nullen in den
höherwertigen Stellen als Word oder Byte mit derselben Adresse verwenden kann.

#table(
  columns: (1fr, 1fr),
  table-header([Big-Endian], [Little-Endian]),
  bytes-tbl([00], [00], [00], [56], extra: (
    grid.cell(colspan: 3, stroke: none)[],
    [Byte],
    grid.cell(colspan: 2, stroke: none)[],
    grid.cell(colspan: 2)[Word],
    grid.cell(colspan: 4)[DWord],
  )),

  bytes-tbl(
    [00],
    [00],
    [00],
    [56],
    extra: (
      [Byte],
      grid.cell(colspan: 3, stroke: none)[],
      grid.cell(colspan: 2)[Word],
      grid.cell(colspan: 2, stroke: none)[],
      grid.cell(colspan: 4)[DWord],
    ),
    big-endian: false,
  ),
)

= Assembler

Der Assembler ist ein Programm, das textuelle Befehle in Maschinencodes
übersetzt. Konventionen hängen massgeblich vom Hersteller des Assemblers ab,
selbst für denselben Prozessor. Wir verwenden in diesem Modul den Netwide
Assembler #link("https://www.nasm.us/xdoc/2.13.01/html/", "NASM").

== Spezifikation von Daten

#table(
  columns: (1fr, 1fr),
  table-header([Quellcode], [Resultat im Binär-Output]), ```asm db 48```,
  [das Byte `48d`], ```asm db 0x35, 0h21, 049h```,
  [die drei Byte `35h, 21h, 49h`], ```asm db 'a'```,
  [das Byte mit dem ASCII-Code von `a` = `61h`\ $equiv space$```asm db 0x61```],
  ```asm db 'Hallo'```,

  [die ASCII-Codes von `H`, `a`, `l`, `l` und `o`\
    $equiv space$```asm db 0x48, 0x61, 0x6c, 0x6c, 0x6f```],
)
Statt einzelnen Bytes können auch Words, DWords und QWords spezifiziert werden,
Endianness muss dann zwingend beachtet werden:

```asm
dw 0x2135 ; = db 0x35, 0x21
dd 0x2135 ; = db 0x35, 0x21, 0x00, 0x00
dq 0x2135 ; = db 0x35, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
```

=== Spezifikation von Zahlen

`$` Präfix auch möglich.

#table(
  columns: 3,
  [Base], [Suffix], [Präfix],
  [Hex], `H / X`, `0h / 0x`,
  [Dec], `D / T`, `0d / 0t`,
  [Oct], `Q / O`, `0q / 0o`,
  [Bin], `B / Y`, `0b / 0y`,
)

== Bits

NASM übersetzt fast jede Anweisung direkt in Binärzahlen und schreibt diese als
Sequenz von Bytes in die Zieldatei
```asm
nop           ; 90h
not rax       ; 48h F7h D0h
mov rax, rbx  ; 48h 89h D8h
```
Traditionell arbeitet der NASM im historischen 16-Bit-Modus, Operationen haben
hier andere Opcodes als im 64-Bit-Modus. Der 64-Bit-Modus wird mit der Direktive
#box(```asm BITS 64```) aktiviert (möglichst als 1. Zeile)

== Offset

Nummeriert man die Bytes in der Ausgabe-Sequenz fortlaufend, erhält jedes Byte
einen _Offset_ (Adresse, Index).

#grid(
  columns: 2,
  gutter: 2em,
  ```asm
  ...
  dd 0x12345678
  ...
  ```,
  bytes-tbl(
    big-endian: false,
    show-byte: false,
    [12],
    [34],
    [56],
    [78],
  ),
)

`$` bezeichnet den aktuellen Offset, bevor die von der aktuellen Zeile
generierten Bytes in die Ausgabe-Sequenz geschrieben werden.

```asm
db 'BSys 1?!'
dq $
; erzeugt                 42 53 79 73 20 31 3f 21 08 00 00 00 00 00 00 00
```

== Labels

Am Anfang jeder Zeile in der Quelle kann ein Label stehen, das *nicht* in
Maschinencode übersetzt wird:

```asm
my_text: db 'BSys 1?!'
current: dq current
; erzeugt auch            42 53 79 73 20 31 3f 21 08 00 00 00 00 00 00 00
```

Intern assoziiert der Assembler das Label $w$ mit dem Offset $A(w)$ des
nachfolgenden Befehls in der Ausgabedatei und ersetzt jede Verwendung von $w$ in
der Quelle durch $A(w)$ in der Ausgabe-Sequenz.

#bytes-tbl(
  show-byte: false,
  show-i-addr: false,
  columns: range(16).map(_ => 2.5em),
  [42],
  [53],
  [79],
  [73],
  [20],
  [31],
  [3f],
  [21],
  [08],
  [00],
  [00],
  [00],
  [00],
  [00],
  [00],
  [00],
  extra: (
    grid.cell(colspan: 8, align(left, ` ^ my_text`)),
    grid.cell(colspan: 8, align(left, ` ^ current`)),
  ),
)

NASM kann während der Übersetzung einfache Arithmetik ausführen:

```asm
length: dq after_my_text - my_text
my_text: db 'BSys 1?!'
after_my_text:
; erzeugt                 08 00 00 00 00 00 00 00 42 53 79 73 20 31 3f 21
```

== Flat-Form Binaries

Per default erzeugt der NASM sogenannte _Flat-Form Binaries_ (plain/pure/raw):
Die reine Bytesequenz analog zum Quell-Text ohne Zusatzinformationen.

== Objekt-Dateien

Objekt-Dateien enthalten darüber hinaus noch weitere Informationen, die später
benötigt werden, u.a. die Symboltabelle.
/ Exportierte Symbole: mit ```asm global``` deklarierte Label
/ Importierte Symbole: mit ```asm extern``` deklarierte Label, haben keinen
  definierten Wert innerhalb der Objekt-Datei
Auf 64-Bit Linux sind Objekt-Dateien im Format ELF64 mit Endung `*.o`
```sh
nasm -f elf64 prog.asm -o prog.o
```
ELF64 kann mit dem Tool `objdump` analysiert werden:
```sh
objdump -t -d -Mintel prog.o
```

=== Symboltabelle

Die Symboltabelle enthält einen Eintrag pro Symbol.

```asm
global x, y
extern z
dq 0, 0
w: dq 0x12345678
x: dq 0xCAFEFACE
y: dq z
```

#grid(
  columns: (2fr, 2.5fr, 1fr, 2fr, 1fr),
  gutter: 5pt,
  ..(
    [Offset],
    [Attribute (g)lobal, (l)ocal],
    [Sektion],
    [Zusatzinformationen],
    [Name],
  ).map(
    i => [*#i*],
  ),
  `0000000000000010`, `l`, `.text`, `0000000000000000`, `w`,
  `0000000000000000`, ` `, `*UND*`, `0000000000000000`, `z`,
  `0000000000000018`, `g`, `.text`, `0000000000000000`, `x`,
  `0000000000000020`, `g`, `.text`, `0000000000000000`, `y`,
)
Das als extern deklarierte Label `z` erscheint als `*UND*` (undefined)
