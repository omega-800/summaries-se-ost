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
  $
        && P(A inter B) = & P(A) dot P(B) \
    <=> &&       P(A|B) = & P(A|overline(B)) \
    <=> &&       P(A|B) = & P(A)
  $
/ Abhängigkeit: $A$ und $B$ heissen _Abhängig_, wenn: $ P(A|B) < P(A|overline(B)) $
/ Bayes-Theorem: #comment[Im Allgemeinen ist $P(A|B)!=P(B|A)$]
  $ P(A|B) = (P(B|A) dot P(A))/(P(B)) $
/ Totale Wahrscheinlichkeit: $ P(A) = P(A|B_1)P(B_1) + ... + P(A|B_n)P(B_n) $
  wenn $B_i$ disjunkt und $union.big_(B_i) = Omega$ (die $B_i$ müssen alles
  abdecken)

#todo[Monty-Hall-Problem]

== Zufallsvariablen

Eine Zufallsvariable $X$ ist eine Funktion $X : Omega -> RR$, die einem
Versuchsausgang $omega$
einen Wert $X(omega)$ zuordnet.

Man beachte:
die Zufälligkeit liegt in dem Versuch, der das $omega$ ermittelt. Die Zuweisung des Wertes
$X(omega)$ ist deterministisch.

Kürzere Schreibweise:
$
  P(X=a) = & P({omega in Omega mid(|) X(omega)=a}) \
         = & P({X=a})
$

/ Diskrete Zufallsvariable: Eine Zufallsvariable heisst _diskret_, wenn sie
  nur einzelne genau bestimmte Zahlenwerte $x_1, x_2, x_3, ...$ annehmen kann
/ Stetige Zufallsvariable: Eine Zufallsvariable heisst _stetig_, wenn sie
  beliebige Werte in einem Intervall annehmen kann (Wertemenge ist nicht
  diskret). $P(X=x) = 0$

== Erwartungswert

Ist $X$ eine Zufallsvariable, dann ist der _Erwartungswert_:
$
  E(X) = & sum "Wert" dot "Wahrscheinlichkeit" \
       = & sum_(omega in Omega) X(omega) dot P({omega}) \
       = & sum_(i=1)^k X(A_i) dot P(A_i)
$
wobei $X$ konstant auf $A_i$ und $union.big A_i = omega$ sein muss.

Der Erwartungswert ist _linear_: Sind $X, Y$ Zufallsvariablen, dann gilt
- $E(X + Y) = E(X) + E(Y)$
- $E(lambda X) = lambda E(X)$

Sei $A subset Omega$ ein Ereignis, dann ist die charakteristische Funktion von
$A$ eine Zufallsvariable:
$
  cal(X)_A : Omega -> RR, quad cal(X)_A (omega) = cases(
    1 quad & omega in A, 0 & omega
    in.not A
  )
$
Ihr Erwartungswert ist $ E(cal(X)_A) = & cal(X)_A (A) dot P(A) + cal(X)_A
                (overline(A)) dot P(overline(A)) \
            = & 1 dot P(A) + 0 dot (1 - P(A)) \
            = & P(A) $

=== Unabhängigkeit

$X$ und $Y$ sind unabhängig, wenn die Ereignisse ${X <= x}$ und ${Y <= y}$ unabhängig sind.

#todo[W4 S18..20]

=== Varianz

Mittlere quadratische Abweichung vom Erwartungswert.

$
  var(X) = & E((X - E(X))^2 \
         = & E(X^2) - E(X)^2
$

Für unabhängige Zufallsvariablen $X$ und $Y$ gilt:
- $var(lambda X) = lambda^2 var(X)$
Für unkorrelierte Zufallsvariablen $X$ und $Y$ gilt:
- $var(X + Y) = var(X) + var(Y)$

#exbox(todo[S21])

#todo[W4 S24]

#todo[W4 S27..]
