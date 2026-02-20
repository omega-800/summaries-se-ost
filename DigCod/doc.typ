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
    [25], [2], [12], [1],
    table.cell(rowspan: 5)[#align(
      horizon,
      $stretch(}, size: #7em) #rotate(-90deg, $arrow.long$)$,
    )],
    [12], [2], [6], [0],
    [6], [2], [3], [0],
    [3], [2], [1], [1],
    [1], [2], [0], [1],
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
    [0.1875], [2], [0.375], [0],
    table.cell(rowspan: 4)[#align(
      horizon,
      $stretch(}, size: #5em) #rotate(90deg, $arrow.long$)$,
    )],
    [0.375], [2], [0.75], [0],
    [0.75], [2], [1.5], [1],
    [0.5], [2], [1], [1],
  ),
)

== Nachkommastellen

Erweiterung der Darstellung einer Zahl: $N_R = d_n R^n + ... + d_0 R^0 + d_(-1) R^(-1) + ... + d_(-m) R^(-m)$

Beispiel: $(101.01)_2 = 1*2^2 + 0*2^1+1*2^0+0*2^(-1)+1*2^(-2) = 4 + 1 + 1/4 = 5.25$

== Subtraktion durch Addition

Beispiel: $753 + 247 = 1000$

Bei $1000$ einen Überlauf ($mod 1000$): $753 + 247 equiv 0 <=> 753 equiv -247 mod 1000$

Dann wäre $620 - 247 equiv 620 + 753 = 1373 equiv 373 mod 1000$

= Dualsystem

== Arithmetik

=== Subtraktion

+ Rechnen in $n$ Bit $=> mod 2^n$
  - Übertrag aus dem MSB wird verworfen (gerechnet wird in $ZZ_(2^n)$)
+ $-b$ als Zweierkomplement
  - Additives Inverses von $b mod 2^n$ ist: $-b equiv 2^n - b mod 2^n$
  - Praktische Berechnung:
    - Bits invertieren: $~b$
    - $+1$ addieren
    - $2K(b) = ~b + 1$
+ Subtraktion durchführen $a - b equiv a + 2K(b) mod 2^n$

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

#todo("Tabelle signed/unsigned Wertebereich")
#todo("show how first half of bits represent negative nrs (signed)")

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

#todo("")
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [Binär], [Näherung], [Binärpräfix], [Dezimal], [Dezimalpräfix],
  [2^10], [1.TODO 10^3], [Ki - Kibi], [10^3], [K - Kilo],
  [2^20], [1.TODO 10^6], [Mi - Mebi], [10^6], [M - Mega],
  [2^30], [1.TODO 10^9], [Gi - Gibi], [10^9], [G - Giga],
  [2^40], [1.TODO 10^12], [Ti - Tebi], [10^12], [T - Tera],
  [2^50], [1.TODO 10^15], [Pi - Pebi], [10^15], [P - Peta],
  [2^60], [1.TODO 10^18], [Ei - Exbi], [10^18], [E - Exa],
)

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
