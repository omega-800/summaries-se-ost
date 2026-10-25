#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)

= Prozessor

/ Adressbus: Adresse der zuzugreifenden Speicherzelle
/ Datenbus: Daten, die aus Speicherzelle gelesen wurde/geschrieben werden soll
/ Steuersignale: Geben an, was getan werden soll
/ Register: Speicher im Prozessor
/ Operation: Prozessorspezifisch, haben $0..n$ Operanden
/ Instruktion: Kombination von Operation + Operanden
/ Sequenzen: Hart-codiert im Prozessor oder Hauptspeicher
/ Zyklus: Prozessor, über mehrere Takte hinweg:
  + Fordert Instruktion ab Adresse vom IP an
  + Decodiert Operation und Operanden aus Instruktion
  + Wählt mit Operation korrespondierenden Baustein aus
  + Aktiver Baustein liest ggf. aus den Registern
  + Aktiver Baustein führt ggf. Berechnung aus
  + Aktiver Baustein schreibt ggf. in die Register
  + Erhöht Befehlszeiger entspr. der Länge der Instruktion

= Maschinencode

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

Kleinste Einheite ist ein Byte (8 Bit). Ein einzelnes Bit muss immer mit dem
gesamten Byte verarbeitet werden.

#table(
  columns: (1fr, 1fr),
  table-header([Big-Endian], [Little-Endian]),
  [Von rechts nach links $<-$ \
    Zahlen beginnen mit dem "grossen Ende", dem _MSByte_
  ],

  [Von links nach rechts $->$ \
    Zahlen beginnen mit dem "kleinen Ende", dem _LSByte_
  ],

  bytes-tbl([00], [00], [80], [85], extra: (
    grid.cell(colspan: 3, stroke: none)[],
    [Byte],
    grid.cell(colspan: 2, stroke: none)[],
    grid.cell(colspan: 2)[Word],
    grid.cell(colspan: 4)[DWord],
  )),

  bytes-tbl(
    [00],
    [00],
    [80],
    [05],
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

= Assembly

Traditionell arbeitet der NASM im 16-Bit-Modus, Operationen haben hier andere
Opcodes als im 64-Bit-Modus. #box(```asm BITS 64```)

/ Aktueller Offset: (Adresse) `$`
/ Label: Werden nicht in Maschinencode übersetzt
/ Flat-Form binaries: Bytesequenz ohne Zusatzinformationen
/ Objekt-Dateien: Beinhalten Metadaten, u.a. Symboltabelle
/ Exportierte Symbole: mit ```asm global``` deklarierte Label
/ Importierte Symbole: mit ```asm extern``` deklarierte Label, haben keinen
  definierten Wert innerhalb der Objekt-Datei

== Symboltabelle

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
    i => text(size: .75em)[*#i*],
  ),
  `00000010`, `l`, `.text`, `00000000`, `w`,
  `00000000`, ` `, `*UND*`, `00000000`, `z`,
  `00000018`, `g`, `.text`, `00000000`, `x`,
  `00000020`, `g`, `.text`, `00000000`, `y`,
)
Als extern deklariertes Label `z` erscheint als `*UND*` (undefined)

== Register

/ General Purpose: Kann nach belieben verwendet werden
/ Special Purpose: Wird für einen spezifischen Zweck verwendet, nur gewisse
  Operationen können darauf zugreifen

#[
  #set text(size: .75em)
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
]
#colbreak()
=== Allzweckregister (GPR)

/ RAX: Accumulator, für einige Rechenop. das einzig mögliche
/ RCX: Counter für Schleifen und Stringoperationen
/ RDX: Pointer für I/O-Operationen
/ RBX: Datenpointer
/ RSI, RDI: Quell- und Zielindizes für Stringoperationen
/ RSP: Stackpointer, Adresse des allozierten Stacks
/ RBP: Basepointer, Basis des Stackframe der Funktion
/ R8 - R15: Zusätzliche Register

=== Spezialregister (SPR)

/ RIP: Instruction Pointer, zeigt auf die nächste Instruktion
/ SS, CS, DS, ES, FS, GS: Segment Register
/ RFLAGS: Flags die spezifische Situationen markieren
/ CR0 - CR15: Control-Registers um die CPU zu konfigurieren
/ GDTR: Enthält die Adresse der GDT - verwendent für VM
/ LDTR: Enthält die Adresse der LDT - verwendent für VM
/ IDTR: Enthält die Adresse der IDT - verwendent für VM
/ TR: Enthält die Adresse des TSS - für Task Switching

64-Bit ISA (SPL, BPL, SIL und DIL) Instruktionen haben REX Präfix. Bsp:
```asm mov ah, sil``` entspricht ```asm REX mov ah, sil```

=== Datentransfer-Operationen

```asm mov ziel, quelle ``` \
Nach Ausführung der Operation enthalten Quelle und Ziel den gleichen Wert.

In ein _Register_ kann man kopieren:
#table(
  columns: 3,
  table-header([Woher], [Befehl], [Auswirkung]),
  [Andere Reg.],
  [ ```asm mov rax, rbx``` ],

  [Inhalt `rax`=Inhalt `rbx`], [Eine Konstante], [ ```asm mov rax, 0x8000``` ],

  [Inhalt `rax`=`8000h`], [Vom Speicher], [ ```asm mov rax, [0x8000]``` ],

  [Inhalt `rax`\ =Inhalt `800[0..7]h`],
)

In den _Speicher_ kann man kopieren:
#table(
  columns: 3,
  table-header([Woher], [Befehl], [Auswirkung]),
  [Andere Reg.],
  [ ```asm mov [0x800], rbx``` ],

  [Inhalt `800[0..7]h`\ =Inhalt `rax`],
  [Konstante],
  [ ```asm mov qword [0x8000], 5``` ],

  [Inhalt `800[0..7]h`=`5`],
)
aber *nicht* direkt vom Speicher in den Speicher. \
Operandengrössen werden mit `byte,word,dword,qword` angegeben. Operanden müssen
gleich gross sein.

=== Adressierung

/ Displacement: `[a]` Adresse `a` der Stelle folgt unmittelbar \
  ```asm mov rax, [0x8000] ```
/ Base (Register): `[r]` Adresse der Stelle steht im Register `r` \
  ```asm
  mov rbx, 0x8000
  mov rax, [rbx]
  ```
/ Scaled Index: `[i*s]` Adresse `i*s` besteht aus Index `i` (Register) skaliert
  Konstante `s` (1,2,4 oder 8) \
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

== Linker

Assembler erzeugt aus jeder `asm`-Datei eine Objekt-Datei. Der Linker `ld`
erstellt daraus ein Executable. Standard-Einsprungspunkt: ```asm _start:```

=== Syscalls

```asm syscall``` übergibt die Ausführung an das OS. In ```asm rax``` übergibt
man den Code, in ```asm rdi, rsi, rdx, r10, r8, r9``` die Parameter.
```asm
mov rax, 60     ; syscall exit
mov rdi, 0      ; exit code
syscall
```

= C

#{
  let node = node.with(inset: 1pt, stroke: .5pt)
  diagram(
    spacing: (0pt, 0pt),
    node((0, 0), `.c`, stroke: none),
    node((1, 0), shape: fletcher.shapes.chevron, [Präprozessor]),
    node((2, 0), `.c`, stroke: none),
    node((3, 0), shape: fletcher.shapes.chevron, [Compiler]),
    node((4, 0), `.asm`, stroke: none),
    node((5, 0), shape: fletcher.shapes.chevron, [Assembler]),
    node((6, 0), `.o`, stroke: none),
    node((7, 0), shape: fletcher.shapes.chevron, [Linker]),
    node((8, 0), `exe`, stroke: none),
  )
}

/ Präprozessor: Kommentare, macros, directives, tokenization. Mehrere
  Durchläufe, jedes mal gesamte Datei einmal.
#colbreak()
#todo[tokens?]

```c #include <file.h>``` sucht nur in den Systemverzeichnissen \
```c #include "file.h"``` erst aktuelles Verzeichnis, dann System \
Wird alles zu einer _Translation Unit_ zusammengeführt. \
Taucht eigener Makroname in der Ersetzung auf, wird er nicht ersetzt, um
infinite Rekursion zu verhindern.

/ Compiler: übersetzt eine C-Datei in eine Assembler-Datei.
Deklarationen haben keinen direkten Einfluss auf den erzeugten Byte-Stream
(ähnlich wie Label in Assembler). \
#tg(sym.checkmark) Mehrfache deklaration (solange gleiche Typsignatur) \
#tr(sym.crossmark) Mehrfache definition

=== Variablen

/ global:
  Speicher wird fix reserviert, die ohne Initialwert werden mit 0 initialisiert,
  standardmässig exportiert: ```c int c = 5; ``` entspricht in Assembler
  ```asm
  global c
  c: dd 5 ```
/ extern:
  Globale Variablen, die aus anderen Objekt-Dateien verwendet werden sollen:
  ```c extern int c; ```
  entspricht in Assembler
  ```asm extern c ```
/ static:
  Variablen, die nicht exportiert werden sollen:
  ```c static int c = 5; ```
  entspricht in Assembler:
  ```asm c: dd 5 ```

#table(
  columns: (1fr, 1fr, 2fr, 1fr),
  [Bez. `.o`],
  [Dekl. `.asm`],
  [Bez. `.c`],
  [Dekl.
    `.c`],

  `lokal`, ``, [`global` internal Linkage], `static`,
  `global`, `global`, [`global` external Linkage], ``,
  ``, `extern`, `extern`, `extern`,
)

#exbox[
  ```c
  // a.c            // Kompiliert und Linkt, kann aber
  extern int x;     // crashen. Bestenfalls passiert
  // b.c            // ein segfault. -> in .h Files
  short x;          // definieren, überall inkludieren
  // c.c
  static int x = 4; // Compiler legt Speicher an
  extern int x;     // extern int x macht nichts
  ```
]

/ Objekt: Ein zusammenhängender Speicherbereich. Inhalt kann verschieden
  interpretiert werden.
/ Wert: Genaue Bedeutung des Inhalts, wenn Typisiert

=== Typen

C kennt verschiedene Arten von Typen:
- Basistypen
- Abgeleitete Typen
- Enumerationen

Jeder Typ ```c T``` hat feste Objektgrösse ```c sizeof(T)```, wird in Vielfachen
von ```c char``` angegeben, genaue Grösse in ```c CHAR_BIT``` in
```c <limits.h>```. Bsp: ```c sizeof(T) * CHAR_BIT``` \
Bei Operationen erzwingt C Typgleichheit der Operanden. \
Nach Übersetzung in Assembler gibt es keine Typen mehr. \

Compiler kann statische checks durchführen, richtige Grösse für Objekte
allozieren, richtige Operationen auswählen, z.B. unsigned/signed.

Typen hängen in C von der verwendeten Maschine (und dem Compiler) ab,
insbesondere ihre Grösse.
/ Vorteil: C-Programme laufen überall möglichst effizient
/ Nachteil: Plattform-Unabhängigkeit schwierig Knowhow

#table(
  columns: 2,
  [Typ], [Grösse],
  ```c char```, [$>= 8$ Bit],
  ```c short int```, [$>= 16$ Bit],
  ```c int```,
  [$>= 16$ Bit $and >=$ ```c short```, "natürliche" Grösse der Arch.],

  ```c long int```, [$>= 32$ Bit $and >=$ ```c int```],
  ```c long long int```, [$>= 64$ Bit $and >=$ ```c long```],
)

#todo[char/signed/unsigned?]


/ Dezimalzahl: Folge von Ziffern (`0..9`), die *nicht* mit `0` beginnt
/ Oktalzahl: Folge von Ziffern (`0..7`), die mit `0` beginnt
/ Hexadezimalzahl: Folge von Ziffern (`0..F`), die mit `0x` beginnt

Typen-Suffixe können angehängt werden: `l,ll,u,ul,ull`. Inferrierte Typ ist der
kleinste, in den Konstante passt, mind. ```c int```

Expliziter cast: ```c int x = 5; long y = (long) x;```

= Arithmetische und Logische Operationen

Alle Operationen können ausschliesslich aus NAND dargestellt werden. Sie sind
leicht als Transistoren zu realisieren.

== Logische Operationen

=== Assembler

Auf Intel 64 ist das Ziel gleichzeitig ein Operand:
$
  & #```asm not z```         && =      && z <- overline(z) \
  & #```asm and z, q``` quad && = quad && z <- z and q \
  & #```asm or  z, q```      && =      && z <- z or q \
  & #```asm xor z, q```      && =      && z <- z xor q \
$

Bitweise Operatoren agieren ohne Interpretation der Operanden als Gesamtzahl
(signed und unsigned).

Bei manchen Instruktionen kann die Grösse nicht abgeleitet werden, z.B.
```asm not [myvar]```. In diesem Fall muss man einen size specifier hinzufügen,
z.B.
```asm not word [myvar]```

=== C

Bitweise Operatoren entsprechen direkt den Assembler-Ops:

$
  & #```c x =   ~ z```      && =      && x <- overline(z) \
  & #```c x = z & q``` quad && = quad && x <- z and q \
  & #```c x = z | q```      && =      && x <- z or q \
  & #```c x = z ^ q```      && =      && x <- z xor q \
$

Logischen Operatoren bedeuten etwas anderes:

$
  & #```c x =   !  z``` && = && x <- cases(1 "if" z = 0, 0 "otherwise") \
  & #```c x = z && q``` quad && = quad && x <- cases(1 "if" z != 0 and p != 0, 0 "otherwise") \
  & #```c x = z || q``` && = && x <- cases(1 "if" z != 0 or p != 0, 0 "otherwise") \
$
Typ dieser Ausdrücke ist immer ```c int```, der Wert immer `0` oder `1`.

== Arithmetische Operationen

=== Assembler

Dank des Zweierkompl. sind diese Ops für (un-)signed gleich

$
  & #```asm add z, q``` quad && = quad && z <- z + q \
  & #```asm sub z, q``` && = && z <- z - q \
  & #```asm adc z, q``` && = && z <- z + q + c \
  & #```asm sbb z, q``` && = && z <- z - q - c \
  & #```asm neg z``` && = && z <- 0 - z && quad "Zweierkomplement" \
  & #```asm inc z``` && = && z <- z + 1 \
  & #```asm dec z``` && = && z <- z - 1 \
$

$c$ ist das Carry-Flag, z.B. bei vorherigen Addition gesetzt

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

== Links- und Rechts-Shift

Links-Shift um $m$ Bits: $dot 2^m$, Rechts-Shift um $m$ Bits: $div 2^m$ \
Im Zweierkomplement mit $4$ Bit: $1110b div 2 = 0111b = 7 != −1$ \
`>>` mit Sign-Extension heisst "Arithmetischer Rechts-Shift".

=== Sign-Extension

#todo[
  Wird eine $n$-Bit-Zahl auf eine $n + m$-Bit-Speicherstelle kopiert, werden die
  $m$ oberen Bits auf $0$ gesetzt. Bei einer Zahl im Zweierkomplement ändert
  sich dadurch aber die Bedeutung. Z.B. $4$ Bit auf $8$ Bit kopieren:
  $ b = −1 = 1111b => 0000 space 1111b = 15d != −1 = 1111 space 1111b $
  Statt einer $0$ muss überall eine $1$ kopiert werden. Dieser Vorgang heisst
  _sign extension_: das Vorzeichen wird auf alle zusätzlichen Bits ausgedehnt.
  Die Sign-Extension wird *nicht* in allen Befehlen automatisch ausgeführt (z.B.
  ```asm mov```).
]

=== Assembler

Rotates füllen statt mit $0$ oder $1$ mit ursprünglichen Bits auf.

$
  & #```asm shl z, i``` quad && = quad && z <- z dot 2^i \
  & #```asm shr z, i``` && = && z <- z dot 2^(-i) && z "unsigned" \
  & #```asm sar z, i``` && = && z <- z dot 2^(-i) && z "signed" \
  & #```asm rol z, i``` && = && z <- "Left-Rotate" i "Bits" \
  & #```asm ror z, i``` && = && z <- "Right-Rotate" i "Bits" \
$

=== C

$
  & #```c q << p``` quad && = quad && z <- q dot 2^p \
  & #```c q >> p```      && =      && z <- q div 2^p \
$
Beim `>>` wählt Compiler die Instruktion abhängig vom Typ: unsigned:
```asm shr```, signed: ```asm sar```\
Rotates können in C nicht direkt ausgedrückt werden.

== Multiplikation

=== Unsigned

Hat nur einen Operanden, der andere ist implizit:
```asm mul z```

Je nach Bit-Grösse von $z$ sind Ergebnis und andere Operand:
#table(
  columns: (1fr, 2fr, 4fr),
  [Bits], [Ergebnis MSBs], [Ergebnis LSBs und zweiter Operand],
  `64`, `RDX`, `RAX`,
  `32`, `EDX`, `EAX`,
  `16`, `DX`, `AX`,
  `8`, `AH`, `AL`,
)

=== Signed

```asm mul```$=>^"Signed"$```asm imul```. Zusätzlich zu Registern bei
```asm mul``` gibt es drei für jede Grösse, wo zweiter Operand explizit
mitgegeben wird: ```asm imul r, z```. Diese verwenden aber nur LSBs des
Ergebnisses

== Division

```asm div```$=>^"Signed"$```asm idiv```. Dividend $d$ verwendet dieselben
Register wie ```asm mul```, z.B. `RDX:RAX`. Quotient $q = d/z$ wird in LSBs von
$d$ geschrieben, z.B. `RAX`. Rest $r = d mod z$ wird in MSBs von $d$
geschreiben, z.B. `RDX`.

#comment[
  Division in Assembler sollte gemieden werden, da sehr langsame Operation. Sie
  kann für Zweierpotenzen durch Rechts-Shift und bei anderen Konstanten oft
  durch Multiplikation oder Umstellen der Formel ersetzt werden.
]

== C

Multiplikation: ```c a * b```, Division: ```c a / b```, Rest: ```c a % b``` Die
richtige Operation (signed oder unsigned) wird aus Typ abgeleitet Aber: Typ
bleibt gleich, d.h. `int * int -> int`

#todo[W6 S9..12 (summary S20)]

= Kontrollfluss

== Flags

Flags sind einzelne Bits, die in einem gemeinsamen Register `RFLAGS` liegen, das
nicht direkt verwendet werden kann.

/ Carry Flag (CF): Überlauf *unsigned* Arithmetik (Übertrag MSBs)
/ Overflow Flag (OF): Überlauf *signed* Arithmetik (Vorzeichen stimmen nicht
  mehr)
/ Zero Flag (ZF): Wird immer gesetzt, wenn das Resultat `0` ist
/ Sign Flag (SF): Höchstwertiges Bit des Resultats
/ Parity Flag (PF): Wenn das niederwertigste Byte des Resultats eine gerade
  Anzahl an gesetzten Bits enthält

Prozessor weiss nicht, ob signed/unsigned gearbeitet wird
- CF und OF werden immer beide bestimmt
- Das Programm muss später das richtige Flag verwenden

== Condition Codes (CC)

Zu vielen CCs gibt es den negierten CC mit vorangestelltem `N`
```
NC <=> CF = 0
NA <=> CF = 1 OR ZF = 1
```
#exbox(title: "Conditional Move", ```asm
dec rax         ; sets ZF = 1 if rax == 0
cmovz rax, [q]  ; sets rax = [q] if rax == 0
```)

=== Unsigned

Differenz $a − b$ zeigt an, ob $a$ kleiner, grösser oder gleich $b$ ist:

#table(
  columns: (1fr, 2.6fr, 6fr),
  [Fall], [Flags], [Begründung],
  $a = b$, $"ZF" = 1$, $a - b = 0$,
  $a < b$, $"CF" = 1$, $a − b "ergibt (unsigned) Überlauf"$,
  $a >= b$, $"CF" = 0$, $a >= b space <=> space overline(a < b)$,
  $a <= b$, $"ZF" = 1 or "CF" = 1$, $a <= b space <=> space a < b or a = b$,
  $a > b$,
  $"ZF" = 0 and "CF" = 0$,
  $a > b space <=> space overline(space a <= b)$,
)

=== Signed

#table(
  columns: (1fr, 2.6fr, 6fr),
  [Fall], [Flags], [Begründung],
  $a = b$, $"ZF" = 1$, $a - b = 0$,
  $a < b$,
  $"OF" != "SF"$,
  $
    a < 0 and b > 0 <=> & "OF" = 1 and "SF" = 0 && "Overflow" \
              a < b <=> & "OF" = 0 and "SF" = 1 && "No overf." \
  $,

  $a >= b$, $"OF" = "SF"$, $a >= b space <=> space overline(a < b)$,
  $a <= b$, $"ZF" = 1 or "OF" != "SF"$, $a <= b space <=> space a < b or a = b$,
  $a > b$, $"ZF" = 0 and "OF" = "SF"$, $a > b space <=> space overline(a <= b)$,
)

=== Intel CCs

#table(
  columns: (auto, 2.5fr, 1fr, 3fr, 3fr, 1fr, 5fr),
  [],
  table.cell(colspan: 3, $a < b$),
  table.cell(colspan: 3, $a > b$),
  emph[signed],
  [Less],
  [L],
  $"SF" != "OF"$,
  [Greater],
  [G],
  $"ZF" = 0 and "OF" = "SF"$,
  emph[unsigned],
  [Below],
  [B],
  $"CF" = 1$,
  [Above],
  [A],
  $"ZF" = 0 and "OF" = 0$,
)

#table(
  columns: 6,
  [CC], [Name], [Flags], [CC], [Name], [Flags],
  `A`, [Above], $"CF" = 0 and "ZF" = 0$, `AE`, [A. or Eq], $"CF" = 0$,
  `B`, [Below], $"CF" = 1$, `BE`, [B. or Eq], $"CF" = 1 or "ZF" = 1$,
  `G`, [Greater], $"ZF" = 0 and "SF" = "OF"$, `GE`, [G. or Eq], $"SF" = "OF"$,

  `L`, [Less], $"SF" != "OF"$, `LE`, [L. or Eq], $"ZF" = 1 or "SF" != "OF"$,
  `PE`, [P. Even], $"PF" = 1$, `PO`, [P. Odd], $"PF" = 0$,
  `E`, [Equal], $"ZF" = 1$,
)

== jmp

```asm jmp d``` setzt $"RIP" <- "RIP" + d$ bezogen auf $"RIP"$ nach dem Befehl
selbst. $d$ ist 8- oder 32-Bit, wird auf 64-Bit sign-extended. Programm springt
um $d$: $d > 0 =>$ vorwärts, $d < 0 =>$ rückwärts.

Bei Labels berechnet der Assembler die relative Adresse.

== Vergleiche

```asm cmp``` entspricht ```asm sub``` ohne Veränderung der Operanden. \
```asm test``` entspricht ```asm and``` ohne Veränderung des Ziel-Operanden,
setzt aber trotzdem die Flags.

== Bedingte Anweisungen

```asm cmovcc```: Conditional MOV \
```asm jcc```: Conditional JMP \
```asm setcc```: Schreibt $1$ in 8-Bit grosses Ziel wenn CC erfüllt, sonst $0$ \

=== C

Der Body von ```c if``` wird genau dann ausgeführt, wenn die Bedingung nicht `0`
ist. Falls ein ```c else``` vorhanden ist, kommt am Ende des ersten Bodys ein
unbedingter Sprung.

#exbox(grid(
  columns: (1fr, 1fr),
  ```c
  if (ux < 3) {
    // if-body ...
  } else {
    // else-body ...
  }
  ```,
  ```asm
    mov eax, [ux]
    cmp eax, 2
    ja else_body
    ; if-body
    jmp after_if

  else_body:
    ; else-body
  after_if:
  ```,
))

=== Schleifen

In C ist do-while das Analogon zur Schleife in Assembler:
#grid(
  columns: (1fr, 1fr),
  ```c
  do {
    /* body */
  } while (condition);
  ```,

  ```asm
  loop:
    ; body
    dec rcx
    jnz loop
  ```,
)

Bei der while-Schleife wird vor jedem Ausführen die Bedingung geprüft, somit ein
mal öfter als der Body.


#exbox(grid(
  columns: (1fr, 1fr),
  ```c
  int i = 23;
  while (--i) {
    /* body */
  }
  ```,
  ```asm
    mov rcx, 23
    jmp condition
  loop:
    ; body
  condition:
    dec rcx
    jnz loop
  ```,
))

== Pointer-addition

Die Addition eines Integers zu einem ```c T*```-Pointer berücksichtigt die
Grösse ```c sizeof(T)``` (genauso bei ```c ++```). Z.B. Bei
```c int *p = (int *)0x20;``` ist ```c p+1 == 0x24``` und ```c p+2 == 0x28```,
usw.
