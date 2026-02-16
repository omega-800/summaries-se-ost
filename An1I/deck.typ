#import "./ankiconf.typ": *
#import "../lib.typ": *

#show: doc => conf(doc)

#card(
  id: "2001",
  target-deck: "An1I",
  q: [Definitionsmenge],
  a: [ Mögliche Funktionsinputs \ Notation definitionsmenge der Funktion $f$: $D_f$ ],
)
#card(
  id: "2002",
  target-deck: "An1I",
  q: [Zielmenge],
  a: [ Mögliche Funktionswerte ],
)
#card(
  id: "2003",
  target-deck: "An1I",
  q: [Definitionsbereich],
  a: [ Alle Funktionsinputs ],
)
#card(
  id: "2004",
  target-deck: "An1I",
  q: [Wertebereich],
  a: [ Alle Funktionswerte ],
)
#card(
  id: "2005",
  target-deck: "An1I",
  q: [Nullstelle einer Funktion],
  a: [ Argument, welches den Funktionswert $0$ hat ],
)
#card(
  id: "2006",
  target-deck: "An1I",
  q: [Bild einer Funktion],
  a: [ Alle möglichen Funktionswerte einer Funktion ],
)
#card(
  id: "2007",
  target-deck: "An1I",
  q: [Graph],
  a: [ Menge aller Punkte (Tupel) einer Funktion in der Form (Argument, Funktionswert) \ $"Graph"_f = (x,y) | y = f(x)$ ],
)
#card(
  id: "2008",
  target-deck: "An1I",
  q: [Polynom],
  a: [ $P(x) = a_n x^n + a_(n-1) x^(n-1) + ... + a_1 x + a_0$ \ Koeffizienten: $a_n,...,a_0$ \ Grad des Polynoms: $n$ ],
)

// TODO:
// #card(id: "2009", target-deck: "An1I", q:   [Streng wachsende Funktion],a: [Monoton wachsende Funktion])
// #card(id: "2010", target-deck: "An1I", q:   [ $x < accent(x, ~) -> f(x) <= f(accent(x, ~))$ \ Bsp: $ f(x) = cases(x","&x<=1, 1","&1<x<=2, (x-2)^2+1", "&x>2) $ ],a: [Streng fallende Funktion])
// #card(id: "2011", target-deck: "An1I", q:   [ $x < accent(x, ~) -> f(x) > f(accent(x, ~))$ ],a: [Monoton fallende Funktion])
// #card(id: "2012", target-deck: "An1I", q:   [ $x < accent(x, ~) -> f(x) >= f(accent(x, ~))$ ],a: [Umkehrfunktion])
// #card(id: "2013", target-deck: "An1I", q:   [ $f(x) = y <=> f^(-1) (y) = x$ ],a: [Stetige Funktion])
// #card(id: "2014", target-deck: "An1I", q:   [Funktion, deren Graph keine Sprünge oder Unterbrechungen aufweist],a: [Stetig fortsetzbare Funktion])

#card(
  id: "2015",
  target-deck: "An1I",
  q: [Funktion, die an einem bestimmten Punkt nicht definiert ist, aber erweitert werden kann, sodass die erweiterte Funktion stetig bleibt],
  a: [Glatte Funktion],
)

#card(
  id: "2016",
  target-deck: "An1I",
  q: [Funktion, die unendlich oft differenzierbar ist],
  a: [
    $x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
    Bsp:
    - $f(x) = x + 2$
    - $f(x) = e^x$
    - $f(x) = a^x, e > 1$
  ],
)
#card(id: "2017", target-deck: "An1I", q: [Gerade Funktion], a: [
  $forall x in D_f: f(-x) = f(x)$ \
  Bsp:
  - $f(x) = x^n, n "gerade"$
  - $f(x) = |x|$
  - $f(x) = cos(x)$
])
#card(id: "2018", target-deck: "An1I", q: [Ungerade Funktion], a: [
  $forall x in D_f: f(-x) = -f(x)$ \
  Bsp:
  - $f(x) = x^n, n "ungerade"$
  - $f(x) = sin(x)$
])
#card(id: "2019", target-deck: "An1I", q: [Periodische Funktion], a: [
  $forall x in D_f: f(x+p) = f(x)$ \
  - Mit der Periode $p$
  - Die kleinste positive Periode heisst _primitive Periode_
])

#card(
  id: "2020",
  target-deck: "An1I",
  q: [Anatomie einer Funktion],
  a: $
    underbrace(f, "Funktionsname") : cases(
      underbrace(RR+ without {0}, "Definitionsmenge") &&-> underbrace(RR+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
    )
  $,
)

#card(id: "2021", target-deck: "An1I", q: [Nullstellenform Quadratisch], a: [
  - $f(x) = a^2 x + b x + c$
  - $f(x) = a(x - x_0)(x - x_1)$
])
#card(id: "2023", target-deck: "An1I", q: [Nullstellenform Qubisch], [
  - $f(x) = a^3 x + b^2 x + c x + d$
  - $f(x) = a(x - x_0)(x - x_1)(x - x_2)$
])

#card(
  id: "2024",
  target-deck: "An1I",
  q: [ Scheitelform],
  a: [$f(x) = a(x-x_0)^2 + y_0$ -> $x_0$ und $y_0$ sind der scheitelpunkt],
)

#card(id: "2025", target-deck: "An1I", q: [ Verknüpfung von Funktionen], [
  $ g(A)=B,f(B)=C <=> f(g(A))=C <=> (f compose g)(A) = C $
  $ f(g(x)) := (f compose g)(x) $
  Fast immer ist $(f compose g)(x) != (g compose f)(x)$. Es gibt ein Fall, wo $(f compose g)(x) = (g compose f)(x)$ gilt, nämlich bei Umkehrfunktionen. $(f^(-1) compose f)(x) = (f compose f^(-1))(x)$ \
  Beispiel \
  $
    & g(x) = x^2 + 1 \
    & f(x) = sqrt(x) \
    & f(g(4)) = sqrt(4^2+1) = sqrt(17) \
    & g(f(4)) = sqrt(4)^2 + 1 = 5 \
  $
])

#card(id: "2026", target-deck: "An1I", q: [$a^(log_a (x))$], a: [$x$])
#card(
  id: "2027",
  target-deck: "An1I",
  q: [$log_a (1)$],
  a: [$0 "weil a hoch was ist 1"$],
)
#card(id: "2028", target-deck: "An1I", q: [$log_a (a)$], a: [$1$])
#card(
  id: "2029",
  target-deck: "An1I",
  q: [$log_a (x/y)$],
  a: [$log_a (x) - log_a (y)$],
)
#card(
  id: "2030",
  target-deck: "An1I",
  q: [$log_a (x*y)$],
  a: [$log_a (x) + log_a (y)$],
)
#card(
  id: "2031",
  target-deck: "An1I",
  q: [$log_a (x^p)$],
  [$log_a (|x|) * p,a: p % 2 = 0$],
)
#card(
  id: "2032",
  target-deck: "An1I",
  q: [$log_a (root(n, x))$],
  a: [$log_a (x^(1/n)) = 1/n log_a (x)$],
)
#card(
  id: "2033",
  target-deck: "An1I",
  q: [$(log_a (b^y))/(log_a (b))$],
  a: [$(y log_a (b))/(log_a (b))$],
)
#card(
  id: "2034",
  target-deck: "An1I",
  q: [$log_a(x)$],
  a: [$-2 <=> a^(-2) = x$],
)

#card(id: "2035", target-deck: "An1I", q: [Splines], [
  Spline 1. Grades = lineare Splines \
  n-te Splines = Splines aus Polynomen maximal n-ten Grades
])

#card(
  id: "2036",
  target-deck: "An1I",
  q: [Lineare interpolation],
  a: $ P_i(x) = y_i + ((y_(i+1) - y_i)/(x_(i+1) - x_i))(x-x_i) $,
)

#card(
  id: "2037",
  target-deck: "An1I",
  q: [Quadratische interpolation],
  a: $ P_i(x) = a_i x^2 + b_i x + c_i $,
)

#card(id: "2038", target-deck: "An1I", q: [Ungleichungen], [
  Wenn man mit negativen Termen multipliziert oder eine fallende Funktion
  anwendet, muss das Ungleichzeichen geändert werden.
])

#card(
  id: "2039",
  target-deck: "An1I",
  q: [Mitternachtsformel],
  a: $ a n^2 + b n + c = 0 => u_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/(2a) $,
)

// TODO:
// #card(id: "2040", target-deck: "An1I", q:   [x],a: [0])
// #card(id: "2041", target-deck: "An1I", q: [$30=pi/6$],a: [$45 = pi/4$])
// #card(id: "2042", target-deck: "An1I", q: [$60=pi/3$],a: [$90 = pi/2$])
// #card(id: "2043", target-deck: "An1I", q:   [$sin(x)$],a: [0])
// #card(id: "2044", target-deck: "An1I", q: [0.5],a: [$sqrt(2)/2$])
// #card(id: "2045", target-deck: "An1I", q: [$sqrt(3)/2$],a: [1])
// #card(id: "2046", target-deck: "An1I", q:   [$cos(x)$],a: [1])
// #card(id: "2047", target-deck: "An1I", q: [$sqrt(3)/2$],a: [$sqrt(2)/2$])
// #card(id: "2048", target-deck: "An1I", q: [0.5],a: [0])

#card(id: "2049", target-deck: "An1I", q: $tan(x)$, a: $sin(x)/cos(x)$)
#card(
  id: "2050",
  target-deck: "An1I",
  q: [Trigonometrischer Satz des Pythagoras],
  a: $sin^2(x) + cos^2(x) = 1$,
)

#card(
  id: "2051",
  target-deck: "An1I",
  q: [Umkehrfunktionen],
  a: $
    &arccos: cases([-1;1]&&->[0;pi], x&&|->"Lösung" y in [0;pi] "der Gleichung" cos(y)=x) \
    &arcsin: cases([-1;1]&&->[-pi/2;pi/2], x&&|->"Lösung" y in [-pi/2;pi/2] "der Gleichung" sin(y)=x) \
    &arctan: cases(RR&&->(-pi/2;pi/2), x&&|->"Lösung" y in (-pi/2;pi/2) "der Gleichung" tan(y)=x)
  $,
)

#card(
  id: "2052",
  target-deck: "An1I",
  q: [Differenzenquotient],
  a: [$m = (f(x) - f(x_0))/(x - x_0) = (Delta s)/(Delta t)$],
)
#card(
  id: "2053",
  target-deck: "An1I",
  q: [Differentialquotient],
  a: [$m = lim(x -> x_0) (f(x) - f(x_0))/(x - x_0)$],
)

#card(
  id: "2054",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) 1$],
  [$0$],
  a: [$(dif x)/(dif y) x$],
  [$1$],
)
#card(
  id: "2055",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) x^2$],
  [$2x$],
  a: [$(dif x)/(dif y) x^n$],
  [$n x^(n-1)$],
)
#card(
  id: "2056",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) 1/x$],
  [$-1/x^2$],
  a: [$(dif x)/(dif y) sqrt(x)$],
  [$1/(2 sqrt(x))$],
)
#card(
  id: "2057",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) e^x$],
  [$e^x$],
  a: [$(dif x)/(dif y) e^(-x)$],
  [$-e^(-x)$],
)
#card(
  id: "2058",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) a^x$],
  [$ln(a) dot a^x "für" a > 0, a != 1$],
  a: [$(dif x)/(dif y) ln(x)$],
  [$1/x "für" x>0$],
)
#card(
  id: "2059",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) ln(y dot x)$],
  [$1/x "für" x>0$],
  a: [$(dif x)/(dif y) log_b (x)$],
  [$1/(ln(b) dot x)$],
)
#card(
  id: "2060",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) sin(x)$],
  [$cos(x)$],
  a: [$(dif x)/(dif y) cos(x)$],
  [$-sin(x)$],
)
#card(
  id: "2061",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) tan(x)$],
  [$1+tan^2(x) = 1/(cos^2(x))$],
  a: [$(dif x)/(dif y) arcsin(x)$],
  [$1/sqrt(1-x^2)$],
)
#card(
  id: "2062",
  target-deck: "An1I",
  q: [$(dif x)/(dif y) arccos(x)$],
  [$- 1/sqrt(1-x^2)$],
  a: [$(dif x)/(dif y) arctan(x)$],
  [$1/(1+x^2)$],
)

#card(
  id: "2063",
  target-deck: "An1I",
  q: [Funktionen ableiten: Addition],
  a: [ $ (f(x) + g(x))' = f'(x) + g'(x) $ $
      (alpha + f(x))' = alpha dot f'(x)
    $ ],
)
#card(
  id: "2064",
  target-deck: "An1I",
  q: [Funktionen ableiten: Produkteregel],
  a: [ $ (f dot g)' = f' dot g + f dot g' $ ],
)
#card(
  id: "2065",
  target-deck: "An1I",
  q: [Funktionen ableiten: Produkteregel Mit 3],
  a: [ $
    (f dot g dot h)' = f' dot g dot h + f dot g' dot h + f dot g dot h'
  $ ],
)
#card(
  id: "2066",
  target-deck: "An1I",
  q: [Funktionen ableiten: Kettenregel],
  a: [ $ (f (g (x)))' = f'(g(x)) dot g'(x) $ ],
)
#card(
  id: "2067",
  target-deck: "An1I",
  q: [Funktionen ableiten: Quotientenregel],
  a: [ $ (f/g)' = (f' g-f g')/g^2 $ ],
)

#card(
  id: "2068",
  target-deck: "An1I",
  q: [Tangente berechnen],
  $ m (x - x_0) + y_0 = f'(x_0) (x - x_0) + f(x_0) $,
)

#card(
  id: "2069",
  target-deck: "An1I",
  q: [Approximation durch Linearisierung (Newtonverfahren)],
  a: ```python
  for i in range(1,max_iter):
    x_neu = x_alt - f(x_alt) / f_prime(x_alt)
    x_alt = x_neu
  ```,
)

#card(
  id: "2070",
  target-deck: "An1I",
  q: [Lokales Minimum],
  a: [$(f'(x_0) = 0) and (f''(x_0) > 0)$],
)
#card(
  id: "2071",
  target-deck: "An1I",
  q: [Lokales Maximum],
  a: [$(f'(x_0) = 0) and (f''(x_0) < 0)$],
)
#card(
  id: "2072",
  target-deck: "An1I",
  q: [Lokaler Sattelpunkt],
  a: [$(f'(x_0) = 0) and (f''(x_0) = 0) and (f'''(x_0) != 0)$],
)
#card(
  id: "2073",
  target-deck: "An1I",
  q: [Wendepunkt],
  a: [$f''(x_0) = 0 and f(x_0)''' != 0$],
)
