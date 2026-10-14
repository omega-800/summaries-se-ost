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

== Register

Es wird zwischen "General Purpose" und "Special Purpose" Register unterschieden.

/ General Purpose: Kann nach belieben verwendet werden
/ Special Purpose: Wird von der CPU für einen spezifischen Zweck verwendet, nur
  gewisse Operationen können darauf zugreifen.

Ursprünglich hatten Intel-Prozessoren (ab dem 8088) 16-Bit-Register, die in zwei
8-Bit-Register (`AH AL`) unterteilt wurden.

Man kann sowohl `AX` als auch `AL` oder `AH` in Instruktionen verwenden.

Mit der 32-Bit-Architektur wurden diese Register um namenlose 16-Bit erweitert
($->$ `EAX`), Mit der 64-Bit-Architektur um weitere 32-Bit ($->$ `RAX`).

Mit der ISA Erweiterung enstand aber auch eine neue Limitierung: `ah`, `bh`,
etc. können nicht in allen Situation verwendet werden.

#align(center, bytes-tbl-custom(
  [],
  [],
  [],
  [],
  [],
  [],
  [AH],
  [AL],
  extra: (
    grid.cell(colspan: 6, stroke: none)[],
    grid.cell(colspan: 2)[AX],
    grid.cell(colspan: 4, stroke: none)[],
    grid.cell(colspan: 4)[EAX],
    grid.cell(colspan: 8)[RAX],
  ),
))

=== Allzweckregister

General Purpose Registers (GPRs)

/ RAX: Accumulator, für einige Rechenoperationen das einzige mögliche Register
/ RCX: Counter für Schleifen und Stringoperationen
/ RDX: Pointer für I/O-Operationen
/ RBX: Datenpointer
/ RSI, RDI: Quell- und Zielindizes für Stringoperationen
/ RSP: Stackpointer, Adresse des allozierten Stacks
/ RBP: Basepointer, Basis des Stackframe der Funktion
/ R8 - R15: Zusätzliche Register

*Wichtig:* Die Verwendungszwecke sind reine Konvention und nicht zwingend.

=== Spezialregister

Special Purpose Registers (SPRs)

/ RIP: Instruction Pointer, zeigt auf die nächste Instruktion
/ SS, CS, DS, ES, FS, GS: Segment Register (kaum noch verwendet)
/ RFLAGS: Flags die spezifische Situationen markieren (z.B. Integer Overflow)
/ CR0 - CR15: Control-Registers um die CPU zu konfigurieren
/ GDTR: Enthält die Adresse der GDT - verwendent für VM
/ LDTR: Enthält die Adresse der LDT - verwendent für VM
/ IDTR: Enthält die Adresse der IDT - verwendent für VM
/ TR: Enthält die Adresse des TSS - verwendet für Task Switching

=== Übersicht

#let byteblock(n) = grid.with(
  columns: (n, n),
  inset: (y: 2pt),
  gutter: 0pt,
  align: center + horizon,
)

#align(center, grid(
  columns: range(8).map(_ => 5em),
  inset: (y: 2pt),
  gutter: 0pt,
  align: center + horizon,
  ..range(8)
    .rev()
    .map(x => grid.cell(stroke: colors.fg, [#{ x * 8 + 7 }...#{ x * 8 }])),

  ..("A", "C", "D", "B")
    .map(x => (
      grid.cell(colspan: 4, rowspan: 2, stroke: colors.orange, raw(
        "R" + x + "X",
      )),
      grid.cell(colspan: 2, rowspan: 2, stroke: colors.green, raw(
        "E" + x + "X",
      )),
      grid.cell(stroke: colors.darkblue, raw(x + "H")),
      grid.cell(stroke: colors.purple, raw(x + "L")),
      grid.cell(stroke: colors.red, colspan: 2, raw(x + "X")),
    ))
    .join(),
  grid.hline(stroke: 2pt + colors.fg),
  ..("S", "B")
    .map(x => (
      grid.cell(colspan: 4, rowspan: 2, stroke: colors.orange, raw(
        "R" + x + "P",
      )),
      grid.cell(colspan: 2, rowspan: 2, stroke: colors.green, raw(
        "E" + x + "P",
      )),
      grid.cell(stroke: colors.darkblue, raw("-")),
      grid.cell(stroke: colors.purple, raw(x + "PL")),
      grid.cell(stroke: colors.red, colspan: 2, raw(x + "P")),
    ))
    .join(),
  ..("S", "D")
    .map(x => (
      grid.cell(colspan: 4, rowspan: 2, stroke: colors.orange, raw(
        "R" + x + "I",
      )),
      grid.cell(colspan: 2, rowspan: 2, stroke: colors.green, raw(
        "E" + x + "I",
      )),
      grid.cell(stroke: colors.darkblue, raw("-")),
      grid.cell(stroke: colors.purple, raw(x + "IL")),
      grid.cell(stroke: colors.red, colspan: 2, raw(x + "I")),
    ))
    .join(),
  grid.hline(stroke: 2pt + colors.fg),
  ..("8", "...", "15")
    .map(x => (
      grid.cell(colspan: 4, rowspan: 2, stroke: colors.orange, raw(
        "R" + x,
      )),
      grid.cell(colspan: 2, rowspan: 2, stroke: colors.green, raw(
        "R" + x + "D",
      )),
      grid.cell(stroke: colors.darkblue, raw("-")),
      grid.cell(stroke: colors.purple, raw(x + "B")),
      grid.cell(stroke: colors.red, colspan: 2, raw("R" + x + "W")),
    ))
    .join(),
))

Kompatibilität: 64-Bit ISA Instruktionen haben `REX` Präfix (Der NASM fügt
diesen ein wenn nötig). Betroffen sind `SPL, BPL, SIL` und `DIL`.

Bsp: ```asm mov ah, sil``` entspricht ```asm REX mov ah, sil```

Würde ```asm mov spl, sil``` bedeuten, wird nicht vom Assembler akzeptiert. Die
Instruktionen könnten kodiert werden, hätten aber falsche Semantik.

== Instruktionen

Operationen benötigen unterschiedlich lange: Die schnellsten benötigen 1
Prozessorzyklus, die langsamsten mehrere 100.

Operationen, die auf den Speicher zugreifen müssen, müssen auf den Speicher
warten: Ist der Operand im Cache: 4 bis 70 Zyklen, ansonsten: mehrere 100 Zyklen

Bestimmte Operationen könnten nur mit immensem Aufwand schneller gemacht werden
(z.B. Division)

Instruktionen sind Binärzahlen, die die Operation und die Operanden codieren.
Sie können auf Intel 64 unterschiedlich lang sein (1 bis 15 Byte). Die Anzahl
und Grösse der Parameter hängen von der Operation ab. Die Länge einer
Instruktion ist nicht in der Sequenz enthalten, eine Sequenz muss von Anfang an
Instruktion für Instruktion durchgegangen werden, um diese richtig decodieren zu
können.

=== Datentransfer-Operationen

```asm mov ziel, quelle ```
Kopiert in das Ziel von der Quelle. Nach Ausführung der Operation enthalten
Quelle und Ziel den gleichen Wert.

In ein _Register_ kann man kopieren:
#table(
  columns: 3,
  table-header([Woher], [Befehl], [Auswirkung]),
  [Von einem anderen Register],
  [ ```asm mov rax, rbx``` ],

  [Setze Inhalt von `rax` gleich Inhalt von `rbx`],
  [Eine Konstante],
  [ ```asm mov rax, 0x8000``` ],

  [Setze Inhalt von `rax` gleich `8000h`],
  [Vom Speicher],
  [ ```asm mov rax, [0x8000]``` ],

  [Setze Inhalt von `rax` gleich Inhalt von `8000h ... 8007h`],
)

In den _Speicher_ kann man kopieren:
#table(
  columns: 3,
  table-header([Woher], [Befehl], [Auswirkung]),
  [Von einem Register],
  [ ```asm mov [0x800], rbx``` ],

  [Setze Inhalt von `8000h ... 8007h` gleich Inhalt von `rax`],
  [Eine Konstante],
  [ ```asm mov qword [0x8000], 5``` ],

  [Setze Inhalt von `8000h ... 8007h` gleich `5`],
)
aber *nicht* direkt vom Speicher in den Speicher.

Operandengrössen können explizit mit `byte, word, dword, qword`, etc angegeben
werden.

Generell können die Operanden 8 Bit, 16 Bit, 32 Bit oder 64 Bit betragen, die
Operanden müssen aber gleich gross sein, z.B.

```asm mov eax, ebx``` #h(1em) OK, beide Register 32-Bit gross

```asm mov eax, rbx``` #h(1em) Fehler, `eax 32` Bit, `rbx 64` Bit

Im Maschinencode gibt es für jede Operandengrösse eine eigene Instruktion

#table(
  columns: (1fr, 2fr, 2fr),
  table-header([Bit], [Befehl], [Code]), `8`, ```asm mov al, bl```,
  `88 D8`, `16`, ```asm mov ax, bx```,
  `66 89 D8`, `32`, ```asm mov eax, ebx```,
  `89 D8`, `64`, ```asm mov rax, rbx```,
  `48 89 D8`,
)

=== Adressierung

Speicherstellen können auf verschiedene Weisen spezifiziert werden.
/ Displacement: `[ a ]` Die Adresse `a` der Speicherstelle folgt unmittelbar \
  ```asm
  mov rax, [0x8000]
  ```
/ Base (Register): `[ r ]` Die Adresse der Speicherstelle steht in einem
  Register `r` \
  ```asm
  mov rbx, 0x8000
  mov rax, [rbx]
  ```
/ Scaled Index: `[ i * s ]` Die Adresse `i * s` besteht aus einem Index `i`
  (Register) skaliert mit einer Konstante `s` (1,2,4 oder 8) \
  ```asm
  mov rcx, 0x1000
  mov rax, [rcx * 8]
  ```
/ Jede Summe der drei vorherigen: Alle drei Adressierungsmodi können beliebig
  addiert werden \
  ```asm
  mov rbx, 0x4000
  mov rcx, 0x1000
  mov rax, [0x2000 + rbx + rcx * 2]
  ```

Wenn man nur die Adresse berechnen möchte, kann man die Operation `lea` (Load
Effective Address) verwenden (greift nicht auf Speicher zu):

```asm
mov rbx, 0x4000
mov rcx, 0x1000
lea rax, [0x2000 + rbx + rcx * 2]
```

== Linker

Programme werden üblicherweise aus mehreren Assemblerdateien generiert. Der
Assembler erzeugt aus einer Assemblerdatei eine Objekt-Datei. Der Linker `ld`
erstellt aus einer oder mehreren Objekt-Dateien ein Executable.

Mit ```sh ld -r prog.o prog2.o -o prog3.o``` können wir partiell linken: Jedes
Symbol erhält einen eigenen Platz im gelinkten Objekt; globale Symbole werden an
einen neuen Offset verschoben. Durch `-r` wird kein Executable erzeugt, sondern
eine weitere Objekt-Datei.

=== Einsprungspunkt

In jedem Executable muss der Einsprungspunkt (entry point) definiert werden (die
Adresse, auf die der IP gesetzt wird, wenn das Programm gestartet wird). Die
wird vom Linker gesetzt und ist standartmässig die Adresse des Labels `_start`,
Kann auf der Kommandozeile geändert werden

```sh ld -e main my_prog.o -o my_prog```

=== Syscalls

Die Instruktion `syscall` übergibt die Ausführung an das OS. Wenn das OS fertig
ist, geht es an der Stelle nach dem Syscall weiter. In `rax` übergibt man den
Code für die OS-Funktion, für allfällige Parameter werden auf Intel 64
verwendet: `rdi, rsi, rdx, r10, r8, r9`. Codes und Parameter können je nach
Architektur ändern; sind aber im allgemeinen recht konstant

=== Ende des Programms

Programme müssen explizit beendet werden: das OS weiss nicht, wann das Programm
zuende ist. Dazu gibt es den OS-Syscall `exit`, üblicherweise Code `60` mit
einem einzigem Parameter: einem 8-Bit Exit-Code. Ein Programm hat also immer
folgenden Rahmen:
```asm
global _start
_start:
...
mov rax, 60     ; syscall exit
mov rdi, 0      ; exit code
syscall
```

= C

== Toolchain

Die Bestandteile der C Toolchain sind:
+ C Präprozessor
+ C Compiler
+ Assembler
+ Linker

#diagram(
  node((0, 0), `.c`),
  node((1, 0), shape: fletcher.shapes.chevron, [Präprozessor]),
  node((2, 0), `.c`),
  node((3, 0), shape: fletcher.shapes.chevron, [Compiler]),
  node((4, 0), `.asm`),
  node((5, 0), shape: fletcher.shapes.chevron, [Assembler]),
  node((6, 0), `.o`),
  node((7, 0), shape: fletcher.shapes.chevron, [Linker]),
  node((8, 0), `exe`),
)

Es lassen sich 3 Sprachebenen unterscheiden:
/ Präprozessor: definiert Direktiven, die im Programm vor dem eigentlichen
  Übersetzen als Textersetzung durchgeführt werden
/ Basiskonstrukte: bestimmen das Grundgerüst eines Programms, z.B. Variablen,
  Schleifen, Verzweigungen.
/ Standardbibliotheken: stellen Funktionen und Typen bereit, die die
  Basis-Funktionalität enthalten

== Präprozessor

Der Präprozessor verarbeitet die Input-Datei in mehreren Durchläufen. In jedem
Durchlauf verarbeitet er die gesamte Datei einmal.

+ Entfernen aller Kommentare und umwandeln fortgesetzter Zeilen, die mit \\
  enden, in eine einzige Zeile.
+ Tokenization
+ Preprocessor directives + Macro expansion

=== Tokenization

Es gibt 5 Klassen von Tokens:
/ Bezeichner (identifiers):
  beginnt mit einem Buchstaben (a-zA-Z) oder \_ gefolgt von einer Sequenz aus
  Buchstaben, \_ oder Ziffern (0-9)
/ Präprozessor-Zahlen:
  Beginnt mit einer Ziffer Gefolgt von einer Sequenz aus Ziffern, Buchstaben,
  \_, ., oder Exponenten (e+, E+, e−, E−, p+, P+, p−, P−). Vor der ersten Ziffer
  kann auch ein Punkt . stehen.
/ String- und Character-Literale:
  String-Literale beginnen und enden mit \", Character-Literale beginnen und
  enden mit \'
/ Operatoren und Satzzeichen (punctuators):
  Jede der folgenden Zeichen bzw. Zeichenkombinationen gilt als Punctuator:
  ```
  ( ) [ ] { } . , : ; ? ... -> # ##
  = + - * / % & | ^ ~ ! << >> == != < > <= >= && ||
  *= /= %= += -= ++ -- <<= >>= &= |= ^=
  ```
  Der Präprozessor ist greedy, d.h. er versucht immer das grösstmögliche Token
  zu bilden.
/ Sonstige: #todo[?]

=== Präprozessor-Direktiven

Ist das erste Token auf einer Zeile \#, wird das nächste Token als Direktive
interpretiert. Beide Token werden entfernt und die entsprechende Direktive
ausgeführt. Die wichtigsten Direktiven sind:
/ include: Fügt einen Header ein
/ define: Definiert ein Makro \
/ if: Bedingte Kompilation
/ else: Alternativer Zweig der bedingten Kompilation
/ endif: Ende der bedingten Kompilation

=== Includes

Präprozessor öffnet die Datei anhand des nächsten Tokens
- ```c #include <file.h>``` sucht nur in den Systemverzeichnissen
- ```c #include "file.h"``` sucht erst im aktuellen Verzeichnis und dann in den
  Systemverzeichnissen
Präprozessor führt Durchläufe 1 bis 3 für file .h durch und setzt Arbeit nach
der Direktive in Orignaldatei fort. Der Präprozessor kann dadurch mehrere
Dateien zu einer _Translation Unit_ zusammenführen

=== Macros

Es gibt objektartige und funktionsartige Makros. Objektartige Makros haben keine
Parameterliste.
```c
#define ANSWER 42
```
Der Präprozessor ersetzt im Programmtext nach der Definition des Makros jedes
Token, das dem Makronamen entspricht, durch die Tokenliste. Nach der Ersetzung
durchsucht der Präprozessor die Ersetzung auf weitere Makronamen und ersetzt
diese. Taucht der eigene Makroname in der Ersetzung auf, wird er nicht ersetzt,
um infinite Rekursion zu verhindern.

== Compiler

Der Compiler übersetzt eine C-Datei in eine Assembler-Datei.

Eine C Translation Unit ist eine Folge von Deklarationen und Definitionen von
- Globalen Variablen
- Funktionen
- Typen

#exbox(
  align(center, ```c
  static int x = 0;     // [00] 8b 04 25 00 00 00 00    mov eax, [x]
  extern void g();
  void f() {
    if (x == 0) {       // [07] 85 c0                   test eax, eax
                        // [09] 75 05                   jne 0x10
      g();              // [0b] e8 00 00 00 00          call g
    }                   // [10] c3                      ret
  }
  ```),
)

=== clang commands

#deftbl(
  ```sh clang prog.c -o prog```,
  [Gesamte Toolchain],
  ```sh clang prog.c```,
  [Ohne Linker-Schritt, erzeugt `prog.o`],
  ```sh clang -S prog.c```,
  [Ohne Linker oder Assembler, erzeugt `prog.s`],
  ```sh clang -masm=intel -S prog.c```,
  [NASM-Kompatibles assembly],
  ```sh clang -E prog.c prog.prep.c```,
  [Nur Präprozessor],
)

=== Deklaration und definition

Deklarationen haben keinen direkten Einfluss auf den erzeugten Byte-Stream
(ähnlich wie Label in Assembler). Innerhalb einer Translation Unit darf jeder
Bezeichner beliebig oft deklariert werden, solange die Deklaration gleich ist.

Eine Entität darf in einer Translation Unit nicht mehrfach definiert werden,
auch nicht wenn die Definition exakt gleich ist.

=== Variablen

#table(
  columns: (1fr, 1fr, 1fr),
  table-header([global], [extern], [static]),
  [
    Für jede globale Variable wird im Programm Speicher fix reserviert. Globale
    Variablen ohne Initialwert werden mit 0 initialisiert.

    Globale Variablen werden standardmässig exportiert:
    ```c
    int c = 5;
    ```
    entspricht in Assembler
    ```asm
    global c
    c: dd 5
    ```
  ],
  [
    Globale Variablen, die aus anderen Objekt-Dateien verwendet werden sollen,
    werden mit extern deklariert:
    ```c
    extern int c;
    ```
    entspricht in Assembler
    ```asm
    extern c
    ```
  ],

  [
    Variablen, die nicht exportiert werden sollen, werden mit static bezeichnet:
    ```c
    static int c = 5;
    ```
    entspricht in Assembler:
    ```asm
    c: dd 5
    ```
  ],
)

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [Bez. in Obj.-Datei], [Deklaration in Asm], [Bez. in C], [Deklaration in C],
  [lokal], [–], [global, internal Linkage], [static],
  [global], [global], [global, external Linkage], [–],
  [–], [extern], [extern], [extern],
)

==== Quirks

```c
// a.c
extern int x;
// b.c
short x;
// Wird kompiliert und gelinkt, kann aber crashen
// Im besten Fall passiert ein segfault
// Sollte in header Files definiert und überall inkludiert werden

static int x = 4;
extern int x;
// Compiler legt Speicher an für static int x, extern int x macht nichts
```

==== Objekte

/ Objekt: ist ein zusammenhängender Speicherbereich; sein Inhalt kann als Wert
  interpretiert werden.
/ Wert: Genaue Bedeutung des Inhalts eines Objekts, wenn dieses mit einem Typ
  versehen ist.
Der Inhalt eines Objekts kann verschieden interpretiert werden.

=== Typen

C kennt verschiedene Arten von Typen:
- Basistypen
- Abgeleitete Typen
- Enumerationen

Typen beschreiben Objekte bzw. deren Eigenschaften:
- Jeder Typ ```c T``` hat eine feste Objektgrösse ```c sizeof(T)```
  - ```c sizeof(T)``` wird in Vielfachen von ```c char``` angegeben, genaue
    Grösse in ```c CHAR_BIT``` in ```c <limits.h>```. \
    Bsp: Anzahl bits eines Typen ```c T``` ist ```c sizeof(T) * CHAR_BIT```
- Bei Operationen erzwingt C Typgleichheit der Operanden
- Typinformationen existieren nur auf Sprachlevel C (Nach der Übersetzung in
  Assembler gibt es keine Typen mehr, sondern nur noch Speicher)

Der Compiler kann dank Typen statische checks durchführen, automatisch die
richtige Grösse für bestimmte Objekte allozieren und die richtigen Operationen
auswählen, z.B. unsigned oder signed Multiplikation.

Typen hängen in C von der verwendeten Maschine (und dem Compiler) ab,
insbesondere ihre Grösse.
/ Vorteil: C-Programme laufen auf jeder Maschine möglichst effizient
/ Nachteil: Plattform-Unabhängigkeit von C-Programmen erfordert sehr viel
  Knowhow

==== char, signed char, unsigned char

- ```c char``` ist wie ```c signed char``` oder ```c unsigned char```, je nach
  Zielsystem und Implementierung, jedoch trotzdem ein eigener Typ
- mindestens 8 Bit gross (kleinste Einheit von Bits, die einzeln adressierbar
  sind)
8 Bit auf Intel 64, aber z.B. 32 Bit auf Analog Devices SHARC

==== integer

Es gibt die folgenden 5 Signed-Integer-Basistypen:
/ signed char: $>=$ 8 Bit
/ short int: $>=$ 16 Bit
/ int: $>=$ 16 Bit und $>=$ ```c short```, soll der "natürlichen" Grösse der
  Architektur der Ausführungsumgebung entsprechen
/ long int: $>=$ 32 Bit und $>=$ int
/ long long int: $>=$ 64 Bit und $>=$ long

Bei den letzten 4 Typen kann in einer Deklaration ```c signed``` davor
geschrieben werden und ```c int``` kann auch weggelassen werden.

Zu jedem Signed-Integer-Basistypen gibt es das ```c unsigned```-Gegenstück, das
die gleiche Grösse hat.

==== void

```c void``` hat keine Werte und wird verwendet, wenn keine Werte zulässig sind
- wenn eine Funktion keinen Rückgabewert hat
- wenn eine Funktion keine Argumente hat
- untypisierte Pointer (können nicht dereferenziert werden)

==== Abgeleitete Typen

/ Array: Mehrere Elemente vom gleichen Typ nacheinander
/ Struct: Mehrere Elemente beliebiger Typen nacheinander
/ Union: Mehrere Elemente beliebiger Typen im selben Speicherbereich
/ Pointer: Adresse eines Objekts \
  ```c void *``` ist ein void-Pointer (Adresse eines Objekts, dessen Typ nicht
  bekannt ist)
/ Funktion: Adresse einer Funktion

=== Ausdrücke

Jeder Ausdruck hat einen Typen, den der Compiler aus den Operanden ableitet.
Primäre Ausdrücke sind Konstanten und Literale sowie Bezeichner. Alle anderen
Ausdrücke werden durch Operatoren und Casts erzeugt.

==== Integer-Konstanten

/ Dezimalzahl: Folge von Ziffern (`0..9`), die *nicht* mit `0` beginnt
/ Oktalzahl: Folge von Ziffern (`0..7`), die mit `0` beginnt
/ Hexadezimalzahl: Folge von Ziffern (`0..F`), die mit `0x` beginnt

Es kann ein Typen-Suffix angehängt werden: `l, ll, u, ul, ull`. Der inferrierte
Typ ist der kleinste, in den die Konstante passt, aber mindestens ```c int```

==== Typkonversionen

Verwendet man Ausdrücke zweier verschiedener Typen in einem Ausdruck, muss einer
davon an den anderen angepasst werden. Die Regeln für implizite Typkonversionen
in C sind zahlreich. Will man explizit von einem Typen in einen anderen
konvertieren, kann man casten:

```c
int x = 5; long y = 7;
y = ((long) x) + y;
x = x + (int) y;
```

= Arithmetische und logische Operationen

== Logische Operationen

=== NAND

Die Basisoperationen können ausschliesslich aus `|` (NAND) dargestellt werden.
NAND-Bausteine sind technisch leicht als Transistoren zu realisieren.

#let edge = edge.with(bend: 0deg, corner-radius: 0pt)
#let (ndot, gate) = fletcher-circuit-elems()
#grid(
  columns: (1fr, 1fr),
  stroke: 1pt,
  gutter: 0pt,
  inset: 1em,
  diagram(
    edge((-1, 0), (1, 0), "O-", label: $x$, label-pos: -1em),
    edge((-1, 1), (1, 1), "O-", label: $y$, label-pos: -1em),
    gate(enclose: ((1, 0), (1, 1)), $\&$, width: 2.5em),
    edge((1, 0.5), (3, 0.5), "O-o", label: $x | y$, label-pos: 3em),
  ),
  diagram(
    edge((-1, 0), (.5, 0), "O-", label: $x$, label-pos: -1em),
    ndot((.5, 0)),
    edge((.5, 0), (2, 0), "-"),
    edge((.5, 0), (2, 1), "-", corner: left),
    gate(enclose: ((2, 0), (2, 1)), $\&$, width: 2.5em),
    edge((2, 0.5), (4, 0.5), "O-o", label: $not x$, label-pos: 3em),
  ),
  diagram(
    edge((-1, 0), (1, 0), "O-", label: $x$, label-pos: -1em),
    edge((-1, 1), (1, 1), "O-", label: $y$, label-pos: -1em),
    gate(enclose: ((1, 0), (1, 1)), $\&$, width: 2.5em),
    edge((1, 0.5), (2, 0.5), "O-"),
    ndot((2, 0.5)),
    edge((2, 0.5), (3, 0), "-", corner: right),
    edge((2, 0.5), (3, 1), "-", corner: left),
    gate(enclose: ((3, 0), (3, 1)), $\&$, width: 2.5em),
    edge((3, 0.5), (5, 0.5), "O-o", label: $x and y$, label-pos: 3em),
  ),
  diagram(
    edge((-1, 0), (.5, 0), "O-", label: $x$, label-pos: -1em),
    ndot((.5, 0)),
    edge((.5, 0), (2, 0), "-"),
    edge((.5, 0), (2, 1), "-", corner: left),
    gate(enclose: ((2, 0), (2, 1)), $\&$, width: 2.5em),
    edge((2, 0.5), (4, 0.5), (4, 1), (5, 1), "O-", corner: right),

    edge((-1, 2), (.5, 2), "O-", label: $y$, label-pos: -1em),
    ndot((.5, 2)),
    edge((.5, 2), (2, 2), "-"),
    edge((.5, 2), (2, 3), "-", corner: left),
    gate(enclose: ((2, 2), (2, 3)), $\&$, width: 2.5em),
    edge((2, 2.5), (4, 2.5), (4, 2), (5, 2), "O-", corner: left),

    gate(enclose: ((5, 1), (5, 2)), $\&$, width: 2.5em),
    edge((5, 1.5), (7, 1.5), "O-o", label: $x or y$, label-pos: 3em),
  ),
  grid.cell(colspan: 2)[...],
)

=== Assembler

Auf Intel 64 ist das Ziel gleichzeitig ein Operand:
$
  & #```asm not z```         && =      && z <- overline(z) \
  & #```asm and z, q``` quad && = quad && z <- z and q \
  & #```asm or  z, q```      && =      && z <- z or q \
  & #```asm xor z, q```      && =      && z <- z xor q \
$

==== Grössenangaben

Bei manchen Instruktionen kann die Grösse nicht abgeleitet werden, z.B.
```asm not [myvar]```.

In diesem Fall muss man einen size specifier hinzufügen, z.B.
```asm not word [myvar]```

=== C

==== Bitwise Operatoren

Die bitweisen Operatoren entsprechen direkt den Assembler-Operationen:

$
  & #```c x =   ~ z```      && =      && x <- overline(z) \
  & #```c x = z & q``` quad && = quad && x <- z and q \
  & #```c x = z | q```      && =      && x <- z or q \
  & #```c x = z ^ q```      && =      && x <- z xor q \
$

==== Logische Operatoren

Die logischen Operatoren bedeuten etwas anderes als auf Assembler-Ebene:

$
  & #```c x =   !  z``` && = && x <- cases(1 "if" z = 0, 0 "otherwise") \
  & #```c x = z && q``` quad && = quad && x <- cases(1 "if" z != 0 and p != 0, 0 "otherwise") \
  & #```c x = z || q``` && = && x <- cases(1 "if" z != 0 or p != 0, 0 "otherwise") \
$
Der Typ dieser Ausdrücke ist immer ```c int```, der Wert immer `0` oder `1`.

== Arithmetische Operationen

=== Assembler

$
  & #```asm add z, q``` quad && = quad && z <- z + q \
  & #```asm sub z, q``` && = && z <- z - q \
  & #```asm adc z, q``` && = && z <- z + q + c \
  & #```asm sbb z, q``` && = && z <- z - q - c \
  & #```asm neg z``` && = && z <- 0 - z && quad "Zweierkomplement" \
  & #```asm inc z``` && = && z <- z + 1 \
  & #```asm dec z``` && = && z <- z - 1 \
$

$c$ ist das Carry-Flag, das z.B. bei einer vorhergehenden Addition gesetzt
wurde.

=== C

$
  & #```c z = q +  p``` quad && = quad && z <- q + p \
  & #```c z = q -  p```      && =      && z <- q - p \
  & #```c z =   -  q```      && =      && z <- 0 - q \
  & #```c z =   ++ q```      && =      && z <- q + 1,quad && q <- q + 1 \
  & #```c z = q ++  ```      && =      && z <- q,quad     && q <- q + 1 \
  & #```c z =   -- q```      && =      && z <- q - 1,quad && q <- q - 1 \
  & #```c z = q --  ```      && =      && z <- q,quad     && q <- q - 1 \
$

=== Links- und Rechts-Shift

Links-Shift um $m$ Bits: $dot 2^m$ \
Rechts-Shift um $m$ Bits: $div 2^m$ \
Im Zweierkomplement mit $4$ Bit: $1110b div 2 = 0111b = 7 != −1$. Der
Rechts-Shift mit Sign-Extension heisst "Arithmetischer Rechts-Shift".

==== Sign-Extension

Wird eine $n$-Bit-Zahl auf eine $n + m$-Bit-Speicherstelle kopiert, werden die
$m$ oberen Bits auf $0$ gesetzt. Bei einer Zahl im Zweierkomplement ändert sich
dadurch aber die Bedeutung. Z.B. $4$ Bit auf $8$ Bit kopieren:
$ b = −1 = 1111b => 0000 space 1111b = 15d != −1 = 1111 space 1111b $
Statt einer $0$ muss überall eine $1$ kopiert werden. Dieser Vorgang heisst
_sign extension_: das Vorzeichen wird auf alle zusätzlichen Bits ausgedehnt. Die
Sign-Extension wird *nicht* in allen Befehlen automatisch ausgeführt (z.B.
```asm mov```).

==== Assembler

Shifts können ähnlich performant wie die elementaren Operationen implementiert
werden. Rotates füllen statt mit $0$ oder $1$ mit den ursprünglichen Bits auf.

$
  & #```asm shl z, i``` quad && = quad && z <- z dot 2^i \
  & #```asm shr z, i``` && = && z <- z dot 2^(-i) && z "unsigned" \
  & #```asm sar z, i``` && = && z <- z dot 2^(-i) && z "signed" \
  & #```asm rol z, i``` && = && z <- "Left-Rotate" i "Bits" \
  & #```asm ror z, i``` && = && z <- "Right-Rotate" i "Bits" \
$

==== C

$
  & #```c q << p``` quad && = quad && z <- q dot 2^p \
  & #```c q >> p```      && =      && z <- q div 2^p \
$
Beim Rechts-Shift wählt der Compiler die Instruktion abhängig vom Typ aus:
- unsigned: ```asm shr```
- signed: ```asm sar```
Rotates können in C nicht direkt ausgedrückt werden

=== Multiplikation

==== Unsigned

Unsigned Multiplikation hat nur einen Operanden, der andere ist implizit:
```asm mul z```

Je nach Bit-Grösse von $z$ sind Ergebnis und der andere Operand:
#table(
  columns: (1fr, 1fr, 2fr),
  [Bits], [Ergebnis MSBs], [Ergebnis LSBs und zweiter Operand],
  `64`, `RDX`, `RAX`,
  `32`, `EDX`, `EAX`,
  `16`, `DX`, `AX`,
  `8`, `AH`, `AL`,
)

==== Signed

```asm imul``` ist das signed Äquivalent zu ```asm mul``` Zusätzlich zu den
fixen Registern wie bei ```asm mul``` gibt es drei flexiblere Versionen für jede
Grösse, bei denen der zweite Operand explizit mitgegeben werden kann:
```asm imul r, z```. Diese Versionen verwenden aber nur die LSBs des
Ergebnisses.

=== Division

Umgekehrt gibt es die Division mit fixen Registern: ```asm div``` und
```asm idiv``` Der Dividend $d$ verwendet dieselben Register wie das Produkt bei
```asm mul``` bzw. ```asm imul```, z.B. `RDX:RAX`.
- Division schreibt den Quotienten $q = d/z$ in die LSBs von $d$, z.B. `RAX`
- Division schreibt den Rest $r = d mod z$ in die MSBs von $d$, z.B. `RDX`

Division in Assembler sollte gemieden werden, da sehr langsame Operation.
Sie kann für Zweierpotenzen durch Rechts-Shift und
bei anderen Konstanten oft durch Multiplikation oder Umstellen der Formel
ersetzt werden.

=== C

- Multiplikation: ```c a * b```
- Division: ```c a / b```
- Rest: ```c a % b```
- Die richtige Operation (signed oder unsigned) wird aus Typ abgeleitet
- Aber: Typ bleibt gleich, d.h. `int * int -> int`
