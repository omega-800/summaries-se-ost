#import "@local/tanki:0.0.1": add-deck, add-note
#import "../lib.typ": *

#let did = 69422
#add-deck(did, "An1I", "Analysis für Informatik")
#let new-note = add-note.with(deck: did)

#card(
  id: "2001",

  (
    [Definitionsmenge],
    [ Mögliche Funktionsinputs \ Notation definitionsmenge der Funktion $f$: $D_f$ ],
  ),
)
#card(
  id: "2002",

  ([Zielmenge], [ Mögliche Funktionswerte ]),
)
#card(
  id: "2003",

  ([Definitionsbereich], [ Alle Funktionsinputs ]),
)
#card(
  id: "2004",

  ([Wertebereich], [ Alle Funktionswerte ]),
)
#card(
  id: "2005",

  (
    [Nullstelle einer Funktion],
    [ Argument, welches den Funktionswert $0$ hat ],
  ),
)
#card(
  id: "2006",

  ([Bild einer Funktion], [ Alle möglichen Funktionswerte einer Funktion ]),
)
#card(
  id: "2007",

  (
    [Graph],
    [ Menge aller Punkte (Tupel) einer Funktion in der Form (Argument, Funktionswert) \ $"Graph"_f = (x,y) | y = f(x)$ ],
  ),
)
#card(
  id: "2008",

  (
    [Polynom],
    [ $P(x) = a_n x^n + a_(n-1) x^(n-1) + ... + a_1 x + a_0$ \ Koeffizienten: $a_n,...,a_0$ \ Grad des Polynoms: $n$ ],
  ),
)

// TODO:
// #card(id: "2009",  (  [Streng wachsende Funktion],[Monoton wachsende Funktion]))
// #card(id: "2010",  (  [ $x < accent(x, ~) -> f(x) <= f(accent(x, ~))$ \ Bsp: $ f(x) = cases(x","&x<=1, 1","&1<x<=2, (x-2)^2+1", "&x>2) $ ],[Streng fallende Funktion]))
// #card(id: "2011",  (  [ $x < accent(x, ~) -> f(x) > f(accent(x, ~))$ ],[Monoton fallende Funktion]))
// #card(id: "2012",  (  [ $x < accent(x, ~) -> f(x) >= f(accent(x, ~))$ ],[Umkehrfunktion]))
// #card(id: "2013",  (  [ $f(x) = y <=> f^(-1) (y) = x$ ],[Stetige Funktion]))
// #card(id: "2014",  (  [Funktion, deren Graph keine Sprünge oder Unterbrechungen aufweist],[Stetig fortsetzbare Funktion]))

#card(
  id: "2015",

  (
    [Funktion, die an einem bestimmten Punkt nicht definiert ist, aber erweitert werden kann, sodass die erweiterte Funktion stetig bleibt],
    [Glatte Funktion],
  ),
)

#card(
  id: "2016",

  (
    [Funktion, die unendlich oft differenzierbar ist],
    [
      $x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
      Bsp:
      - $f(x) = x + 2$
      - $f(x) = e^x$
      - $f(x) = a^x, e > 1$
    ],
  ),
)
#card(id: "2017", (
  [Gerade Funktion],
  [
    $forall x in D_f: f(-x) = f(x)$ \
    Bsp:
    - $f(x) = x^n, n "gerade"$
    - $f(x) = |x|$
    - $f(x) = cos(x)$
  ],
))
#card(id: "2018", (
  [Ungerade Funktion],
  [
    $forall x in D_f: f(-x) = -f(x)$ \
    Bsp:
    - $f(x) = x^n, n "ungerade"$
    - $f(x) = sin(x)$
  ],
))
#card(id: "2019", (
  [Periodische Funktion],
  [
    $forall x in D_f: f(x+p) = f(x)$ \
    - Mit der Periode $p$
    - Die kleinste positive Periode heisst _primitive Periode_
  ],
))

#card(
  id: "2020",

  (
    [Anatomie einer Funktion],
    $
      underbrace(f, "Funktionsname") : cases(
        underbrace(RR+ without {0}, "Definitionsmenge") &&-> underbrace(RR+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
      )
    $,
  ),
)

#card(id: "2021", (
  [Nullstellenform Quadratisch],
  [
    - $f(x) = a^2 x + b x + c$
    - $f(x) = a(x - x_0)(x - x_1)$
  ],
))
#card(id: "2023", (
  [Nullstellenform Qubisch],
  [
    - $f(x) = a^3 x + b^2 x + c x + d$
    - $f(x) = a(x - x_0)(x - x_1)(x - x_2)$
  ],
))

#card(
  id: "2024",

  (
    [ Scheitelform],
    [$f(x) = a(x-x_0)^2 + y_0$ -> $x_0$ und $y_0$ sind der scheitelpunkt],
  ),
)

#card(id: "2025", (
  [ Verknüpfung von Funktionen],
  [
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
  ],
))

#card(id: "2026", ([$a^(log_a (x))$], [$x$]))
#card(
  id: "2027",

  ([$log_a (1)$], [$0 "weil a hoch was ist 1"$]),
)
#card(id: "2028", ([$log_a (a)$], [$1$]))
#card(
  id: "2029",

  ([$log_a (x/y)$], [$log_a (x) - log_a (y)$]),
)
#card(
  id: "2030",

  ([$log_a (x*y)$], [$log_a (x) + log_a (y)$]),
)
#card(
  id: "2031",

  ([$log_a (x^p)$], [$log_a (|x|) * p,a: p % 2 = 0$]),
)
#card(
  id: "2032",

  ([$log_a (root(n, x))$], [$log_a (x^(1/n)) = 1/n log_a (x)$]),
)
#card(
  id: "2033",

  ([$(log_a (b^y))/(log_a (b))$], [$(y log_a (b))/(log_a (b))$]),
)
#card(
  id: "2034",

  ([$log_a(x)$], [$-2 <=> a^(-2) = x$]),
)

#card(id: "2035", (
  [Splines],
  [
    Spline 1. Grades = lineare Splines \
    n-te Splines = Splines aus Polynomen maximal n-ten Grades
  ],
))

#card(
  id: "2036",

  (
    [Lineare interpolation],
    $ P_i(x) = y_i + ((y_(i+1) - y_i)/(x_(i+1) - x_i))(x-x_i) $,
  ),
)

#card(
  id: "2037",

  ([Quadratische interpolation], $ P_i(x) = a_i x^2 + b_i x + c_i $),
)

#card(id: "2038", (
  [Ungleichungen],
  [
    Wenn man mit negativen Termen multipliziert oder eine fallende Funktion
    anwendet, muss das Ungleichzeichen geändert werden.
  ],
))

#card(
  id: "2039",

  (
    [Mitternachtsformel],
    $ a n^2 + b n + c = 0 => u_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/(2a) $,
  ),
)

// TODO:
// #card(id: "2040",  (  [x],[0]))
// #card(id: "2041",  ([$30=pi/6$],[$45 = pi/4$]))
// #card(id: "2042",  ([$60=pi/3$],[$90 = pi/2$]))
// #card(id: "2043",  (  [$sin(x)$],[0]))
// #card(id: "2044",  ([0.5],[$sqrt(2)/2$]))
// #card(id: "2045",  ([$sqrt(3)/2$],[1]))
// #card(id: "2046",  (  [$cos(x)$],[1]))
// #card(id: "2047",  ([$sqrt(3)/2$],[$sqrt(2)/2$]))
// #card(id: "2048",  ([0.5],[0]))

#card(id: "2049", ($tan(x)$, $sin(x)/cos(x)$))
#card(
  id: "2050",

  ([Trigonometrischer Satz des Pythagoras], $sin^2(x) + cos^2(x) = 1$),
)

#card(
  id: "2051",

  (
    [Umkehrfunktionen],
    $
      &arccos: cases([-1;1]&&->[0;pi], x&&|->"Lösung" y in [0;pi] "der Gleichung" cos(y)=x) \
      &arcsin: cases([-1;1]&&->[-pi/2;pi/2], x&&|->"Lösung" y in [-pi/2;pi/2] "der Gleichung" sin(y)=x) \
      &arctan: cases(RR&&->(-pi/2;pi/2), x&&|->"Lösung" y in (-pi/2;pi/2) "der Gleichung" tan(y)=x)
    $,
  ),
)

#card(
  id: "2052",

  (
    [Differenzenquotient],
    [$m = (f(x) - f(x_0))/(x - x_0) = (Delta s)/(Delta t)$],
  ),
)
#card(
  id: "2053",

  ([Differentialquotient], [$m = lim(x -> x_0) (f(x) - f(x_0))/(x - x_0)$]),
)

#card(
  id: "2054",
  ([$(dif x)/(dif y) 1$], [$0$]),
)
#card(
  id: "2074",
  ([$(dif x)/(dif y) x$], [$1$]),
)
#card(
  id: "2055",

  ([$(dif x)/(dif y) x^2$], [$2x$]),
)
#card(
  id: "2075",

  ([$(dif x)/(dif y) x^n$], [$n x^(n-1)$]),
)
#card(
  id: "2056",

  ([$(dif x)/(dif y) 1/x$], [$-1/x^2$]),
)
#card(
  id: "2076",
  ([$(dif x)/(dif y) sqrt(x)$], [$1/(2 sqrt(x))$]),
)
#card(
  id: "2057",

  ([$(dif x)/(dif y) e^x$], [$e^x$]),
)
#card(
  id: "2077",
  ([$(dif x)/(dif y) e^(-x)$], [$-e^(-x)$]),
)
#card(
  id: "2058",

  ([$(dif x)/(dif y) a^x$], [$ln(a) dot a^x "für" a > 0, a != 1$]),
)
#card(
  id: "2078",
  ([$(dif x)/(dif y) ln(x)$], [$1/x "für" x>0$]),
)
#card(
  id: "2059",

  ([$(dif x)/(dif y) ln(y dot x)$], [$1/x "für" x>0$]),
)
#card(
  id: "2079",
  ([$(dif x)/(dif y) log_b (x)$], [$1/(ln(b) dot x)$]),
)
#card(
  id: "2060",

  ([$(dif x)/(dif y) sin(x)$], [$cos(x)$]),
)
#card(
  id: "2080",
  ([$(dif x)/(dif y) cos(x)$], [$-sin(x)$]),
)
#card(
  id: "2061",

  ([$(dif x)/(dif y) tan(x)$], [$1+tan^2(x) = 1/(cos^2(x))$]),
)
#card(
  id: "2081",
  ([$(dif x)/(dif y) arcsin(x)$], [$1/sqrt(1-x^2)$]),
)
#card(
  id: "2062",

  ([$(dif x)/(dif y) arccos(x)$], [$- 1/sqrt(1-x^2)$]),
)
#card(
  id: "2082",
  ([$(dif x)/(dif y) arctan(x)$], [$1/(1+x^2)$]),
)

#card(
  id: "2063",

  (
    [Funktionen ableiten: Addition],
    [ $ (f(x) + g(x))' = f'(x) + g'(x) $ $
        (alpha + f(x))' = alpha dot f'(x)
      $ ],
  ),
)
#card(
  id: "2064",

  (
    [Funktionen ableiten: Produkteregel],
    [ $ (f dot g)' = f' dot g + f dot g' $ ],
  ),
)
#card(
  id: "2065",

  (
    [Funktionen ableiten: Produkteregel Mit 3],
    [ $
      (f dot g dot h)' = f' dot g dot h + f dot g' dot h + f dot g dot h'
    $ ],
  ),
)
#card(
  id: "2066",

  (
    [Funktionen ableiten: Kettenregel],
    [ $ (f (g (x)))' = f'(g(x)) dot g'(x) $ ],
  ),
)
#card(
  id: "2067",

  ([Funktionen ableiten: Quotientenregel], [ $ (f/g)' = (f' g-f g')/g^2 $ ]),
)

#card(
  id: "2068",

  ([Tangente berechnen], $ m (x - x_0) + y_0 = f'(x_0) (x - x_0) + f(x_0) $),
)

#card(
  id: "2069",

  (
    [Approximation durch Linearisierung (Newtonverfahren)],
    ```python
    for i in range(1,max_iter):
      x_neu = x_alt - f(x_alt) / f_prime(x_alt)
      x_alt = x_neu
    ```,
  ),
)

#card(
  id: "2070",

  ([Lokales Minimum], [$(f'(x_0) = 0) and (f''(x_0) > 0)$]),
)
#card(
  id: "2071",

  ([Lokales Maximum], [$(f'(x_0) = 0) and (f''(x_0) < 0)$]),
)
#card(
  id: "2072",

  (
    [Lokaler Sattelpunkt],
    [$(f'(x_0) = 0) and (f''(x_0) = 0) and (f'''(x_0) != 0)$],
  ),
)
#card(
  id: "2073",

  ([Wendepunkt], [$f''(x_0) = 0 and f(x_0)''' != 0$]),
)
