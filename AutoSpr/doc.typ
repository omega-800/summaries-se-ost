#import "../lib.typ": *

#show: project.with(
  module: "AutoSpr",
  name: "Automaten und Sprachen",
  semester: "FS26",
)

= Prädikate

Prädikate sind Aussagen über mathematische Objekte, die wahr oder falsch sein können. "Funktionen" mit booleschen Rückgabewerten: $P, Q(n), R(x,y,z)$. Siehe #link("../DMI/doc.pdf", "DMI").

== Normalformen

Normalformen (allgemein, _kanonische Formen_) helfen, das Vergleichsproblem zu lösen (ob zwei Aussagen dieselben sind).

$ P_1 and ... and P_n = forall i in {1,...,n}(P_i) = limits(or)_(i=1)^n P_i $
$ P_1 or ... or P_n = exists i in {1,...,n}(P_i) = limits(or)_(i=1)^n P_i $

== Negation

Nicht für alle = Es gibt einen Fall, für den nicht
$
  not forall i in {1,...,n}(P_i) <=> not (P_1 and ... and P_n) <=> not P_1 or ... or not P_n <=> exists i in {1,...,n}(not P_i)
$

= Mengen

== Konstruktion

Grundmenge $G$, Prädikat $P(x)$. Konstruierte Menge $A = {x in G | P(x)}$

== Operationen

#deftbl(
  [Vereinigung],
  [$A union B = {x | x in A or x in B}$],
  [Schnittmenge],
  [$A inter B = {x | x in A and x in B}$],
  [Komplement],
  [$overline(A) = {x | x in.not A}$],
  [Differenz],
  [$A without B = {x in A | x in.not B}$],
)

== Tupel

$A times B = {(a,b) | a in A and b n B}$ \
$limits(times)_(i=1)^n A_i = {(a_1, a_2,...,a_n)|a_i in A_i}$

= Beweise

Eine Folge von logischen Schlüssen, die zeigen, dass die Aussage aus den gegebenen Voraussetzungen folgt.

#deftbl(
  [Konstruktiver Beweis],
  [Liefert explizite "Lösung" / Algorithmus],
  [Widerspruchsbeweis],
  [Geeignet für Unmöglichkeitsaussagen. Z.B. $sqrt(2) in.not QQ$],
  [Vollständige Induktion],
  [Für Aussagen, die für alle $n in NN$ gelten.],
)

= Sprachen

#deftbl(
  [Alphabet],
  [Eine nichtleere endliche menge $Sigma$ heisst _Alphabet_. Die Elemente von $Sigma$ heissen _Zeichen_],
  [Wort],
  [Eine Zeichenkette der Länge $n$ ist ein $n$-Tupel in $Sigma^n = Sigma times ... times Sigma$. Ein Element von $Sigma^n$ heisst _Wort_ der Länge $n$],
  [Leeres Wort],
  [Die Zeichenkette $epsilon in Sigma^0 = {epsilon}$ der Länge 0 heisst das _leere Wort_.],
  [Menge aller Wörter],
  [
    Leeres Wort ist *immer* drin
    $
      Sigma^* = {epsilon} union Sigma union Sigma^2 union Sigma^3 union ... = limits(union)_(k=0)^oo Sigma^k
    $
  ],
  [Abgekürzte Schreibweisen von Wörtern],
  [$
    (A,u,t,o,S,p,r) = A u t o S p r \
    a^3b^5 = a a a b b b b b \
    b^5a^3 = b b b b b a a a \
  $],
  [Sprache],
  [Teilmenge $L subset Sigma^*$],
)

== Wortlänge

#deftbl(
  [Länge des Wortes $w$],
  [$w in Sigma^n => abs(w) = n$],
  [Anzahl Zeichen $a$ im Wort $w$],
  [$abs(w)_a, w in Sigma^n, a in Sigma$],
)

#exbox(grid(
  columns: (1fr, 1fr, 1fr),
  $
    abs(epsilon) = 0 \
    abs(01010)_0 = 3 \
  $,
  $
    abs(01010)_1 = 2 \
    abs(01010)_3 = 0 \
  $,
  $
    abs(a^3b^5) = 8 \
    abs((1291)^7) = 7 abs(1291) = 7 dot 4 = 28 \
  $,
))
$
  => abs(w^n) = n dot abs(w)
$

== Sprache

#exbox(
  $
    L = Sigma^* subset Sigma^* \
    L = emptyset subset Sigma^*, "die leere Sprache" \
    Sigma = {0,1}, "Sprache aller Binärstrings:" L = Sigma^* \
    Sigma = "Unicode", J = {w in Sigma^* | w "wird vom Java-Compiler akzeptiert"} \
    M "eine \"Maschine\"", L(M) = {w in Sigma^* | w "wird von" M "akzeptiert"} \
  $,
)
