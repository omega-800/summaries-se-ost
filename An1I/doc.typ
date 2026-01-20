#import "../lib.typ": *
#import "@preview/lilaq:0.5.0" as lq
#show: project.with(
  module: "An1I",
  name: "Analysis für Informatiker",
  semester: "HS25",
)
// approximation
#let e = 2.718281828

= Funktionen

== Anatomie einer Funktion

$
  underbrace(f, "Funktionsname") : cases(
    underbrace(RR^+ without {0}, "Definitionsmenge") &&-> underbrace(RR^+, "Zielmenge"), underbrace(x, "Input / Argument") &&|-> underbrace(x+4, "Element des Wertebereichs (Output)"),
  )
$
Schreibweisen:
$
  & f : cases(RR^+ without {0} &&-> RR^+, x &&|-> x+4) \
  & f : RR^+ without {0} -> RR^+, x |-> x+4 \
  // &f_(RR^+ without {0} -> RR^+) (x) = x+4
$

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

#grid(
  columns: (1fr, 1fr),
  [=== Stetige Funktion

    Funktion, deren Graph keine Sprünge oder Unterbrechungen aufweist\
    Bsp: \

    #let xs = lq.linspace(0, 5)
    #lq.diagram(
      title: $f(x) = x - 3$,
      lq.plot(xs, xs.map(x => x - 3), mark: none),
    )
  ],
  [
    === Stetig fortsetzbare Funktion

    Funktion, die an einem bestimmten Punkt nicht definiert ist, aber erweitert werden kann, sodass die erweiterte Funktion stetig bleibt\
    Bsp: \

    #let xs = lq.linspace(-3, 3)
    #lq.diagram(
      title: $f(x) = ((x-1)(x+1))/(x-1), "nicht stetig bei" x = 1$,
      lq.plot(
        xs,
        xs.map(x => (x - 1) * (x + 1) / (x - 1)),
        mark: mark => place(center + horizon, text(
          mark.fill,
          size: 8pt,
        )[#sym.circle]),

        every: (32,),
      ),
    )

    Stetige fortsetzung: $accent(f, ~) (x) = x+1$

  ],

  [

    === Streng wachsende Funktion

    $x < accent(x, ~) -> f(x) < f(accent(x, ~))$ \
    Bsp: \
    #let xs = lq.linspace(0, 5)
    #lq.diagram(
      title: $f(x) = a^x, a > 1\ ("Diagramm: " f(x) = 2^x)$,
      lq.plot(xs, xs.map(x => calc.pow(2, x)), mark: none),
    )
  ],
  [

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
  ],

  [

    === Streng fallende Funktion

    $x < accent(x, ~) -> f(x) > f(accent(x, ~))$ \
    Bsp: \
    #let xs = lq.linspace(0.0001, 5, num: 150)
    #lq.diagram(
      title: $f(x): RR^+ -> RR, x |-> 1 / x$,
      ylim: (-0.5, 12),
      lq.plot(xs, xs.map(x => 1 / x), mark: none),
    )
  ],
  [

    === Monoton fallende Funktion

    $x < accent(x, ~) -> f(x) >= f(accent(x, ~))$ \
    Bsp: \
    #let xs = lq.linspace(0, 5)
    #lq.diagram(
      title: $ f(x) = cases(-2x + 2&","x<=2, -2&","1<x<=4, -x / 2&", "x>4) $,
      lq.plot(
        xs,
        xs.map(x => if x <= 2 { x * -2 + 2 } else if x <= 4 { -2 } else {
          -x / 2
        }),
        mark: none,
      ),
    )
  ],

  [

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
  ],
  [

    === Glatte Funktion

    Funktion, die unendlich oft differenzierbar ist \
    Bsp: \

    #let xs = lq.linspace(0, 5)
    #lq.diagram(
      title: $f(x) = e^x$,
      lq.plot(xs, xs.map(x => calc.pow(e, x)), mark: none),
    )
  ],
)

=== Gerade Funktion

$forall x in D_f: f(-x) = f(x)$ \

Bsp: \

#grid(
  columns: (1fr, 1fr),
  [#let xs = lq.linspace(-10, 10)
    #lq.diagram(
      title: $f(x) = x^n, n "gerade" \ "Diagramm: " f(x) = x^2$,
      lq.plot(xs, xs.map(x => calc.pow(x, 2)), mark: none),
    )
  ],
  [
    #let xs = lq.linspace(-10, 10)
    #lq.diagram(
      title: $f(x) = |x|$,
      lq.plot(xs, xs.map(calc.abs), mark: none),
    )
  ],

  [
    #let xs = lq.linspace(-2 * calc.pi, 2 * calc.pi)
    #lq.diagram(
      title: $f(x) = cos(x)$,
      lq.plot(xs, xs.map(calc.cos), mark: none),
    )
  ],
)

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

=== Umkehrfunktion

$f(x) = y <=> f^(-1) (y) = x$ \
Bsp: \
#let xs = lq.linspace(0, 10)
#lq.diagram(
  title: $f(x) = x^2$,
  lq.plot(xs, xs.map(x => calc.pow(x, 2)), mark: none),
)
#let xs = lq.linspace(0, 10, num: 200)
#lq.diagram(
  title: $f^(-1) (x) = sqrt(x)$,
  lq.plot(xs, xs.map(x => calc.sqrt(x)), mark: none),
)

== Nullstellenform

Quadratisch
- $f(x) = a^2 x + b x + c$
- $f(x) = a(x - x_0)(x - x_1)$
Kubisch
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

#let xs = lq.linspace(0.1, 10, num: 200)
#align(center, lq.diagram(
  title: $f(x) = ln (x)$,
  width: 15cm,
  height: 6cm,
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

#let xs = range(10)
#let ys = (4, 2, 3, 0, 5, 8, 4, 6, 4, 5)

#align(center, lq.diagram(
  title: "Datenpunkte",
  width: 15cm,
  height: 6cm,
  lq.plot(xs, ys, stroke: none, mark: "o"),
))

== Lineare interpolation

#align(center, lq.diagram(
  title: $P_i(x) = y_i + ((y_(i+1) - y_i)/(x_(i+1) - x_i))(x-x_i)$,
  width: 15cm,
  height: 6cm,
  lq.plot(xs, ys, stroke: none, mark: "o"),
  lq.plot(xs, ys, mark: none),
))

== Quadratische interpolation

#let num = 200
#let qxs = lq.linspace(0, 10, num: num)
#let qys = qxs.map(_ => 0)
#for (i, x) in qxs.enumerate() {
  if x + 2 > ys.len() { break }
  let x_prime = calc.floor(x)
  let x1 = x_prime
  let x2 = x_prime + 1
  let x3 = x_prime + 2
  let y1 = ys.at(x1)
  let y2 = ys.at(x2)
  let y3 = ys.at(x3)
  let a = (
    ((y2 - y1) / ((x2 - x1) * (x2 - x3)))
      - ((y3 - y1) / ((x3 - x1) * (x2 - x3)))
  )
  let b = ((y2 - y1) / (x2 - x1)) - (a * (x1 + x2))
  let c = y1 - (a * x1 * x1) - (b * x1)
  let y = a * calc.pow(x, 2) + b * x + c
  let _ = qys.remove(i)
  qys.insert(i, y)
}
#let off = num - int(num / 10 * 2)
#align(center, lq.diagram(
  title: $P_i(x) = a_i x^2 + b_i x + c_i$,
  width: 15cm,
  height: 6cm,
  lq.plot(xs, ys, stroke: none, mark: "o"),
  lq.plot(qxs.slice(0, off), qys.slice(0, off), mark: none),
))


= Misc

== Ungleichungen

Wenn man mit negativen Termen multipliziert oder eine fallende Funktion
anwendet, muss das Ungleichzeichen geändert werden.

== Mitternachtsformel

$ a n^2 + b n + c = 0 => u_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/(2a) $

= Trigonometrie

#grid(
  columns: (auto, auto),
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      $x$, $0$, $30=pi/6$, $45 = pi/4$, $60=pi/3$, $90 = pi/2$,
      $sin(x)$, $0$, $1/2$, $sqrt(2)/2$, $sqrt(3)/2$, $1$,
      $cos(x)$, $1$, $sqrt(3)/2$, $sqrt(2)/2$, $1/2$, $0$,
      $tan(x)$, $0$, $1/sqrt(3)$, $1$, $sqrt(3)$, $$,
    )

    $tan(x) = sin(x)/cos(x)$ \

    Trigonometrischer Satz des Pythagoras: \ $sin^2(x) + cos^2(x) = 1$
  ],
  {
    let circle(s: 1, x: 0, y: 0) = {
      let n = 100
      let p = i => i * 2 * calc.pi / n
      range(0, n).map(i => (calc.sin(p(i)) * s + x, calc.cos(p(i)) * s + y))
    }
    let cut(points, (x1, y1), (x2, y2)) = {
      points.filter(((x, y)) => {
        x >= x1 and x <= x2 and y >= y1 and y <= y2
      })
    }

    lq.diagram(
      width: 8cm,
      height: 8cm,
      legend: (position: left + top),

      lq.path(
        ..circle(),
        closed: true,
      ),

      lq.plot(
        (0, calc.cos(calc.pi / 4)),
        (0, calc.sin(calc.pi / 4)),
        label: $1$,
        mark: none,
        stroke: 3pt,
      ),

      lq.plot(
        (calc.cos(calc.pi / 4), calc.cos(calc.pi / 4)),
        (calc.sin(calc.pi / 4), 0),
        label: $sin(alpha)$,
        mark: none,
        stroke: 3pt,
      ),

      lq.plot(
        (calc.cos(calc.pi / 4), 0),
        (0, 0),
        label: $cos(alpha)$,
        mark: none,
        stroke: 3pt,
      ),

      lq.path(
        // eh hardcoded is fine for now
        ..cut(circle(s: 1 / 4), (0, 0), (1, 0.18)),
      ),
      lq.path(
        // don't wanna waste more time here
        ..cut(
          circle(s: 1 / 8, x: calc.cos(1) + 0.17),
          (0, 0),
          (calc.cos(calc.pi / 4), 1),
        ),
        stroke: colors.red,
      ),
      lq.plot(
        (calc.cos(calc.pi / 4) - 0.05,),
        (0.05,),
        stroke: colors.red,
      ),
      lq.plot(
        (0.12,),
        (0.11,),
        mark: mark => $alpha$,
      ),
    )
  },
)

== Umkehrfunktionen

$
  &arccos: cases([-1;1]&&->[0;pi], x&&|->"Lösung" y in [0;pi] "der Gleichung" cos(y)=x) \
  &arcsin: cases([-1;1]&&->[-pi/2;pi/2], x&&|->"Lösung" y in [-pi/2;pi/2] "der Gleichung" sin(y)=x) \
  &arctan: cases(RR&&->(-pi/2;pi/2), x&&|->"Lösung" y in (-pi/2;pi/2) "der Gleichung" tan(y)=x)
$

#let xs = lq.linspace(-1, 1, num: 200)
#grid(
  columns: (1fr, 1fr),
  [
    #lq.diagram(
      title: $cos$,
      lq.plot(xs, xs.map(x => calc.cos(x)), mark: none, label: $cos$),
      lq.plot(xs, xs.map(x => calc.acos(x).rad()), mark: none, label: $arccos$),
    )
  ],
  [
    #lq.diagram(
      legend: (position: left + top),
      title: $sin$,
      lq.plot(xs, xs.map(x => calc.sin(x)), mark: none, label: $sin$),
      lq.plot(xs, xs.map(x => calc.asin(x).rad()), mark: none, label: $arcsin$),
    )
  ],

  [
    #lq.diagram(
      legend: (position: left + top),
      title: $tan$,
      lq.plot(xs, xs.map(x => calc.tan(x)), mark: none, label: $tan$),
      lq.plot(xs, xs.map(x => calc.atan(x).rad()), mark: none, label: $arctan$),
    )
  ],
)

= Ableitungen

#table(
  columns: (auto, 1fr),
  [Ableitung], [Bedeutung],
  $f′$, [Steigung],
  $f′(x)>0$, [Funktion steigt],
  $f′(x)<0$, [Funktion fällt],
  $f′(x)=0$, [Mögliche Extremstelle],
  $f′′$, [Form der Parabel],
  $f′′(x)>0$, [Nach oben geöffnet],
  $f′′(x)<0$, [Nach unten geöffnet],
  $f′(x)=0 and f′′(x)>0$, [Lokales Minimum],
  $f′(x)=0 and f′′(x)<0$, [Lokales Maximum],
  $f′(x)=0 and f''(x) = 0 and f'''(x) != 0$, [Lokaler Sattelpunkt],
  $f′′′$, [Änderung der Form / Wendepunkt-Richtung bei $f′′(x)=0$],
  $f′′(x)=0 and f′′′(x)≠0$, [Wendepunkt],
  $f′′(x)=0 and f′′′(x)>0$, [Krümmung ändert sich von oben nach unten],
  $f′′(x)=0 and f′′′(x)<0$, [Krümmung ändert sich von unten nach oben],
)

_Beispiele_ \
#[
  #let mrk = (m, ..b) => lq.plot(
    ..b,
    mark: mark => place(
      center + horizon,
      circle(fill: colors.white, inset: 0.25pt, m),
    ),
    mark-color: colors.black,
    z-index: 99,
  )
  #grid(
    columns: (1fr, 1fr),
    [
      $
        #td($f(x) = x^2$), #tp($f'(x) = 2x$), #tg($f''(x) = 2$), #tr($f'''(x) = 0$)
      $
      $
        & 1) #tp($f'(3) = 6$)                       && => "Steigend" \
        & 2) #tp($f'(-3) = -6$)                     && => "Fallend" \
        & 3) #tg($f''(3) = 2$)                      && => "Nach oben geöffnet" \
        & 4) #tp($f'(0) = 0$)                       && => "Mögliche Extremstelle" \
        & 5) #tp($f'(0) = 0$) and #tg($f''(0) = 2$) && => "Lokales Minimum"
      $
    ],
    {
      let xs = lq.linspace(-4, 4)
      lq.diagram(
        legend: (position: left + top),
        height: 7cm,
        lq.plot(
          xs,
          xs.map(x => calc.pow(x, 2)),
          mark: none,

          label: $f$,
        ),
        lq.plot(xs, xs.map(x => 2 * x), mark: none, label: $f'$),
        lq.plot(xs, xs.map(_ => 2), mark: none, label: $f''$),
        lq.plot(xs, xs.map(_ => 0), mark: none, label: $f'''$),
        mrk([1], (3,), (6,)),
        mrk([2], (-3,), (-6,)),
        mrk([3], (3,), (2,)),
        mrk([5], (0,), (0,)),
      )
    },

    [
      $
        #td($f(x) = 1/2 x^3 + 10$), #tp($f'(x) = 3/2 x^2$), #tg($f''(x) = 3x$), #tr($f'''(x) = 3$)
      $
      $
        1) & #tp($f'(2) = 6$)                       && => "Steigend" \
        2) & #tp($f'(-2) = 6$)                      && => "Steigend" \
        3) & #tg($f''(2) = 6$)                      && => "Nach oben geöffnet" \
        4) & #tg($f''(-2) = -6$)                    && => "Nach unten geöffnet" \
        5) & #tp($f'(0) = 0$)                       && => "Mögliche Extremstelle" \
        6) & #tp($f'(0) = 0$) and #tg($f''(0) = 0$) \
           & and #tr($f'''(0) = 3$)                 && => "Lokaler Sattelpunkt" \
      $
    ],
    {
      let xs = lq.linspace(-3, 3)
      lq.diagram(
        legend: (position: left + top),
        height: 7cm,
        lq.plot(
          xs,
          xs.map(x => 1 / 2 * calc.pow(x, 3) + 10),
          mark: none,
          label: $f$,
        ),
        lq.plot(xs, xs.map(x => 3 / 2 * x * x), mark: none, label: $f'$),
        lq.plot(xs, xs.map(x => 3 * x), mark: none, label: $f''$),
        lq.plot(xs, xs.map(_ => 3), mark: none, label: $f'''$),
        mrk([1], (2,), (6,)),
        mrk([2], (-2,), (6,)),
        mrk([5], (0,), (0,)),
        mrk([6], (0,), (10,)),
      )
    },
  )

  $
    #td($f: cases([-4;8] &&|-> RR, x &&|-> 1/2 x^3 - 5 x^2 + 30)$) "  "
    #tp($f': cases([-4;8] &&|-> RR, x &&|-> 3/2 x^2 - 10x)$) "  "
    #tg($f'': cases([-4;8] &&|-> RR, x &&|-> 3 x - 10)$) "  "
    #tr($f''': cases([-4;8] &&|-> RR, x &&|-> 3)$)
  $
  $ 1) & #tp($f'(20/3) = 0$) and #tg($f''(20/3) = 10$) && => "Lokales Minimum" \
  2) & #tp($f'(0) = 0$) and #tg($f''(0) = -10$) && => "Lokales & Globales Maximum" \
  3) & #td($f(-4) = -82$) && => "Globales Minimum" \
  4) & #td($f(8) = -34$) && => "Lokales Minimum" \
  5) & #tg($f''(10/3) = 0$) and #tr($f'''(10/3) = 3$) && => "Wendepunkt nach unten" $,
  #let xs = lq.linspace(-4, 8)
  #align(center, lq.diagram(
    legend: (position: center + bottom),
    height: 10cm,
    width: 15cm,
    xlim: (-5, 9),
    lq.plot(
      xs,
      xs.map(x => calc.pow(x, 3) / 2 - 5 * calc.pow(x, 2) + 30),
      mark: none,
      label: $f$,
    ),
    lq.plot(xs, xs.map(x => 3 / 2 * x * x - 10 * x), mark: none, label: $f'$),
    lq.plot(xs, xs.map(x => 3 * x - 10), mark: none, label: $f''$),
    lq.plot(xs, xs.map(_ => 3), mark: none, label: $f'''$),
    mrk([1], (20 / 3,), (-44.07,)),
    mrk([2], (0,), (30,)),
    mrk([3], (-4,), (-82,)),
    mrk([4], (8,), (-34,)),
    mrk([5], (10 / 3,), (-7.03,)),
  ))
]
== Glossar

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
  [$ln(x)$], [$1/x "für" x>0$], [$ln(y dot x)$], [$1/x "für" x>0$],
  [$a^x$],
  [$ln(a) dot a^x "für" a > 0, a != 1$],
  [$log_b (x)$],
  [$1/(ln(b) dot x)$],

  [$sin(x)$], [$cos(x)$], [$sin(2x)$], [$2cos(x)$],
  [$cos(x)$], [$-sin(x)$], [$cos(a x)$], [$-a sin(x)$],
  [$tan(x)$], [$1+tan^2(x) = 1/(cos^2(x))$], [$arcsin(x)$], [$1/sqrt(1-x^2)$],
  [$arccos(x)$], [$- 1/sqrt(1-x^2)$], [$arctan(x)$], [$1/(1+x^2)$],
)
#let xs = lq.linspace(0, 4)

#grid(
  columns: (1fr, 1fr),
  lq.diagram(
    legend: (position: right + horizon),
    lq.plot(xs, xs.map(x => 1), mark: none, label: $f(x) = 1$),
    lq.plot(xs, xs.map(x => 0), mark: none, label: $f'$),
  ),
  lq.diagram(
    legend: (position: left + top),
    lq.plot(xs, xs.map(x => x), mark: none, label: $f(x) = x$),
    lq.plot(xs, xs.map(x => 1), mark: none, label: $f'$),
  ),

  lq.diagram(
    legend: (position: left + top),
    lq.plot(
      xs,
      xs.map(x => calc.pow(x, 2)),
      mark: none,

      label: $f(x) = x^2$,
    ),
    lq.plot(xs, xs.map(x => 2 * x), mark: none, label: $f'$),
  ),
  lq.diagram(
    legend: (position: left + top),
    lq.plot(
      xs,
      xs.map(x => calc.pow(x, 3)),
      mark: none,

      label: $f(x) = x^3$,
    ),
    lq.plot(
      xs,
      xs.map(x => 3 * calc.pow(x, 2)),
      mark: none,

      label: $f'$,
    ),
  ),

  {
    let xs = lq.linspace(0.3, 4)
    lq.diagram(
      legend: (position: right + bottom),
      xlim: (-0.2, 4),
      lq.plot(
        xs,
        xs.map(x => 1 / x),
        mark: none,

        label: $f(x) = 1/x$,
      ),
      lq.plot(
        xs,
        xs.map(x => -1 / calc.pow(x, 2)),
        mark: none,

        label: $f'$,
      ),
    )
  },
  {
    let xs = lq.linspace(0.01, 4)
    lq.diagram(
      legend: (position: left + top),
      ylim: (-0.1, 2),
      lq.plot(
        xs,
        xs.map(x => calc.sqrt(x)),
        mark: none,

        label: $f(x) = sqrt(x)$,
      ),
      lq.plot(
        xs,
        xs.map(x => 1 / 2 * calc.sqrt(x)),
        mark: none,

        label: $f'$,
      ),
    )
  },

  lq.diagram(
    legend: (position: left + top),
    lq.plot(
      xs,
      xs.map(x => calc.pow(e, x)),
      mark: none,

      label: $f(x) = e^x$,
    ),
    lq.plot(
      xs,
      xs.map(x => calc.pow(e, x)),
      mark: none,

      label: $f'$,
    ),
  ),
  lq.diagram(
    legend: (position: right + top),
    lq.plot(
      xs,
      xs.map(x => calc.pow(e, -x)),
      mark: none,

      label: $f(x) = e^(-x)$,
    ),
    lq.plot(
      xs,
      xs.map(x => -calc.pow(e, -x)),
      mark: none,

      label: $f'$,
    ),
  ),

  {
    let xs = lq.linspace(0.3, 4)
    lq.diagram(
      xlim: (-0.2, 4),
      legend: (position: right + top),
      lq.plot(
        xs,
        xs.map(calc.ln),
        mark: none,

        label: $f(x) = ln(x)$,
      ),
      lq.plot(
        xs,
        xs.map(x => 1 / x),
        mark: none,

        label: $f'$,
      ),
    )
  },
  lq.diagram(
    legend: (position: left + top),
    lq.plot(
      xs,
      xs.map(x => calc.pow(2, x)),
      mark: none,

      label: $f(x) = 2^x$,
    ),
    lq.plot(
      xs,
      xs.map(x => calc.ln(2) * calc.pow(2, x)),
      mark: none,

      label: $f'$,
    ),
  ),

  lq.diagram(
    legend: (position: left + bottom),
    lq.plot(
      xs,
      xs.map(calc.sin),
      mark: none,
      label: $f(x) = sin(x)$,
    ),
    lq.plot(
      xs,
      xs.map(calc.cos),
      mark: none,
      label: $f'$,
    ),
  ),
  lq.diagram(
    legend: (position: center + top),
    lq.plot(
      xs,
      xs.map(calc.cos),
      mark: none,
      label: $f(x) = cos(x)$,
    ),
    lq.plot(
      xs,
      xs.map(x => -calc.sin(x)),
      mark: none,
      label: $f'$,
    ),
  ),
)

== Funktionen

#deftbl(
  [Addition],
  [
    $ (f(x) + g(x))' = f'(x) + g'(x) $
  ],
  [Multiplikation],
  [
    $ (alpha dot f(x))' = alpha dot f'(x) $
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

$
  &tr(underbrace(m, "Steigung")) && dot tb(underbrace(x, "Abstand")) &&&&+ tg(underbrace(y, "Funktionswert")) \
  =&tr(f'(x_0)) &&dot tb((x - x_0)) &&&&+ tg(f(x_0)) \
$

#let xs = lq.linspace(0, 6)
#grid(
  columns: (2fr, 3fr),
  grid.cell(colspan: 2, align: center)[_Beispiel_],
  grid(
    columns: (auto, 1fr),
    "Gegeben:", $f(x) = 2x^2 - 6x + 4 \ x_0 = 3$,
    "Funktionswert:", $tg(y = f(3) = 4) \ => P = (3;4)$,
    "Ableitung:", $f'(x) = 4x - 6$,
    "Steigung:", $tr(m = f'(3) = 6)$,
    "Tangentenformel:", $t_3 (x) = tr(6) dot tb((x - 3)) + tg(4)\ = 6x - 14$,
  ),

  lq.diagram(
    legend: (position: top + center),
    height: 6cm,
    width: 11cm,
    ylim: (-1, 20),
    lq.plot(
      xs,
      xs.map(x => 2 * calc.pow(x, 2) - 6 * x + 4),
      mark: none,
      label: $f(x)$,
    ),
    lq.plot(xs, xs.map(x => 4 * x - 6), mark: none, label: $f'(x)$),
    lq.plot(xs, xs.map(x => 6 * x - 14), mark: none, label: $t_3 (x)$),
    lq.plot((3,), (4,), mark: "o", label: $P$),
  ),
)

== Approximation durch Linearisierung (Newtonverfahren)

$ x_(n+1) = x_n - (f(x_n))/(f'(x_n)) $

```python
for i in range(1, max_iter):
  x_neu = x_alt - f(x_alt) / f_prime(x_alt)
  x_alt = x_neu
```

#let xs = lq.linspace(0.00001, 2.5, num: 500)
#grid(
  columns: (2fr, 3fr),
  grid.cell(colspan: 2, align: center)[_Beispiel_],
  grid(
    columns: (auto, 1fr),
    grid.cell(colspan: 2)[Ziel: Nullstelle finden],
    "Gegeben:",
    $
      e^x & = ln(x) + 3 && , x > 0 \
        x & approx 1
    $,
    "Als Funktion:", $f(x) &= e^x - ln(x) - 3$,
    "Ableitung:", $f'(x) = e^x - 1/x$,
    "Linearisierung:",
    $
      t_1 (x) & =f'(1)(x - 1) + f(1) \
              & = e x - x - 2 \
    $,
    "Nullstelle:",
    $
          & e x - x - 2 = 0 \
      <=> & x_1 = 2/(e - 1)
    $,
  ),
  lq.diagram(
    legend: (position: top + center),
    height: 6cm,
    width: 11cm,
    ylim: (-2, 8),
    lq.plot(
      xs,
      xs.map(x => calc.pow(e, x) - calc.ln(x) - 3),
      mark: none,
      label: $f(x)$,
    ),
    lq.plot(
      xs,
      xs.map(x => e * x - x - 2),
      mark: none,
      label: $t_1 (x)$,
    ),
    lq.plot(
      (1,),
      (e - 3,),
      mark: "o",
      label: $P_0$,
      mark-size: 8pt,
    ),
    lq.plot(
      (2 / (e - 1),),
      (calc.pow(e, 2 / (e - 1)) - calc.ln(2 / (e - 1)) - 3,),
      mark: "o",
      label: $P_1$,
      mark-size: 8pt,
    ),
  ),
  "Vergrössert:",
  {
    let xs = lq.linspace(0.97, 1.19, num: 500)
    lq.diagram(
      legend: (position: bottom + right),
      height: 6cm,
      width: 11cm,
      ylim: (-0.3, 0.1),
      xaxis: (position: 0),
      yaxis: (position: 0.98),
      lq.plot(
        xs,
        xs.map(x => calc.pow(e, x) - calc.ln(x) - 3),
        mark: none,
        label: $f(x)$,
      ),
      lq.plot(
        xs,
        xs.map(x => e * x - x - 2),
        mark: none,
        label: $t_1 (x)$,
      ),
      lq.plot(
        (1,),
        (e - 3,),
        mark: "o",
        label: $P_0$,
        mark-size: 8pt,
      ),
      lq.plot(
        (2 / (e - 1),),
        (calc.pow(e, 2 / (e - 1)) - calc.ln(2 / (e - 1)) - 3,),
        mark: "o",
        label: $P_1$,
        mark-size: 8pt,
      ),
    )
  },
)

#let xs = lq.linspace(0, 1.5)
#grid(
  columns: (2fr, 3fr),
  grid.cell(colspan: 2, align: center)[_Beispiel_],
  grid(
    columns: (auto, 1fr),
    grid.cell(colspan: 2)[Ziel: Nullstelle finden],
    "Gegeben:", $f(x) = x^3 + 4x - 4 \ x_0 = 1/2$,
    "Ableitung:", $f'(x) = 3x^2 + 4$,
    grid.cell(colspan: 2)[Annäherung],
    grid.cell(colspan: 2)[$
       f(1/2) & = (1/2)^3 + 4(1/2) - 4 = -15/8 \
      f'(1/2) & = 3 (1/2)^2 + 4 = 19/4 \
          x_1 & = 1/2 - (-15/8)/(19/4) = 17/19
    $],
  ),
  lq.diagram(
    legend: (position: top + center),
    height: 6cm,
    width: 11cm,
    lq.plot(
      xs,
      xs.map(x => calc.pow(x, 3) + 4 * x - 4),
      mark: none,
      label: $f(x)$,
    ),
    lq.plot((1 / 2,), (-15 / 8,), mark: "o", label: $P_0$, mark-size: 8pt),
    // lq.plot((1 / 2,), (19 / 4,), mark: "o", label: $P'$),
    lq.plot(
      (17 / 19,),
      (calc.pow(17 / 19, 3) + 4 * (17 / 19) - 4,),
      mark: "o",
      label: $P_1$,
      mark-size: 8pt,
    ),
  ),
)
