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
/ Totale Wahrscheinlichkeit: $
    P(S'_i) = & sum_(k in S) P(S'_i|S_k)P(S_k) \
       p'_i = & sum_(k in S) T_(i k) p_k \
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
/ Stationäre Verteilung:
  Der Eigenvektor zum Eigenwert $1$ einer Übergangsmatrix ist die stationäre
  Verteilung der Markov‑Kette. Er wird berechnet, weil er die langfristige,
  unveränderliche Wahrscheinlichkeit über die Zustände liefert
  $
    p' = & T p \
  $
/ Nach $n$ Zeitschritten: $p(t)$ Verteilung zur Zeit $t$: $p(t + n) = T^n p(t)$

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
und $alpha$ der "Freie Wille" ist, also wie oft der Surfer einem link folgt.
$alpha
= 1 =>$ Surfer klickt immer einen link, $alpha = 0 =>$ der Surfer "Teleportiert"
immer zur Seite durch "Freien Willen".

Der Pagerank Vektor $p$ ist der Eigenvektor von $G$ zum Eigenwert $1$:
$
  G p = p = lim_(n -> oo) G^n p_0
$
wobei $p_0$ ein geeigneter Startvektor.

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

/ Satz: Der Erwartungswert $E(X)$ einer reellen Zufallsvariable $X$ ist
  diejenige reelle Zahl $mu$, für die $E((X - mu)^2)$ minimal wird.

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

== Varianz

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

=== Empirische Varianz

Messwerte $x_1,x_2, ..., x_n$ einer Zufallsvariable $X$

$
  var(X) approx & 1/n sum_i (x_i - mu)^2 \
              = & E(X^2) - E(X)^2
$

// #todo[book p67 "Der Mittelwert der Messwert"]

=== Ungleichung von Tschebyscheff

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

=== Satz von Bernoulli (Gesetz der grossen Zahlen)

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

#exbox(title: "Relative Wahrscheinlichkeit")[
  #todo[]
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

= Lineare Regression

#let xs = range(0, 10)
#let ys = range(0, 10)
#let (rng, ys) = deviate-x(rng, ys, m: 1 / 10)
#let (m, b) = linear-regression(xs, ys)
#let ysl = xs.map(x => m * x + b)

#grid(
  columns: 2,
  [

    / Abweichung eines Punktes: $ tg(Delta) = tr(Y) - (a tr(X) + b) $
    / Quadratische Abweichung: $ abs(tg(Delta))^2 = (tr(Y) - a tr(X) - b)^2 $
    / Mitlere quadratische Abweichung: $
        tg("Fehler") = E((tr(Y) - a tr(X) - b)^2) = var(tr(Y) - a tr(X) - b)
      $
    / Minimalproblem: Finde $a$ und $b$ so, dass Fehler, bzw\
      $var(tr(Y) - a tr(X) - b)$ minimal wird (z.B. ableiten)

  ],
  diagram2d(
    width: 8cm,
    height: 6cm,
    xaxis: (ticks: none),
    yaxis: (ticks: none),
    lq.plot(xs, ysl),
    lq.scatter(xs, ys, stroke: colors.red),
    ..xs
      .zip(ys, ysl)
      .map(((x, y, y2)) => lq.line((x, y), (x, y2), stroke: colors.green)),
    lq.place(xs.at(3), ys.at(3) + 1.2, $tr((X\,Y))$),
    lq.place(xs.at(3) - .4, ys.at(3) - 2, $tg(Delta)$),
  ),
)

== Lineares Modell

Linearer Zusammenhang zwischen zwei Zufallsvariablen $X$ und $Y$:

$ Y = a X + b + "Fehler" $

Optimieren:
+ Fehler:
  $
    Q(a,b) = & E((Y - a X - b)^2) \
           = & E(Y^2) + a^2 E(X^2) + b^2 - 2 a E(X Y) - 2 b E(Y) + 2 a b E(X) \
  $
+ Ableiten:
  $
    (partial Q)/(partial a) = & 2 a E(X^2) - 2 E(X Y) + 2 b E(X) & =^! 0 \
    (partial Q)/(partial b) = & 2 b - 2 E(Y) + 2 a E(X)          & =^! 0 \
  $
+ Gleichungssysteme Aufstellen:
  $
    E(X^2) a + && E(X) b = && E(X Y) & => quad a = (E(X Y) - E(X) E(Y))/(E(X^2) -
                                       E(X)^2) = cov(X, Y)/var(X) \
      E(X) a + &&      b = &&   E(Y) & => quad b = E(Y) - a E(X) \
  $
+ Fehlerberechnung:
  $
    var(Y - a X - b)/var(Y) = & 1 - (cov(X, Y)^2)/(var(X) var(Y)) = 1 - r^2 \
                          r = & (cov(X, Y))/sqrt(var(X) var(Y)) \
                            = & (E(X Y) - E(X) E(Y))/sqrt(var(X) var(Y)) \
                            = & "Regressionskoeffizient"
  $
Modell passt gut, falls $r^2 approx 1$

#context shared.corrdiags

=== An empirischen Daten

/ Prinzip: Erwartungswerte durch Mittelwerte ersetzen (Gesetz der grossen
  Zahlen)

$
  a = & (1/n sum_(i=1)^n x_i y_i - (1/n sum_(i=1)^n x_i)(1/n sum_(i=1)^n y_i))/(
  1/n sum_(i=1)^n x_i^2 - (1/n sum_(i=1)^n x_i)^2)
  && = (overline(x y) - overline(x) dot overline(y))/(overline(x^2) - overline(x)^2) \
  b = & 1/n sum_(i=1)^n y_i - a 1/n sum_(i=1)^n x_i
  && = overline(y) - a overline(x) \
  r^2 = & (1/n sum_(i=1)^n x_i y_i - (1/n sum_(i=1)^n x_i)(1/n sum_(i=1)^n
      y_i))^2/((1/n sum_(i=1)^n x_i^2 - (1/n sum_(i=1)^n x_i)^2) (1/n sum_(i=1)^n y_i^2
    - (1/n sum_(i=1)^n y_i)^2))
  && = (overline(x y) - overline(x) dot overline(y))^2/((overline(x^2) -
    overline(x)^2)(overline(y^2) - overline(y)^2)) \
$

#exbox(title: [Treibstoff], [
  #grid(
    columns: (1fr, 1fr),
    [Messresultate:
      #table(
        columns: 2,
        [Zeit [s]], [Länge [mm]],
        $6$, $10.98$,
        $10$, $13.89$,
        $14$, $16.23$,
        $18$, $18.57$,
      )],
    [Berechnungstabelle:
      #table(
        columns: 6,
        stroke: (x, y) => (
          if x == 1 or x == 3 or x == 5 { (left: colors.fg) } else { (:) }
            + if y == 1 or y == 5 { (top: colors.fg) }
        ),
        $i$, $t_i$, $t_i^2$, $x_i$, $x_i^2$, $t_i x_i$,
        $1$, $6$, $36$, $10.98$, $120.56$, $65.88$,
        $2$, $10$, $100$, $13.89$, $192.93$, $138.90$,
        $3$, $14$, $196$, $16.23$, $263.41$, $227.22$,
        $4$, $18$, $324$, $18.57$, $344.84$, $334.26$,
        $$, $48$, $656$, $59.67$, $921.75$, $766.26$,
      )],
  )
  $
    E(T) & = 12 & E(T^2) & = 164 & E(T X) & = 1/4 sum_i
    t_i x_i = 191.57 \
    E(X) & = 14.92 & E(X^2) & = 230.44 & \
    & & var(T) & = 20 & cov(T, X) & = E(T X)
    - E(T) E(X) = 12.55 \
    & & var(X) & = 7.91 \
    a & = cov(T, X)/var(T) & b & = E(X) - a E(T) & r^2 & = cov(T, X)^2/(var(T)
    var(X)) \
    & = 0.628 "[mm/s]" & & = 7.385 "[mm]" & & = 0.997
  $
])

=== Nichtlineae Regressionsverfahren

Lineare Regression funktioniert auch für einige nichtlineare Funktionen:

$
  y = & a x + b & && & && => X = x && Y = y \
  y = & a x^b & -> && log y & = b log x + log a && => X = log x quad && Y = log y \
  y = & a b^x & -> && log y & = (log a)x + log a quad && => X = x && Y = log y \
  y = & log(a x + b) quad & -> && e^y & = a x + b && => X = x && Y = e^y
$

#{
  let xs = lq.linspace(.1, 10, num: 50)
  let diagram2d = diagram2d.with(
    width: 90%,
    yaxis: (subticks: none, format-ticks: none),
    xaxis: (subticks: none, format-ticks: none),
    margin: (x: 0%, y: 0%),
    legend: (position: top + left),
  )
  table(
    align: right,
    columns: (1fr, 1fr, 1fr),
    inset: 1em,
    align(center)[Potenzfunktion],
    align(center)[Exponentialfunktion],
    align(center)[Logarithmusfunktion],

    diagram2d(
      xlabel: $x$,
      ylabel: $y$,
      lq.plot(
        label: $y= a x^b$,
        xs,
        xs.map(x => calc.pow(x, 2)),
        mark: none,
        stroke: colors.purple,
      ),
    ),
    diagram2d(
      xlabel: $x$,
      ylabel: $y$,
      lq.plot(
        label: $y= a b^x$,
        xs,
        xs.map(x => calc.pow(2, x)),
        mark: none,
        stroke: colors.purple,
      ),
    ),
    diagram2d(
      xlabel: $x$,
      ylabel: $y$,
      lq.plot(
        label: $y= log(a x + b)$,
        xs,
        xs.map(x => calc.ln(x)),
        mark: none,
        stroke: colors.purple,
      ),
    ),

    diagram2d(
      xlabel: $x$,
      ylabel: $log y$,
      yscale: lq.scale.scale(
        x => if x <= 0 { x } else { calc.sqrt(x) },
        x => calc.pow(x, 2),
      ),
      lq.plot(
        xs,
        xs.map(x => calc.pow(x, 2)),
        mark: none,
        label: $log y = b log x + a$,
      ),
    ),
    diagram2d(
      xlabel: $x$,
      ylabel: $log y$,
      yscale: lq.scale.scale(
        x => if x <= 0 { x } else { calc.log(x, base: 2) },
        x => calc.pow(2, x),
      ),
      lq.plot(
        xs,
        xs.map(x => calc.pow(2, x)),
        mark: none,
        label: $log y = b x + a$,
      ),
    ),
    diagram2d(
      xlabel: $x$,
      ylabel: $e^y$,
      yscale: lq.scale.scale(
        x => calc.exp(x),
        x => if x <= 0 { x } else { calc.ln(x) },
      ),
      lq.plot(xs, xs.map(x => calc.ln(x)), mark: none, label: $e^y = a x + b$),
    ),
  )
}

=== $X$ und $Y$ vertauschen

#todo[]
// #{
//   let xs = lq.linspace(-5, 5, num: 50)
//   let ys = lq.linspace(-5, 5, num: 50)
//   let (rng, xsr) = deviate-x-pn(rng, xs, m: 1 / 20)
//   let (rng, ysr) = deviate-x-pn(rng, ys, m: 1 / 20)
//   let (my, by) = linear-regression(xs, ysr)
//   let ysl = xs.map(x => my * x + by)
//   let (mx, bx) = linear-regression(ys, xsr)
//   let xsl = xs.map(x => mx * x + bx)
//   grid(
//     columns: (1fr, 1fr),
//     diagram2d(
//       ylim: (-5, 5),
//       xlim: (-5, 5),
//       lq.scatter(xs, ysr),
//       lq.plot(xs, ysl, mark: none),
//       lq.plot(xsl, ys, mark: none),
//     ..ysr.zip(ysl, xs).map(((y,yl, x))=> lq.line((x,y),(x,yl)))
//     ),
//     diagram2d(
//       ylim: (-5, 5),
//       xlim: (-5, 5),
//       lq.scatter(ys, xsr),
//       lq.plot(ys, xsl, mark: none),
//       lq.plot(ysl, xs, mark: none),
//     ..xsr.zip(xsl, ys).map(((x,xl, y))=> lq.line((x,y),(xl,y)))
//     ),
//   )
// }

#todo[W5 S21..]

= Merkmale

#let discrete-xs = range(10)
#let (rng, discrete-ys) = suiji.uniform(rng, size: 9)
#let discrete-ys = (0, ..discrete-ys)

#grid(
  columns: 2,
  [#emph[Quantitativ-diskret]

    #diagram2d(lq.stem(discrete-xs, discrete-ys, mark: none))
  ],
  [#emph[Quantitativ-stetig]

    #let xs = lq.linspace(0, 10, num: 50)
    #let ys = xs.map(x => calc.sin((x - 2) / 4))
    #diagram2d(lq.plot(xs, ys, mark: none))
  ],

  [#emph[Qualitativ-nominal]

    #text(size: 2em, [#tr[rot], #td[blau], #tp[violett]])],
  [#emph[Qualitativ-ordinal]

    #text(size: 2em, [#td[kalt] < #to[warm] < #tr[heiss]])],
)

= Verteilung

#{
  let node = node.with(inset: 1.5em)
  align(center, diagram(
    node-shape: fletcher.shapes.ellipse,
    spacing: (2em, 0pt),
    node((0, 0), [_Zufallsprozess_ wählt $omega in Omega$]),
    edge("-|>", label: [erzeugt Wert]),
    edge((0, 2), "-|>", label: [modelliert durch]),
    node((1, 1), [_Zufallsvariable_ $X(omega)$]),
    edge("-|>", label: [hat]),
    node((0, 2), [_Verteilung_ $F_X (x), phi_X (x)$]),
  ))
}

== Kumulative Häufigkeitsverteilung

$
   H_j = & sum_(k=1)^j h_k = abs({x_i mid(|) x_i <= a_j}) \
       = & "Anzahl Mermalsausprägungen links von" a_j \
  H(x) = & abs({i mid(|) x_i <= x}) \
$

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  diagram2d(
    xlabel: $x$,
    ylabel: $h$,
    lq.stem(discrete-xs, discrete-ys, mark: none),
  ),
  diagram2d(
    xlabel: $x$,
    ylabel: $H$,
    ..discrete-xs
      .zip(cumulative(discrete-ys).slice(1, 10))
      .map(((x, y)) => lq.line(
        (x, y),
        (x + 1, y),
        stroke: colors.darkblue + 1.5pt,
      )),
  ),
)

Relative häufigkeit:
$
  f_j = 1/n h_j, quad F_j = 1/n H_j, quad F(x) = 1/n H(x)
$

== Verteilungsfunktion

Die Verteilungsfunktion einer Zufallsvariable $X$ beschreibt die
Wahrscheinlichkeiten der Werte von $X$:
$ F(x) = F_X (x) = P(X <= x) $

#grid(
  columns: (1fr, 1fr),
  diagram2d(
    title: "diskret",
    lq.plot(
      range(8),
      (0, 0.2, 0.4, 0.5, 0.8, 0.9, 1, 1),
      step: end,
      mark: none,
    ),
    lq.line((0, 1), (7, 1), stroke: colors.comment),
  ),
  diagram2d(
    title: "stetig",
    lq.plot(
      lq.linspace(0, 7, num: 50),
      lq.linspace(0, 7, num: 50).map(x => (calc.tanh(x - 3.5) + 1) / 2),
      mark: none,
    ),
    lq.line((0, 1), (7, 1), stroke: colors.comment),
  ),
)

Eigenschaften:
- $F_X (x)$ ist monoton wachsend
- $F_X (X) subset [0;1]$
- $limits(lim)_(x -> -oo) F(x) = 0, quad limits(lim)_(x->oo) F(x) = 1$
Wahrscheinlichkeit für das Intervall $[a,b] subset RR$:
$P(a < X <= b) = F_X (b) - F_X (a)$

Die Verteilungsfunkton $F(x)$ ist eine Wahrscheinlichkeit, durch die man
Wahrscheinlichkeiten von Ereignissen mit $X$ berechnen kann.

=== Maximum zweier Zufallsvariablen

/ Gegeben: Zwei unabhängige Zufallsvariablen $X$ und $Y$ mit
  Verteilungsfunktionen $F_X (x)$ und $F_Y (y)$
/ Gesucht: Verteilungsfunktion $F_(max(X, Y))(x)$
/ Lösung: $
    F_(max(X, Y))(x) = & P(max(X, Y) <= z) \
                     = & P(X <= z and Y <= z) \
                     = & P(X <= z) P(Y <= z) \
                     = & F_X (z) F_Y (z) \
  $

=== Verteilungsfunktion umkehren

// / Gegeben: $F_Z, Z = f(X)$
// / Vorgehen: $
//     F_Z (z) = & P(Z <= z) = P(f(X) <= z) = P(X <= f^(-1) (z)) = F_X (f^(-1) (z)) \
//     => phi_Z (z) = & F'_X (f^(-1) (z)) = phi_X (f^(-1) (z)) f'^(-1) (z) \
//   $

Ist $f : RR -> RR$ eine invertierbare differenzierbare Funktion, deren Ableitung
nirgends verschwindet, und $X$ eine Zufallsvariable mit Verteilungsfunkion
$F_X$. Dann ist $f compose X$ eine Zufallsvariable mit Verteilungsfunktion
$F_Y = F_X
compose f^(−1)$. Hat $F_X$ die Dichtefunktion $phi_X$, dann hat $F_Y$ die
Dichtefunktion $phi_Y = phi_X/f' compose f^(-1)$

#exbox(
  $
        a, b in & RR, quad a > 0 \
            Z = & a X + b \
      F_Z (z) = & P(a X + b <= z) = P(X <= (z - b)/a) = F_X ((z - b)/a) \
    phi_X (z) = & F'_X ((z - b)/a) = 1/a phi_X ((z - b)/a)
  $,
)

== Mittelwert und Median

#let num = 100

#let xs = lq.linspace(0, 1, num: num)
#let (rng, rys) = suiji.normal(rng, loc: .5, scale: 1, size: num)
#let ys = range(num).map(i => (
  (rys.slice(-i - 1).sum())
    / num
    * (if i > (num / 2) { i / (num / 2 + 5) } else { 1 })
))
#for i in range(num) {
  ys.at(i) = if i == 0 { ys.at(i) } else if ys.at(i - 1) > ys.at(i) {
    ys.at(i - 1)
  } else { ys.at(i) }
}

#let med = ys.position(y => y > 0.5) / num
#let avg = ys.position(y => y > ys.sum() / ys.len()) / num
#let q75 = ys.position(y => y > 0.75) / num
#let q25 = ys.position(y => y > 0.25) / num
#v(1em)
#diagram2d(
  xlabel: $x$,
  ylabel: $F$,
  width: 100%,
  height: 15em,
  legend: (position: top + center),
  yaxis: (ticks: (.25, .5, .75, 1)),
  xaxis: (ticks: none),
  ylim: (-.3, 1.1),
  lq.line((0, 1), (1, 1)),
  lq.line((0, .5), (1, .5)),
  lq.line((0, .75), (1, .75), stroke: .5pt),
  lq.line((0, .25), (1, .25), stroke: .5pt),
  lq.line((q75, -.1), (q75, 1), stroke: colors-l.fg + 1.5pt),
  lq.place(q75, -.15, $x_(0.75)$),
  lq.line((q25, -.1), (q25, 1), stroke: colors-l.fg + 1.5pt),
  lq.place(q25, -.15, $x_(0.25)$),
  lq.line((q25, -.05), (q75, -.05), tip: tiptoe.stealth, toe: tiptoe.stealth),
  lq.place(q25 + (q75 - q25) / 2, -.1, $Q = x_(0.75) - x_(0.25)$),
  lq.line((1, -.3), (1, 1)),
  lq.line((0, -.25), (1, -.25), tip: tiptoe.stealth, toe: tiptoe.stealth),
  lq.place(0, -.35, $x_min$),
  lq.place(1, -.35, $x_max$),
  lq.place(.5, -.3, $R = x_max - x_min$),
  lq.line(
    (avg, 0),
    (avg, 1),
    stroke: colors.purple + 1.5pt,
  ),
  lq.place(avg, 1.1, tp[Mittelwert]),
  lq.line((med, 0), (med, 1), stroke: colors.green + 1.5pt),
  lq.place(med, 1.1, tg[Median]),
  lq.plot(xs, ys, mark: none),
)

/ Mittelwert: $
    "Allgemein": overline(x) = 1/n sum_(i=1)^n x_i, quad "minimiert"
    sum_(i=1)^n (x_i - overline(x))^2 space "(Queadratische Abweichung)"
  $
/ Gewichteter Mittelwert: $
    overline(x) = (sum_(i=1)^n w_i x_i)/(sum_(i=1)^n w_i), quad "minimiert"
    sum_(i=1)^n w_i (x_i - overline(x))^2
  $
/ Modus / Modalwert: Häufigster Wert
/ Spannweite: $R = x_max - x_min$
/ Median: $x_(0.5)$
/ Quartilabstand: $Q = x_(0.75) - x_(0.25)$

/*
#todo[diagram]
  Verteilungsfunktion und Erwartungswert
  $
    E(X) approx & sum_(k = 0)^n xi_k dot (F(xi_(k+1)) - F(xi_k)) \
             -> & integral xi dif F(xi) quad "Stieltjes-Integral" \
          "mit" & abs(xi_(k+1) - xi_k) < epsilon, space "Fehler" approx O(epsilon)
  $
*/

== Wahrscheinlichkeitsdichte

=== Riemann- und Stieltjes-Integral

#let xs = lq.linspace(0, calc.pi * 5 / 4, num: 51)
#let fn = x => (calc.cos(x) + 1.5) * (x + .5) - 1
#let ys = xs.map(fn)
#let wsi = xs.map(x => calc.sin(x / 1.5 + .3) - .2)
#let ws = wsi.chunks(5, exact: true).map(ns => ns.sum() / 5)
#let ysg = range(51).map(i => wsi.slice(-i - 1).sum())

#{
  let diagram2d = diagram2d.with(
    xaxis: (ticks: none),
    yaxis: (ticks: none),
    width: 90%,
  )
  table(
    columns: (1fr, 1fr),
    [Riemann-Integral], [Stieltjes-Integral],
    $
      sum_i td(f(x_i)) dot tr((x_(i+1) - x_i)) -> integral td(f(x)) tr(dif x)
    $,
    $
      sum_i td(f(x_i)) dot tr((g(x_(i+1)) - g(x_i))) -> integral td(f(x)) tr(dif g(x))
    $,

    {
      v(1em)
      align(center, diagram2d(
        xlabel: $x$,
        ylabel: $f(x)$,
        ..range(10)
          .map(i => {
            let ifrom = i * 5
            let ito = (i + 1) * 5
            let yfrom = ys.at(ifrom)
            let yto = ys.at(ito)
            let xfrom = xs.at(ifrom)
            let xto = xs.at(ito)
            let (ylg, ysm) = if yfrom > yto { (yfrom, yto) } else {
              (yto, yfrom)
            }
            (
              lq.rect(
                xfrom,
                0,
                width: xto - xfrom,
                height: ylg,
                fill: colors-l.purple.transparentize(50%),
                stroke: colors.purple,
              ),
              lq.rect(
                xfrom,
                0,
                width: xto - xfrom,
                height: ysm,
                fill: colors-l.purple.transparentize(50%),
                stroke: colors.purple,
              ),
              lq.line(
                (xfrom, .2),
                (xto, .2),
                tip: tiptoe.stealth,
                toe: tiptoe.stealth,
                stroke: colors.green,
              ),
            )
          })
          .join(),

        lq.plot(xs, ys, mark: none),
      ))
    },

    {
      v(1em)
      align(center, diagram2d(
        xlabel: $x$,
        ylabel: $f(x)$,
        ..range(10)
          .zip(ws)
          .map(((i, w)) => {
            let ifrom = i * 5
            let ito = (i + 1) * 5
            let yfrom = ys.at(ifrom)
            let yto = ys.at(ito)
            let xfrom = xs.at(ifrom)
            let xto = xs.at(ito)
            let (ylg, ysm) = if yfrom > yto { (yfrom, yto) } else {
              (yto, yfrom)
            }
            let width = (xto - xfrom) * w
            let xfrom2 = xfrom + ((xto - xfrom) * (1 - w)) / 2
            let xto2 = xfrom2 + width
            (
              lq.rect(
                xfrom,
                0,
                width: xto - xfrom,
                height: ylg,
                stroke: colors.purple,
              ),
              lq.rect(
                xfrom,
                0,
                width: xto - xfrom,
                height: ysm,
                stroke: colors.purple,
              ),
              lq.rect(
                xfrom2,
                0,
                width: width,
                height: ylg,
                fill: colors-l.purple.transparentize(50%),
                stroke: colors.purple,
              ),
              lq.line(
                (xfrom2, .2),
                (xto2, .2),
                tip: tiptoe.stealth,
                toe: tiptoe.stealth,
                stroke: colors.green,
              ),
            )
          })
          .join(),

        lq.plot(xs, ys, mark: none),
      ))
    },

    {
      v(1em)
      align(center, diagram2d(
        xlabel: $x$,
        ylabel: $y = x$,
        ..range(10)
          .map(i => {
            let ifrom = i * 5
            let ito = (i + 1) * 5
            let xto = xs.at(ito)
            let xfrom = xs.at(ifrom)
            (
              lq.line(
                (xto, 0),
                (xto, xto),
                stroke: colors.red,
              ),
              lq.line(
                (xfrom, xto),
                (xto, xto),
                stroke: colors.red,
              ),
              lq.line(
                (xfrom, xto),
                (xfrom, xfrom),
                stroke: colors.green,
                tip: tiptoe.stealth,
                toe: tiptoe.stealth,
              ),
            )
          })
          .join(),
        lq.plot(xs, xs, mark: none, stroke: colors.red),
      ))
    },

    {
      v(1em)
      align(center, diagram2d(
        xlabel: $x$,
        ylabel: $y = g(x)$,
        ..range(10)
          .map(i => {
            let ifrom = i * 5
            let ito = (i + 1) * 5
            let yto = ysg.at(ito)
            let xto = xs.at(ito)
            let yfrom = ysg.at(ifrom)
            let xfrom = xs.at(ifrom)
            (
              lq.line(
                (xto, 0),
                (xto, yto),
                stroke: colors.red,
              ),
              lq.line(
                (xfrom, yto),
                (xto, yto),
                stroke: colors.red,
              ),
              lq.line(
                (xfrom, yto),
                (xfrom, yfrom),
                stroke: colors.green,
                tip: tiptoe.stealth,
                toe: tiptoe.stealth,
              ),
            )
          })
          .join(),
        lq.plot(
          xs,
          ysg,
          mark: none,
          stroke: colors.red,
        ),
      ))
    },
  )
}

=== Wahrscheinlichkeitsdichte

Die Ableitung der Verteilungsfunktion heisst _Wahrscheinlichkeitsdichte_ (gibt
es nur für stetige Zufallsvariablen).

$
         phi(x) = & dif/(dif x) F(x) = F'(x) \
  P(a < X <= b) = & F(b) - F(a) = integral_a^b phi(x) dif x
$


#block(breakable: false, {
  let xs = lq.linspace(-3, 3, num: 50)
  let pfn = normpdf(0, 1)
  let cfn = normcdf(0, 1)
  let a = -1
  let b = 1.5
  let axs = xs.filter(x => x < a)
  let bxs = xs.filter(x => x < b)
  let abxs = xs.filter(x => x < b and x > a)
  let diagram2d = diagram2d.with(
    xaxis: (ticks: none),
    yaxis: (ticks: none),
    height: 5em,
  )
  grid(
    columns: 2,
    $ td(F(x)) $, $ tr(phi(x)) $,
    grid.cell(rowspan: 3, diagram2d(
      legend: (position: (0%, -5em)),
      height: 12em,
      lq.line((b, -.05), (b, cfn(b))),
      lq.line((a, cfn(b)), (b, cfn(b))),
      lq.place(a, -.1, $a$),
      lq.place(b, -.1, $b$),
      lq.line((a, -.05), (a, cfn(a))),
      lq.plot(xs, xs.map(cfn), mark: none),
      lq.plot(
        (b,),
        (cfn(b),),
        stroke: none,
        mark: mark => place(
          center + horizon,
          circle(fill: colors.green, stroke: colors.green, radius: 2.5pt),
        ),
        label: $P(X<=b)$,
      ),
      lq.line(
        (a, cfn(a)),
        (a, cfn(b)),
        stroke: colors.purple + 2pt,
        label: $P(a<X<=b) = F(b) - F(a)$,
      ),
      lq.plot(
        (a,),
        (cfn(a),),
        stroke: none,
        mark: mark => place(
          center + horizon,
          circle(fill: colors.red, stroke: colors.red, radius: 2.5pt),
        ),
        label: $P(X<=a)$,
      ),
    )),
    diagram2d(
      lq.fill-between(
        bxs,
        bxs.map(pfn),
        y2: range(bxs.len()).map(_ => 0),
        fill: colors-l.green.transparentize(50%),
        label: $P(X<=b)$,
      ),
      lq.plot(xs, xs.map(pfn), mark: none, stroke: colors.red),
    ),
    diagram2d(
      lq.fill-between(
        abxs,
        abxs.map(pfn),
        y2: range(abxs.len()).map(_ => 0),
        fill: colors-l.purple.transparentize(50%),
        label: $P(a<=X<=b)$,
      ),
      lq.plot(xs, xs.map(pfn), mark: none, stroke: colors.red),
    ),
    diagram2d(
      lq.fill-between(
        axs,
        axs.map(pfn),
        y2: range(axs.len()).map(_ => 0),
        fill: colors-l.red.transparentize(50%),
        label: $P(X<=a)$,
      ),
      lq.plot(xs, xs.map(pfn), mark: none, stroke: colors.red),
    ),
  )
})

=== Erwartungswert

/ Gegeben: Zufallsvariable $X$ mit Wahrscheinlichkeitsdichte $phi(x)$.
/ Erwartungswert: $
    E(tg(X)) = & td(sum) && tg("Wert") dot && tr("Wahrscheinlichkeit") \
    = & td(integral_(-oo)^oo) && tg(x) && tr(phi(x) dif x) \
    E(tg(X^2)) = & td(integral_(-oo)^oo) && tg(x^2) && tr(phi(x) dif x) \
    E(tg(f(X))) = & td(integral_(-oo)^oo) && tg(f(x)) && tr(phi(x) dif x) \
  $

=== Stetige Gleichverteilung

#todo[]

=== Faltung

Sind $X$ und $Y$ unabhängige Zufallsvariable mit Wahrscheinlichkeitsdichte
$phi_X (x)$ und $phi_Y (y)$, dann hat die Zufallsvariable $Z = X + Y$ die
Wahrscheinlichkeitsdichte
$
  phi_Z (z) = phi_(X+Y) (z) = (phi_X * phi_Y) (z) = integral_(-oo)^oo phi_X (x) phi_Y (z - x) dif x
$
Für die Verteilungsfunktionen gilt
$
  F_Z (z) = F_(X+Y) (z) = & (F_X * phi_Y) (z) = integral_(-oo)^oo F_X (x) phi_Y (z - x) dif x \
  = & (phi_X * F_Y) (z) = integral_(-oo)^oo phi_X (x) F_Y (z - x) dif x \
$

== Verteilungen

#let diag-elems-e-v(xs, E, v, fn) = {
  let mx = calc.max(..xs.map(fn))
  let mn = calc.min(..xs.map(fn))
  let unit = (mx - mn) / 10
  let xunit = (calc.max(..xs) - calc.min(..xs)) / 50
  (
    lq.line((E, -unit * 2), (E, mx), stroke: colors.purple + 1.5pt),
    lq.place(E, mx + unit, tp[$E(X)$]),
    lq.line(
      (E - calc.sqrt(v), -unit),
      (E, -unit),
      tip: tiptoe.stealth,
      toe: tiptoe.stealth,
    ),
    lq.line(
      (E - calc.sqrt(v), -unit),
      (E - calc.sqrt(v), fn(E - calc.sqrt(v))),
      stroke: (dash: "dashed"),
    ),
    lq.place(E - xunit, -unit * 2.5, $sqrt(var(X))$, align: right),
    lq.line(
      (E + calc.sqrt(v), -unit),
      (E, -unit),
      tip: tiptoe.stealth,
      toe: tiptoe.stealth,
    ),
    lq.line(
      (E + calc.sqrt(v), -unit),
      (E + calc.sqrt(v), fn(E + calc.sqrt(v))),
      stroke: (dash: "dashed"),
    ),
    lq.place(E + xunit, -unit * 2.5, $sqrt(var(X))$, align: left),
  )
}

#let F-phi-diag(xs, F, p, E, E2, v) = {
  let Fs = xs.map(F)
  let ps = xs.map(p)
  let common = diag-elems-e-v.with(xs, E, v)
  grid(
    columns: (1fr, 1fr),
    align: center,
    diagram2d(
      width: 20em,
      yaxis: (
        ticks: none,
        label: td[$F(x)$],
      ),
      xaxis: (
        ticks: none,
        label: $x$,
      ),
      lq.plot(
        xs,
        Fs,
        mark: none,
        stroke: colors.darkblue,
      ),
      ..common(F),
    ),
    diagram2d(
      width: 20em,
      yaxis: (
        ticks: none,
        label: tr[$phi(x)$],
      ),
      xaxis: (
        ticks: none,
        label: $x$,
      ),
      ..plot-fill(
        xs,
        ps,
        stroke: colors.red,
      ),
      ..common(p),
    ),
  )
}

#let (normal, erlang, exponential, poisson) = distributions

=== Exponentialverteilung

Findet Anwendung bei gedächtnislosen Prozessen, beispielsweise bei:
- Radioaktivem Zerfall
- Warteschlangen

$
  F(x) = & cases(0 & x < 0, 1 - e^(-a x) space & x >= 0) \
  phi(x) = & cases(0 & x < 0, a e^(-a x) space & x >= 0) \
  E(X) = & 1/a && = "Mean Time Between Failure, Masseinheit" 1/s \
  E(X^2) = & 2/a^2 \
  var(X) = & 1/a^2 \
$

#F-phi-diag(lq.linspace(-1, 3, num: 100), ..exponential(1))

#exbox(
  title: [Mit welcher Wahrscheinlichkeit wird ein Bauteil, das eine mittlere
    Lebensdauer von $1000$ Tagen hat, älter als $500$ Tage?],
  [
    $
             a = & 1/1000 \
          F(t) = & 1 - e^(-t/1000) \
      P(T>500) = & 1 - P(T<= 500) = 1 - F(500) = e^(-1/2)
    $
  ],
)

==== Gedächtnislose Prozesse

Die positive Zufallsvariable $T$ ist der Zeitpunkt, zu dem ein Ereignis
eintritt.
$
  F(x) = P(T <= x), space G(x) = 1 - F(x) = P(T > x)
$

/ Gedächtnislos: $T$ ist gedächtnislos, wenn die Wahrscheinlichkeit, dass das
  Ereignis in einem Intervall eintritt, immer gleich ist, wenn es zu Beginn des
  Intervalls noch nicht eingetreten ist.
  $
    P(T <= x + y mid(|) T > x) = P(T <= y)
  $

Herleitung des $G(x)$:
$
      && P(T > x + y)/P(T>x) = & P(T>y) \
  <=> &&       G(x + y)/G(x) = & G(y) \
  <=> &&            G(x + y) = & G(y)G(x) quad && "Ableitung nach" y "bei" y=0 \
      &&               G'(x) = & G'(0)G(x) \
   => &&                G(x) = & C e^(-a x)    && "mit" a = -G'(0) \
   => &&              phi(x) = & a C e^(-a x)  && "für" x > 0 \
$
Normierung: $C = 1$

==== Halbwertszeit

Gegeben ein $T$ exponentialverteilt mit Parameter $a$, finde den Median von $T$,
also $t_(1/2)$ derart, dass
$ P(T<=t_(1/2)) = 1/2 $
$t_(1/2)$ heisst _Halbwertszeit_.
$
      && P(T <= t_(1/2)) = & 1/2 = F(t_(1/2)) = 1 - e^(-a t_(1/2)) \
  <=> &&  e^(-a t_(1/2)) = & 1/2 \
  <=> &&      -a t_(1/2) = & -log 2 \
  <=> &&         t_(1/2) = & (log 2)/a \
  <=> &&               a = & (log 2)/(t_(1/2)) \
$

=== Erlang-Verteilung

Beschreibt die Wartezeit bis zum $k$-ten Ereignis, wenn Ereignisse unabhängig
und mit gleichbleibender Rate $lambda$ auftreten, beispielsweise:
- Wartezeit in einer Telefonzentrale
- Warteschlangenprobleme

Gegeben $X_i$ unabhängige exponentialverteilte Zufallsvariablen mit Parameter
$a$ ist die Erlang-Verteilung

$
  phi_k (x) = & cases(
                  a^k (x^(k-1))/((k-1)!) e^(-a x) space & x>= 0,
                  0 & "sonst"
                ) \
       k = 1: & "Exponentialverteilung" \
       F(x) = & cases(
                  1 - e^(- a x) sum_(i=0)^(k - 1) (a x)^i/i!
                  space & x>= 0,
                  0 & "sonst"
                ) \
       E(X) = & k / a \
     E(X^2) = & (k(k+1)) / a^2 \
     var(X) = & k / a^2 \
     lambda = & a x = "mittlere Anzahl Ereignisse innerhalb vom intervall" x
$

#F-phi-diag(lq.linspace(-1, 6, num: 100), ..erlang(1, 2))

#exbox(
  title: [Die Wahrscheinlichkeit für den Verlust eines Datenbits innerhalb von
    $100$ Jahren ist $10^(-6)$. Wie gross ist die Wahrscheinlichkeit, dass das
    dritte Bit nach $20000$ Jahren verloren gegangen ist?],
  $
    1 - e^(-100 a) = & 10^(-6) \
             <=> a = & -ln(1 - 10^(-6))/100 approx 10^(-8) \
      P(T_3 < 20000) & = 1 - e^(-20000 dot 10^(-8)) (1 + 20000 dot 10^(-8) +
                         (20000 dot 10^(-8))^2/2!) approx 1.33 dot 10^(-12) \
  $,
)

==== Summe von Exponentialverteilungen

$
  tp(phi_(k + 1) (x)) = tr(phi_k) * td(phi_1) (x) = integral_0^x tr(phi_k (t))
  td(phi_1 (x - t)) dif t = (a^(k+1))/(k!) e^(-a x) x^k
$

#{
  let k = 2
  let a = 4
  let x = 2
  let xs = lq.linspace(-.5, x + .5, num: 100)
  let xs1 = xs.filter(x1 => x1 < x)

  align(center, diagram2d(
    xaxis: (label: $t$, tick-distance: .5),
    yaxis: (label: $phi$, ticks: none),
    width: 15cm,
    height: 5cm,
    ..plot-fill(
      xs,
      xs.map(erlcdf(a, k)),
      stroke: colors.red,
      label: $phi_k (t)$,
    ),
    ..plot-fill(
      xs,
      xs.map(erlcdf(a, k + 1)),
      stroke: colors.purple,
      label: $phi_(k+1) (t)$,
    ),
    ..plot-fill(
      xs1,
      xs1.map(t => erlcdf(a, 1)(x - t)),
      stroke: colors.darkblue,
      label: $phi_1 (x - t)$,
    ),
    lq.place(2, -.5, $x$),
  ))
}

=== Poisson-Verteilung

Gegeben gedächtnisloser Prozesse $T_i$ mit gleichem $a$, wie gross ist die
Wahrscheinlichkeit, dass in einem Intervall der Länge $l$ genau $k$ Prozesse
stattfinden?

$
  S_k = & T_1 +...+T_k \
  P(S_k <= x) = & F_k (x) && "Erlang-Verteilung" \
  P(S_k <= l and S_(k+1) > l) = & P({S_k <= l} without {S_(k+1) <= l}) \
  = & F_k (l) - F_(k+1) (l) \
  = & P_lambda (k) && "Poisson-Verteilung" \
  = & e^(- a l) (a l)^k/k! = e^(-lambda) lambda^k/k! \
  E(X) = & lambda \
  E(X^2) = & e^(-lambda) lambda (e^lambda + lambda e^lambda) \
  var(X) = & lambda \
$

#{
  let xs = range(15)

  let (F, E, E2, v) = poisson(7.5)

  let mx = calc.max(..xs.map(F)) + .01
  let mn = calc.min(..xs.map(F))
  let unit = (mx - mn) / 10
  let xunit = (calc.max(..xs) - calc.min(..xs)) / 50

  align(center, diagram2d(
    width: 15cm,
    height: 6cm,
    xaxis: (ticks: none, label: $k$),
    yaxis: (ticks: none, label: $P(X=k)$),
    lq.bar(xs, xs.map(F)),
    lq.line((E, -unit * 2), (E, mx), stroke: colors.purple + 1.5pt),
    lq.place(E, mx + unit, tp[$E(X) = lambda$]),
    lq.line(
      (E - calc.sqrt(v), -unit),
      (E, -unit),
      tip: tiptoe.stealth,
      toe: tiptoe.stealth,
    ),
    lq.line(
      (E - calc.sqrt(v), -unit),
      (E - calc.sqrt(v), mx),
      stroke: (dash: "dashed"),
    ),
    lq.place(
      E - xunit,
      -unit * 2.5,
      $sqrt(var(X)) = sqrt(lambda)$,
      align: right,
    ),
    lq.line(
      (E + calc.sqrt(v), -unit),
      (E, -unit),
      tip: tiptoe.stealth,
      toe: tiptoe.stealth,
    ),
    lq.line(
      (E + calc.sqrt(v), -unit),
      (E + calc.sqrt(v), mx),
      stroke: (dash: "dashed"),
    ),
    lq.place(
      E + xunit,
      -unit * 2.5,
      $sqrt(var(X)) = sqrt(lambda)$,
      align: left,
    ),
  ))
}

#exbox(title: "London Bombing Raids")[
  #grid(
    columns: 2,
    [
      / Frage: Wurden $n = 538$ Bomben gezielt oder ziellos geschossen?
      / Methode: Zielgebiet in $N = 576$ gleich grosse Quadrate aufteilen, $X_k$
        Anzahl Quadrate mit genau $k$ Treffern.
      / Modell: Erwartete Trefferrate pro Feld: $lambda = n/N$
        $
          P(k "Treffer") = & P_lambda (k) \
                  E(X_k) = & N dot P_lambda (k)
        $
      Empirische Wahrscheinlichkeiten $n_k/N$ stimmen mit $P_lambda (k)$ überein
      $=>$ ziellose/zufällige Treffer.
    ],
    table(
      columns: 4,
      $k$, $P(X = k)$, $E(X_k)$, $n_k$,
      $0$, $0.39298$, $226.35$, $229$,
      $1$, $0.36704$, $211.42$, $211$,
      $2$, $0.17141$, $98.73$, $93$,
      $3$, $0.05337$, $30.74$, $35$,
      $4$, $0.01246$, $7.19$, $7$,
      $> 4$, $0.00274$, $1.58$, $1$,
    ),
  )
]

=== Normalverteilung

Summe vieler kleiner Einflüsse, beispielsweise:
- Messwerte
- Wiederholte Experimente
- Verteilung der in einem Medium diffundierender Moleküle, die in
  einem Punkt konzentriert waren

$
  phi(x) = & 1/(sqrt(2 pi) sigma) e^((x - mu)^2/(2 sigma^2)) \
  F(x) = & 1/(sqrt(2 pi) sigma) integral_(-oo)^x e^(-1/2 ((x - mu)/sigma)^2) dif t \
  E(X) = & 1/(sqrt(2 pi sigma^2)) integral_(-oo)^(+oo) x e^(- (x - mu)^2/(2
  sigma^2)) dif x && = mu \
  E(X^2) = & sigma^2 + mu^2 \
  var(x) = & 1/(sqrt(2 pi sigma^2)) integral_(-oo)^(+oo) (x - mu)^2 e^(- (x -
    mu)^2/(2 sigma^2)) dif x space && = sigma^2 \
  sigma = & "Standardabweichung" \
$

#F-phi-diag(lq.linspace(0, 6, num: 100), ..normal(3, 1))

#exbox(todo[])

Das Maximum ist bei $x = mu$ und die Wendepunkte liegen bei $x = mu plus.minus
sigma$. Die Ableitungen liegen bei:
$
  phi'(x) = & 1/(sqrt(2 pi) sigma) e^((x - mu)^2/(2 sigma^2)) (-(x - mu)/(sigma^2)) \
  phi''(x) = & 1/(sqrt(2 pi) sigma) e^((x - mu)^2/(2 sigma^2)) 1/sigma^4 ((x - mu)^2-sigma^2) \
$

==== Typische Werte

Fast alle Realisierungen landen innerhalb
von diesen 3 Standardabweichungen

#{
  let xs = lq.linspace(-3, 3, num: 100)
  let m = 0
  let s = 1
  let pdf = normpdf(m, s)
  grid(
    columns: (1fr, 1fr, 1fr),
    ..(68, 95, 99.7)
      .enumerate()
      .map(((i, p)) => {
        let j = i + 1
        let xs1 = xs.filter(x => x > m - s * j and x < m + s * j)
        diagram2dnx(
          width: 6cm,
          height: 3cm,
          lq.plot(xs, xs.map(pdf), stroke: colors.darkblue, mark: none),
          lq.fill-between(
            xs1,
            xs1.map(pdf),
            y2: xs1.map(_ => 0),
            fill: colors-l.red.transparentize(50%),
            label: $#p%$,
          ),
          lq.place(m, -.05, $mu$),
          lq.place(m - s * j, -.05, $-#if j != 1 { j } sigma$),
          lq.place(m + s * j, -.05, $#if j != 1 { j } sigma$),
        )
      })
  )
}

==== Rechnen mit der Wahrscheinlichkeitsdichte

Die Wahrscheinlichkeitsdichte der Normalverteilung hat keine Stammfunktion in
geschlossener Form.

$
  P(a<X<=b) = & 1/(sqrt(2 pi) sigma) integral_a^b e^(-1/2 ((x - mu)/sigma)^2) dif x \
$

#todo[W8 S8..]

==== Rechenregeln

/ Linearität: Ist $X tilde N(mu,sigma^2)$ mit $E(X) = mu$ und $var(X) = sigma^2$, dann ist $a X + b$ normalverteilt mit
  $E(a X + b) = a mu + b$ und $var(a X + b) = a^2 sigma^2$
/ Summensatz: Ist $X_1 tilde N(mu_1,sigma^2_1)$ und  $X_2 tilde
  N(mu_2,sigma^2_2)$, dann ist $X = X_1 +X_2$ normalverteilt mit $E(X) = mu_1 +
  mu_2$ und $var(X) = sigma_1^2 + sigma_2^2$

==== Standardnormalverteilung

/ Standardisierung: Sei $X ~ N(mu, sigma^2)$, dann ist $Z = (X - mu)/sigma$
  normalverteilt mit $E(Z) = 0$ und $var(Z) = 1$.
/ Standardnormalverteilung: $Z$ heisst _Standardnormalverteilung_ mit
  Verteilungsfunktion $Phi(z)$. $Phi(-z) = 1 - Phi(z)$

#exbox(todo[W8 S10])

Anhand der Wertetabelle (@wertetabelle), kann man nach Standardisierung die Werte
ablesen.

==== Parameter bestimmen

#todo[W8 S15..]
Durch Schätzen:
$
  hat(mu) = & E(X) = 1/n sum_(i=1)^n x_i \
  hat(sigma)^2 = & E(X^2) - E(X)^2 = 1/n sum_(i=1)^n x_i^2 - (1/n sum_(i=1)^n x_i)^2 \
$
#todo[
  Schätzung $hat(sigma)^2$ ist nicht erwartungstreu (biased)
  - $hat(mu)$ und $hat(sigma)^2$ sind Zufallsvariablen
  - $hat(mu)$ und $hat(sigma)^2$ eingesetzt in
  Normalverteilung ist keine
  Normalverteilung (t-Verteilung)
]

#todo[book]

Durch Wahrscheinlichkeit:
$
                            P(X <= x) = & p \
  P((X - mu)/sigma <= (x - mu)/sigma) = & p \
               P(Z <= (x - mu)/sigma) = & p \
                  Phi((x - mu)/sigma) = & p \
      tp(mu) + Phi^(-1) (p) tp(sigma) = & x \
$
Als zweiten Term kann man den Median nehmen, um die #tp[Unbekannten] aufzulösen:
$
               p = & 0.5 \
  Phi^(-1) (0.5) = & 0 => mu = x \
$

==== Zentraler Grenzwertsatz

Sind $X_1, X_2, ...$ identisch verteilte und unabhängige Zufallsvariablen mit
$E(X_i) = mu$ und $var(X_i) = sigma^2$, dann gilt
$
  S_n = &sum_(i=1)^n X_i &=> & E(S_n) = n mu, space &var(S_n) = &n sigma^2 \
  Z_n = & (S_n - n mu)/(sqrt(n) sigma) &=> & E(Z_n) = 0, space &var(Z_n) = &1
$

Für $n->oo$ strebt die Verteilung von $Z_n$ gegen die Standardnormalverteilung,
d.h.
$
  lim_(n->oo) P(Z_n <= z) = Phi(z)
$
Heisst: die Summe vieler vergleichbarer kleiner Einflüsse ist annähernd normalverteilt.

= Anhang

#figure(alt: "Wertetabelle", caption: "Wertetabelle", table(
  columns: range(11).map(_ => 1fr),
  $x$, $+0.00$, $+0.01$, $+0.02$, $+0.03$, $+0.04$, $+0.05$, $+0.06$, $+0.07$, $+0.08$, $+0.09$,

  emph[$0.0$], $0.5000$, $0.5040$, $0.5080$, $0.5120$, $0.5160$, $0.5199$, $0.5239$, $0.5279$, $0.5319$, $0.5359$,

  emph[$0.1$], $0.5398$, $0.5438$, $0.5478$, $0.5517$, $0.5557$, $0.5596$, $0.5636$, $0.5675$, $0.5714$, $0.5753$,

  emph[$0.2$], $0.5793$, $0.5832$, $0.5871$, $0.5910$, $0.5948$, $0.5987$, $0.6026$, $0.6064$, $0.6103$, $0.6141$,

  emph[$0.3$], $0.6179$, $0.6217$, $0.6255$, $0.6293$, $0.6331$, $0.6368$, $0.6406$, $0.6443$, $0.6480$, $0.6517$,

  emph[$0.4$], $0.6554$, $0.6591$, $0.6628$, $0.6664$, $0.6700$, $0.6736$, $0.6772$, $0.6808$, $0.6844$, $0.6879$,

  emph[$0.5$], $0.6915$, $0.6950$, $0.6985$, $0.7019$, $0.7054$, $0.7088$, $0.7123$, $0.7157$, $0.7190$, $0.7224$,

  emph[$0.6$], $0.7257$, $0.7291$, $0.7324$, $0.7357$, $0.7389$, $0.7422$, $0.7454$, $0.7486$, $0.7517$, $0.7549$,

  emph[$0.7$], $0.7580$, $0.7611$, $0.7642$, $0.7673$, $0.7704$, $0.7734$, $0.7764$, $0.7794$, $0.7823$, $0.7852$,

  emph[$0.8$], $0.7881$, $0.7910$, $0.7939$, $0.7967$, $0.7995$, $0.8023$, $0.8051$, $0.8078$, $0.8106$, $0.8133$,

  emph[$0.9$], $0.8159$, $0.8186$, $0.8212$, $0.8238$, $0.8264$, $0.8289$, $0.8315$, $0.8340$, $0.8365$, $0.8389$,

  emph[$1.0$], $0.8413$, $0.8438$, $0.8461$, $0.8485$, $0.8508$, $0.8531$, $0.8554$, $0.8577$, $0.8599$, $0.8621$,

  emph[$1.1$], $0.8643$, $0.8665$, $0.8686$, $0.8708$, $0.8729$, $0.8749$, $0.8770$, $0.8790$, $0.8810$, $0.8830$,

  emph[$1.2$], $0.8849$, $0.8869$, $0.8888$, $0.8907$, $0.8925$, $0.8944$, $0.8962$, $0.8980$, $0.8997$, $0.9015$,

  emph[$1.3$], $0.9032$, $0.9049$, $0.9066$, $0.9082$, $0.9099$, $0.9115$, $0.9131$, $0.9147$, $0.9162$, $0.9177$,

  emph[$1.4$], $0.9192$, $0.9207$, $0.9222$, $0.9236$, $0.9251$, $0.9265$, $0.9279$, $0.9292$, $0.9306$, $0.9319$,

  emph[$1.5$], $0.9332$, $0.9345$, $0.9357$, $0.9370$, $0.9382$, $0.9394$, $0.9406$, $0.9418$, $0.9429$, $0.9441$,

  emph[$1.6$], $0.9452$, $0.9463$, $0.9474$, $0.9484$, $0.9495$, $0.9505$, $0.9515$, $0.9525$, $0.9535$, $0.9545$,

  emph[$1.7$], $0.9554$, $0.9564$, $0.9573$, $0.9582$, $0.9591$, $0.9599$, $0.9608$, $0.9616$, $0.9625$, $0.9633$,

  emph[$1.8$], $0.9641$, $0.9649$, $0.9656$, $0.9664$, $0.9671$, $0.9678$, $0.9686$, $0.9693$, $0.9699$, $0.9706$,

  emph[$1.9$], $0.9713$, $0.9719$, $0.9726$, $0.9732$, $0.9738$, $0.9744$, $0.9750$, $0.9756$, $0.9761$, $0.9767$,

  emph[$2.0$], $0.9772$, $0.9778$, $0.9783$, $0.9788$, $0.9793$, $0.9798$, $0.9803$, $0.9808$, $0.9812$, $0.9817$,

  emph[$2.1$], $0.9821$, $0.9826$, $0.9830$, $0.9834$, $0.9838$, $0.9842$, $0.9846$, $0.9850$, $0.9854$, $0.9857$,

  emph[$2.2$], $0.9861$, $0.9864$, $0.9868$, $0.9871$, $0.9875$, $0.9878$, $0.9881$, $0.9884$, $0.9887$, $0.9890$,

  emph[$2.3$], $0.9893$, $0.9896$, $0.9898$, $0.9901$, $0.9904$, $0.9906$, $0.9909$, $0.9911$, $0.9913$, $0.9916$,

  emph[$2.4$], $0.9918$, $0.9920$, $0.9922$, $0.9925$, $0.9927$, $0.9929$, $0.9931$, $0.9932$, $0.9934$, $0.9936$,

  emph[$2.5$], $0.9938$, $0.9940$, $0.9941$, $0.9943$, $0.9945$, $0.9946$, $0.9948$, $0.9949$, $0.9951$, $0.9952$,

  emph[$2.6$], $0.9953$, $0.9955$, $0.9956$, $0.9957$, $0.9959$, $0.9960$, $0.9961$, $0.9962$, $0.9963$, $0.9964$,

  emph[$2.7$], $0.9965$, $0.9966$, $0.9967$, $0.9968$, $0.9969$, $0.9970$, $0.9971$, $0.9972$, $0.9973$, $0.9974$,

  emph[$2.8$], $0.9974$, $0.9975$, $0.9976$, $0.9977$, $0.9977$, $0.9978$, $0.9979$, $0.9979$, $0.9980$, $0.9981$,

  emph[$2.9$], $0.9981$, $0.9982$, $0.9982$, $0.9983$, $0.9984$, $0.9984$, $0.9985$, $0.9985$, $0.9986$, $0.9986$,

  emph[$3.0$], $0.9987$, $0.9987$, $0.9987$, $0.9988$, $0.9988$, $0.9989$, $0.9989$, $0.9989$, $0.9990$, $0.9990$,
)) <wertetabelle>
