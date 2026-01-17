#import "../lib.typ": *
#import "@preview/lilaq:0.5.0" as lq
#show: project.with(
  module: "An1I",
  name: "Analysis für Informatiker",
  semester: "HS25",
)

= Funktionen

== Glossar

#deftbl(
  [Definitionsmenge],
  [
    Mögliche Funktionsinputs \
    Notation definitionsmenge der Funktion $f$: $D_f$
  ],
  [Zielmenge],
  [
    Mögliche Funktionswerte
  ],
  [Definitionsbereich],
  [
    Alle Funktionsinputs
  ],
  [Wertebereich],
  [
    Alle Funktionswerte
  ],
  [Nullstelle einer Funktion],
  [
    Argument, welches den Funktionswert $0$ hat
  ],
  [Bild einer Funktion],
  [
    Alle möglichen Funktionswerte einer Funktion
  ],
  [Graph],
  [
    Menge aller Punkte (Tupel) einer Funktion in der Form (Argument, Funktionswert) \
    $"Graph"_f = (x,y) | y = f(x)$
  ],
  [Polynom],
  [
    $P(x) = a_n x^n + a_(n-1) x^(n-1) + ... + a_1 x + a_0$ \
    Koeffizienten: $a_n,...,a_0$ \
    Grad des Polynoms: $n$
  ],
)

=== Stetige Funktion

Funktion, deren Graph keine Sprünge oder Unterbrechungen aufweist

=== Stetig fortsetzbare Funktion

Funktion, die an einem bestimmten Punkt nicht definiert ist, aber erweitert werden kann, sodass die erweiterte Funktion stetig bleibt

=== Glatte Funktion

Funktion, die unendlich oft differenzierbar ist

=== Streng wachsende Funktion

$x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
Bsp: \
#let xs = lq.linspace(0, 10)
#lq.diagram(
  title: $f(x) = x + 2$,
  ylim: (-0.5, 12),
  lq.plot(xs, xs.map(x => x + 2), mark: none),
)
// approximation
#let e = 2.718281828
#let xs = lq.linspace(0, 5)
#lq.diagram(
  title: $f(x) = a^x, a > 1\ ("Diagramm: " f(x) = 2^x)$,
  lq.plot(xs, xs.map(x => calc.pow(2, x)), mark: none),
)

=== Monoton wachsende Funktion

$x < accent(x, ~) -> f(x) <= f(accent(x, ~))$ \
Bsp: \
#let xs = lq.linspace(0, 5)
#lq.diagram(
  title: $ f(x) = cases(x","&x<=1, 1","&1<x<=2, (x-2)^2+1", "&x>2) $,
  lq.plot(
    xs,
    xs.map(x => if x <= 1 { x } else if x <= 2 { 1 } else {
      calc.pow(x - 2, 2) + 1
    }),
    mark: none,
  ),
)

=== Streng fallende Funktion

$x < accent(x, ~) -> f(x) > f(accent(x, ~))$ \
Bsp: \
#let xs = lq.linspace(0.0001, 5)
#lq.diagram(
  title: $f(x): RR^+ -> RR, x |-> 1 / x$,
  ylim: (-0.5, 12),
  lq.plot(xs, xs.map(x=> 1 / x), mark: none),
)

=== Monoton fallende Funktion

$x < accent(x, ~) -> f(x) >= f(accent(x, ~))$ \
Bsp: \
#let xs = lq.linspace(0, 5)
#lq.diagram(
  title: $ f(x) = cases(-2x + 2&","x<=2, -2&","1<x<=4, -x / 2&", "x>4) $,
  lq.plot(
    xs,
    xs.map(x => if x <= 2 { x * - 2 + 2 } else if x <= 4 { -2 } else {
      - x / 2
    }),
    mark: none,
  ),
)

=== Gerade Funktion

$forall x in D_f: f(-x) = f(x)$ \

Bsp: \

#grid(columns: (1fr,1fr),
[#let xs = lq.linspace(-10, 10)
#lq.diagram(
  title: $f(x) = x^n, n "gerade" \ "Diagramm: " f(x) = x^2$,
  lq.plot(xs, xs.map(x => calc.pow(x, 2)), mark: none),
)
],[
#let xs = lq.linspace(-10, 10)
#lq.diagram(
  title: $f(x) = |x|$,
  lq.plot(xs, xs.map(calc.abs), mark: none),
)
],[
#let xs = lq.linspace(-2 * calc.pi, 2 * calc.pi)
#lq.diagram(
  title: $f(x) = cos(x)$,
  lq.plot(xs, xs.map(calc.cos), mark: none),
)
])

=== Ungerade Funktion

$forall x in D_f: f(-x) = -f(x)$ \
Bsp: \

#let xs = lq.linspace(-5, 5)
#lq.diagram(
  title: $f(x) = x^n, n "ungerade" \ "Diagramm: " f(x) = x^3$,
  lq.plot(xs, xs.map(x => calc.pow(x, 3)), mark: none),
)
#let xs = lq.linspace(-2 * calc.pi, 2 * calc.pi)
#lq.diagram(
  title: $f(x) = sin(x)$,
  lq.plot(xs, xs.map(calc.sin), mark: none),
)

=== Periodische Funktion

$forall x in D_f: f(x+p) = f(x)$ \
- Mit der Periode $p$
- Die kleinste positive Periode heisst _primitive Periode_
Bsp: \
#let xs = lq.linspace(0, 4 * calc.pi)
#lq.diagram(
  title: $f(x) = sin(x) \ p = 2pi$,
  lq.plot(xs, xs.map(calc.sin), mark: none),
)

=== Umkehrfunktion

$f(x) = y <=> f^(-1) (y) = x$ \
Bsp: \
#let xs = lq.linspace(0, 10)
#lq.diagram(
  title: $f(x) = x^2$,
  lq.plot(xs, xs.map(x => calc.pow(x, 2)), mark: none),
)
#let xs = lq.linspace(0, 10)
#lq.diagram(
  title: $f^(-1) (x) = sqrt(x)$,
  lq.plot(xs, xs.map(x => calc.sqrt(x)), mark: none),
)

== Anatomie einer Funktion

$
  underbrace(f, "Funktionsname") : cases(
    underbrace(RR^+ without {0}, "Definitionsmenge") &&-> underbrace(RR^+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
  )
$

== Nullstellenform

Quadratisch
- $f(x) = a^2 x + b x + c$
- $f(x) = a(x - x_0)(x - x_1)$
Qubisch
- $f(x) = a^3 x + b^2 x + c x + d$
- $f(x) = a(x - x_0)(x - x_1)(x - x_2)$

== Scheitelform

$f(x) = a(x-x_0)^2 + y_0$ -> $x_0$ und $y_0$ sind der scheitelpunkt

== Verknüpfung von Funktionen

$ g(A)=B,f(B)=C <=> f(g(A))=C <=> (f compose g)(A) = C $
$ f(g(x)) := (f compose g)(x) $
Fast immer ist $(f compose g)(x) != (g compose f)(x)$. Es gibt ein Fall, wo $(f compose g)(x) = (g compose f)(x)$ gilt, nämlich bei Umkehrfunktionen. $(f^(-1) compose f)(x) = (f compose f^(-1))(x)$

=== Beispiel

$
  & g(x) = x^2 + 1 \
  & f(x) = sqrt(x) \
  & f(g(4)) = sqrt(4^2+1) = sqrt(17) \
  & g(f(4)) = sqrt(4)^2 + 1 = 5 \
$

= Logarithmen

#let xs = lq.linspace(0.1, 10)
#align(center, lq.diagram(
  title: $f(x) = ln (x)$,
  lq.plot(xs, xs.map(calc.ln), mark: none),
))

#table(
  columns: (auto, 1fr, auto, 1fr),
  table.header([Term], [Lösung], [Term], [Lösung]),
  [$a^(log_a (x))$], [$x$], [$log_a (1)$], [$0 "weil a hoch was ist 1"$],
  [$log_a (a)$], [$1$], [$log_a (x/y)$], [$log_a (x) - log_a (y)$],
  [$log_a (x*y)$],
  [$log_a (x) + log_a (y)$],
  [$log_a (x^p)$],
  [$log_a (|x|) * p, p % 2 = 0$],

  [$log_a (root(n, x))$],
  [$log_a (x^(1/n)) = 1/n log_a (x)$],
  [$ln$],
  [$log_e$],
)

= Splines

Spline 1. Grades = lineare Splines n-te Splines = Splines aus Polynomen maximal
n-ten Grades

== Lineare interpolation

$ P_i(x) = y_i + ((y_(i+1) - y_i)/(x_(i+1) - x_i))(x-x_i) $

== Quadratische interpolation

$ P_i(x) = a_i x^2 + b_i x + c_i $

= misc

== Ungleichungen

Wenn man mit negativen Termen multipliziert oder eine fallende Funktion
anwendet, muss das Ungleichzeichen geändert werden.

== Mitternachtsformel

$ a n^2 + b n + c = 0 => u_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/(2a) $

= Trigonometrie

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [x], [0], [$30=pi/6$], [$45 = pi/4$], [$60=pi/3$], [$90 = pi/2$],
  [$sin(x)$], [0], [0.5], [$sqrt(2)/2$], [$sqrt(3)/2$], [1],
  [$cos(x)$], [1], [$sqrt(3)/2$], [$sqrt(2)/2$], [0.5], [0],
)

$tan(x) = sin(x)/cos(x)$ \

Trigonometrischer Satz des Pythagoras: $sin^2(x) + cos^2(x) = 1$

== Umkehrfunktionen

$
  &arccos: cases([-1;1]&&->[0;pi], x&&|->"Lösung" y in [0;pi] "der Gleichung" cos(y)=x) \
  &arcsin: cases([-1;1]&&->[-pi/2;pi/2], x&&|->"Lösung" y in [-pi/2;pi/2] "der Gleichung" sin(y)=x) \
  &arctan: cases(RR&&->(-pi/2;pi/2), x&&|->"Lösung" y in (-pi/2;pi/2) "der Gleichung" tan(y)=x)
$

= Ableitungen

#table(
  columns: (auto, 1fr),
  [Ableitung], [Bedeutung],
  $f′$, [Steigung],
  $f′(x)>0$, [Funktion steigt],
  $f′(x)<0$, [Funktion fällt],
  $f′′$, [Form der Parabel],
  $f′′(x)>0$, [Nach oben geöffnet],
  $f′(x)=0 and f′′(x)>0$, [Lokales Minimum],
  $f′′(x)<0$, [nach unten geöffnet],
  $f′(x)=0 and f′′(x)<0$, [Lokales Maximum],
  $f′(x)=0 and f''(x) = 0 and f'''(x) != 0$, [Lokaler Sattelpunkt],
  $f′′′$, [Änderung der Form / Wendepunkt-Richtung bei $f′′(x)=0$],
  $f′′(x)=0 and f′′′(x)≠0$, [Wendepunkt],
  $f′′(x)=0 and f′′′(x)>0$, [Krümmung ändert sich von oben nach unten],
  $f′′(x)=0 and f′′′(x)<0$, [Krümmung ändert sich von unten nach oben],
)

#deftbl(
  [Differenzenquotient],
  [$(f(x) - f(x_0))/(x - x_0) = (Delta s)/(Delta t)$],
  [Differentialquotient],
  [$lim(x -> x_0) (f(x) - f(x_0))/(x - x_0)$],
)

== Ableitungsregeln

#table(
  columns: (auto, 1fr, auto, 1fr),
  table.header([Term], [Ableitung], [Term], [Ableitung]),
  [$1$], [$0$], [$x$], [$1$],
  [$x^2$], [$2x$], [$x^n$], [$n x^(n-1)$],
  [$1/x$], [$-1/x^2$], [$sqrt(x)$], [$1/(2 sqrt(x))$],
  [$e^x$], [$e^x$], [$e^(-x)$], [$-e^(-x)$],
  [$a^x$], [$ln(a) dot a^x "für" a > 0, a != 1$], [$ln(x)$], [$1/x "für" x>0$],
  [$ln(y dot x)$], [$1/x "für" x>0$], [$log_b (x)$], [$1/(ln(b) dot x)$],
  [$sin(x)$], [$cos(x)$], [$sin(2x)$], [$2cos(x)$],
  [$cos(x)$], [$-sin(x)$], [$cos(a x)$], [$-a sin(x)$],
  [$tan(x)$], [$1+tan^2(x) = 1/(cos^2(x))$], [$arcsin(x)$], [$1/sqrt(1-x^2)$],
  [$arccos(x)$], [$- 1/sqrt(1-x^2)$], [$arctan(x)$], [$1/(1+x^2)$],
)

== Funktionen

#deftbl(
  [Addition],
  [
    $ (f(x) + g(x))' = f'(x) + g'(x) $
    $ (alpha + f(x))' = alpha dot f'(x) $
  ],
  [Produkteregel],
  [
    $ (f dot g)' = f' dot g + f dot g' $
  ],
  [Mit 3],
  [
    $ (f dot g dot h)' = f' dot g dot h + f dot g' dot h + f dot g dot h' $
  ],
  [Kettenregel],
  [
    $ (f (g (x)))' = f'(g(x)) dot g'(x) $
  ],
  [Quotientenregel],
  [
    $ (f/g)' = (f' g-f g')/g^2 $
  ],
)

== Tangente berechnen

$ m (x - x_0) + y_0 = f'(x_0) (x - x_0) + f(x_0) $

== Approximation durch Linearisierung (Newtonverfahren)

```python
for i in range(1,max_iter):
  x_neu = x_alt - f(x_alt) / f_prime(x_alt)
  x_alt = x_neu
```
