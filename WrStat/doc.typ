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
#todo[Hypergeometrische Verteilung]

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
/ Abhängigkeit: $A$ und $B$ heissen _Abhängig_, wenn:
  $ P(A|B) < P(A|overline(B)) $
/ Bayes-Theorem: #comment[Im Allgemeinen ist $P(A|B)!=P(B|A)$]
  $ P(A|B) = (P(B|A) dot P(A))/(P(B)) $
/ Totale Wahrscheinlichkeit: $ P(A) = P(A|B_1)P(B_1) + ... + P(A|B_n)P(B_n) $
  wenn $B_i$ disjunkt und $union.big_(B_i) = Omega$ (die $B_i$ müssen alles
  abdecken)

=== Monty-Hall-Problem

Es gibt drei Türen. Hinter einer ist ein Auto, hinter den anderen beiden eine
Ziege.

+ Spieler wählt eine Tür (erste Wahl).
+ Spielleiter öffnet eine Tür, hinter der sich eine Ziege verbirgt.
+ Spieler kann bei der Wahl bleiben oder die Tür wechseln.

Ereignisse:
#grid(
  columns: (1fr, 1fr),
  $
    Omega = & {"Alle Spielverläufe"} \
        Z = & {"Erste Wahl ist eine Ziege"} \
        A = & {"Erste Wahl ist ein Auto"} \
        G = & {"Gewinnt ein Auto"} \
  $,
  $
    P(Z) = & 2/3 \
    P(A) = & 1/3 \
  $,
)

Spielstrategien:
+ Wechselstrategie: Auf die verbleibende, nicht geöffnete Tür wechseln.
  $
    P(G|A) = 0 quad & P(G|Z) = 1 \
             P(G) = & P(G|A) dot P(A) + P(G|Z) dot P(Z) \
                  = & 0 dot P(A) + 1 dot P(Z) \
                  = & P(Z) = 2/3 \
  $
+ Bleibestrategie: Bei der Tür der ersten Wahl bleiben.
  $
    P(G|A) = 1 quad & P(G|Z) = 0 \
             P(G) = & P(G|A) dot P(A) + P(G|Z) dot P(Z) \
                  = & 1 dot P(A) + 0 dot P(Z) \
                  = & P(A) = 1/3 \
  $

== Übergangsmatrix / Markov-Kette

Eine _homogene_ Markov-Kette ist eine *zeitunabhängige* Übergangsmatrix $T$

// #exbox(automaton(
//   (
//     "1": ("2": "", "3": ""),
//     "2": ("1": "", "3": ""),
//     "3": ("1": "", "2": ""),
//   ),
//   layout: (
//     "1": (0, 0),
//     "2": (1.5, 3),
//     "3": (3, 0),
//   ),
//   final: (),
//   initial: (),
// ))

/ Zustände: $
    S = {0,1,2,3,...}
  $
/ Ereignisse: $
     S_j = & { "Zustand" j "vor Übergang"} \
    S'_i = & { "Zustand" i "nach Übergang"}
  $
/ Übergänge: Wahrscheinlichkeit für den Übergang $j -> i$
  $
    t_(i j) = P(S'_i|S_j)
  $
/ Übergangsmatrix: $
    T = & (t_(i j)) \
      = & mat(
            P(S'_1|S_1), ..., P(S'_1|S_N);
            dots.v, dots.down, dots.v;
            P(S'_N|S_1), ..., P(S'_N|S_N);
          )
  $
/ Verteilung vorher/nachher: $
    p = vec(
      P(S_0),
      P(S_1),
      dots.v,
      P(S_N),
    ), quad
    p' = vec(
      P(S'_0),
      P(S'_1),
      dots.v,
      P(S'_N),
    )
  $
/ Totale Wahrscheinlichkeit: Kann auch in Matrixschreibweise geschrieben werden
  $
    P(S'_i) = & sum_(k in S) P(S'_i|S_k)P(S_k) \
       p'_i = & sum_(k in S) T_(i k) p_k \
         p' = & T p \
    vec(
      P(S'_1),
      dots.v,
      P(S'_N),
    ) =       & mat(
                  P(S'_1|S_1), ..., P(S'_1|S_N);
                  dots.v, dots.down, dots.v;
                  P(S'_N|S_1), ..., P(S'_N|S_N);
                )
                vec(
                  P(S_1),
                  dots.v,
                  P(S_N),
                )
  $
/ $n$ Zeitschritte: $p(t)$ Verteilung zur Zeit $t$: $p(t + n) = T^n p(t)$

#exbox(title: "Weblinks", grid(
  columns: (1fr, auto),
  grid.cell(colspan: 2, [
    Angenommen alle Übergänge und Initialzustände sind gleich wahrscheinlich:
  ]),
  [
    $
          S_i = & {"Besucher auf Seite" i} \
         S'_j = & {"Besucher nach Navigation auf Seite" i} \
            T = & mat(
                    0, 0, 0, 0, 0, 1;
                    1/2, 0, 1/2, 1/3, 0, 0;
                    1/2, 0, 0, 1/3, 0, 0;
                    0, 1, 0, 0, 1/2, 0;
                    0, 0, 1/2, 0, 0, 0;
                    0, 0, 0, 1/3, 1/2, 0;
                  ) \
      P(S'_j) = & P(S'_j|S_1)P(S_1) + P(S'_j|S_2)P(S_2) \
                & + ... + P(S'_j|S_N)P(S_N) \
      P(S'_1) = & 0 + 0 + 0 + 0 + 0 + 1 dot 1/6 = 1/6 \
    $
  ],
  [
    _Markov-Kette_
    #automaton(
      (
        "1": ("2": "", "3": ""),
        "2": ("4": ""),
        "3": ("2": "", "5": ""),
        "4": ("2": "", "6": "", "3": ""),
        "5": ("6": "", "4": ""),
        "6": ("1": ""),
      ),
      layout: (
        "1": (0, 6),
        "2": (3, 6),
        "3": (0, 3),
        "4": (3, 3),
        "5": (0, 0),
        "6": (3, 0),
      ),
      final: (),
      initial: (),
    )],
))

=== Google page rank

$
  G = alpha H + (1 - alpha)/N A
$
heisst _Google-Matrix_, wobei
$
  H = & mat(
          P(S'_1|S_1), ..., P(S'_1|S_N);
          dots.v, dots.down, dots.v;
          P(S'_N|S_1), ..., P(S'_N|S_N);
        ) \
  A = & mat(
          1, ..., 1;
          dots.v, dots.down, dots.v;
          1, ..., 1;
        )
$

Der Pagerank Vektor $p$ ist der Eigenvektor von $G$ zum Eigenwert $1$:
$
  G p = p = lim_(n -> oo) G^n p_0, quad p_0 "ein geeigneter Startvektor"
$

#todo[
  Potenzmethode
]

=== Stationäre Verteilung

/ Stationär: Die Verteilung $p$ heisst _stationär_, wenn sie sich mit der Zeit
  nicht ändert: $T p = p$.
/ Grenzverteilung: $p$ heisst _Grenzverteilung_, wenn $lim_(n->oo) T p_0 = p$
  für eine Startverteilung $p_0$ => Grenzverteilungen sind stationär

Daraus folgt, dass eine Stationäre Verteilung als Eigenvektor von $T$ existiert.

/ Perron-Frobenius-Theorie: Die Übergangsmatrix $T$ ist _nichtnegativ_, d. h.
  $
    T >= 0 <=> t_(i j) >= 0 space forall i, j
  $
  und die Totalen Wahrscheinlichkeiten summieren immer zu $1$:
  $
    sum_j P(S'_i|S_j) = sum_i t_(i j) = 1 space forall j
  $
/ Satz von Perron-Frobenius: Eine irreduzible Wahrscheinlichkeitsmatrix hat
  einen einzigen positiven EV zum EW $1$: $T p = p$

== Zufallsvariablen

Eine Zufallsvariable $X$ ist eine Funktion $X : Omega -> RR$, die einem
Versuchsausgang $omega$ einen Wert $X(omega)$ zuordnet.

Man beachte: die Zufälligkeit liegt in dem Versuch, der das $omega$ ermittelt.
Die Zuweisung des Wertes $X(omega)$ ist deterministisch.

Kürzere Schreibweise:
$
  P(X=a) = & P({omega in Omega mid(|) X(omega)=a}) \
         = & P({X=a})
$

/ Diskrete Zufallsvariable: Eine Zufallsvariable heisst _diskret_, wenn sie nur
  einzelne genau bestimmte Zahlenwerte $x_1, x_2, x_3, ...$ annehmen kann
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
$
      E(X + Y) = & E(X) + E(Y) \
   E(lambda X) = & lambda E(X) \
  E(f(X) g(Y)) = & E(f(X)) E(g(y)), quad f, g : RR -> RR \
$

Sei $A subset Omega$ ein Ereignis, dann ist die charakteristische Funktion von
$A$ eine Zufallsvariable:
$
  chi_A : Omega -> RR, quad chi_A (omega) = cases(
    1 quad & omega in A, 0 & omega
    in.not A
  )
$
Ihr Erwartungswert ist
$
  E(chi_A) = & chi_A (A) dot P(A) + chi_A
               (overline(A)) dot P(overline(A)) \
           = & 1 dot P(A) + 0 dot (1 - P(A)) \
           = & P(A)
$

/ Satz: Der Erwartungswert $E(X)$ einer reellen Zufallsvariable $X$ ist diejenige
  reelle Zahl $mu$, für die $E((X - mu)^2)$ minimal wird.

=== Unabhängigkeit

$X$ und $Y$ sind unabhängig, wenn die Ereignisse ${X <= x}$ und ${Y <= y}$
unabhängig sind, also
$
  fora(
    x\,y in RR,
    P((X <= x) and (Y <= y)) = P(X<=x) P(Y<=y)
  )
$

Seien $A_i, B_j$ Ereignisse, auf denen $X$ bzw. $Y$ konstant ist $=>$
unabhängig.

$
     E(X Y) = & sum_i sum_j X(A_i inter B_j) Y(A_i inter B_j) P(A_i inter B_j) \
            = & sum_i sum_j X(A_i) Y(B_j) P(A_i) P(B_j) \
            = & sum_i (X(A_i) P(A_i)) sum_j (X(B_j) P(B_j)) \
            = & E(X) E(Y) \
  cov(X, Y) = & E(X Y) - E(X) E(Y)
$

Unabhängig $=>$ unkorreliert, unkorreliert $arrow.r.double.not$ unabhängig

=== Varianz

#let rng = suiji.gen-rng-f(42)

#let xs = range(10)
#let (rng, ysd) = suiji.normal(rng, loc: 5, size: 50, scale: 2)
#let ysd = ysd.map(int)
#let ys = xs.map(x => ysd.filter(y => y + 1 == x).len())

#let ex = ys.zip(xs).map(((y, x)) => y * x / 50).sum()
#let vx = ys.map(y => calc.pow(y - ex, 2)).sum() / 50
#let vxrt = calc.sqrt(vx)

#grid(
  columns: 2,
  [
    Mittlere quadratische Abweichung vom Erwartungswert.

    $
      var(X) = & E(X - E(X))^2 \
             = & E(X^2) - E(X)^2
    $

    Für unabhängige Zufallsvariablen $X$ und $Y$ gilt:
    $
      var(lambda X) = & lambda^2 var(X) \
           var(X Y) = & var(X) var(Y) + var(Y) E(X)^2 \
                      & + var(X) E(Y)^2
    $
    Für unkorrelierte Zufallsvariablen $X$ und $Y$ gilt:
    $ var(X + Y) = var(X) + var(Y) $
  ],
  align(center, diagram2d(
    width: 8cm,
    height: 6cm,
    xaxis: (ticks: none),
    yaxis: (ticks: none),
    lq.bar(xs, ys),
    lq.line((ex, -2), (ex, 15), stroke: colors.purple + 2pt),
    lq.place(ex, 16, tp[$E(X)$]),
    lq.line((ex - vxrt, -2), (ex - vxrt, 15), stroke: colors.green + 2pt),
    lq.line((ex + vxrt, -2), (ex + vxrt, 15), stroke: colors.green + 2pt),
    lq.line(
      (ex - vxrt, -1),
      (ex + vxrt, -1),
      toe: tiptoe.stealth,
      tip: tiptoe.stealth,
    ),
    lq.place(ex - vxrt / 1.5, -3, $sqrt(var(X))$),
    lq.place(ex + vxrt / 1.5, -3, $sqrt(var(X))$),
  )),
)

#exbox(title: "Würfel", align(center, table(
  columns: 6,
  $omega$, $P(omega)$, $X$, $X^2$, $X-E(X)$, $(X-E(X))^2$,
  $1$, $1/6$, $1$, $1$, $-2.5$, $6.25$,
  $2$, $1/6$, $2$, $4$, $-1.5$, $2.25$,
  $3$, $1/6$, $3$, $9$, $-0.5$, $0.25$,
  $4$, $1/6$, $4$, $16$, $0.5$, $0.25$,
  $5$, $1/6$, $5$, $25$, $1.5$, $2.25$,
  $6$, $1/6$, $6$, $36$, $2.5$, $6.25$,
  $$,
  $$,
  $E(X) = 21/6$,
  $E(X^2) = 91/6$,
  $$,
  $var(X) = E(X^2) - E(X)^2 = 35/12$,
)))

==== Empirische Varianz

Messwerte $x_1,x_2, ..., x_n$ einer Zufallsvariable $X$

$
  var(X) approx & 1/n sum_i (x_i - mu)^2 \
              = & E(X^2) - E(X)^2
$

// #todo[book p67 "Der Mittelwert der Messwert"]

==== Ungleichung von Tschebyscheff

#grid(
  columns: (auto, 9cm),
  [
    Selbst wenn man gar nichts über die Zufallsvariable weiss, ausser dass sie
    eine Varianz besitzt, kann man eine Aussage über die Wahrscheinlichkeit
    einer grossen Abweichung machen.

    Ist eine Zufallsvariable $X$, dann lässt sich die Wahrscheinlichkeit, dass
    $X$ um mehr als $epsilon$ vom Erwartungswert abweicht, wie folgt abschätzen:

    $
      P(|X - mu| > epsilon) <= var(X)/epsilon^2
    $
    Beweis
    $
      A = {epsilon < & abs(X - mu)} = {epsilon^2 < (X - mu)^2} \
             chi_A < & (X - mu)^2/epsilon^2 \
             P(A) <= & E((X - mu)^2/epsilon^2) = var(X)/epsilon^2 \
    $
  ],
  [

    #let xs = lq.linspace(0, 10, num: 50)
    #let (rng, ys1) = deviate-x(rng, range(20).map(_ => 1), m: 1 / 50)
    #let (rng, ys2) = deviate-x(rng, range(10).map(_ => 4), m: 1 / 50)
    #let (rng, ys3) = deviate-x(rng, range(20).map(_ => 1), m: 1 / 50)
    #let ysall = (..ys1, ..ys2, ..ys3)

    #let m = 2
    #let e = 1

    #align(center, grid(
      columns: 1,
      align: right,
      diagram2d(
        ylabel: $X$,
        xlabel: $omega$,
        width: 8cm,
        height: 4cm,
        xaxis: (ticks: none),
        yaxis: (ticks: none),
        lq.plot(xs, ysall, mark: none),
        lq.line(stroke: purple, (0, m), (10, m)),
        lq.place(-.75, m, tp[$mu$]),
        lq.place(5, -1, tp[$A = {abs(X - mu)>epsilon}$]),
        lq.line(stroke: green, (0, m + e), (10, m + e)),
        lq.place(-1.25, m + e, tg[$mu + epsilon$]),
        lq.line(stroke: green, (0, m - e), (10, m - e)),
        lq.place(-1.25, m - e, tg[$mu - epsilon$]),
        lq.fill-between(
          fill: green.transparentize(80%),
          (0, 10),
          (m + e, m + e),
          y2: (m - e, m - e),
        ),
        lq.fill-between(
          fill: purple.transparentize(80%),
          (4, 6),
          (6, 6),
          y2: (0, 0),
        ),
      ),
      diagram2d(
        ylabel: $(X - mu)^2$,
        xlabel: $omega$,
        width: 8cm,
        height: 4cm,
        xaxis: (ticks: none),
        yaxis: (ticks: none),
        lq.plot(xs, ysall.map(y => calc.pow(y - m, 2)), mark: none),
        lq.line(stroke: green, (0, e), (10, e)),
        lq.place(-.75, e, tg[$epsilon^2$]),
        lq.fill-between(
          fill: green.transparentize(80%),
          (0, 10),
          (0, 0),
          y2: (e, e),
        ),
        lq.fill-between(
          fill: purple.transparentize(80%),
          (4, 6),
          (15.5, 15.5),
          y2: (0, 0),
        ),
      ),
    ))
  ],
)

==== Satz von Bernoulli

/ Gegeben: Zufallsvariable $X$
/ Stichprobe: $X_1, ... , X_n$ Zufallsvariablen mit gleichem Erwartungswert
  $mu =
  E(X)$ und gleicher Varianz wie $X$
/ Mittelwert: $M_n = (X_1 + ... + X_n)/n, quad E(M_n) = E(X), quad var(M_n) =
  var(X)/n$

$
  P(abs(M_n - mu) > epsilon) <= var(X)/(n epsilon^2)
$

$=>$ Je mehr Messungen $n$, desto unwahrscheinlicher eine grosse Abweichung des
Mittelwertes vom Erwartungswert.

#exbox[
  / Ereignis: $A subset Omega$
  / Experiment: $X = chi_A, quad P(A) = E(X), quad var(X) = P(A) - P(A)^2 =
    P(A)(1 - P(A))$
  / Wiederholtes Experiment: $X_1,...,X_n$
  / Relative Häufigkeit: $h_n = (X_1,...,X_n)/n, quad E(h_n) = P(A), quad var(h_n)
    = var(X)/n = (P(A)(1 - P(A)))/n$

  $
    P(abs(h_n - P(A))> epsilon) <= (P(A)(1 - P(A)))/(n epsilon^2) <= 1/(4 n
    epsilon^2)
  $
  #let xs = lq.linspace(0, 1)
  #align(center, diagram2d(
    height: 3cm,
    legend: (position: horizon + right),
    lq.plot(
      xs,
      xs.map(x => x * (1 - x)),
      mark: none,
      label: $f(x) = x (1 - x)$,
    ),
    lq.line((0.5, 0), (0.5, 0.25), stroke: (dash: "dashed")),
    lq.line((-.05, 0.25), (0.5, 0.25), stroke: (dash: "dashed")),
    lq.place(-.1, 0.25, $1/4$),
    lq.place(0.4, 0.05, $P(A)$),
    lq.line((0.4, -.02), (0.4, 0.02)),
  ))
]
