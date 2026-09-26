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

= Kombinatorik

Mathematische Disziplin, die sich mit der Frage befasst, wie viele (und welche)
Möglichkeiten es gibt, eine bestimmte Anzahl von Dingen auszuwählen und
miteinander zu kombinieren.

== Zählregeln

#todo[merge with DigCod and MathFML]

/ Disjunkte Vereinigung: $abs(A union B) = abs(A) + abs(B)$
/ Schnittmenge: $abs(A union B) = abs(A) + abs(B) - abs(A inter B)$
/ Paare/Produkt: $abs(A times B) = abs(A) dot abs(B)$
/ Permutation: Auf wieviele Arten kann man $n$ Objekte anordnen?
  $ P_n = n! $
/ Kombination: Auf wieviele Arten kann man $k$ Objekte aus $n$ auswählen?
  $ C_k^n = binom(n, k) $
/ Variation: Auf wieviele Arten kann man $k$ mal unter $n$ verschiedenen
  Objekten auswählen?
  $ V_k^n = n^k $
/ Binomische Formel:
$
  (a+b)^n = sum_(k=0)^n binom(n, k) a^k b^(n-k)
$

== Erzeugende Funktion

Oftmals lassen sich schwierige kombinatorische Fragestellungen in algebraische
oder analytische Probleme umformulieren. Damit steht dann der Apparat der
Analysis zur Verfügung.

Die Zahlen $a_0, a_1, a_2, ..., a_n$ kann man wie folgt in ein _erzeugende
Funktion_ codieren:
$ f(z) = a_0 + a_1 z + a_2 z^2 + a_3 z^3 + ... $

Für den Platzhalter $z$ soll gar kein Zahlenwert substituiert werden. Vielmehr
dienen die Potenzen $z_k$ nur dazu, die einzelnen Zahlen $a_k$ auseinander zu
halten. Man spricht von einer _formalen Potenzreihe_.

#exbox(title: "Kombination", [
  Die Koeffizienten dieses Polynoms geben an, #tp[auf wie viele Arten] man $k$
  Elemente aus einer $n$-elementigen Menge auswählen kann.
  $
    p_n (z) = (1 + z)^n = sum_(k=1)^n tp(binom(n, k)) z^k
    quad => quad tp(C_k^n = binom(n, k))
  $
])

#todo[]

= Wahrscheinlichkeit

== Experimente und Ereignisse

/ Elementarereignis: Der Ausgang eines Experiments heisst _Elementarereignis_
  $omega$.
/ Experiment: Menge der möglichen Versuchsausgänge/Elementarereignisse: $Omega,
  omega in Omega$.
/ Ereignis: Teilmengen von $Omega$ heissen _Ereignisse_. $A$ eingetreten $<=>
  omega in A$, $B$ nicht eingetreten $<=> omega in.not B$
/ Versuch: Einzelne Durchführung eines Zufallsexperiments
/ Das Sichere Ereignis: $A = Omega subset Omega$, $A$ tritt immer ein
/ Das Unmögliche Ereignis: $B = emptyset = {} subset Omega$, $B$ tritt nie ein

=== Ereignis-Algebra

Eine Ereignis-Algebra ist eine Menge $cal(A)$ von Ereignissen derart, dass gilt:

+ Mit zwei Ereignissen $A, B in cal(A)$ ist auch die Vereinigung ein Ereignis:
  $
    A, B in cal(A) => A union B in cal(A)
  $
+ Mit zwei Ereignissen $A, B in cal(A)$ ist auch die Differenz ein Ereignis:
  $
    A, B in cal(A) => A without B in cal(A)
  $
+ Es gibt das sichere Ereignis:
  $ Omega in cal(A) $

#deftbl(
  definition: "Modell",
  [Ereignis ist eingetreten],
  $omega in A$,
  [$A$ und $B$ treten ein],
  $A inter B$,
  [$A$ oder $B$ treten ein],
  $A union B$,
  [$A$ aber nicht $B$],
  $A without B$,
  [$A$ hat $B$ zur Folge, wenn $A$ dann auch $B$],
  $A subset B$,
  [nicht $A$],
  $overline(A) = Omega without A$,
)

Daraus folgt:

+ Es gibt das unmögliche Ereignis
  $ emptyset = Omega without Omega in cal(A) $
+ Das Komplement eines Ereignisses ist ebenfalls ein Ereignis
  $ A in cal(A) => overline(A) = Omega without A in cal(A) $
+ Die Schnittmenge zweier Ereignisse ist ebenfalls ein Ereignis:
  $
    A, B in cal(A) => A inter B = (A union B) without ((A without B) union (B without A)) in cal(A)
  $

_Rechenregeln_

$
  A inter (B union C) = & (A inter B) union (A inter C) \
  A union (B inter C) = & (A union B) inter (A union C) \
  overline(A inter B) = & overline(A) union overline(B) \
  overline(A union B) = & overline(A) inter overline(B) \
$

=== Wahrscheinlichkeit

Die Wahrscheinlichkeit eines Ereignisses $A subset Omega$ ist ist eine Zahl
$
  P(A) = lim_(n -> oo) ("Anzahl Eintreten von" A)/("Anzahl" n "Versuche") =
  lim_(n->oo) "rel. Häufigkeit von" A
$
mit den folgenden Eigenschaften:
+ Wertebereich:
  $ 0 <= P(A) <= 1 $
+ Wahrscheinlichkeit des sicheren Ereignisses:
  $ P(Omega) = 1 $
+ Disjunkte Vereinigung: Sind die Ereignisse $A_i$ disjunkt, also $A_j inter A_i
  = emptyset$ für $i!=j$, dann gilt
  $
    P(A_1 union A_2 union ... union A_n union ...) = P(A_1) + P(A_2) + ... + P(A_n) + ...
  $

Daraus folgt:
+ Wahrscheinlichkeit des unmöglichen Ereignisses:
  $ P(emptyset) = 0 $
  Aber: auch nichtleere Ereignisse können Wahrscheinlichkeit $0$ haben!
+ Wahrscheinlichkeit des komplementären Ereignisses
  $ P(overline(A)) = P(Omega without A) = 1 - P(A) $
+ Wahrscheinlichkeit der Differenz zweier Ereignisse $A$ und $B$
  $ P(A without B) = P(A) - P(A inter B) $
+ Wahrscheinlichkeit der Vereinigung zweier beliebiger Ereignisse
  $ P(A union B) = P(A) + P(B) - P(A inter B) $

/ Laplace-Experiment: Alle Versuchsausgänge haben die gleiche Wahrscheinlichkeit
  $
    P(A) = "Anzahl günstige Ausgänge"/"Anzahl mögliche Ausgänge" =
    abs(A)/abs(Omega)
  $
/ Bernoulli-Experiment: Genau zwei Versuchsausgänge mit Wahrscheinlichkeiten $p$
  und $1 - p$.
  $ p = P(A), 1 - p = 1 - P(A) = P(overline(A)) $

=== Bedingte Wahrscheinlichkeit

/ Bedingte Wahrscheinlichkeit: Wahrscheinlichkeit für $A$, wenn $B$ bereits
  eingetreten ist:
  $ P(A|B) = (P(A inter B))/(P(B)) $
/ Unabhängigkeit: $A$ und $B$ heissen _unabhängig_, wenn:
  $ P(A inter B) = P(A) dot P(B) <=> P(A|B) = P(A|overline(B)) $
/ Abhängigkeit: $A$ und $B$ heissen _Abhängig_, wenn: $ P(A|B) < P(A|overline(B)) $
/ Bayes-Theorem: #comment[Im Allgemeinen ist $P(A|B)!=P(B|A)$]
  $ P(A|B) = (P(B|A) dot P(A))/(P(B)) $
/ Totale Wahrscheinlichkeit: $ P(A) = P(A|B_1)P(B_1) + ... + P(A|B_n)P(B_n) $
  wenn $B_i$ disjunkt und $union.big_(B_i) = Omega$
