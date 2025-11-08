#import "../lib.typ": *
#let lang = "de"
#show: project.with(module: "An1I", name: "Analysis für Informatiker", semester: "HS25")
#let tbl = (..body)=> deftbl(lang, ..body)

= Funktionen

== Glossar

#tbl(
  [Definitionsmenge], [
    Mögliche Funktionsinputs \
    Notation definitionsmenge der Funktion $f$: $D_f$
  ], [Zielmenge], [
    Mögliche Funktionswerte
  ], [Definitionsbereich], [
    Alle Funktionsinputs
  ], [Wertebereich], [
    Alle Funktionswerte
  ], [Nullstelle einer Funktion], [
    Argument, welches den Funktionswert $0$ hat
  ], [Bild einer Funktion], [
    Alle möglichen Funktionswerte einer Funktion
  ], [Graph], [
    Menge aller Punkte (Tupel) einer Funktion in der Form (Argument, Funktionswert) \
    $"Graph"_f = (x,y) | y = f(x)$
  ], [Implizite darstellung], [
    -
  ], [Polynom], [
    -
  ], [Koeffizient], [
    -
  ], [Interpolation], [
    -
  ], [Streng wachsende Funktion], [
    $x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
    Bsp:
    - $f(x) = x + 2$ 
    - $f(x) = e^x$ 
    - $f(x) = a^x, e > 1$ 
  ], [Wachsende Funktion], [
    $x < accent(x, ~) -> f(x) <= f(accent(x, ~))$ \
    Bsp: $ f(x) = cases(x","&x<=1, 1","&1<x<=2, (x-2)^2+1", "&x>2) $
  ], [Streng fallende Funktion], [
    $x < accent(x, ~) -> f(x) > f(accent(x, ~))$
  ], [Fallende Funktion], [
    $x < accent(x, ~) -> f(x) >= f(accent(x, ~))$
  ], [Gerade funktion], [
    $forall x in D_f: f(-x) = f(x)$ \
    Bsp:
    - $f(x) = x^n, n "gerade"$ 
    - $f(x) = |x|$ 
    - $f(x) = cos(x)$ 
  ], [Ungerade funktion], [
    $forall x in D_f: f(-x) = -f(x)$ \
    Bsp:
    - $f(x) = x^n, n "ungerade"$ 
    - $f(x) = sin(x)$ 
  ], [Periodische funktion], [
    $forall x in D_f: f(x+p) = f(x)$ \
    - Mit der Periode $p$
    - Die kleinste positive Periode heisst _primitive Periode_
  ], [Umkehrfunktion], [
    $f(x) = y <=> f^(-1) (y) = x$
  ],
)

== Anatomie einer Funktion

$ underbrace(f, "Funktionsname") : cases(
  underbrace(RR+ without {0}, "Definitionsmenge") &&-> underbrace(RR+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
) $

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

$ A-g(x)->B-f(y)->C <=> A-f(g(x))->C $ 
$ f(g(x)) := (f compose g)(x) $ 
Fast immer ist $(f compose g)(x) != (g compose f)(x)$. Es gibt ein Fall, wo $(f compose g)(x) = (g compose f)(x)$ gilt, nämlich bei Umkehrfunktionen. $(f^(-1) compose f)(x) = (f compose f^(-1))(x)$

=== Beispiel

$
    &g(x) = x^2 + 1 \
    &f(x) = sqrt(x) \
    &f(g(4)) = sqrt(4^2+1) = sqrt(17) \
    &g(f(4)) = sqrt(4)^2 + 1 = 5 \
$

= Logarithmen

$a^(log_a (x)) = x$ \
$log_a (1) = 0$ weil a hoch was ist 1\
$log_a (a) = 1$ \
$log_a (x/y) = log_a (x) - log_a (y)$ \
$log_a (x*y) = log_a (x) + log_a (y)$ \
$log_a (x^p) = log_a (|x|) * p, p % 2 = 0$ \
$log_a (root(n, x)) = log_a (x^(1/n)) = 1/n log_a (x) $ \
$(log_a (b^y))/(log_a (b)) = (y log_a (b))/(log_a (b))$ \
$log_a(x) = -2 <=> a^(-2) = x$

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

#table(columns:(auto,auto,auto,auto,auto,auto),
  [x],       [0],[$30=pi/6$],[$45 = pi/4$], [$60=pi/3$],[$90  = pi/2$],
  [$sin(x)$],[0],[0.5],[$sqrt(2)/2$],[$sqrt(3)/2$],[1],
  [$cos(x)$],[1],[$sqrt(3)/2$],[$sqrt(2)/2$],[0.5],[0],
)

$tan(x) = sin(x)/cos(x)$ \
Trigonometrischer Satz des Pythagoras: $sin^2(x) + cos^2(x) = 1$

== Umkehrfunktionen 

$ &arccos: cases([-1;1]&&->[0;pi],x&&|->"Lösung" y in [0;pi] "der Gleichung" cos(y)=x) \
 &arcsin: cases([-1;1]&&->[-pi/2;pi/2],x&&|->"Lösung" y in [-pi/2;pi/2] "der Gleichung" sin(y)=x) \
 &arctan: cases(RR&&->(-pi/2;pi/2),x&&|->"Lösung" y in (-pi/2;pi/2) "der Gleichung" tan(y)=x) $

= Ableitungsregeln

#table(
  columns: (auto,1fr),
  table.header([Funktion], [Ableitungsfunktion]),
  [$x |-> 1$],[$x |-> 0$],
  [$"id" := x |-> x$],[$x |-> 1$],
  [$"sqr" := x |-> x^2$],[$x |-> 2x$],
  [$"rez" := x |-> 1/x$],[$x |-> -(1/x^2)$],
  [$"sqrt" := x |-> sqrt(x)$],[$x |-> 1/(2 sqrt(x))$],
  [$x |-> x^n$],[$x |-> n x^(n-1)$],
  [$x |-> e^x$],[$x |-> e^x$],
  [$x |-> e^(-x)$],[$x |-> -e^(-x)$],
  [$x |-> a^x$],[$x |-> ln(a) a^x$],
  [$ln$],[$x |-> 1/x "für" x>0$],
  [$log_b (x)$],[$1/(ln(b) x)$],
  [$sin$],[$cos$],
  [$cos$],[$-sin$],
  [$tan$],[$1+tan^2 = 1/(cos^2)$],
  [$arcsin$],[$1/sqrt(1-x^2)$],
  [$arccos$],[$- 1/sqrt(1-x^2)$],
  [$arctan$],[$1/(1+x^2)$],
)
