#import "../lib.typ": *
#show: cheatsheet.with(
  module: "DMI",
  name: "Diskrete Mathematik",
  semester: "HS25",
  columnsnr: 3,
  language: "de",
)

#include "./content.typ"

= Vorgehensweise, um

== Diagonale und Fläche berechnen

Gegeben: $A = (0;1;0), B = (2;1;0), C = (0;0;1), D = (1;0;0)$

Diagonale $ve(B D) = ve(r_D) - ve(r_B) = vec(1, 0, 0) - vec(2, 1, 0) = vec(-1, -1, 0)$

Fläche $F = abs((ve(r_B) - ve(r_A)) times (ve(r_D) - ve(r_A))) = abs(vec(2, 0, 0) times vec(1, -1, 0)) = abs(vec(0, 0, -2)) = 2$

== Abbildungsmatrix berechnen

Gegeben: $A = (1;-1), B = (1;1), A' = (2;1), B' = (0;1)$

$M_U = mat(1, 1; -1, 1), M_B = mat(2, 0; 1, 1), M^(-1)_U = 1/2 mat(1, -1; 1, 1)$

$M = M_B dot M^(-1)_U = mat(1, -1; 1, 0)$

== Nullteiler von $ZZ_n$ finden

Multiplikationstabelle?

Können nicht Teilerfremd zu $n$ sein.

== Elemente von $ZZ^*_n$ finden (Mult. inv. in $ZZ_n$)

Multiplikationstabelle?

== $abs(ZZ^*_n)$ berechnen

$abs(ZZ^*_n) = phi(n)$

== Lösungsmenge Gauss-Tableau mit Nullzeile

#grid(
  columns: (auto, auto),
  table(
    columns: (auto, auto, auto, auto),
    table.cell(colspan: 4)[...],
    [1], tg[0], [2], table.cell(fill: colors.blue)[3],
    tg[0], [1], [1], table.cell(fill: colors.blue)[0],
    tg[0], tg[0], tr[0], table.cell(fill: colors.red)[4],
  ),
  [$=>$ Unlösbar],

  table(
    columns: (auto, auto, auto, auto, auto),
    table.cell(colspan: 5)[...],
    [1], tg[0], [2], table.cell(fill: colors.blue)[3], [],
    tg[0], [1], [1], table.cell(fill: colors.blue)[0], [],
    tg[0], tg[0], tr[0], table.cell(fill: colors.blue)[0], [],
  ),

  $
    x_1 = 3 - 2t ,
    x_2 = - t ,
    x_3 = t \
    LL(A, ve(b)) = {ve(x) in RR^3 mid(|) ve(x) = vec(3, 0, 0) + t dot vec(-2, -1, 1), t in RR}
  $,
)

== Disjunktive/Konjunktive Normalform angeben

Wahrheitstafel. Für konjunktive Normalform zuerst disjunktive erstellen, danach negieren und umformen. Beispiel:
$
  not R = (A and B and C) or (A and not B and C) <=> R = not (A and B and C) and not (A and not B and C) <=> R = (not A or not B or not C) and (not A or B or not C)
$

== $x^y mod p$ berechnen

Rechenregeln Totient ($phi$)

== Zahl $x in ZZ_n$ finden, für die $y dot x equiv 1 mod n$ gilt (mult. Inv.)

Falls $"ggT"(y,n) != 1 =>$ gibt kein mult. Inv. Ansonsten: Euklidscher Algorithmus.

Beispiel: $x in ZZ_32, 21 dot x equiv 1 mod 32$
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto),
  [x], [y], [q], [r], [u], [s], [v], [t],
  [32], [21], [1], [11], [1], [0], [0], [1],
  [21], [11], [1], [10], [], [], [1], [-1],
  [11], [10], [1], [1], [], [], [-1], [2],
  [10], [1], [10], [0], [], [], [2], tr[-3],
)
$=> x = -3 + 32 = 29$

Beispiel: $x in ZZ_32, 22 dot x equiv 1 mod 32$

$"ggT"(22,32) = 2 =>$  gibt kein mult. Inv.

== Aus Geraden $G_1$ und $G_2$ folgendes herausfinden:

Gegeben: $G_1 = (2;3) dot ve(x) - 1 = 0, G_2 = (3;4) dot ve(x) + 5 = 0, P = (1;1)$

Welche Gerade liegt näher an Punkt $P$:

#grid(
  columns: (auto, auto),
  [Hessesche Normalenform],
  $
    abs(vec(2, 3)) = sqrt(13) \
    G_1 = 1/sqrt(13) dot (2;3) dot ve(x) - 1/sqrt(13) = 0
  $,

  [Abstand],
  $ a_1 = 1/sqrt(13) dot (2;3) dot vec(1, 1) - 1/sqrt(13) = 4/sqrt(13) $,

  [Hessesche Normalenform],
  $
    abs(vec(3, 4)) = 5 \
    G_2 = (3/5;4/5) dot ve(x) + 1 = 0
  $,

  [Abstand], $ a_2 = (3/5;4/5) dot vec(1, 1) + 1 = 12/5 $,
)

$4/sqrt(13) < 12/5 => G_1$

Wo schneiden sich die Geraden:
Koordinatengleichung $ 2s_x + 3s_y = 1 \
3s_x + 4s_y = -5 \
S = (-19;13) $

Für welche Gerade liegt $P$ auf derselben Seite wie der Ursprung:
Ursprung in HNF einsetzen
#grid(
  columns: (auto, auto),
  [Abstand],
  $
    b_1 = 1/sqrt(13) dot (2;3) dot vec(0, 0) - 1/sqrt(13) = -1/sqrt(13) \
    b_1 < 0 and a_1 > 0 => "verschiedene Seiten"
  $,

  [Abstand],
  $
    b_2 = (3/5;4/5) dot vec(0, 0) + 1 = 1 \
    b_1 > 0 and a_1 > 0 => "dieselben Seiten"
  $,
)

== Ebenen

Gegeben: Punkte $A = (-1;1;4), B = (-7;3;1), C = (2;1;5)$

Ebene $E in RR^3$ verläuft durch oben genannte Punkte. Gib sie in Parameterform unter Verwendung des Ortsvektors zum Punkt $A$ als Stützvektor an:
$
  ve(A B) = vec(-6, 2, -3), ve(A C) = vec(3, 0, 1) \
  E: vec(-1, 1, 4) + s vec(-6, 2, -3) + t vec(3, 0, 1)
$

Hessesche Normalenform der Ebene $E$:

$
  ve(n) = vec(-6, 2, -3) times vec(3, 0, 1) = vec(2, -3, -6) \
  abs(ve(n)) = 7, ve(n)_0 = vec(2/7, -3/7, -6/7), b_0 = vec(-1, 1, 4) prod ve(n)_0 = -29/7 \
  E: (ve(x) - ve(a)) prod ve(n)_0 = 0 <=> ve(x) prod ve(n)_0 - b_0 = 0
$

Abstand des Punktes $Q = (10;2;-1)$ von der Ebene $E$: $vec(10, 2, -1) prod ve(n)_0 - b_0$

Für welchen Wert von $z$ liegt $R = (-4;1;z)$ auf der Ebene $E$: $vec(-4, 1, z) prod ve(n)_0 - b_0 = 0$

== RSA Verschlüsselung

Gegeben: $n = 119$

Zahlen angeben, die als Schlüssel infrage kommen: Teilerfremd zu $phi(n)$

Zum Schlüssel $a$ den Schlüssel $b$ berechnen: Euklidscher Algorithmus mit $phi(n), a$

Mit dem Schlüssel $a$ die Zahl $x$ ent- / verschlüsseln: $x^a mod n$

== Alle Elemente von $R = {(a,b) in M times M mid(|) a dot b equiv 1 mod x }$

== Alle Elemente von $R = {(a,b) in ZZ^*_x times ZZ^*_x mid(|) a dot b equiv y mod x}$

#grid(
  columns: (auto, auto),
  [Falls $y$ teilerfremd zu $x$: Multiplikationstabelle mit Fremdteilern zu $x$ erstellen.

    Beispiel: $R = {(a,b) in ZZ^*_12 times ZZ^*_12 mid(|) a dot b equiv 7 mod 12}$

    $= {(1,7), (5,11), (7,1), (11,5)}$
  ],
  table(
    columns: (auto, auto, auto, auto, auto),
    [$dot$], [1], [5], [7], [11],
    emph[1], [1], [5], tr[7], [11],
    emph[5], [5], [1], [11], tr[7],
    emph[7], tr[7], [11], [1], [5],
    emph[11], [11], tr[7], [5], [1],
  ),
)

== Lösung von $M dot ve(x) = ve(y)$ zu $ve(x)$

$ve(x) = M^(-1) dot ve(y)$

== Eigenwerte der Matrix M berechnen

== Eigenvektoren der Matrix M berechnen
