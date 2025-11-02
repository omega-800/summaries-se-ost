#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "An1I",
  name: "Analysis für Informatiker",
  semester: "HS25",
)
#let tbl =(..body)=> deftbl(lang,..body)


= Funktionen

== Glossar

#tbl(
  [Definitionsbereich], [
  - 
  ], [Definitionsmenge], [
  - Notation definitionsmenge der Funktion $f$: $D_f$
  ], [Zielmenge], [
  - Mögliche Funktionswerte
  ], [Nullstelle einer Funktion], [
  - Argument, welches den Funktionswert $0$ hat
  ], [Bild einer Funktion], [
  - Alle möglichen Funktionswerte einer Funktion
  ], [Graph], [
  - Menge aller Punkte (Tupel) einer Funktion in der Form (Argument, Funktionswert)
  - $"Graph"_f = (x,y) | y = f(x)$
  ], [Implizite darstellung], [
  - 
  ], [Polynom], [
  - 
  ], [Koeffizient], [
  - 
  ], [Interpolation], [
  - 
  ], [Gerade funktion], [
  - $forall x in D_f: f(-x) = f(x)$
  ], [Ungerade funktion], [
  - $forall x in D_f: f(-x) = -f(x)$
  ], [Periodische funktion], [
  - mit der Periode $p$
  - $forall x in D_f: f(x+p) = f(x)$
  - Die kleinste positive Periode heisst _primitive Periode_
  ], [Umkehrfunktion], [
  - $f(x) = y <=> f^(-1) (y) = x$
  ]
)

== Ableitungsregeln

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

== Anatomie einer Funktion

$ f : cases(
  RR+ without {0} -> RR+,
  x |-> x+4
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

= Logarithmen

$a^(log_a (x)) = x$ \
$log_a (1) = 0$ weil a hoch was ist 1 \
$log_a (a) = 1$ \
$log_a (x/y) = log_a (x) - log_a (y)$ \
$log_a (x*y) = log_a (x) + log_a (y)$ \
$log_a (x^p) = log_a (|x|) * p, p % 2 = 0$ \
$log_a (root(n,x)) = log_a (x^(1/n)) = 1/n log_a (x) $ \
$(log_a (b^y))/(log_a (b)) = (y log_a (b))/(log_a (b))$ \
$log_a(x) = -2 <=> a^(-2) = x$

= Splines

Spline 1. Grades = lineare Splines
n-te Splines = Splines aus Polynomen maximal n-ten Grades

== Lineare interpolation

$ P_i(x) = y_i + ((y_(i+1) - y_i)/(x_(i+1) - x_i))(x-x_i) $ 

== Quadratische interpolation

$ P_i(x) = a_i x^2 + b_i x + c_i $ 

= misc

$a n^2 + b n + c = 0$ \
$u_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/2a$

== Trigonometrie

$sin^2(x) + cos^2(x) = 1$
