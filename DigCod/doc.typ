#import "../lib.typ": *
#import "./info.typ": info

// FIXME:
#import "@preview/cetz:0.3.4"

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

#let dec = dec.with(postfix: true, prefix: false)
#let hex = hex.with(postfix: true, prefix: false)
#let bin = bin.with(postfix: true, prefix: false)
#let oct = oct.with(postfix: true, prefix: false)

= Stellenwertsystem

#deftbl(
  [Basis (Radix)],
  $E in NN, R >= 2$,
  [Ziffernmenge],
  $T_R = {0,1,...,R-1}$,
  [Darstellung einer Zahl (Polynom)],
  $N_R = sum_(i=0)^n d_i R^i$,
  [Stellenwertigkeit an der Position $i$],
  $d_i in Z_R, R^i$,
)

#table(
  columns: (1fr, 1fr),
  table-header(table.cell(colspan: 2, [Beispiele])),
  add-note(
    "Dezimalsystem",
    [
      - $R = 10$
      - $Z_10 = {0,1,2,3,4,5,6,7,8,9}$
      - $#dec(110) = #dec(postfix: false, prefix: true, 110)$
    ],
  ),

  add-note(
    "Oktalsystem",
    [
      - $R = 8$
      - $Z_10 = {0,1,2,3,4,5,6,7}$
      - $#oct(72) = #oct(postfix: false, prefix: true, 72) = #dec(72)$
    ],
  ),
  add-note(
    "Dualsystem",
    [
      - $R = 2$
      - $Z_10 = {0,1}$
      - $#bin(6) = #bin(postfix: false, prefix: true, 6) = #dec(6)$
    ],
  ),

  add-note(
    "Hexadezimalsystem",
    [
      - $R = 16$
      - $Z_10 = {0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}$
      - $#hex(45) = #hex(postfix: false, prefix: true, 45) = #dec(45)$
    ],
  ),
)

== Konversion

#grid(
  columns: (1fr, 1fr),
  add-note(
    format: note-answer,
    "Konversion Dezimal- zu Dualsystem",
    [
      Dezimal- zu Dualsystem:
      - Rechts shift ist eine Division durch 2
      - Es entsteht nur dann ein Rest, wenn die Bitstelle $2^0 = 1$ ist.
      Beispiel: #dec(25) \
      Resultat: #bin(25)
    ],
  ),
  table(
    columns: (1fr, 1fr, 1.25fr, 0.75fr, auto),
    [Zähler], [Nenner], [Resultat], [Rest], [],
    [25], [2], [12], [*1*],
    table.cell(rowspan: 5)[#align(
      horizon,
      $stretch(}, size: #7em) #rotate(-90deg, $arrow.long$)$,
    )],
    [12], [2], [6], [*0*],
    [6], [2], [3], [*0*],
    [3], [2], [1], [*1*],
    [1], [2], [0], [*1*],
  ),

  add-note(
    format: note-answer,
    "Konversion Dual- zu Dezimalsystem bei Nachkommastellen",
    [
      Dual- zu Dezimalsystem bei Nachkommastellen:
      - Links shift ist eine Multiplikation mit 2
      Beispiel: $0.187'5_10$ \
      Resultat: $0.001 space 1_2$
    ],
  ),
  table(
    columns: (1fr, 1fr, 1.25fr, 0.75fr, auto),
    [a], [b], [Resultat], [Rest], [],
    [0.1875], [2], [0.375], [*0*],
    table.cell(rowspan: 4)[#align(
      horizon,
      $stretch(}, size: #5em) #rotate(90deg, $arrow.long$)$,
    )],
    [0.375], [2], [0.75], [*0*],
    [0.75], [2], [1.5], [*1*],
    [0.5], [2], [1], [*1*],
  ),
)

== Nachkommastellen

Erweiterung der Darstellung einer Zahl: $N_R = d_n R^n + ... + d_10 R^0 + d_(-1) R^(-1) + ... + d_(-m) R^(-m)$

Beispiel: $(101.01)_2 = 1*2^2 + 0*2^1+1*2^0+0*2^(-1)+1*2^(-2) = 4 + 1 + 1/4 = 5.25_10$

#ta.start-note()
== Subtraktion durch Addition

#ta.start-field()
Beispiel: $753 + 247 = 1000$

Bei $1000$ einen Überlauf ($mod 1000$): $753 + 247 equiv 0 <=> 753 equiv -247 mod 1000$

Dann wäre $620 - 247 equiv 620 + 753 = 1373 equiv 373 mod 1000$
#ta.end-note()

= Dualsystem

== Arithmetik

#ta.start-note()
=== Komplementbildung (Zweierkomplement)

#ta.start-field()
+ Rechnen in $n$ Bit $=> mod 2^n$
  - Übertrag aus dem MSB wird verworfen (gerechnet wird in $ZZ_(2^n)$)
+ $-b$ als Zweierkomplement
  - Additives Inverses von $b mod 2^n$ ist: $-b equiv 2^n - b mod 2^n$
  - Praktische Berechnung:
    - Bits invertieren: $~b$
    - $+1$ addieren
    - $2K(b) = ~b + 1$
#ta.end-note()

#ta.start-note()
=== Subtraktion

#ta.start-field()
Subtraktion wird durch Addition des Komplements ersetzt
$ a - b equiv a + 2K(b) mod 2^n $
#ta.end-note()

#exbox(title: $#dec(13) - #dec(5)$, [
  $8 "Bit"$, wobei $#dec(13) = 0000 space #bin(13), #dec(5) = 0000 space #bin(5)$ \
  Zweierkomplement von #dec(5):
  - invertieren: $#bin(250)$
  - $+1: #bin(251)$
  Addieren: $0000 space #bin(13) + #bin(251) = #bin(264)$

  MSB-Übertrag weg: $0000 space #bin(8) = #dec(8)$

  Also: $#dec(13) - #dec(5) = #dec(8)$
])

=== Addition

#todo("signed, unsigned")

=== Multiplikation

#todo("signed, unsigned")

=== Division

#todo("signed, unsigned")

== Wertebereich

Graphische Veranschaulichung für Wortbreite von 3 Bit

#let edge = edge.with(bend: 20deg)
#grid(
  columns: (1fr, 1fr),
  align: center,
  diagram(
    node-stroke: 0pt,
    spacing: (1em, 2em),
    node((-1, 0), $111$, name: <fst>),
    edge("->"),
    node((1, 0), $000$),
    edge("->"),
    node((2, 1), $001$),
    edge("->"),
    node((2, 2), $010$),
    edge("->"),
    node((1, 3), $011$),
    edge("->"),
    node((-1, 3), $100$),
    edge("->"),
    node((-2, 2), $101$),
    edge("->"),
    node((-2, 1), $110$),
    edge("->", <fst>),

    node((-0.5, 0.5), text(fill: colors.red)[$7$]),
    edge("->", stroke: colors.red),
    node((0.5, 0.5), text(fill: colors.red)[$0$]),
    node((1.25, 1), $1$),
    node((1.25, 2), $2$),
    node((0.5, 2.5), $3$),
    node((-0.5, 2.5), $4$),
    node((-1.25, 2), $5$),
    node((-1.25, 1), $6$),
  ),
  diagram(
    node-stroke: 0pt,
    spacing: (1em, 2em),
    node((-1, 0), $111$, name: <fst>),
    edge("->"),
    node((1, 0), $000$),
    edge("->"),
    node((2, 1), $001$),
    edge("->"),
    node((2, 2), $010$),
    edge("->"),
    node((1, 3), $011$),
    edge("->"),
    node((-1, 3), $100$),
    edge("->"),
    node((-2, 2), $101$),
    edge("->"),
    node((-2, 1), $110$),
    edge("->", <fst>),

    node((-0.5, 0.5), $-1$),
    node((0.5, 0.5), $0$),
    node((1.25, 1), $1$),
    node((1.25, 2), $2$),
    node((0.5, 2.5), tr[$3$]),
    edge("->", stroke: colors.red),
    node((-0.5, 2.5), tr[$-4$]),
    node((-1.25, 2), $-3$),
    node((-1.25, 1), $-2$),
  ),

  [#tr[unsigned:] Überlauf von $7$ auf $0$],
  [#tr[signed:] Überlauf von $3$ auf $-4$],
)

== Bit

#deftbl(
  [set bit (gesetztes Bit)],
  $1$,
  [cleared bit (gelöschtes Bit)],
  $0$,
  [LSB],
  [Least Significant Bit (Bit $0$)],
  [MSB],
  [Most Significant Bit (Bit $n-1$) in einer $n$-stelligen Binärzahl],
  [Nibble],
  [Binärzahl mit 4 Bit],
  [Oktett],
  [Binärzahl mit 8 Bit],
  [Byte],
  [Oktett],
)

== Präfixe

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [Binär], [Näherung], [Binärpräfix], [Dezimal], [Dezimalpräfix],
  [$2^10$], [$1.024 dot 10^3$], [Ki - Kibi], [$10^3$], [K - Kilo],
  [$2^20$], [$1.049 dot 10^6$], [Mi - Mebi], [$10^6$], [M - Mega],
  [$2^30$], [$1.074 dot 10^9$], [Gi - Gibi], [$10^9$], [G - Giga],
  [$2^40$], [$1.100 dot 10^12$], [Ti - Tebi], [$10^12$], [T - Tera],
  [$2^50$], [$1.126 dot 10^15$], [Pi - Pebi], [$10^15$], [P - Peta],
  [$2^60$], [$1.153 dot 10^18$], [Ei - Exbi], [$10^18$], [E - Exa],
)

#ta.start-note()
=== Multiplikation/Division

#ta.start-field()
+ Umformen in Potenzschreibweise
+ Addition der Exponenten
+ Umformen in Präfixschreibweise

Beispiel: $128K dot 64M = 2^7 dot 2^10 dot 2^6 dot 2^20 = 2^(17+26) = 2^(43) = 2^3 dot 2^40 = 8T$
#ta.end-note()

= Codierungen

Erst wenn man die Codierung kennt, kann man daten richtig interpretieren.

== Warum reicht eine einzige Zahlendarstellung nicht aus?

- Negative Zahlen
  - Vorzeichen-Bit
  - Einerkomplement
  - Exzess-Code
- Sehr grosse und kleine Zahlen
  - Fixkomma ist unflexibel
  - 334 Milliarden + 0.00001
- Genauigkeit
  - 0.1 ist im Dualsystem nicht exakt darstellbar
  - Rundungsfehler unvermeidbar
- Nicht nur Zahlen
  - Textdarstellung
  - Zeichenkodierungen

== Vorzeichen

Jede Codierung optimiert eine andere Eigenschaft

- Betrag mit Vorzeichen: Intuition
- Einerkomplement: Einfache Negation
- Zweierkomplement: Arithmetische Effizienz
- Exzess: Vergleichbarkeit/Sortierung

#let tc0 = table.cell.with(fill: colors.darkblue.lighten(60%))
#let tc7 = table.cell.with(fill: colors.green.lighten(20%))
#let tc6 = table.cell.with(fill: colors.green.lighten(30%))
#let tc5 = table.cell.with(fill: colors.green.lighten(40%))
#let tc4 = table.cell.with(fill: colors.green.lighten(50%))
#let tc3 = table.cell.with(fill: colors.green.lighten(60%))
#let tc2 = table.cell.with(fill: colors.green.lighten(70%))
#let tc1 = table.cell.with(fill: colors.green.lighten(80%))
#let tcn8 = table.cell.with(fill: colors.red)
#let tcn7 = table.cell.with(fill: colors.red.lighten(20%))
#let tcn6 = table.cell.with(fill: colors.red.lighten(30%))
#let tcn5 = table.cell.with(fill: colors.red.lighten(40%))
#let tcn4 = table.cell.with(fill: colors.red.lighten(50%))
#let tcn3 = table.cell.with(fill: colors.red.lighten(60%))
#let tcn2 = table.cell.with(fill: colors.red.lighten(70%))
#let tcn1 = table.cell.with(fill: colors.red.lighten(80%))

#add-note(
  format: note-answer,
  "Codierungen, um Zahlen mit Vorzeichen darzustellen",
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    [Binär], [Betrag mit V.], [EinerK.], [ZweierK.], [$C_(e x, - 8, 4)$],
    `0000`, tc0[` 0`], tc0[` 0`], tc0[` 0`], tcn8[`-8`],
    `0001`, tc1[` 1`], tc1[` 1`], tc1[` 1`], tcn7[`-7`],
    `0010`, tc2[` 2`], tc2[` 2`], tc2[` 2`], tcn6[`-6`],
    `0011`, tc3[` 3`], tc3[` 3`], tc3[` 3`], tcn5[`-5`],
    `0100`, tc4[` 4`], tc4[` 4`], tc4[` 4`], tcn4[`-4`],
    `0101`, tc5[` 5`], tc5[` 5`], tc5[` 5`], tcn3[`-3`],
    `0110`, tc6[` 6`], tc6[` 6`], tc6[` 6`], tcn2[`-2`],
    `0111`, tc7[` 7`], tc7[` 7`], tc7[` 7`], tcn1[`-1`],
    `1000`, tc0[` 0`], tcn7[`-7`], tcn8[`-8`], tc0[` 0`],
    `1001`, tcn1[`-1`], tcn6[`-6`], tcn7[`-7`], tc1[` 1`],
    `1010`, tcn2[`-2`], tcn5[`-5`], tcn6[`-6`], tc2[` 2`],
    `1011`, tcn3[`-3`], tcn4[`-4`], tcn5[`-5`], tc3[` 3`],
    `1100`, tcn4[`-4`], tcn3[`-3`], tcn4[`-4`], tc4[` 4`],
    `1101`, tcn5[`-5`], tcn2[`-2`], tcn3[`-3`], tc5[` 5`],
    `1110`, tcn6[`-6`], tcn1[`-1`], tcn2[`-2`], tc6[` 6`],
    `1111`, tcn7[`-7`], tc0[` 0`], tcn1[`-1`], tc7[` 7`],
  ),
)

#ta.start-note()
=== Betrag mit Vorzeichen

#ta.start-field()
Erstes Bit signalisiert, ob Zahl positiv ($0$) oder Negativ ($1$) ist.

Problem: Bekannte Rechenregeln funktionieren nicht.

$
  & -19_10            && + 1_10              &&                     && = -18_10 \
  & 1001 space 0011_2 && + 0000 space 0001_2 && = 1001 space 0100_2 && = -20_10
$
#ta.end-note()

#exbox(title: "Codierung Betrag mit Vorzeichen", grid(
  columns: (1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = -3_10$
  ],
  [
    _Dezimal $->$ Binär_

    $3_10 = x 011_2$
  ],
  [
    _Ergebnis_

    $-3_10 = 1011_2$
  ],
))
#exbox(title: "Decodierung Betrag mit Vorzeichen", grid(
  columns: (1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = 1001_2$
  ],
  [
    _Binär $->$ Dezimal_

    $x 001_2 = 1_10$
  ],
  [
    _Ergebnis_

    $1001_2 = -1_10$
  ],
))

#ta.start-note()
=== (b-1) Komplement / Einerkomplement

#ta.start-field()
Von allen bits wird das Komplement gebildet.

Problem: $0000 space 00000_2 = 1111 space 1111_2 = 0_10$
#ta.end-note()

#exbox(title: "Codierung (b-1) Komplement", grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = -5_10$
  ],
  [
    _Dezimal $->$ Binär_

    $5_10 = 0101_2$
  ],
  [
    _Komplement_

    $0101_2 => 1010_2$
  ],
  [
    _Ergebnis_

    $-5_10 = 1010_2$
  ],
))
#exbox(title: "Decodierung (b-1) Komplement", grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = 1011_2$
  ],
  [
    _Komplement_

    $1011_2 => 0100_2$
  ],
  [
    _Binär $->$ Dezimal_

    $0100_2 = 4_10$
  ],
  [
    _Ergebnis_

    $1011_2 = -4_10$
  ],
))

#ta.start-note()
=== (b) Komplement / Zweierkomplement

#ta.start-field()
Nach der Komplementbildung wird $1$ addiert.
#ta.end-note()

#exbox(title: "Codierung (b) Komplement", grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = -5_10$
  ],
  [
    _Dezimal $->$ Binär_

    $5_10 = 0101_2$
  ],
  [
    _Komplement_

    $0101_2 => 1010_2$
  ],
  [
    _+1_

    $0101_2 => 1011_2$
  ],
  [
    _Ergebnis_

    $-5_10 = 1011_2$
  ],
))
#exbox(title: "Decodierung (b) Komplement", grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = 1111_2$
  ],
  [
    _-1_

    $1111_2 => 1110_2$
  ],
  [
    _Komplement_

    $1110_2 => 0001_2$
  ],
  [
    _Binär $->$ Dezimal_

    $0001_2 = 1_10$
  ],
  [
    _Ergebnis_

    $1111_2 = -1_10$
  ],
))

#ta.start-note()
=== Exzess-Codierung (Bias-Code)

#ta.start-field()
Darstellung vorzeichenbehafteter Zahlen durch *Verschiebung des Wertebereichs*.

Statt negativer Zahlen wird ein *Offset (Bias)* addiert
#ta.end-note()

#defbox($C_(e x, - B, n) (x)$, [
  $C_(e x) =$ Exzess-Codierung \
  $-B =$ Bias (negativer Überhang zur 0) \
  $n =$ Länge der binären Schreibweise \
  $x =$ zu codierende Zahl \

  Gespeichert wird: $c = x + B$

  Decodierung: $x = c - B$
])

#table(
  columns: (1fr, 1fr, 1fr),
  [Gegeben], [Codierung], [Decodierung],
  [
    Basis $b = 2$ \
    Wortbreite $n$ \
    Bias $B$ \
    typischerweise: $B = 2^(n - 1) - 1$
  ],
  [$C_(e x , - B, n) (x) = x + B$

    mit $x in [-B, 2^n - 1 - B]$],
  $x = c - B$,
)

#exbox(title: "Codierung Bias-Code", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Bias: $B = 2^7 - 1 = 127$ \
    Zu codierende Zahl: $x = -5$
  ],
  [
    _Bias addieren_

    $c = x + B = -5 + 127 = 122$

    _Dezimal $->$ Binär_

    $#dec(122) = #bin(122)$

    _Ergebnis_

    $C_(e x, -127,8) (-5) = #bin(122)$
  ],
))

#exbox(title: "Decodierung Bias-Code", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Bias: $B = 2^7 - 1 = 127$ \
    Bitmuster: $C_(e x, -127,8) = #bin(122)$
  ],
  [
    _Binär $->$ Dezimal_

    $#bin(122) = #dec(122)$

    _Bias subtrahieren_

    $x = c - B = 122 - 127 = -5$

    _Ergebnis_

    $#bin(122) => -#dec(5)$
  ],
))

== Gleitkommazahlen

#ta.start-note()
=== Fixkommazahl

#ta.start-field()
Skalierte Ganzzahl

#table(
  columns: (1fr, 1fr),
  [Pro], [Contra],
  [Einfache Implementierung], [Fester Wertebereich],
  [Deterministische Genauigkeit], [Feste Auflösung],
  [Keine Exponentendarstellung], [Überlauf bei grossen Zahlen],
  [Schnelle Berechnung],
  [Ungeeignet für stark unterschiedliche Grössenordnungen],
)
#ta.end-note()

#defbox($C_(F K, k, n) (x) = x dot 2^k$, [
  $C_(F K) =$  Fixkomma-Codierung \
  $k =$ Anzahl Nachkommabits \
  $n =$ Länge der binären Schreibweise - daraus ergibt sich die Anzahl der Vor-Kommastellen: $n - k$  \
  $x =$ zu codierende Zahl \
  $I =$ Ganzzahl
])

#exbox(title: "Codierung Fixkommazahl", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Nachkommabits: $k = 4$ \
    Zu codierende Zahl: $x = 3.25$
  ],
  [
    _Skalieren_

    $I = x dot 2^k = 3.25 dot 16 = 52$

    _Dezimal $->$ Binär_

    $#dec(52) = #bin(52)$

    _Ergebnis_

    $C_(F K, 4, 8) (3.25) = #bin(52)$
  ],
))

#exbox(title: "Decodierung Fixkommazahl", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Nachkommabits: $k = 4$ \
    Bitmuster: $C_(F K, 4, 8) (3.25)$
  ],
  [
    _Binär $->$ Dezimal_

    $#bin(52) = #dec(52) = I$

    _Skalieren_

    $x = I/2^k = 52/16 = 3.25$

    _Ergebnis_

    $#bin(52) => 3.25_10$
  ],
))

#ta.start-note()
=== Allgemeiner Wertebereich

#ta.start-field()
Wertebereich bei $n$ Bit und $k$ Nachkommabits

#table(
  columns: (1fr, 1fr, 1fr),
  [], [Ganzzahlbereich], [Reeller Bereich],
  [unsigned], $ I in [0,2^n - 1] $, $ x in [0, (2^n - 1)/2^k] $,
  [signed],
  $ I in [-2^(n-1),2^(n-1) - 1] $,
  $ x in [-(2^(n-1))/2^k, (2^(n-1) - 1)/2^k] $,
)
#ta.end-note()

#exbox(grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Nachkommabits: $k = 3$ \
    Darstellung im Zweierkomplement (= inkl. Vorzeichen)
  ],
  [
    _Ganzzahlbereich_

    $I in [-2^(8-1),2^(8-1)-1] = [-128,127]$

    _Reeller Bereich_

    $
      x = I/2^k = I/8 \
      x_min = (-128)/8 = -17 \
      x_max = 127/8 = 15.875
    $

    _Ergebnis_

    $x in [-16,15.875]$
  ],
))

#ta.start-note()
=== Auflösung

#ta.start-field()
Kleinster darstellbarer Schritt: $Delta x = 2^(-k)$

Absoluter Fehler: $E_"abs" = abs(x_"korrekt" - x_"gerundet")$

Relativer Fehler: $E_"rel" = abs(x_"korrekt" - x_"gerundet")/x_"korrekt"$
#ta.end-note()

=== Arithmetik

Addition, Subtraktion und Zweierkomplement sind wie bei Ganzzahlen

- Addiert man zwei Fixkommazahlen $z_0 + z_1$ mit $k_0 > k_1$, so muss $z_1$ um $k_0 − k_1$ Bits nach rechts geschoben werden.

Multiplikation und Division verschieben das Komma

- Multipliziert man zwei Fixkommazahlen $z_0 dot z_1 = z_2$, dann ist $k_2 = k_0 + k_1$

$k$ muss für jede Zahl berücksichtigt werden

- Wird von den meisten Programmiersprachen kaum unterstützt
- Meist von Hand in Kommentaren
- Limitiert die Zahlen auf Bereiche, die zur Compilezeit bekannt sind
- unflexibel und fehleranfällig, aber performant

== Gleitkomma

#defbox($plus.minus m dot 2^e$, [
  $m =$ Mantisse (Signifikand) \
  $e =$ Exponent
])

// FIXME: table 0th row color only if th

#grid(
  columns: (auto, 8fr, 23fr),
  stroke: 1pt,
  gutter: 0pt,
  inset: .5em,
  align: center + horizon,
  grid.cell(colspan: 3, $<- 32 "Bit" ->$),
  grid.cell(fill: colors.darkblue.transparentize(60%), $plus.minus$),
  grid.cell(fill: colors.purple.transparentize(60%), [$8-"Bit"$\ Exponent]),
  grid.cell(fill: colors.red.transparentize(60%), [$23-"Bit"$\ Mantisse]),
)
$ #td($plus.minus$) (1 + #tr("Mantisse")) dot 2^(#tp("Exponent") -127) $

#exbox(title: "Codierung Gleitkommazahl", [
  _Gegeben_

  Zu codierende Zahl: $x = -42.625$

  _Vorzeichenbit bestimmen_

  $x$ ist negativ, somit eine $1$

  _Mantisse Dezimal $->$ Binär_

  $underbrace(101010, 42).underbrace(101, 0.625)$

  _Komma verschieben_

  $101010.101_2 dot 2^0 = 1.01010101_2 dot 2^5$

  _Runden_

  Bei Überfluss: falls vorherige Bit eine $1$ ist, aufrunden, ansonsten kürzen (in diesem Beispiel nicht nötig).

  _Bias addieren_

  $5 + 127 = 132$

  _Exponent Dezimal $->$ Binär_

  $132_10 => 1000 space 0100_2$

  _Zusammensetzen_

  $#td($1$) | #tp($1000 space 0100$) | (1) #tr($010 space 1010 space 1000 space 0000 space 0000 space 0000$)$
  $=> #td($1$)#tp($100 space 0010 space 0$)#tr($010 space 1010 space 1000 space 0000 space 0000 space 0000$) _2$
])
#exbox(title: "Decodierung Gleitkommazahl", [
  _Gegeben_

  Bitmuster: $#td($0$)#tp($100 space 0001 space 0$)#tr($011 space 0110 space 0000 space 0000 space 0000 space 0000$) _2$

  _Komponenten extrahieren_

  $#td($0$) | #tp($1000 space 0010$) | (1) #tr($011 space 0110 space 0000 space 0000 space 0000 space 0000$)$

  _Erstes Bit_

  $0 =$ Zahl ist positiv

  _Exponent Binär $->$ Dezimal_

  $1000 space 0010_2 => 130_10$

  _Bias subtrahieren_

  $130 - 127 = 3$

  _Mantisse Binär $->$ Dezimal_

  $011 space 0110 space 0000 space 0000 space 0000 space 0000_2 => 0.40625_10$

  _Zusammensetzen_

  $+1 dot (1 + 0.40625) dot 2^3 = 11.25$
])

=== Sonderfälle

#table(
  columns: (auto, auto, auto, 1fr, auto),
  [Fall], [Vorzeichenbit], [Exponent], [Mantisse], [Beispielwert],
  [Positive Null],
  $0$,
  $0000 space 0000$,
  $000 space 0000 space 0000 space 0000 space 0000 space 0000$,
  $+0$,

  [Negative Null],
  $1$,
  $0000 space 0000$,
  $000 space 0000 space 0000 space 0000 space 0000 space 0000$,
  $-0$,

  [Positive\ Unendlichkeit],
  $0$,
  $1111 space 1111$,
  $000 space 0000 space 0000 space 0000 space 0000 space 0000$,
  $+oo$,

  [Negative\ Unendlichkeit],
  $1$,
  $1111 space 1111$,
  $000 space 0000 space 0000 space 0000 space 0000 space 0000$,
  $-oo$,

  [NaN],
  [$0$ oder $1$],
  $1111 space 1111$,
  [mindestens ein Bit $1$],
  [Nicht darstellbare\ Werte],

  [Subnormale\ Zahlen],

  [$0$ oder $1$],
  $0000 space 0000$,
  [mindestens ein Bit $1$],
  [$approx 1.4 dot 10^(−45)$\ (positiv)],
  [Normalisierte\ Zahlen],

  [$0$ oder $1$],
  [alles ausser\ $0000 space 0000$ und\ $1111 space 1111$],
  [beliebig],
  [Alle regulären\ Werte],
)

=== Präzision

Viele Zahlen können nicht präzise dargestellt werden

- $0.1_10 = 0.0001100110011...$
  - Abbruch nach 23 Bits
  - Beispiel: $0.1 + 0.2 != 0.3$
- Präzision für "Single Precision": $epsilon approx 2^(-23) approx 10^(-7)$
  - $epsilon$ ist die kleinste relative Differenz nahe 1

=== Addition

+ Hidden Bit ergänzen
+ Exponenten vergleichen
  - Wenn unterschiedlich: Bei kleinerer Zahl Mantisse nach rechts schieben
+ Vorzeichen berücksichtigen
  - Gleiche Vorzeichen: Addieren
  - Unterschiedliche Vorzeichen: Subtrahieren
+ Addition/Subtraktion der Signifikanden
+ Falls Carry = 1: Normalisieren
  - Erhöhe Exponent um 1
  - Schiebe Signifikand um 1 nach rechts
+ Hidden Bit entfernen

#exbox(title: [Gleitkomma addition: $x=1.5,y=0.75$], [
  + Hidden Bit ergänzen
  $
    x' = 0 | 0111 space 1111 | (1) 100 space 0000 space 0000 space 0000 space 0000 space 0000 \
    y' = 0 | 0111 space 1110 | (1) 100 space 0000 space 0000 space 0000 space 0000 space 0000
  $
  + Exponent verschieben bei $y'$
  $
    x'' = 0 | 0111 space 1111 | (1) 100 space 0000 space 0000 space 0000 space 0000 space 0000 \
    y'' = 0 | 0111 space 1111 | (0) 110 space 0000 space 0000 space 0000 space 0000 space 0000
  $
  + Vorzeichen: beide positiv → Addition
  + Addition $z'' = x'' + y''$
  $
    z'' = 0 | 0111 space 1111 | (10) 010 space 0000 space 0000 space 0000 space 0000 space 0000
  $
  + Carry = 1: Normalisieren
  $
    z' = 0 | 1000 space 0000 | (1) 001 space 0000 space 0000 space 0000 space 0000 space 0000
  $
  + Hidden Bit entfernen
  $
    z = 0 | 1000 space 0000 | 001 space 0000 space 0000 space 0000 space 0000 space 0000
  $
])

=== IEEE 754 - Single vs. Double

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [Format], [Bits], [Vorzeichen], [Exponent], [Mantisse], [Bias],
  [Single], [32], [1], [8], [23], [-127],
  [Double], [64], [1], [11], [52], [-1023],
)
- Grösserer Exponent $->$ grösserer Wertebereich
- Grössere Mantisse $->$ höhere Präzision
  - Single Precision: $epsilon approx 2^(−23) approx 10^(−7)$
  - Double Precision: $epsilon approx 2^(−52) approx 10^(−16)$
• Interpretation
- Single $approx 7$ signifikante Dezimalstellen
- Double $approx 15^(–16)$ signifikante Dezimalstellen

== Text

- Text besteht aus einer endlichen Folge von Zeichen: Buchstaben, Zahlen, Satzzeichen usw.
- Alle Zeichen stammen aus einer endlichen Menge $Z$, dem Zeichensatz (character set)
  - Jedem Zeichen kann eindeutig eine natürliche Zahl zugeordnet werden
- Ein Encoding (character encoding, Zeichenkodierung) ist eine bijektive Funktion $E$, die jedem Zeichen $z$ eine natürliche Zahl zuordnet
  - $E: Z -> {0,1, ... , abs(Z) −1}$
  - Text mit $n$ Zeichen $z_0, ..., z_(n−1)$ kann als endliche Folge von kodierten Zeichen beschrieben werden

=== ASCII

American Standard Code for Information Interchange

- Grösse des Zeichensatzes: $2^7 = 128 -> 7 "Bit"$ (nicht 8 Bit!)
- 8-Bit-ASCII sind Extended ASCII-Varianten und nicht standardisiert, sondern Codepages – bspw.:
  − ISO-8859-1 (Latin-1)
  - für westeuropäische Sprachen mit zusätzlichen Buchstaben wie ä, ö, ü, é usw.
  − Windows-1252
  - Microsoft-Codepage – weitgehend wie ISO-8859-1 mit typografischen Zeichen wie €, “ usw.
  − Codepage 437
  - IBM-PC-Zeichensatz mit grafischen Symbolen, Linienzeichen und Sonderzeichen
- Enthält druckbare (darstellbare) Zeichen und (nicht darstellbare) Steuerzeichen (0x00=NUL, 0x07=BEL, …)

#let cd = grid.cell.with(fill: colors.darkblue.lighten(40%))
#let c1 = grid.cell.with(fill: colors.purple.lighten(20%))
#let c2 = grid.cell.with(fill: colors.purple.lighten(40%))
#let c3 = grid.cell.with(fill: colors.purple.lighten(60%))
#grid(
  columns: (
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
    1fr,
  ),
  rows: (3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em),
  gutter: 0pt,
  stroke: 1pt,
  align: center + horizon,
  [],
  [0],
  [1],
  [2],
  [3],
  [4],
  [5],
  [6],
  [7],
  [8],
  [9],
  [A],
  [B],
  [C],
  [D],
  [E],
  [F],

  [0],
  [*NUL*\ 00],
  [SOH\ 01],
  [STX\ 02],
  [ETX\ 03],
  [EOT\ 04],
  [ENQ\ 05],
  [ACK\ 06],
  [BEL\ 07],
  [*BS*\ 08],
  [*TAB*\ 09],
  [*LF*\ 0A],
  [VT\ 0B],
  [FF\ 0C],
  [*CR*\ 0D],
  [SO\ 0E],
  [SI\ 0F],

  [1],
  [DLE\ 10],
  [DC1\ 11],
  [DC2\ 12],
  [DC3\ 13],
  [DC4\ 14],
  [NAK\ 15],
  [SYN\ 16],
  [ETB\ 17],
  [CAN\ 18],
  [EM\ 19],
  [SB\ 1A],
  [ESC\ 1B],
  [FS\ 1C],
  [GS\ 1D],
  [RS\ 1E],
  [US\ 1F],

  [2],
  cd[*SP*\ 20],
  cd[*!*\ 21],
  cd[*“*\ 22],
  cd[*\#*\ 23],
  cd[*\$*\ 24],
  cd[*%*\ 25],
  cd[*&*\ 26],
  cd[*‘*\ 27],
  cd[*\(*\ 28],
  cd[*\)*\ 29],
  cd[*\**\ 2A],
  cd[*+*\ 2B],
  cd[*,*\ 2C],
  cd[*–*\ 2D],
  cd[*.*\ 2E],
  cd[*\/ *\ 2F],

  [3],
  c1[*0*\ 30],
  c1[*1*\ 31],
  c1[*2*\ 32],
  c1[*3*\ 33],
  c1[*4*\ 34],
  c1[*5*\ 35],
  c1[*6*\ 36],
  c1[*7*\ 37],
  c1[*8*\ 38],
  c1[*9*\ 39],
  cd[*:*\ 3A],
  cd[*;*\ 3B],
  cd[*<*\ 3C],
  cd[*\=*\ 3D],
  cd[*>*\ 3E],
  cd[*?*\ 3F],

  [4],
  cd[*@*\ 40],
  c2[*A*\ 41],
  c2[*B*\ 42],
  c2[*C*\ 43],
  c2[*D*\ 44],
  c2[*E*\ 45],
  c2[*F*\ 46],
  c2[*G*\ 47],
  c2[*H*\ 48],
  c2[*I*\ 49],
  c2[*J*\ 4A],
  c2[*K*\ 4B],
  c2[*L*\ 4C],
  c2[*M*\ 4D],
  c2[*N*\ 4E],
  c2[*O*\ 4F],

  [5],
  c2[*P*\ 50],
  c2[*Q*\ 51],
  c2[*R*\ 52],
  c2[*S*\ 53],
  c2[*T*\ 54],
  c2[*U*\ 55],
  c2[*V*\ 56],
  c2[*W*\ 57],
  c2[*X*\ 58],
  c2[*Y*\ 59],
  c2[*Z*\ 5A],
  cd[*\[*\ 5B],
  cd[*\\*\ 5C],
  cd[*\]*\ 5D],
  cd[*^*\ 5E],
  cd[*\_*\ 5F],

  [6],
  cd[*\`*\ 60],
  c3[*a*\ 61],
  c3[*b*\ 62],
  c3[*c*\ 63],
  c3[*d*\ 64],
  c3[*e*\ 65],
  c3[*f*\ 66],
  c3[*g*\ 67],
  c3[*h*\ 68],
  c3[*i*\ 69],
  c3[*j*\ 6A],
  c3[*k*\ 6B],
  c3[*l*\ 6C],
  c3[*m*\ 6D],
  c3[*n*\ 6E],
  c3[*o*\ 6F],

  [7],
  c3[*p*\ 70],
  c3[*q*\ 71],
  c3[*r*\ 72],
  c3[*s*\ 73],
  c3[*t*\ 74],
  c3[*u*\ 75],
  c3[*v*\ 76],
  c3[*w*\ 77],
  c3[*x*\ 78],
  c3[*y*\ 79],
  c3[*z*\ 7A],
  cd[*{*\ 7B],
  cd[*|*\ 7C],
  cd[*}*\ 7D],
  cd[*\~*\ 7E],
  cd[*DEL*\ 7F],
)

=== Unicode

Globale Zeichennummerierung

- ASCII-kompatibel
- 1 bis 4 Byte pro Zeichen
- Häufige (westliche) Zeichen kurz
- Seltene (westliche) Zeichen länger
- Das erste Byte verrät, wie viele Bytes folgen
- Unicode = Codepoint
- UTF-8 = Bytecodierung

==== Struktur

#table(
  columns: (auto, auto, 1fr),
  [Codepoint-Bereich], [Bytes], [Bitmuster],
  `U+0000  - U+007F`, `1`, `0xxxxxxx`,
  `U+0080  - U+07FF`, `2`, `110xxxxx 10xxxxxx`,
  `U+0800  - U+FFFF`, `3`, `1110xxxx 10xxxxxx 10xxxxxx`,
  `U+10000 - U+10FFFF`, `4`, `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx`,
)

- Erstes Byte zeigt Länge
- Folgebytes beginnen mit $10$
- ASCII-Zeichen (0-127) bleiben unverändert

==== Codierung

Gegeben: Unicode-Codepoint U

+ Bestimme den Wertebereich → Anzahl Bytes.
+ Schreibe U in Binärdarstellung.
+ Fülle die Bits in die x-Positionen des passenden Musters ein.
+ Wandle in Hex um.

#exbox([
  _Gegeben_

  Zeichen: `ä`

  _Unicode_

  $U = #hex(228) = #dec(228) = #bin(228)$

  Benötigt 8 Bit $->$ 2 Bytes

  _Muster einfügen_

  `110xxxxx 10xxxxxx` $=>$ \
  `11000011 10100100` $=> #bin(50084) = #hex(50084)$

  UTF-8(`ä`) = #hex(50084)
])

==== Decodierung

Gegeben: Bytefolge

+ Lies das erste Byte.
+ Bestimme anhand der führenden Bits die Länge.
+ Entferne die Strukturpräfixe (110, 10, etc.).
+ Füge die restlichen Bits zusammen.
+ Interpretiere als Codepoint.

#exbox([
  _Gegeben_

  #bin(14844588)

  _Muster entfernen_

  `11100010 10000010 10101100` \
  `1110xxxx 10xxxxxx 10xxxxxx` $=>$ \
  `    0010   000010   101100` $=> #bin(8364) = #hex(8364) = euro$
])

==== Encodings

_UTF-16_

- Meist 2 Bytes pro Zeichen
- Zeichen ausserhalb der BMP (Basic Multilingual Pane) benötigen in UTF-16 sogenannte Surrogate Pairs (4 Bytes)
- Nicht ASCII-kompatibel

Vorteil:

- Häufig effizient für asiatische Sprachen

Nachteil:

- Komplexere Handhabung

_UTF-32_

- Immer 4 Bytes pro Zeichen
- Direkter Zugriff auf Codepoints
- Sehr speicherintensiv

#table(
  columns: (auto, auto, 1fr, 1fr),
  [Encoding], [Länge], [Vorteil], [Nachteil],
  [UTF-8], [1-4 Byte], [ASCII-Kompatibel, effizient], [Variable Länge],
  [UTF-16], [2-4 Byte], [Teils effizient], [Surrogate-Komplexität],
  [UTF-32], [4 Byte], [Sehr einfach], [Hoher Speicherbedarf],
)

==== Basic Multilingual Plane (BMP)

Unicode ist als Zahlenraum definiert: $0 <= U <= #hex(1114111)$

Das sind #dec(1114111) mögliche Codepoints. Dieser Raum ist in Planes (Ebenen) aufgeteilt.

Die BMP umfasst $U + 0000$ bis $U + "FFFF"$, also: $0 <= U <= 65535$. Das sind genau 16 Bit.

In der BMP liegen:

- ASCII
- Lateinische Schriftzeichen
- Griechisch
- Kyrillisch
- Hebräisch
- Arabisch
- Viele asiatische Zeichen
- Mathematische Symbole
- Satzzeichen

= Boolsche Logik

- Eine Aussage ist entweder wahr ($1$) oder falsch ($0$)
- Aussagen können logisch verknüpft werden

#let t0 = table.cell(fill: colors-l.red, $0$)
#let t1 = table.cell(fill: colors-l.green, $1$)

#grid(
  columns: 3,
  [
    _Kommutativität_

    - $x and y = y and x$
    - $x or y = y or x$

    _Assoziativität_

    - $(x and y) and z = x and (y and z)$
    - $(x or y) or z = x or (y or z)$
  ],
  [
    _Distributivität_

    - $x and (y or z)\ = (x and y) or (x and z)$

    _Absorption_

    - $x or (x and y) = x$
    - $x and (x or y) = x$
  ],
  [
    ($x and y$ schreibt man auch als $x y$ oder $x dot y$ oder $x inter y$, $x or y$ als $x + y$ oder $x union y$)
    #align(center, table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      $x$, $y$, $x and y$, $x or y$, $x xor y$, $not x$,
      t0, t0, t0, t0, t0, t1,
      t0, t1, t0, t1, t1, t1,
      t1, t0, t0, t1, t1, t0,
      t1, t1, t1, t1, t0, t0,
    ))],
)

Dualitätsprinzip: Ersetze in einer wahren Gleichung $and <-> or$ und $0 <-> 1$, Ergebnis bleibt wahr.

#todo(link("../DMI/doc.pdf", "De-Morgan-Gesetze"))

== Terme

#deftbl(
  [Literal],
  [Variable oder Negation einer Variablen: $x_3$ (positiver Literal), $not x_3$ oder $overline(x_3)$ (negatives Literal)],
  [Konjunktionsterm],
  [Konjunktion von Literalen: $overline(x_1) x_3 x_4 = overline(x_1) and x_3 and x_4$],
  [Disjunktionsterm],
  [Disjunktion von Literalen: $overline(x_1) or x_3 or x_4$],
  [Minterm],
  [Konjunktionsterm, der alle Parameter der Funktion enthält: $x_0 overline(x_1) overline(x_2) x_3 x_4$],
  [Maxterm],
  [Disjunktionsterm, der alle Parameter der Funktion enthält: $x_0 or overline(x_1) or overline(x_2) or x_3 or x_4$],
)

== Normalformen

Standardisierte Schreibweise. Vorteile:

- aus Wahrheitstabelle konstruierbar
- Vereinfachung systematisch möglich
- Umsetzung als Schaltung (AND-OR-Structure) direkt ableitbar

=== Disjunktive Normalform

in Term ist in DNF, wenn er eine ODER-Verknüpfung von UND-Verknüpfungen ist, z.B.:

#todo("this is wrong")

$ f(x, y, z) = (not x and y) or (x and z) = not x and y or x and z $

Da $and$ eine höhere Bindungsstärke als $or$ hat, sind die Klammern nicht zwingend notwendig. Die kanonische DNF (KDNF) ist die Disjunktion der Minterme.

=== KV-Diagramm

Je grösser die Blöcke, desto einfacher wird das Ergebnis. Dabei müssen aber bestimmte Regeln eingehalten werden:

- Die Blöcke müssen immer rechteckig sein und
- die Grösse einer Zweierpotenz haben, also 2, 4, 8, 16, 32, ...
- Die Blöcke können auch über den Rand hinaus gehen und mit der gegenüberliegenden Seite verbunden werden,
- Blöcke können sich teilweise überlappen. Das kann sinnvoll sein, wenn dadurch grössere Blöcke entstehen.
- Werte, die sowohl einfach als auch negiert vorkommen, werden gestrichen
- Ein Block wird nur berücksichtigt, wenn seine Einsen nicht vollständig in anderen Blöcken enthalten sind. Andernfalls entsteht ein nichtessentieller Term, der redundant ist, da andere Terme bereits die gleichen Variablenbelegungen abdecken und nicht weiter vereinfacht werden können.

#let rectg = cetz.draw.rect.with(
  fill: colors.green.transparentize(60%),
  stroke: colors.green,
)
#let rectd = cetz.draw.rect.with(
  fill: colors.darkblue.transparentize(60%),
  stroke: colors.darkblue,
)
#let rectr = cetz.draw.rect.with(
  fill: colors.red.transparentize(60%),
  stroke: colors.red,
)
#let ccvs = it => cetz.canvas(length: 1.5em, {
  cetz.draw.grid(
    (0, 0),
    (4, 4),
  )
  it
})

#grid(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center,
  grid.cell(colspan: 3, [_OK_]),
  grid.cell(colspan: 3, [_NOK_]),
  ccvs({
    rectg((0, 3), (2, 1))
    rectd((2, 4), (4, 0))
  }),
  ccvs({
    rectg((0, 3), (1, 1))
    rectg((3, 3), (4, 1))
  }),
  ccvs({
    rectd((0, 0), (1, 1))
    rectd((3, 0), (4, 1))
    rectd((0, 3), (1, 4))
    rectd((3, 3), (4, 4))
  }),
  ccvs({ rectr((1, 1), (3, 4)) }),
  ccvs({
    rectr((0, 0), (1, 1))
    rectr((1, 1), (2, 2))
    rectr((2, 2), (3, 3))
    rectr((3, 3), (4, 4))
  }),
  ccvs({
    cetz.draw.line(
      (1, 0),
      (1, 3),
      (3, 3),
      (3, 2),
      (2, 2),
      (2, 0),
      fill: colors.red.transparentize(60%),
      stroke: colors.red,
    )
  }),
)

== NAND (Not AND)

#grid(
  columns: (1fr, auto),
  [Universalbaustein

    $x underbrace(|, "Sheffer stroke") y = overline(x and y) = overline(x y)$

    - praktisch (in CMOS schnell sowie einfach aufzubauen)
    - funktional vollständig: jede Boolesche Funktion lässt sich nur mit NAND realisieren.
  ],
  table(
    align: center,
    columns: (4em, 4em, 4em, 4em),
    $x$, $y$, $x and y$, $x | y$,
    t0, t0, t0, t1,
    t0, t1, t0, t1,
    t1, t0, t0, t1,
    t1, t1, t1, t0,
  ),
)

#deftbl(
  term: "OP",
  definition: "impl",
  [NOT],
  $overline(x) = overline(x and x) = x | x$,
  [AND],
  $x and y = overline(x | y) = (x | y) | (x | y)$,
  [OR],
  $x or y = overline(overline(x or y)) = overline(overline(x) and overline(y)) = overline((x | x) and (y | y)) = (x | x) | (y | y)$,
)

== Von Logik zur Arithmetik

#let edge = edge.with(bend: 0deg, corner-radius: 0pt)
#let ndot = node.with(
  width: 4pt,
  height: 4pt,
  fill: colors.fg,
  shape: fletcher.shapes.circle,
)
#grid(
  columns: (auto, auto),
  [
    Boolesche Logik realisiert binäre Addition

    XOR bildet die Addition zweier Bits ab (im Zahlenraum mit nur $0$ und $1$, also $mod 2$), AND bildet den Übertrag ab
    - $s = x xor y ->$ Addition mod 2
    - $c = x and y ->$ Übertrag
  ],
  table(
    align: center,
    columns: (4em, 4em, 4em, 4em, 4em),
    $x$, $y$, $x + y$, $x and y$, $x xor y$,
    t0, t0, $00$, t0, t0,
    t0, t1, $01$, t0, t1,
    t1, t0, $01$, t0, t1,
    t1, t1, $10$, t1, t0,
  ),

  [
    _Halbaddierer (half adder)_
    - Kann 2 einstellige Binärzahlen addieren
    - Hat 2 Eingänge ($x, y$) und 2 Ausgänge ($s, c$)
  ],

  align(center, diagram(
    edge((-1, 0), (2, 0), "O-", label: $x$, label-pos: -1em),
    edge((-1, 1), (1, 1), "O-", label: $y$, label-pos: -1em),
    ndot((2, 0), ""),
    ndot((1, 1), ""),
    node(enclose: ((3, 0), (3, 1)), $\&$, width: 2.5em),
    edge((2, 0), (3, 0)),
    edge((1, 1), (3, 1)),
    node(enclose: ((3, 2), (3, 3)), $=1$, width: 2.5em),
    edge((2, 0), (2, 2), (3, 2)),
    edge((1, 1), (1, 3), (3, 3)),
    edge((3, 0.5), (4, 0.5), "-O", label: $c$, label-pos: 2em),
    edge((3, 2.5), (4, 2.5), "-O", label: $s$, label-pos: 2em),
  )),

  [
    _Volladdierer (full adder)_
    - Hat 3 Eingänge ($x, y, c_(I N)$)
  ],
  align(center, diagram(
    ndot((2, 0), ""),
    ndot((1, 1), ""),
    edge((-1, 0), (2, 0), "O-", label: $x$, label-pos: -1em),
    edge((-1, 1), (1, 1), "O-", label: $y$, label-pos: -1em),
    node(enclose: ((3, 0), (3, 1)), $\&$, width: 2.5em),
    edge((2, 0), (3, 0)),
    edge((1, 1), (3, 1)),
    node(enclose: ((3, 2), (3, 3)), $=1$, width: 2.5em),
    edge((2, 0), (2, 2), (3, 2)),
    edge((1, 1), (1, 3), (3, 3)),
    node((2.5, -1), stroke: none, "HA"),
    node(
      enclose: ((1, -0.5), (1, 3.5), (3.5, -0.5), (3.5, 3.5)),
      stroke: (dash: "dotted", paint: colors.fg),
      snap: -1,
    ),

    ndot((4, 2.5), ""),
    ndot((5, 3.5), ""),
    node(enclose: ((6, .5), (6, 1.5)), $\&$, width: 2.5em),
    node(enclose: ((6, 2.5), (6, 3.5)), $=1$, width: 2.5em),
    edge((4.5, 3.5), (6, 3.5)),
    edge((5, 3.5), (5, 1.5), (6, 1.5)),
    edge((-1, 3.5), (5, 3.5), "O-", label: $c_(I N)$, label-pos: -1em),
    edge((4, 2.5), (4, .5), (6, .5)),
    edge((4, 2.5), (4, 3), (6, 3)),
    edge((3, 2.5), (4, 2.5)),

    edge((2, 0), (3, 0)),
    edge((1, 1), (3, 1)),
    edge((2, 0), (2, 2), (3, 2)),
    edge((1, 1), (1, 3), (3, 3)),

    node(enclose: ((7.5, 0), (7.5, 1)), $>=1$, width: 2.5em),
    edge((3, 0), (7.5, 0)),
    edge((6, 1), (7.5, 1)),

    edge((7.5, .5), (9, .5), "-O", label: $c_(O U T)$, label-pos: 3em),
    edge((6, 3), (9, 3), "-O", label: $s$, label-pos: 6em),
    node((5.5, -.5), stroke: none, "HA"),
    node(
      enclose: ((4, 0), (6.5, 0), (4, 4), (6.5, 4)),
      stroke: (dash: "dotted", paint: colors.fg),
      snap: -1,
    ),
  )),

  grid.cell(colspan: 2, [
    _4-Bit Ripple carry adder_

    - Jedes Bit muss auf das Carry-Bit des letzten Volladierers warten
    #{
      // custom mark
      // cum
      // haha
      let cum = it => cetz.draw.content((0, 0), box(fill: colors.bg, it))
      let c-in-out = n => (
        (
          draw: cum($c^#(n) _(O U T)$),
          pos: .2,
        ),
        (inherit: "O", pos: 0),
        (inherit: "O", pos: 1),
        (
          draw: cum($c^#(n + 1) _(I N)$),
          pos: .8,
        ),
      )
      align(center, diagram(
        spacing: (3em, 1em),
        edge((-0.25, 0), (-0.25, 1), "O-", label: $x_1$, label-pos: -1em),
        edge((0.25, 0), (0.25, 1), "O-", label: $y_1$, label-pos: -1em),
        node((0, 1), $"FA"_1$, width: 3em, height: 3em),
        edge((0, 1), (0, 2), "O-", label: $s_1$, label-pos: 2em),
        edge(
          (0, 1),
          (3, 1),
          marks: c-in-out(1),
        ),
        edge((2.75, 0), (2.75, 1), "O-", label: $x_2$, label-pos: -1em),
        edge((3.25, 0), (3.25, 1), "O-", label: $y_2$, label-pos: -1em),
        node((3, 1), $"FA"_2$, width: 3em, height: 3em),
        edge((3, 1), (3, 2), "O-", label: $s_2$, label-pos: 2em),
        edge(
          (3, 1),
          (6, 1),
          marks: c-in-out(2),
        ),
        edge((5.75, 0), (5.75, 1), "O-", label: $x_3$, label-pos: -1em),
        edge((6.25, 0), (6.25, 1), "O-", label: $y_3$, label-pos: -1em),
        node((6, 1), $"FA"_3$, width: 3em, height: 3em),
        edge((6, 1), (6, 2), "O-", label: $s_3$, label-pos: 2em),
        edge(
          (6, 1),
          (9, 1),
          marks: c-in-out(3),
        ),
        edge((8.75, 0), (8.75, 1), "O-", label: $x_4$, label-pos: -1em),
        edge((9.25, 0), (9.25, 1), "O-", label: $y_4$, label-pos: -1em),
        node((9, 1), $"FA"_4$, width: 3em, height: 3em),
        edge((9, 1), (9, 2), "O-", label: $s_4$, label-pos: 2em),
        edge((9, 1), (9.65, 1), "-O", label: $c_(O U T)$, label-pos: 3em),
      ))
    }]),
  grid.cell(colspan: 2)[
    _Carry Look-Ahead adder_

    - Reduziert propagations-delay durch komplexere hardware
  ],
)

== Definition $ZZ_2$

$ ZZ_2 = ({0,1},+,dot) $

- Abgeschlossen: Jede Operation erzeugt wieder ein Element in $ZZ_2$
- Es existiert das neutrale Element ($0$ für die Addition, $1$ für die Multiplikation)
- Jedes Element ist sein eigenes additives Inverses.
- Addition und Multiplikation sind kommutativ und assoziativ.
- Es gilt das Distributivgesetz.

=== Bitfolge Darstellungen

#table(
  columns: (1fr, 1fr),
  [Darstellung], [Beispiel],
  [Zahl], $#bin(5) = #dec(5)$,
  [Vektor], $(1,0,1)^T$,
  [Polynom], $u^2 + 1$,
)

==== Vektor

#exbox(
  title: [Bitfolge als Vektor in $ZZ_2^n$],
  $
    v,w in ZZ_2^4, v = vec(1, 0, 1, 1), w = vec(1, 1, 0, 1) \
    v + w = vec(1, 0, 1, 1) + vec(1, 1, 0, 1) equiv vec(0, 1, 1, 0) mod 2
  $,
)

==== Polynom

Polynome erlauben

- Verschiebungen elegant zu beschreiben
- Redundanz strukturiert zu erzeugen
- Generatorpolynome (zyklische Codes)
- CRC-Rechnung als Polynomdivision

#exbox(
  title: [Bitfolge als Polynom in $ZZ_2$],
  [$
      & [1 space 0 space 0 space 1 space 0 space 1] \
      & = 1u^5 + 0u^4 + 0u^3 + 1u^2 + 0u^1 + 1u^0 \
      & = u^5 + u^2 + 1
    $
    $u$ ist keine Zahl, $u^k$ beschreibt "Bitposition $k$"
  ],
)

#table(
  columns: (1fr, 1fr),
  [Polynomaddition in $ZZ_2$],

  [Polynommultiplikation in $ZZ_2$],

  $
    & (u^3 + u + 1) + (u^3 + u^2) \
    & = cancel(2u^3) + u^2 + u + 1 \
    & = u^2 + u + 1
  $,

  $
    & (u^2 + u + 1)(u + 1) \
    & =u^3 + cancel(2u^2) + cancel(2u) + 1 \
    & =u^3 + 1
  $,
)

== Fun games

#link("https://www.nandgame.com/", "NAND Game")

#link("https://www.nand2tetris.org/", "nand2tetris")

= Wahrscheinlichkeit

In realen Systemen trifft Unsicherheit auf. Diese lässt sich nicht exakt vorhersagen, sondern nur statistisch beschreiben. Dafür verwenden wir _Wahrscheinlichkeit_.

#deftbl(
  [Disjunke Ereignisse],
  [Ereignisse, die sich gegenseitig ausschliessen. Beispiel: $z$ ist gerade oder ungerade],
  [Zufallsvorgang],
  [Ein Vorgang mit mehreren möglichen Ergebnissen, dessen Ausgang nicht sicher vorhergesagt werden kann],
  [Zufallsexperiment],
  [Zufallsvorgang, der geplant ist und kontrolliert ablauft],
)

== Ergebnismenge

#deftbl(
  [Ergebnismenge],
  [Die _Ergebnismenge_ eines Zufallsvorgangs umfasst *alle möglichen Ausgänge* des Experiments. Sie wird mit dem Symbol $Omega$ (Omega) bezeichnet. Die Anzahl aller möglichen Ergebnisse der Ergebnismenge wird mit $abs(Omega)$ bezeichnet.],
  [Ergebnis],
  [Ein einzelner möglicher Ausgang $omega in Omega$ heisst _Ergebnis_],
  [Ereignis],
  [Ein _Ereignis_ ist eine Teilmenge der Ergebnismenge $A subset Omega$],
)

#exbox([
  Würfel: $Omega = {1, 2, 3, 4, 5, 6}$

  Werfen einer Münze so lange, bis Kopf erscheint: $Omega = {K, Z K, Z Z K, Z Z Z K, ...}$
])

== Eigenschaften

Für jedes Ereignis $A$ gilt $0 <= P(A) <= 1$.

#deftbl(
  definition: "Eigenschaft",
  [Sicheres Ereignis],
  [Die Wahrscheinlichkeit der gesamten Ergebnismenge ist $P(Omega) = 1$],
  [Unmögliches Ereignis],
  [Die Wahrscheinlichkeit der leeren Menge ist $P(emptyset) = 0$],
  [Additionsregel],
  [
    Für zwei Ereignisse $A$ und $B$: $P(A union B) = P(A) + P(B) - P(A inter B)$

    Für *disjunkte* Ereignisse: $P(A union B) = P(A) + P(B)$
  ],
  [Gegenereignis],
  [Wird notiert als $overline(A)$ und hat die Eigenschaft $P(overline(A)) = 1 - P(A)$.],
)

Wahrscheinlichkeit, dass $A_1$ oder $A_2$ auftritt: $P(A_1 or A_2) = P(A_1) + P(A_2)$

Wahrscheinlichkeit, dass zuerst $A_1$ und dann $A_2$ auftritt: $P(A_1 and A_2) = P(A_1) dot P(A_2)$

== Wahrscheinlichkeitsdefinition nach Laplace

Wenn ein Experiment eine Anzahl verschiedener und gleich möglicher Ausgänge hervorbringen kann und einige davon als günstig anzusehen sind, dann ist die Wahrscheinlichkeit eines günstigen Ausgangs gleich dem Verhältnis der Anzahl der günstigen zur Anzahl der möglichen Ausgänge.

$
  P(E) = "Anzahl günstiger Ergebnisse"/"Anzahl aller möglichen Ergebnisse" = abs(E)/abs(Omega)
$

Dabei gilt:

- $Omega$: Ergebnismenge (alle möglichen Ergebnisse)
- $E subset.eq Omega$: betrachtetes Ereignis
- $abs(E)$: Anzahl günstiger Ergebnisse
- $abs(Omega)$ : Anzahl aller möglichen Ergebnisse

#exbox(title: "Urnen", [

  Es gibt zwei Urnen, $U_1$ und $U_2$. Urne $U_1$ enthält 5 schwarze und 5 weisse Kugeln und Urne $U_2$ enthält 9 schwarze und 1 weisse Kugel. Die Wahrscheinlichkeit eine Kugel aus $U_1$ oder $U_2$ zu ziehen, ist gleich gross (50/50). Wie gross ist nun die Wahrscheinlichkeit eine weisse Kugel zu ziehen?

  #let node = node.with(width: 2em, height: 2em)
  #let edge = edge.with(crossing-fill: colors.blue.lighten(95%))

  #align(center, diagram(
    spacing: (3em, 3em),
    node-shape: fletcher.shapes.circle,
    node((3, 0), $space$, name: <s>),
    node((1, 1), $U_1$, name: <s1>),
    node((5, 1), $U_2$, name: <s0>),
    node((0, 2), $W$, name: <s11>, fill: colors-l.white),
    node((2, 2), $S$, name: <s10>, fill: colors-l.black),
    node((4, 2), $W$, name: <s01>, fill: colors-l.white),
    node((6, 2), $S$, name: <s00>, fill: colors-l.black),
    edge(<s>, <s1>, label: $P(U_1) = 0.5$, label-side: right),
    edge(<s>, <s0>, label: $P(U_2) = 0.5$, label-side: left),
    edge(<s1>, <s11>, label: $P(W|U_1) = 0.5$, label-side: right),
    edge(<s1>, <s10>, label: $P(S|U_1) = 0.5$, label-side: left),
    edge(<s0>, <s01>, label: $P(W|U_2) = 0.9$, label-side: right),
    edge(<s0>, <s00>, label: $P(S|U_2) = 0.1$, label-side: left),
  ))

  $
    P(W|U_1) and P(U_1) or P(W|U_2) and P(U_2) = & P(W|U_1) dot P(U_1) + P(W|U_2) dot P(U_2) \
    = & 0.5 dot 0.5 + 0.5 dot 0.1 \
    = & 0.25 + 0.05 \
    = & 0.3
  $

  Die Wahrscheinlichkeit beträgt also $30%$, eine weisse Kugel zu ziehen unter der Annahme, dass jede Urne mit gleicher Wahrscheinlichkeit gewählt wird.
])

== Kombinatorik

Laplace-Wahrscheinlichkeit erfordert Berechnung von Anzahlen. _Kombinatorik_ ist die Mathematische Technik hierfür.

#table(
  columns: (auto, 1fr, 1fr),
  [], [Wiederholung], [Keine Wiederholung],
  [_Anordnung_],
  link(<pmw>)[Permutation mit Wiederholung],
  link(<pow>)[Permutation ohne Wiederholung],

  [_Geordnete Auswahl_],
  link(<vmw>)[Variation mit Wiederholung],
  link(<vow>)[Variation ohne Wiederholung],

  [_Ungeordnete Auswahl_],
  link(<kmw>)[Kombination mit Wiederholung],
  link(<kow>)[Kombination ohne Wiederholung],
)

=== Permutation mit Wiederholung <pmw>

Anordnung von $n$ Objekten, die *nicht* alle voneinander unterscheidbar sind ($s$ Subsets $k$ mit gleichen Objekten).

$ (n!)/(k_1 ! k_2 ! ... k_s !) $

#exbox(
  title: "Anordnung drei roter und zwei blauer Kugeln",
  $
    s = 2, n = #tp($5$), k_1 = #tr($3$), k_2 = #td($2$), "Anzahl" = #tp($(5 dot 4 dot 3 dot 2 dot 1)$)/(#tr($(3 dot 2 dot 1)$)#td($(2 dot 1)$)) = 10
  $,
)

=== Permutation ohne Wiederholung <pow>

Anordnung von $n$ Objekten, die alle unterscheidbar sind.
// Es gibt $n!$ Möglichkeiten, $n$ unterscheidbare Objekte in einer Reihe anzuordnen.
$ n! $

#exbox(
  title: "Anordnung fünf verschiedenfarbiger Kugeln",
  $ "Anzahl" = 5 dot 4 dot 3 dot 2 dot 1 = 5! $,
)


=== Variation mit Wiederholung <vmw>

- Reihenfolge spielt eine Rolle
- Elemente dürfen mehrfach vorkommen

$ n^k $

#exbox(title: "PIN-Code mit 4 Ziffern", grid(
  align: center,
  columns: (1fr, 1fr),
  ```
  0000
  1234
  9876
  ```,
  [
    Jede Position hat 10 Möglichkeiten\ $"Anzahl" = 10 dot 10 dot 10 dot 10 = 10^4$
  ],
))

=== Variation ohne Wiederholung <vow>

- Reihenfolge spielt eine Rolle
- Elemente dürfen *nicht* mehrfach vorkommen

$ (n!)/((n - k)!) = product_n^(n - k + 1) n $

#exbox(
  title: "1., 2. und 3. Platz aus 10 Teilnehmern",
  $ "Anzahl" = 10 dot 9 dot 8 $,
)

=== Kombination mit Wiederholung <kmw>

- Reihenfolge spielt *keine* Rolle
- Elemente dürfen mehrfach vorkommen

$ binom(n + k - 1, k) = ((n+k - 1)!)/((n - 1)! dot k!) $

#exbox(
  title: "Es sollen drei von fünf verschiedenfarbigen Kugeln gezogen und wieder zurückgelegt werden.",
  $ "Anzahl" = binom(5 + 3 - 1, 3) = binom(7, 3) = 35 $,
)

=== Kombination ohne Wiederholung <kow>

- Reihenfolge spielt *keine* Rolle
- Elemente dürfen *nicht* mehrfach vorkommen

$
  binom(n, k) = ((n!)/((n-k)!))/(k!) = (n!)/(k!(n-k)!) = (product_n^(n-k+1) n)/(k!)
$

#exbox(title: "Lotto 6 aus 42", $ "Anzahl" = binom(42, 6) $)

=== Übersicht Auswahl

#let gt = grid.cell.with(fill: colors-l.purple)
#let gr = grid.cell(fill: colors-l.red, sym.crossmark)
#let gg = grid.cell(fill: colors-l.green, sym.checkmark)

#grid(
  columns: (auto, auto, 1fr, 1fr),
  align: center + horizon,
  inset: .5em,
  gutter: 0pt,
  stroke: 1pt + colors.fg,
  grid.cell(colspan: 4)[Anzahl $A$ der Möglichkeiten],
  grid.cell(colspan: 2, rowspan: 2)[#tg($n$) Optionen \ #tr($k$) Auswählen],
  gt(colspan: 2)[Beachtung der Reihenfolge],
  gg,

  gr,
  gt(rowspan: 2, [Wiederholung\ erlaubt]),
  gg,
  $ A = #tg($n$)^#tr($k$) $,

  $ A = binom(#tg($n$) + #tr($k$) - 1, #tr($k$)) $,
  gr,
  $
    A = #tg($n$) (#tg($n$) - 1) ... (#tg($n$) - #tr($k$) + 1) = (#tg($n$)!)/((#tg($n$) - #tr($k$))!)
  $,
  $
    A = (#tg($n$)!)/(#tr($k$)!(#tg($n$) - #tr($k$))!) = binom(#tg($n$), #tr($k$))
  $,
)

=== Hypergeometrische Verteilung

Die hypergeometrische Verteilung ist ein Modell, das verwendet wird, um die Wahrscheinlichkeit $P(k)$ von $k$ Erfolgen (gewünschten Ergebnissen) aus den $K$ gesamt möglichen Erfolgen aus $N$ Objekten in $n$ Ziehungen zu berechnen.

$
  P(k) = (binom(K, k) dot binom(N - K, n - k))/(binom(N, n))
$

#exbox(todo[])

== Bitfehler

#grid(
  columns: (1fr, auto),
  [
    Ein Bitfehler bezeichnet die inkorrekte Wiedergabe eines Bits während der Datenübertragung oder ‐speicherung. Das
    bedeutet, dass ein Bit von 0 zu 1 oder von 1 zu 0 fälschlicherweise geändert wird.

    Die Wahrscheinlichkeit, dass ein Datenblock der Grösse $n$ Bits bei einer Fehlerrate von $p$ fehlerhaft ist, kann mit folgender Formel berechnet werden:
  ],

  ```
   Bitübertragung
         │
    ┌────┴────┐
  Korrekt   Fehler
   1-p        p
  ```,
)

$ P("fehlerhaft") = 1 - (1 - p)^n $

Wahrscheinlichkeit für genau $k$ Fehler in einem Datenblock mit $n$ Bits bei Bitfehlerrate $p$ (Binomialverteilung):

$ P(k) = binom(n, k) dot p^k dot (1 - p)^(n - k) $

#exbox(title: "Bitfehler", [
  Gegeben sei eine Bitfehlerrate von $10^(−5)$. Wie gross ist die Wahrscheinlichkeit, dass ein Datenblock mit einer Grösse von $150$ kbit fehlerhaft ist?

  $ P("fehlerhaft") = 1 −(1 − 10^(−5))^(150 dot 10^3) approx 0.77687 $

  Was ist die Wahrscheinlichkeit für genau $2$ Fehler?

  $
    P(2) = binom(150 dot 10^3, 2) dot (10^(-5))^2 dot (1 - 10^(-5))^(150 dot 10^3 - 2) approx 0.25102
  $
])

== Gesamtwahrscheinlichkeit

Jede mögliche Fehleranordnung hat die Wahrscheinlichkeit
$ p^k (1-p)^(n-k) $
Es gibt $binom(n, k)$ solche Anforderungen. Darum gilt
$
  P(X=k) = overbrace(binom(n, k), "Anzahl Kombinationen") underbrace(p^k, k times "Erfolg") overbrace((1-p)^(n-k), n - k times "Misserfolg")
$

#exbox(title: "Schraubenproduktion", [
  Bei einer Schraubenproduktion ist jede 10e Schraube fehlerhaft. Was ist die Wahrscheinlichkeit, dass 2 von 3 Schrauben OK sind?
  $
    P(X = 2) = binom(3, 2) dot (9/10)^2 dot (1 - 9/10)^(3 - 2) = binom(3, 2) dot 81/100 dot 1/10 = 3 dot 81/1000 = 0.243
  $
])

#todo[example (slides 27)]

#todo[Restfehlerwahrscheinlichkeit]

== Binomialverteilung

$
  P(X=k) = binom(n, k)p^k (1-p)^(n-k) \
  E(X) = n p
$

Die Binomialverteilung beschreibt, wie wahrscheinlich es ist, dass bei $n$ unabhängigen Versuchen genau $k$ Erfolge auftreten.

In unserem Kontext bedeutet das:

- $n$ = Anzahl übertragener Bits
- $p$ = Bitfehlerwahrscheinlichkeit
- $k$ = Anzahl Fehler

#let xs = range(20)
#let prob-fn = (n, p, k) => (
  calc.binom(n, k) * calc.pow(p, k) * calc.pow((1 - p), n - k)
)
#grid(
  align: center + horizon,
  columns: (1fr, 1fr),
  lq.diagram(
    height: 6cm,
    width: 90%,
    title: [Binomialverteilung von Bitfehlern\ ($n = 20 "bits", p = 0.1$)],
    xaxis: (
      label: lq.label([Anzahl Fehler $k$], kind: "x", dy: 1em, dx: -100%),
    ),
    yaxis: (
      label: lq.label(
        [Wahrscheinlichkeit $P(X = k)$],
        angle: -90deg,
        kind: "y",
        dy: 100%,
        dx: -2em,
      ),
    ),
    lq.bar(xs, xs.map(k => prob-fn(20, 0.1, k))),
  ),
  lq.diagram(
    height: 6cm,
    width: 90%,
    title: [Kumulative Binomialverteilung\ ($n = 20 "bits", p = 0.1$)],
    xaxis: (
      label: lq.label([Anzahl Fehler $k$], kind: "x", dy: 1em, dx: -100%),
    ),
    ylim: (0, 1.05),
    yaxis: (
      label: lq.label(
        [Wahrscheinlichkeit $P(X = k)$],
        angle: -90deg,
        kind: "y",
        dy: 100%,
        dx: -2em,
      ),
    ),
    lq.plot(
      xs,
      xs.map(x => range(x + 1).map(k => prob-fn(20, 0.1, k)).sum()),
      step: end,
      mark: none,
    ),
  ),
)
#h(1em)

== Bedingte Wahrscheinlichkeit

Wie wahrscheinlich ist Ereignis $A$, wenn Ereignis $B$ bereits eingetreten ist? Formelle Schreibweise: $P(A|B)$.

Allgemein gilt für die bedingte Wahrscheinlichkeit: $ P(A|B) = P(A inter B) / P(B) $
Voraussetzung ist dabei, dass gilt: $ P(B) > 0 $

Die Formel bedeutet:
- Im Nenner steht die Wahrscheinlichkeit der Bedingung $B$.
- Im Zähler steht die Wahrscheinlichkeit, dass sowohl $A$ als auch $B$ eintreten.

Man betrachtet also nur noch den Teil des Wahrscheinlichkeitsraums, in dem $B$ gilt, und fragt dann, wie gross darin der Anteil der Fälle ist, in denen zusätzlich $A$ eintritt.

Daraus folgt die _Multiplikationsregel_:
$ P(A inter B) = P(A|B) dot P(B) $

#exbox(title: "Würfelwurf", [
  $A$ = "Die gewürfelte Zahl ist gerade" \
  $B$ = "Die gewürfelte Zahl ist grösser als 3" \
  $
    A = {2,4,6}, B = {4,5,6}, P(A) = P(B) = 1/2 \
    A inter B = {4,6}, P(A | B) = 2/3
  $
  Die Wahrscheinlichkeit für "gerade Zahl" ist also unter der Bedingung "grösser als 3" nicht mehr $1/2$, sondern $2/3$.
])

=== Zusammenhang mit Multiplikationsregel

Aus der Definition folgt direkt eine wichtige Umformung: $ P(A inter B) = P(A|B) dot P(B) $
Ebenso gilt auch: $ P(A inter B) = P(B|A) dot P(A) $

=== Bayes-Theorem

Setzt man die beiden Ausdrücke gleich, erhält man $ P(A|B) dot P(B) = P(B|A) dot P(A) $
Durch Umstellen ergibt sich das _Bayes-Theorem_: $ P(A|B) = (P(B|A) dot P(A))/(P(B)) $
Diese Formel erlaubt es, Wahrscheinlichkeiten umzukehren: Aus der Wahrscheinlichkeit von $B$ unter der Bedingung $A$ kann die Wahrscheinlichkeit von $A$ unter der Bedingung $B$ berechnet werden.

==== Satz der totalen Wahrscheinlichkeit

Angenommen ein Ereignis $B$ kann durch mehrere verschiedene Ursachen entstehen. Seien
$ A_1, A_2, ..., A_n $
Ereignisse, die
- sich gegenseitig ausschließen
- zusammen den gesamten Ereignisraum bilden
Dann gilt für jedes Ereignis $B$:
$ P(B) = P(B|A_1) dot P(A_1) + P(B|A_2) dot P(A_2) + ... + P(B|A_n) dot P(A_n) $
Diese Formel nennt man den _Satz der totalen Wahrscheinlichkeit_. Sie beschreibt die Gesamtwahrscheinlichkeit eines Ereignisses als Summe aller möglichen Fälle, in denen es entstehen kann.

== Unabhängigkeit von Ereignissen

Zwei Ereignisse $A$ und $B$ heissen unabhängig, wenn das Eintreten des einen Ereignisses keinen Einfluss auf die Wahrscheinlichkeit des anderen hat. Dann gilt:
$ P(A|B) = P(A) $
Das bedeutet: Auch wenn $B$ bereits eingetreten ist, bleibt die Wahrscheinlichkeit von $A$ unverändert. Setzt man das in die Multiplikationsregel ein, erhält man:
$ P(A inter B) = P(A) dot P(B) $

= Informationstheorie

Die Informationstheorie versucht, mathematisch zu messen:

- wie viel Information Ereignisse enthalten
  - ein sehr erwartbares Ereignis liefert wenig Information
  - ein überraschendes Ereignis liefert viel Information
- wie unsicher eine Informationsquelle ist
- wie effizient Informationen codiert werden können.

Die *Entropie* ist dabei die zentrale Grösse, die die durchschnittliche Informationsmenge einer Quelle
beschreibt.

Die Einheit der Information ist das *Bit*.

== Informationsgehalt

Der Informationsgehalt $I(x_k)$ eines Symbols $x_k$ ist ein Mass dafür, wie viel Information das Symbol trägt, basierend auf seiner Wahrscheinlichkeit des Auftretens $p(x_k)$.

$ I(x_k) = log_2 (1/p(x_k)) = -log_2 (p(x_k)) $

#{
  let node = node.with(height: 1em, stroke: none, outset: .25em)
  let edge = edge.with(label-wrapper: it => block(
    fill: colors.bg,
    width: 1.25em,
    height: 1.25em,
    align(center + horizon)[#it.label],
  ))
  grid(
    columns: (1fr, 1fr),
    align: right,
    diagram(
      spacing: (.01em, 3em),
      node((7, 0), $circle$, name: <s>),

      node((3, 1), `0`, name: <s0>),
      node((11, 1), `1`, name: <s1>),

      node((1, 2), `00`, name: <s00>),
      node((5, 2), `01`, name: <s01>),
      node((9, 2), `10`, name: <s10>),
      node((13, 2), `11`, name: <s11>),

      node((0, 4), `000`, name: <s000>),
      node((2, 4), `001`, name: <s001>),
      node((4, 4), `010`, name: <s010>),
      node((6, 4), `011`, name: <s011>),
      node((8, 4), `100`, name: <s100>),
      node((10, 4), `101`, name: <s101>),
      node((12, 4), `110`, name: <s110>),
      node((14, 4), `111`, name: <s111>),

      edge(label: $1/2$, <s>, <s0>, "->"),
      edge(label: $1/2$, <s>, <s1>, "->"),

      edge(label: $1/2$, <s0>, <s00>, "->"),
      edge(label: $1/2$, <s0>, <s01>, "->"),
      edge(label: $1/2$, <s1>, <s10>, "->"),
      edge(label: $1/2$, <s1>, <s11>, "->"),

      edge(label: $1/2$, <s00>, <s000>, "->"),
      edge(label: $1/2$, <s00>, <s001>, "->"),
      edge(label: $1/2$, <s01>, <s010>, "->"),
      edge(label: $1/2$, <s01>, <s011>, "->"),
      edge(label: $1/2$, <s10>, <s100>, "->"),
      edge(label: $1/2$, <s10>, <s101>, "->"),
      edge(label: $1/2$, <s11>, <s110>, "->"),
      edge(label: $1/2$, <s11>, <s111>, "->"),
    ),
    diagram(
      spacing: (.01em, 3em),
      node((3, 0), $circle$, name: <s>),

      node((1, 1), `0`, name: <s0>),
      node((7, 1), `1`, name: <s1>),

      node((0, 2), `00`, name: <s00>),
      node((2, 2), `01`, name: <s01>),
      node((5, 2), `10`, name: <s10>),
      node((11, 2), `11`, name: <s11>),

      node((4, 3), `100`, name: <s100>),
      node((6, 3), `101`, name: <s101>),
      node((9, 3), `110`, name: <s110>),
      node((13, 3), `111`, name: <s111>),

      node((8, 4), `1100`, name: <s1100>),
      node((10, 4), `1101`, name: <s1101>),
      node((12, 4), `1110`, name: <s1110>),
      node((14, 4), `1111`, name: <s1111>),

      edge(label: $1/4$, <s>, <s0>, "->"),
      edge(label: $3/4$, <s>, <s1>, "->"),

      edge(label: $1/2$, <s0>, <s00>, "->"),
      edge(label: $1/2$, <s0>, <s01>, "->"),
      edge(label: $1/3$, <s1>, <s10>, "->"),
      edge(label: $2/3$, <s1>, <s11>, "->"),

      edge(label: $1/2$, <s10>, <s100>, "->"),
      edge(label: $1/2$, <s10>, <s101>, "->"),
      edge(label: $1/2$, <s11>, <s110>, "->"),
      edge(label: $1/2$, <s11>, <s111>, "->"),

      edge(label: $1/2$, <s110>, <s1100>, "->"),
      edge(label: $1/2$, <s110>, <s1101>, "->"),
      edge(label: $1/2$, <s111>, <s1110>, "->"),
      edge(label: $1/2$, <s111>, <s1111>, "->"),
    ),
  )
}

== Entscheidungsgehalt

Der Entscheidungsgehalt $H_0$ einer Quelle gibt an, wie viel Information im Durchschnitt benötigt wird, um ein Ereignis aus $N$ gleich wahrscheinlichen unterschiedlichen Ereignissen zu identifizieren.

$ H_0 = log_2 (N) $

#exbox(title: "Entscheidungsgehalt und Informationsgehalt", [
  Gleichwahrscheinliche Ereignisse
  - Angenommen eine Quelle besitzt $N$ mögliche und gleichwahrscheinliche Symbole.
  Wahrscheinlichkeit eines Symbols
  - Bei gleichwahrscheinlichen Symbolen gilt: $p(x) = 1/N$
  Informationsgehalt eines Ereignisses: $I(x) = -log_2 P(x)$
  - Einsetzen von $p(x) = 1/N : I(x) = -log_2 (1/N) = log_2 N$
  Ergebnis: $I(x) = log_2 N = H_0$
  - für gleichwahrscheinliche Ereignisse.
  $=>$ Der Entscheidungsgehalt $H_0$ ist ein Spezialfall des Informationsgehalts $I(x)$ für gleichwahrscheinliche Ereignisse.
])

== Entropie

Die Entropie $H(X)$ beschreibt den durchschnittlichen Informationsgehalt / durchschnittliche Unsicherheit einer Quelle.

$
  H(X) = sum_(k=1)^N p(x_k) dot I(x_k) = sum_(k=1)^N p(x_k) dot log_2 (1/p(x_k)) = - sum_(k=1)^N p(x_k) dot log_2 (p(x_k))
$

#table(
  columns: (1fr, 1fr, 1.5fr),
  table-header($p(x) = 1$, $p(x) = 0$, $0<=H(X)<=log_2 N$),
  [
    - Ergebnis ist sicher
    - $I(x) = 0$
  ],
  [
    - Ergebnis tritt nie auf
    - Trägt 0 zur Entropie bei
  ],

  [
    - Minimum: deterministische Quelle
    - Maximum: gleichverteilte Quelle
  ],
)

#exbox(
  title: $
    H(X) = -(0.99 dot log_2 0.99 + 0.01 dot log_2 0.01) = 0.014 + 0.066 approx 0.080 "Bit"
  $,
  grid(
    columns: 2,
    [
      - A liefert fast keine Information, weil es praktisch immer kommt.
      - B liefert sehr viel Information, weil es extrem selten ist.
        - Aber: B kommt nur 1% der Zeit, deshalb ist der durchschnittliche Informationsgehalt klein.
      $=>$ Ergebnis: ca. 0.08 Bit pro Symbol
    ],
    table(
      columns: 2,
      table-header([Zeichen], [Wahrscheinlichkeit]), $A$,
      $0.99$, $B$,
      $0.01$,
    ),
  ),
)

== Redundanz

#let xs = lq.linspace(.000000001, .999999999)
#grid(
  columns: (1fr, auto),
  gutter: 2em,
  [
    Die Redundanz $R_q$ beschreibt den Anteil vorhersehbarer Information / den Unterschied zwischen dem maximal möglichen Entscheidungsgehalt und der tatsächlichen Entropie der Quelle.

    $
      &R_q = R_"abs" = H_0 - H(x) && ["Bit/Zeichen"] \
      &R_"rel" = (R_"abs")/H_0 = (H_0 - H(X))/H_0 = 1 - (H(X))/H_0 space && [%]
    $
  ],
  lq.diagram(
    xaxis: (ticks: (0, 1 / 4, 1 / 2, 3 / 4, 1), label: $p$),
    yaxis: (ticks: (0, 1 / 4, 1 / 2, 3 / 4, 1), label: $H(X)$),
    grid: (stroke: colors.comment),
    width: 5cm,
    lq.plot(
      xs,
      xs.map(x => (
        x * calc.log(1 / x, base: 2) + (1 - x) * calc.log(1 / (1 - x), base: 2)
      )),
      mark: none,
    ),
  ),
)

#table(
  columns: (1fr, 1fr),
  [Hohe Redundanz], [Geringe Redundanz],
  [Quelle stark vorhersehbar], [Quelle nahe maximaler Unsicherheit],
)

Eine Quelle mit hoher Redundanz enthält viele regelmässige Strukturen oder Abhängigkeiten. Diese können genutzt werden, um Daten effizienter zu codieren oder zu komprimieren.

== Codierung der Zeichen

=== Codewortlänge

Idealerweise sollte die Länge eines Codeworts dem Informationsgehalt des Symbols entsprechen:

$ L(x_k) approx I(x_k) approx -log_2 p(x_k) $

Da Codewörter jedoch aus einer *ganzen Anzahl Bits* bestehen müssen, wird aufgerundet:

$ L(x_k) = ceil(I(x_k)) = ceil(-log_2 p(x_k)) $

=== Mittlere Codewortlänge

Die mittlere Codewortlänge $L(X)$ ist definiert als der gewichtete Durchschnitt der Längen der Codewörter, wobei jedes Gewicht der Auftretenswahrscheinlichkeit des entsprechenden Symbols gleich ist.

$ L(X) = sum_(k=1)^N p(x_k) dot L(x_k) $

Es gilt für jeden Code $H(X) <= L(X)$

#exbox([
  Folgende Zeichen mit entstprechenden Codewörter, deren Länge und ihren Wahrscheinlichkeiten sind gegeben:
  #align(center, table(
    columns: 4,
    table-header([Zeichen], [Codewort], [Wahrscheinlichkeit $p$], [Länge]),
    [a],
    [0],

    [0.3], [1], [b], [110],
    [0.1], [3], [c], [1111],
    [0.1], [4], [d], [1110],
    [0.2], [4], [e], [10],
    [0.3], [2],
  ))
  Nun berechnen wir die mittlere Codewortlänge $L$ mit der oberigen Formel:
  $
    L = & (0.3 dot 1) + (0.1 dot 3) + (0.1 dot 4) + (0.2 dot 4) + (0.3 dot 2) \
      = & 0.3 + 0.3 + 0.4 + 0.8 + 0.6 \
      = & 2.4 "bit"
  $
])

=== Redundanz des Codes

Die Redundanz des Codes $R_c$ ist die Differenz zwischen der mittleren Codewortlänge und der Entropie der Quelle.

$ R_c = L - H(x) $

=== Präfixcodes

#grid(
  columns: 2,
  [
    Ein Code besitzt die *Präfixeigenschaft*, wenn kein Codewort der Anfang eines anderen Codeworts ist.

    Präfixcodes sind wichtig, weil sie eine *eindeutige und sofortige Decodierung* ermöglichen.
  ],
  table(
    columns: 2,
    table-header([Symbol], [Code]), [A],
    `0`, [B],
    `10`, [C],
    `110`, [D],
    `111`,
  ),
)

== Shannon'sches Codierungstheorem

Das Shannon-Theorem beschreibt die theoretischen Grenzen der Datenkompression. Für jede Informationsquelle mit mittlerer Codewortlänge $L$ und deren Entropie $H(X)$ gilt:

$ H(X) <= L < H(X) + 1 $

- Entropie ist die theoretische Mindestlänge eines Codes
- Praktische Codes können dieser Grenze sehr nahe kommen.

== Diskrete Quellen

=== Quellen ohne Gedächtnis

Diskrete Quellen ohne Gedächtnis haben Symbole, die unabhängig von vorherigen Symbolen auftreten. Jedes Symbol $x_k$ aus einem endlichen Set tritt mit einer Wahrscheinlichkeit $p(x_k)$ auf. Verbundwahrscheinlichkeit für die beiden Zeichen $x_i$ und $x_(i+1)$ lautet: $ p(x_i, x_(i+1)) = p(x_i) dot p(x_(i+1)) $

=== Quellen mit Gedächtnis

In der Praxis sind nur wenige Datenquellen vollständig gedächtnislos. Häufig hängt die Wahrscheinlichkeit eines Zeichens vom vorhergehenden Zeichen ab. Solche Kontextabhängigkeiten lassen sich mit bedingten Wahrscheinlichkeiten beschreiben: $p(x_(i+1) | x_i)$

#exbox(title: "Zeichenfolgen", [
  In deutschen und englischen Texten folgt auf den Buchstaben "q" praktisch immer "u". $ p(u|q) approx 1 $
])

==== Entropie

Für zwei aufeinanderfolgende Zeichen gilt: $ H(X,Y) = sum_(k=1)^N sum_(i=1)^N p(x_k, y_i) dot log_2 (1/(p(x_k,y_i))) $
Mit $ p(x_k,y_i) = p(x_k) dot p(y_i | x_k) $
ergibt sich $ H(X,Y) = H(X) + H(Y | X) $

Interpretation

- $H(X)$: Unsicherheit über das erste Zeichen
- $H(X, Y)$: "Verbundentropie" = Unsicherheit über zwei aufeinanderfolgende Zeichen
- $H(Y | X)$: verbleibende Unsicherheit über $Y$ wenn $X$ bereits bekannt ist

Da Kontextinformation Unsicherheit reduziert, gilt:

$ H(Y | X) <= H(Y) $

==== Redundanz

$
  R_("abs,oG") = H_0 - H(Y) \
  R_("abs,mG") = H_0 - H(Y | X) \
  R_("abs,oG") <= R_("abs,mG")
$

Kontext reduziert Unsicherheit

- Entropie sinkt
- Redundanz steigt

#todo[]

= Qubit

- Superposition
  - Ein Qubit kann gleichzeitig $0$ und $1$ repräsentieren. Mehrere Qubits können dadurch alle $2^n$ möglichen Zustände gleichzeitig darstellen.
  - $|Psi chevron.r = alpha |0chevron.r + beta |1 chevron.r$
  - $P(0) = abs(alpha)^2, P(1) = abs(beta)^2$
- Beispiel
  - $|Psi chevron.r = sqrt(0.75) |0chevron.r + sqrt(0.25) |1 chevron.r$
  - $P(0) = 0.75, P(1) = 0.25$
- Interferenz
  - $alpha, beta$ sind Amplituden. Zwei Qubits können sich gegenseitig beeinflussen, indem die Amplituden mittels Interferenz verstärkt oder ausgelöscht werden
  - Quantenalgorithmen verändern gezielt die Amplituden:
    - richtige Lösungen werden verstärkt
    - falsche Lösungen werden abgeschwächt
- Verschränkung
  - Verschränkung bedeutet, dass zwei Qubits einen gemeinsamen Zustand besitzen, der sich nicht in zwei unabhängige Einzelzustände zerlegen lässt.
  - Misst man eines der Qubits, ist der Zustand des anderen sofort festgelegt

= CPU

Gesamtübersicht des CPU Zyklus
+ Fetch: Instruktion aus RAM lesen
+ Decode: Opcode interpretieren
+ Operand-Fetch: Speicherwerte laden
+ Execute: ALU rechnet
+ Writeback: Ergebnis ins Register
+ IP erhöhen
