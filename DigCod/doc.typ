#import "../lib.typ": *

#show: project.with(
  module: "DigCod",
  name: "Digitale Codierungen",
  semester: "FS26",
)

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
  table.cell(colspan: 2, [Beispiele]),
  [
    Dezimalsystem
    - $R = 10$
    - $Z_10 = {0,1,2,3,4,5,6,7,8,9}$
    - $(110)_10 = (110)_10$
  ],
  [
    Oktalsystem
    - $R = 8$
    - $Z_10 = {0,1,2,3,4,5,6,7}$
    - $(110)_8 = (72)_10$
  ],
  [
    Dualsystem
    - $R = 2$
    - $Z_10 = {0,1}$
    - $(110)_2 = (6)_10$
  ],
  [
    Hexadezimalsystem
    - $R = 16$
    - $Z_10 = {0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F}$
    - $(110)_8 = (48)_10$
  ],
)

== Multiplikation als Polynommultiplikation

#todo("")

== Konversion

#grid(
  columns: (1fr, 1fr),
  [
    Dezimal- zu Dualsystem:
    - Rechts shift ist eine Division durch 2
    - Es entsteht nur dann ein Rest, wenn die Bitstelle $2^0 = 1$ ist.
    Beispiel: $25$ \
    Resultat: $11001$
  ],
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

  [
    Dual- zu Dezimalsystem bei Nachkommastellen:
    - Links shift ist eine Multiplikation mit 2
    Beispiel: $0.1875$ \
    Resultat: $0.0011$
  ],
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

Beispiel: $(101.01)_2 = 1*2^2 + 0*2^1+1*2^0+0*2^(-1)+1*2^(-2) = 4 + 1 + 1/4 = 5.25$

== Subtraktion durch Addition

Beispiel: $753 + 247 = 1000$

Bei $1000$ einen Überlauf ($mod 1000$): $753 + 247 equiv 0 <=> 753 equiv -247 mod 1000$

Dann wäre $620 - 247 equiv 620 + 753 = 1373 equiv 373 mod 1000$

= Dualsystem

== Arithmetik

=== Komplementbildung (Zweierkomplement)

+ Rechnen in $n$ Bit $=> mod 2^n$
  - Übertrag aus dem MSB wird verworfen (gerechnet wird in $ZZ_(2^n)$)
+ $-b$ als Zweierkomplement
  - Additives Inverses von $b mod 2^n$ ist: $-b equiv 2^n - b mod 2^n$
  - Praktische Berechnung:
    - Bits invertieren: $~b$
    - $+1$ addieren
    - $2K(b) = ~b + 1$

=== Subtraktion

Subtraktion wird durch Addition des Komplements ersetzt
$ a - b equiv a + 2K(b) mod 2^n $

#exbox(title: $13 - 5$, [
  $8 "Bit"$, wobei $13 = 0000 space 1101, 5 = 0000 space 0101$ \
  Zweierkomplement von 5:
  - invertieren: $1111 space 1010$
  - $+1: 1111 space 1011$
  Addieren: $0000 space 1101 + 1111 space 1011 = 1 space 0000 space 1000$

  MSB-Übertrag weg: $0000 space 1000 = 8$

  Also: $13 - 5 = 8$
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
    node((0.5, 2.5), text(fill: colors.red)[$3$]),
    edge("->", stroke: colors.red),
    node((-0.5, 2.5), text(fill: colors.red)[$-4$]),
    node((-1.25, 2), $-3$),
    node((-1.25, 1), $-2$),
  ),

  [#text(fill: colors.red)[unsigned:] Überlauf von $7$ auf $0$],
  [#text(fill: colors.red)[signed:] Überlauf von $3$ auf $-4$],
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

== Computertechnik

#todo("")

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

=== Multiplikation/Division

+ Umformen in Potenzschreibweise
+ Addition der Exponenten
+ Umformen in Präfixschreibweise

Beispiel: $128K dot 64M = 2^7 dot 2^10 dot 2^6 dot 2^20 = 2^(17+26) = 2^(43) = 2^3 dot 2^40 = 8T$

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

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [Binär], [Betrag & V.], [EinerK.], [ZweierK.], [$C_(e x, - 8, 4)$],
  `0000`, ` 0`, ` 0`, ` 0`, `-8`,
  `0001`, ` 1`, ` 1`, ` 1`, `-7`,
  `0010`, ` 2`, ` 2`, ` 2`, `-6`,
  `0011`, ` 3`, ` 3`, ` 3`, `-5`,
  `0100`, ` 4`, ` 4`, ` 4`, `-4`,
  `0101`, ` 5`, ` 5`, ` 5`, `-3`,
  `0110`, ` 6`, ` 6`, ` 6`, `-2`,
  `0111`, ` 7`, ` 7`, ` 7`, `-1`,
  `1000`, ` 0`, `-7`, `-8`, ` 0`,
  `1001`, `-1`, `-6`, `-7`, ` 1`,
  `1010`, `-2`, `-5`, `-6`, ` 2`,
  `1011`, `-3`, `-4`, `-5`, ` 3`,
  `1100`, `-4`, `-3`, `-4`, ` 4`,
  `1101`, `-5`, `-2`, `-3`, ` 5`,
  `1110`, `-6`, `-1`, `-2`, ` 6`,
  `1111`, `-7`, ` 0`, `-1`, ` 7`,
)

=== Betrag mit Vorzeichen

Erstes Bit signalisiert, ob Zahl positiv ($0$) oder Negativ ($1$) ist.

Problem: Bekannte Rechenregeln funktionieren nicht.

$
  & -19_10            && + 1_10              &&                     && = -18_10 \
  & 1001 space 0011_2 && + 0000 space 0001_2 && = 1001 space 0100_2 && = -20_10
$

#exbox(title: "Codierung", grid(
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
#exbox(title: "Decodierung", grid(
  columns: (1fr, 1fr, 1fr),
  [
    _Gegeben_

    $x = 1001_2$
  ],
  [
    _Binär $->$ Dezimal_

    $x 001_10 = 1_2$
  ],
  [
    _Ergebnis_

    $1001_2 = -1_10$
  ],
))

=== (b-1) Komplement / Einerkomplement

Von allen bits wird das Komplement gebildet.

Problem: $0000 space 00000_2 = 1111 space 1111_2 = 0_10$

#exbox(title: "Codierung", grid(
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
#exbox(title: "Decodierung", grid(
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

=== (b) Komplement / Zweierkomplement

Nach der Komplementbildung wird $1$ addiert.

#exbox(title: "Codierung", grid(
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
#exbox(title: "Decodierung", grid(
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

=== Exzess-Codierung (Bias-Code)

Darstellung vorzeichenbehafteter Zahlen durch *Verschiebung des Wertebereichs*.

Statt negativer Zahlen wird ein *Offset (Bias)* addiert

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
  $x = c - 127$,
)

#exbox(title: "Codierung", grid(
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

    $122_10 = 01111010_2$

    _Ergebnis_

    $C_(e x, -127,8) (-5) = 01111010_2$
  ],
))

#exbox(title: "Decodierung", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Bias: $B = 2^7 - 1 = 127$ \
    Bitmuster: $C_(e x, -127,8) = 01111010_2$
  ],
  [
    _Binär $->$ Dezimal_

    $01111010_2 = 122_10$

    _Bias subtrahieren_

    $x = c - B = 122 - 127 = -5$

    _Ergebnis_

    $01111010_2 => -5$
  ],
))

== Gleitkommazahlen

=== Fixkommazahl

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

#defbox($C_(F K, k, n) (x) = x dot 2^k$, [
  $C_(F K) =$  Fixkomma-Codierung \
  $k =$ Anzahl Nachkommabits \
  $n =$ Länge der binären Schreibweise - daraus ergibt sich die Anzahl der Vor-Kommastellen: $n - k$  \
  $x =$ zu codierende Zahl \
  $I =$ Ganzzahl
])

#exbox(title: "Codierung", grid(
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

    $52_10 = 00110100_2$

    _Ergebnis_

    $C_(F K, 4, 8) (3.25) = 00110100_2$
  ],
))

#exbox(title: "Decodierung", grid(
  columns: (1fr, 1fr),
  [
    _Gegeben_

    Wortbreite: $n = 8 "Bit"$ \
    Nachkommabits: $k = 4$ \
    Bitmuster: $C_(F K, 4, 8) (3.25)$
  ],
  [
    _Binär $->$ Dezimal_

    $00110100_2 = 522_10 = I$

    _Skalieren_

    $x = I/2^k = 52/16 = 3.25$

    _Ergebnis_

    $00110100_2 => 3.25$
  ],
))

=== Allgemeiner Wertebereich

Wertebereich bei $n$ Bit und $k$ Nachkommabits

#table(
  columns: (1fr, 1fr, 1fr),
  [], [Ganzzahlbereich], [Reeller Bereich],
  [unsigned], $ I in [0,2^n - 1] $, $ x in [0, (2^n - 1)/2^k] $,
  [signed],
  $ I in [-2^(n-1),2^(n-1) - 1] $,
  $ x in [-(2^(n-1))/2^k, (2^(n-1) - 1)/2^k] $,
)

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

=== Auflösung

Kleinster darstellbarer Schritt: $Delta x = 2^(-k)$

Absoluter Fehler: $E_"abs" = abs(x_"korrekt" - x_"gerundet")$

Relativer Fehler: $E_"rel" = abs(x_"korrekt" - x_"gerundet")/x_"korrekt"$

=== Arithmetik

#todo("slides 20")

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
$#td($plus.minus$) (1 + #tr("Mantisse")) dot 2^(#tp("Exponent") -127)$

#todo("sonderfälle (slides 27)")

#todo("ASCII/Unicode")

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
