#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "An1I",
  name: "Analysis für Informatiker",
  semester: "HS25",
)
#let tbl = (..body) => deftbl(lang, "An1I", ..body)

= Funktionen

== Glossar

#tbl(
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
  [Implizite darstellung],
  [
    -
  ],
  [Polynom],
  [
    $P(x) = a_n x^n + a_(n-1) x^(n-1) + ... + a_1 x + a_0$ \
    Koeffizienten: $a_n,...,a_0$ \
    Grad des Polynoms: $n$
  ],
  [Streng wachsende Funktion],
  [
    $x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
    Bsp:
    - $f(x) = x + 2$
    - $f(x) = e^x$
    - $f(x) = a^x, e > 1$
  ],
  [Monoton wachsende Funktion],
  [
    $x < accent(x, ~) -> f(x) <= f(accent(x, ~))$ \
    Bsp: $ f(x) = cases(x","&x<=1, 1","&1<x<=2, (x-2)^2+1", "&x>2) $
  ],
  [Streng fallende Funktion],
  [
    $x < accent(x, ~) -> f(x) > f(accent(x, ~))$
  ],
  [Monoton fallende Funktion],
  [
    $x < accent(x, ~) -> f(x) >= f(accent(x, ~))$
  ],
  [Gerade Funktion],
  [
    $forall x in D_f: f(-x) = f(x)$ \
    Bsp:
    - $f(x) = x^n, n "gerade"$
    - $f(x) = |x|$
    - $f(x) = cos(x)$
  ],
  [Ungerade Funktion],
  [
    $forall x in D_f: f(-x) = -f(x)$ \
    Bsp:
    - $f(x) = x^n, n "ungerade"$
    - $f(x) = sin(x)$
  ],
  [Periodische Funktion],
  [
    $forall x in D_f: f(x+p) = f(x)$ \
    - Mit der Periode $p$
    - Die kleinste positive Periode heisst _primitive Periode_
  ],
  [Umkehrfunktion],
  [
    $f(x) = y <=> f^(-1) (y) = x$
  ],
  [Stetige Funktion],
  [Funktion, deren Graph keine Sprünge oder Unterbrechungen aufweist],
  [Stetig fortsetzbare Funktion],
  [Funktion, die an einem bestimmten Punkt nicht definiert ist, aber erweitert werden kann, sodass die erweiterte Funktion stetig bleibt],
  [Glatte Funktion],
  [Funktion, die unendlich oft differenzierbar ist],
)

== Anatomie einer Funktion

$
  underbrace(f, "Funktionsname") : cases(
    underbrace(RR+ without {0}, "Definitionsmenge") &&-> underbrace(RR+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
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


#table(
  columns: (auto, 1fr),
  table.header([Term], [Lösung]),
  [$a^(log_a (x)) $], [$x $],
  [$log_a (1) $], [$0 "weil a hoch was ist 1" $],
  [$log_a (a) $], [$1 $],
  [$log_a (x/y) $], [$log_a (x) - log_a (y) $],
  [$log_a (x*y) $], [$log_a (x) + log_a (y) $],
  [$log_a (x^p) $], [$log_a (|x|) * p, p % 2 = 0 $],
  [$log_a (root(n, x)) $], [$log_a (x^(1/n)) = 1/n log_a (x) $],
  [$(log_a (b^y))/(log_a (b)) $], [$(y log_a (b))/(log_a (b)) $],
  [$log_a(x) $], [$-2 <=> a^(-2) = x $],
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

#tbl(
  [Differenzenquotient],
  [$m = (f(x) - f(x_0))/(x - x_0) = (Delta s)/(Delta t)$],
  [Differentialquotient],
  [$m = lim(x -> x_0) (f(x) - f(x_0))/(x - x_0)$],
)

== Ableitungsregeln

#table(
  columns: (auto, 1fr, auto, 1fr),
  table.header([Term], [Ableitung], [Term], [Ableitung]),
  [$1$], [$0$],
  [$x$], [$1$],
  [$x^2$], [$2x$],
  [$x^n$], [$n x^(n-1)$],
  [$1/x$], [$-1/x^2$],
  [$sqrt(x)$], [$1/(2 sqrt(x))$],
  [$e^x$], [$e^x$],
  [$e^(-x)$], [$-e^(-x)$],
  [$a^x$], [$ln(a) dot a^x "für" a > 0, a != 1$],
  [$ln(x)$], [$1/x "für" x>0$],
  [$ln(y dot x)$], [$1/x "für" x>0$],
  [$log_b (x)$], [$1/(ln(b) dot x)$],
  [$sin(x)$], [$cos(x)$],
  [$cos(x)$], [$-sin(x)$],
  [$tan(x)$], [$1+tan^2(x) = 1/(cos^2(x))$],
  [$arcsin(x)$], [$1/sqrt(1-x^2)$],
  [$arccos(x)$], [$- 1/sqrt(1-x^2)$],
  [$arctan(x)$], [$1/(1+x^2)$],
)

== Funktionen

#tbl(
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

== Extremwerte

Falls die Ableitung von $f$ in $x = x_0$ verschwindet, kann folgendes passieren:

#tbl(
  [Lokales Minimum],
  [$(f'(x_0) = 0) and (f''(x_0) > 0)$],
  [Lokales Maximum],
  [$(f'(x_0) = 0) and (f''(x_0) < 0)$],
  [Lokaler Sattelpunkt],
  [$(f'(x_0) = 0) and (f''(x_0) = 0) and (f'''(x_0) != 0)$],
  [Wendepunkt],
  [$f''(x_0) = 0 and f(x_0)''' != 0$],
)
