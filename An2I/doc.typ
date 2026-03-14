#import "@preview/cetz:0.4.1"
#import "@preview/tiptoe:0.3.1" as tiptoe
#import "../lib.typ": *

#show: project.with(
  module: "An2I",
  name: "Analysis für Informatik 2",
  semester: "FS26",
)

#let shade = (x: 15pt, y: 15pt, stroke: 1pt) => tiling(size: (x, y))[
  #place(line(
    start: (0%, 100%),
    end: (100%, 0%),
    stroke: stroke,
  ))
]

= Taylorpolynom

- Approximation von Funktionen durch Polynome
- Innerhalb vom Konvergenzradius sind Funktionen immer durch unendliche Polynome perfekt approximierbar


== Berechnung

Jede Ableitung ist die nächste Unbekannte:
$
  &p(x) = &&#tp($a_0$) && + #tp($a_1$) (x - x_0) && + #tp($a_2$) (x - x_0)^2 && + #tp($a_3$) (x - x_0)^3 \
  &p'(x) = &&#td(0) && + #tp($a_1$) 1 && + #tp($a_2$) 2(x - x_0) && + #tp($a_3$) 3(x - x_0)^2 \
  &p''(x) = &&#td(0) && + #td(0) && + #tp($a_2$) 2 && + #tp($a_3$) 6(x - x_0) \
  &p'''(x) = &&#td(0) && + #td(0) && + #td(0) && + #tp($a_3$) 6 \
  &p''''(x) = &&#td(0) && + #td(0) && + #td(0) && + #td(0) \
$
$x_0$ einsetzen:
$
  &p(x_0) = &&#tp($a_0$) && + cancel(#tp($a_1$) (x_0- x_0)) && + cancel(#tp($a_2$) (x_0- x_0)^2) && + cancel(#tp($a_3$) (x_0- x_0)^3) &&= a_0\
  &p'(x_0) = &&#td(0) && + #tp($a_1$) 1 && + cancel(#tp($a_2$) 2(x_0- x_0)) && + cancel(#tp($a_3$) 3(x_0- x_0)^2) &&= a_1 dot 1\
  &p''(x_0) = &&#td(0) && + #td(0) && + #tp($a_2$) 2 && + cancel(#tp($a_3$) 6(x_0- x_0)) &&= a_2 dot 2 dot 1\
  &p'''(x_0) = &&#td(0) && + #td(0) && + #td(0) && + #tp($a_3$) 6 &&= a_3 dot 3 dot 2 dot 1\
  &p''''(x_0) = &&#td(0) && + #td(0) && + #td(0) && + #td(0) \
$
Somit:
$
      & p^((n)) (x_0) = a_n dot n! \
  <=> & a_n = (p^((n)) (x_0)) / (n!)
$

#exbox([
  $p(x) = 3x^3 - 2x + 5$ \
  Entwicklungspunkt $"EWP" = x_0 = 1$ \

  NR: $ p(x) = 3x^3 - 2x^5 \
  p'(x) = 9x^2 - 2 $
  Linearisierung: $ p(x_0) = 3x_0^3 - 2x_0^5 = 3 - 2 + 5 = 6\
  p'(x_0) = 9x_0^2 - 2 = 9 - 2 = 7 $
  Ergo: $p(x) approx 6 + 7(x-1)$ = Taylor-Polynom von Grad 1 \
  Taylor-Polynom von Grad 3: $p(x) approx underbrace(6 + 7(x-1), "Linearisierung") + ? (x-1)^2 + ? (x-1)^3$ \
  $
    &p(x_0) &&= 3x_0^3 - 2x_0^5 = 3 - 2 + 5 &&= 6 &&= a_0 &&=> a_0 = 6\
    &p'(x_0) &&= 9x_0^2 - 2 = 9 - 2 &&= 7 &&= 1 dot a_1 &&=> a_1 = 7 \
    &p''(x_0) &&= 18x_0 &&= 18 &&= 1 dot 2 dot a_2 &&=> a_2 = 9 \
    &p'''(x_0) &&= 18 && &&= 1 dot 2 dot 3 dot a_3 &&=> a_3 = 3 \
  $
  Gibt uns: $ p(x) approx 6 + 7(x-1) + 9(x-1)^2 + 3(x-1)^3 $
])

== Generalisierung

Für ein Polynom $p(x)$ vom Grad $n$ und einem Entwicklungspunkt $x_0$ gilt: $ p(x) = sum_(k=0)^n (p^((k)) (x_0)) / (k!) (x-x_0)^k $
Für eine Funktion #td($f(x)$) und einen EWP $x_0$ heisst $ sum_(k=0)^n (#td($f$)^((k)) (x_0))/(k!) (x-x_0)^k $ Taylor-Polynom von Grad $n$ für $f(x)$ um EWP $x_0$

#let xs = lq.linspace(-3 * calc.pi, 3 * calc.pi, num: 100)
#exbox(title: $#td($f(x)$) = sin(x), x_0 = 0$, lq.diagram(
  height: 8cm,
  width: 100%,
  ylim: (-6, 6),
  lq.plot(xs, xs.map(calc.sin), mark: none, label: $sin(x)$, stroke: 3.5pt),
  lq.plot(xs, xs, mark: none, label: $n = 1$, stroke: .5pt),
  lq.plot(
    xs,
    xs.map(x => x - calc.pow(x, 3) / 6),
    mark: none,
    label: $n = 3$,
    stroke: 1pt,
  ),
  lq.plot(
    xs,
    xs.map(x => x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120),
    mark: none,
    label: $n = 5$,
    stroke: 1.5pt,
  ),
  lq.plot(
    xs,
    xs.map(x => (
      x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120 - calc.pow(x, 7) / 5040
    )),
    mark: none,
    label: $n = 7$,
    stroke: 2pt,
  ),
  lq.plot(
    xs,
    xs.map(x => (
      (
        x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120 - calc.pow(x, 7) / 5040
      )
        + calc.pow(x, 9) / 362880
    )),
    mark: none,
    label: $n = 9$,
    stroke: 2.5pt,
  ),
  lq.plot(
    xs,
    xs.map(x => (
      (
        x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120 - calc.pow(x, 7) / 5040
      )
        + calc.pow(x, 9) / 362880
        - calc.pow(x, 11) / 39916800
    )),
    mark: none,
    label: $n = 11$,
    stroke: 3pt,
  ),
))

#obsbox(
  [In der Nähe des EWP $x_0$ gilt $f(x) approx sum_(k=0)^n (f^((k)) (x_0))/(k!) (x-x_0)^k$ ],
  [Je grösser $n$ ist, umso kleiner ist der Unterschied der beiden Seiten],
  [Der Unterschied ist umso kleiner, je näher $x$ bei $x_0$ liegt],
)

#exbox(title: [$f(x) = e^x$, EWP $x_0 = 0$], [
  Gesucht: Taylor-Polynom vom Grad $n$

  $
    & f(x)        && = e^x && =>f(0)        && = e^0 = 1 \
    & f'(x)       && = e^x && =>f'(0)       && = e^0 = 1 \
    & f''(x)      && = e^x && =>f''(0)      && = e^0 = 1 \
    & f^((n)) (x) && = e^x && =>f^((n)) (0) && = e^0 = 1 \
  $
  $
    => e^x approx sum_(k=0)^n 1/(k!) ((x-0)^k) <=> e^x approx sum_(k=0)^n 1/(k!) (x^k) \
  $
])

== Taylorreihe

Die Taylor-Reihe von $f(x)$ um den Entwicklungspunkt $x_0$ ist $ sum_(k=0)^#tp($oo$) (p^((k)) (x_0)) / (k!) (x-x_0)^k $
Es gibt eine Zahl $R>0$, so dass $f(x) = sum_(k=0)^oo (p^((k)) (x_0)) / (k!) (x-x_0)^k$, für $abs(x-x_0) < R$ \
($R$ = Konvergenzradius)

== Fehlerabschätzungen

Wie weit liegt der vom Taylor-Polynom mit Grad $n$ vorhergesagte Funktionswert vom richtigen Wert entfernt? \

$
  "Rechenfehler" &= abs(f(x) - sum_(k=0)^n (p^((k)) (x_0)) / (k!) (x-x_0)^k) \
  &approx abs(sum_(k=0)^(#tp($n+1$)) (p^((k)) (x_0)) / (k!) (x-x_0)^k - sum_(k=0)^n (p^((k)) (x_0)) / (k!) (x-x_0)^k) \
  &= abs((f^((n+1)) (x_0))/((n+1)!) (x-x_0)^(n+1))
$
Es gibt eine Zahl $xi in [x_0; x]$, so dass
$
  "Rechenfehler" & = abs(f(x) - sum_(k=0)^n (p^((k)) (x_0)) / (k!) (x-x_0)^k) \
  & = abs((f^((n+1)) (xi))/((n+1)!) (x-x_0)^(n+1)) \
  & = abs(f^((n+1)) (xi))/((n+1)!) abs(x-x_0)^(n+1) \
  & <= (display(max_(xi in [x_0; x]))abs(f^((n+1)) (xi)))/((n+1)!) abs(x-x_0)^(n+1) \
$
(Falls $f(x)$ nicht berechenbar)

#grid(
  columns: (auto, 1fr),
  cetz.canvas({
    import cetz.draw: *
    line((0, 0), (11, 0), stroke: colors.fg)
    mark((11, 0), (12, 0), ">", stroke: colors.fg, fill: colors.fg)
    line((1, 1), (9, 1), stroke: colors.darkblue)
    mark((5, 1), (9, 1), ">", stroke: colors.darkblue, fill: colors.darkblue)
    mark((5.2, 1), (9, 1), "<", stroke: colors.darkblue, fill: colors.darkblue)
    mark((1.2, 1), (5, 1), "<", stroke: colors.darkblue, fill: colors.darkblue)
    mark((8.8, 1), (5, 1), "<", stroke: colors.darkblue, fill: colors.darkblue)
    line((1, 0.2), (1, -0.2), stroke: colors.darkblue)
    content((1, -0.5), text(fill: colors.darkblue)[$a$])
    line((9, 0.2), (9, -0.2), (9.1, -0.3), stroke: colors.darkblue)
    content((9.15, -0.5), text(fill: colors.darkblue)[$b$])
    line((5, 0.2), (5, -0.2), stroke: colors.fg)
    content((5, -0.5), text(fill: colors.fg)[$x_0$])
    line((9, -0.2), (8.9, -0.3), stroke: colors.fg)
    content((8.85, -0.5), text(fill: colors.fg)[$x$])
    line((5, 0.5), (9, 0.5), stroke: colors.red)
    line((7, 0.5), (7, -0.2), stroke: colors.red)
    content((7, -0.5), text(fill: colors.red)[$xi$])
  }),
  $x_0 = (a+b)/2, abs(x - x_0) <= #td($(b-a)/2$)$,
)

=== Anwendung

Gegeben: $f(x)$, Intervall $I = [a;b]$, max. Rechenfehler $Delta$ \
Gesucht: Grad des Taylor-Polynoms $n$, Entwicklungspunkt $x_0$

Antwort: $x_0 = (a+b)/2 => abs(x-x_0)<=(b-a)/2$ \
Bestimme $n$:
$
  &(display(max_(xi in [x_0; x]))abs(f^((n+1)) (xi)))/((n+1)!) abs(x-x_0)^(n+1) &&<=^! Delta\
  <&(m)/((n+1)!) ((b-a)/2)^(n+1) && lr(| m > max_(xi in [x_0; x])abs(f^((n+1)) (xi))space) \
$

#exbox(
  title: [
    Gegeben: $f(x) = sin(x)$ auf $I = [0;pi]$ durch Taylor-Polynom mit Rechenfehler $Delta = 0.01$ \
    berechnet werde: $x_0 = pi/2$
  ],
  [
    $
             & f(x)                  && = sin(x) \
             & f'(x)                 && = cos(x) \
             & f''(x)                && = -sin(x) \
             & f'''(x)               && = -cos(x) \
             & f''''(x)              && = sin(x) \
      dots.v \
             & f^((n)) (x)           && = sin(x) \
             & => abs(f^((n+1)) (x)) && = cases(abs(sin(x)), abs(cos(x))) <= 1 \
             & => m = 1
    $
    $n$ muss so gewählt werden, dass
    $
      1/((n+1)!) (pi/2)^(n+1) <= 0.01 \
    $
  ],
)

==== Rechenregeln Fakultät

$
  (n!)/((n-1)!) = n dot (n - 1) \
  (n!)/((n-2)!) = n dot (n - 1) dot (n - 2) \
  n! dot (n + 1)! = (n + 1)!
$

= Grenzwerte

== Eigentliche Grenzwerte im Unendlichen

Die Zahl $#tp($F$) in RR$ heisst Grenzwert von #td($f(x)$) für $x$ gegen $oo$, wenn für alle #ty($epsilon > 0$) eine "Grenze" #tg($X$) existiert, so dass für alle "noch grössere Zahlen" $x > #tg($X$)$ gilt: $abs(#td($f(x)$) - #tp($F$)) < #ty($epsilon$)$.

$
  forall epsilon in RR: epsilon > 0 and abs(f(x) - F) < epsilon \
  => lim_(x->oo) f(x) = F <=> f(x) -->^(x->oo) F \
$

#obsbox(
  $forall x > X: abs(f(x) - F) < epsilon => lim_(x->oo) f(x) = F$,
  $forall x < X: abs(f(x) - F) < epsilon => lim_(x->-oo) f(x) = F$,
)

#let xs = lq.linspace(-calc.pi, 3 * calc.pi, num: 100)
#let eps = calc.pi / 2 - calc.atan(calc.pi / 2).rad()
#exbox(
  title: $
    #td($f(x)$) = arctan(x), #tp($F$) = pi/2, #tg($X$) = tan(pi/2 - #ty($epsilon$))
  $,
  [#lq.diagram(
      height: 8cm,
      width: 100%,
      title: $
        forall x > tan(pi/2 - epsilon): abs(arctan(x) - pi/2) < epsilon
      $,
      // ylim: (-calc.pi / 2 - 0.2, calc.pi / 2 + 0.2),
      legend: (position: bottom + right),
      yaxis: (
        // tick-distance: calc.pi / 4,
        locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),
        format-ticks: lq.tick-format.linear.with(suffix: $pi$),
      ),
      xaxis: (
        locate-ticks: lq.tick-locate.linear.with(unit: calc.pi),
        format-ticks: lq.tick-format.linear.with(suffix: $pi$),
      ),
      lq.plot(xs, xs.map(x => calc.atan(x).rad()), mark: none, label: $arctan$),
      lq.plot(xs, xs.map(_ => calc.pi / 2), mark: none, label: $pi/2$),
      lq.plot(
        xs,
        xs.map(_ => calc.pi / 2 + eps),
        mark: none,
        stroke: colors.yellow,
        label: $pi/2 plus.minus epsilon$,
      ),
      lq.plot(
        xs,
        xs.map(_ => calc.pi / 2 - eps),
        mark: none,
        stroke: colors.yellow,
      ),
      lq.fill-between(
        xs.filter(x => x > calc.pi / 2),
        xs.filter(x => x > calc.pi / 2).map(_ => calc.pi / 2 + eps),
        y2: xs.filter(x => x > calc.pi / 2).map(_ => calc.pi / 2 - eps),
        fill: shade(stroke: colors.green.transparentize(75%)),
      ),
      lq.line(
        (0.5, calc.pi / 2),
        (0.5, calc.pi / 2 + eps),
        tip: tiptoe.stealth,
        stroke: (paint: colors.yellow, dash: "dashed"),
      ),
      lq.line(
        (0.5, calc.pi / 2),
        (0.5, calc.pi / 2 - eps),
        tip: tiptoe.stealth,
        stroke: (paint: colors.yellow, dash: "dashed"),
      ),
      lq.place(1, (calc.pi + eps) / 2, ty($+ epsilon$)),
      lq.place(1, (calc.pi - eps) / 2, ty($- epsilon$)),
      // lq.plot((calc.pi / 2, calc.pi / 2), (1, 1), mark: mark => place(
      //   center + horizon,
      //   circle(radius: 2pt, fill: colors.green, stroke: colors.green),
      // )),
      lq.line(
        (calc.pi / 2, 0),
        (calc.pi / 2, calc.pi / 2 - eps),
        tip: tiptoe.circle.with(length: 7pt),
        stroke: (paint: colors.green, dash: "dashed"),
      ),
      lq.place(calc.pi / 2, -0.35, text(fill: colors.green)[$X$]),
    )
    $
      lim_(x->oo) arctan(x) = pi / 2 \
      lim_(x->-oo) arctan(x) = - pi / 2 \
    $
  ],
)

#obsbox(
  [$abs(x) - F$ wird kleiner, wenn $x$ grösser wird],
  [Falls $epsilon$ bei $F$ anders gewählt wird, verschiebt sich $X$ aber die Funktionswerte bleiben im Bereich $abs(f(x) - F)$],
  [Falls $F$ anders gewählt wird, kommen Funktionswerte ausserhalb vom erlaubten Bereich],
)

Bei $lim -> oo$ kann man alle Terme, die sich nach $0$ bewegen, ignorieren.

#exbox(
  title: $ lim_(x -> oo) (2x+3)/(x^2-3x+5) $,
  $
    lim_(x -> oo) (2x+3)/(x^2-3x+5) \
    = lim_(x -> oo) (x(2+3/x))/(x^2(1-3/x+5/x^2)) \
    = lim_(x -> oo) 1/x ((2+3/x))/(1-3/x+5/x^2) \
    = 0 dot 2/1 = 0
  $,
)

== Eigentliche Grenzwerte im Endlichen

$lim_(x->#tg($q$)) #td($f(x)$) =$ Wert der stetigen Fortsetzung von $#td($f$) _(| D_f without #tg($q$)) (x)$ an der Stelle $x = #tg($q$)$. #td($f$) ist stetig in #tg($q$) $<=> lim_(x->q) f(x) = f(q)$


#let eps = 5
#let del = .5
#let xs = lq.linspace(-5, 5, num: 100).filter(x => x != 2)
#exbox(
  title: $ f(x) = (x^3 + 3 x^2 - 6 x - 8)/(x - 2) $,
  lq.diagram(
    height: 8cm,
    width: 100%,
    ylim: (-15, 35),
    xlim: (-5, 5),
    lq.plot(
      xs,
      xs.map(x => (calc.pow(x, 3) + 3 * x * x - 6 * x - 8) / (x - 2)),
      mark: none,
    ),
    lq.line(
      (0, 18),
      (2, 18),
      stroke: (paint: colors.green, dash: "dashed"),
    ),
    lq.place(2, -4, text(fill: colors.green)[$q$]),
    lq.line(
      (2, 0),
      (2, 18),
      tip: tiptoe.circle.with(length: 7pt),
      stroke: (paint: colors.green, dash: "dashed"),
    ),
    lq.place(-.5, 18, text(fill: colors.green)[$z$]),
    lq.line(
      (-6, 18 + eps),
      (6, 18 + eps),
      stroke: colors.yellow + 1.5pt,
    ),
    lq.line(
      (-6, 18 - eps),
      (6, 18 - eps),
      stroke: colors.yellow + 1.5pt,
    ),
    lq.line(
      (.5, 18),
      (.5, 18 + eps),
      tip: tiptoe.stealth,
      stroke: (paint: colors.yellow, dash: "dashed"),
    ),
    lq.line(
      (.5, 18),
      (.5, 18 - eps),
      tip: tiptoe.stealth,
      stroke: (paint: colors.yellow, dash: "dashed"),
    ),
    lq.place(1, (18 + eps / 2), ty($+ epsilon$)),
    lq.place(1, (18 - eps / 2), ty($- epsilon$)),

    lq.line(
      (2 - del, -20),
      (2 - del, 50),
      stroke: colors.red + 1.5pt,
    ),
    lq.line(
      (2 + del, -20),
      (2 + del, 50),
      stroke: colors.red + 1.5pt,
    ),
    lq.line(
      (2, 5),
      (2 - del, 5),
      tip: tiptoe.stealth,
      stroke: (paint: colors.red, dash: "dashed"),
    ),
    lq.line(
      (2, 5),
      (2 + del, 5),
      tip: tiptoe.stealth,
      stroke: (paint: colors.red, dash: "dashed"),
    ),
    lq.place((2 + del / 2), 2, tr($+ delta$)),
    lq.place((2 - del / 2), 2, tr($- delta$)),
  ),
)

#exbox(title: $ lim_(x->0) sig^2 (x) = 1 $, grid(
  columns: (35%, 1fr),
  align: center + horizon,
  [
    $
      sig: cases(RR &-> RR, x &|-> cases(+1 &"für" x > 0, 0 &"für" x = 0, -1 &"für" x < 0))
    $
  ],
  lq.diagram(
    width: 10cm,
    height: 5cm,
    ylim: (-1, 2),
    xlim: (-2, 2),
    lq.line((-2, 1), (2, 1), stroke: colors.darkblue + 1.5pt),
    lq.ellipse(
      0,
      1,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.blue.lighten(95%),
    ),
    lq.ellipse(
      0,
      0,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.darkblue,
    ),
  ),
))

#obsbox(
  [$sig^2(x)$ ist an der Stelle $0$ nicht stetig, denn $lim_(x->0) f(x) != f(0)$ ],
  [$lim_(x->0) sig^2(x) = 1$, obwohl der Funktionswert bei $x=0$ nicht $1$ sondern $y=0$ ist.],
)

=== Einseitige Grenzwerte

$lim_(x->0) sig(x)$ existiert nicht. Das ändert sich aber, wenn man den Definitionsbereich auf $RR^+$ oder $RR^-$ einschränkt.

#grid(
  columns: (35%, 1fr),
  align: center + horizon,
  [
    Rechtsseitiger Grenzwert
    $ lim_(x -> 0\ x > 0) sig(x) = lim_(x -> 0+) sig(x) = 1 $

    Linksseitiger Grenzwert
    $ lim_(x -> 0\ x < 0) sig(x) = lim_(x -> 0-) sig(x) = -1 $
  ],
  lq.diagram(
    title: $ sig(x) $,
    width: 10cm,
    height: 5cm,
    ylim: (-2, 2),
    xlim: (-2, 2),
    lq.line((0, 1), (2, 1), stroke: colors.darkblue + 1.5pt),
    lq.line((-2, -1), (0, -1), stroke: colors.darkblue + 1.5pt),
    lq.line((0, 1), (0, -1), stroke: colors.darkblue + 1.5pt),
    lq.ellipse(
      0,
      -1,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.bg,
    ),
    lq.ellipse(
      0,
      1,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.bg,
    ),
    lq.ellipse(
      0,
      0,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.darkblue,
    ),
  ),
)

#obsbox(
  [Wenn sich der rechtsseitige und linksseitige Grenzwert unterscheiden, existiert der beidseitige Grenzwert nicht.],
)

== Rechenregeln

Seien $f(x)$ und $g(x)$ zwei Funktionen und $q in RR union {-oo,oo}$ eine beliebige reelle Zahl oder Unendlich.
$
  lim_(x->q) (c dot f(x)) &= c dot lim_(x->q) f(x) &&, "für" c in RR \
  lim_(x->q) (f(x) + g(x)) &= lim_(x->q) f(x) + lim_(x->q) g(x) \
  lim_(x->q) (f(x) dot g(x)) &= lim_(x->q) f(x) dot lim_(x->q) g(x) \
  lim_(x->q) (f(x) / g(x)) &= (lim_(x->q) f(x)) / (lim_(x->q) g(x)) &&, "falls" lim_(x->q) g(x) != 0 \
  lim_(x->q) (f(x)^(g(x))) &= (lim_(x->q) f(x))^(lim_(x->q) g(x)) &&, "falls" lim_(x->q) f(x) > 0 \
$

All diese Formeln gelten auch für einseitige Grenzwerte.

Gilt $G = lim_(x ->q) g(x)$ (an dieser Stelle ist ein einseitiger Grenzwert nicht ausreichend), so gilt ausserdem:
$ lim_(x->q) f(g(x)) lim_(g->G) f(g) $
falls der Grenzwert auf der rechten Seite existiert.

== Uneigentliche Grenzwerte im Endlichen

$ lim_(x -> q) f(x) = oo $

Für jedes $S in RR$ gibt es ein $delta > 0$, so dass $forall x : 0 < abs(x - q) < delta : f(x) > S$


#let xs = lq.linspace(-2, 6, num: 100).filter(x => x != 2)
#let del = .75
#let xs11 = xs.filter(x => x < 2 - del)
#let xs12 = xs.filter(x => x > 2 + del)
#let xs2 = xs.filter(x => x >= 2 - del - .05 and x <= 2 + del + .05)
#let fn = x => (calc.pow((x - 1), 2) - 2 * x + 10) / (calc.pow(x - 2, 2))
#let y = fn(2 - del)
#exbox(
  title: $
    f(x) = ((x-1)^2 - 2 x + 10)/((x-2)^2)
  $,
  lq.diagram(
    height: 8cm,
    width: 100%,
    ylim: (0, 30),
    lq.plot(
      xs2,
      xs2.map(fn),
      mark: none,
      stroke: colors.red + 2pt,
    ),
    lq.plot(
      xs11,
      xs11.map(fn),
      mark: none,
      stroke: colors.darkblue,
    ),
    lq.plot(
      xs12,
      xs12.map(fn),
      mark: none,
      stroke: colors.darkblue,
    ),
    lq.line((2, 0), (2, 30), stroke: (
      paint: colors.green,
      dash: "dashed",
    )),
    lq.place(
      2,
      -2.5,
      tg($q$),
    ),
    lq.line((2 - del, 0), (2 - del, fn(2 - del)), stroke: (
      paint: colors.red,
      dash: "dashed",
    )),
    lq.line((2 + del, 0), (2 + del, fn(2 + del)), stroke: (
      paint: colors.red,
      dash: "dashed",
    )),
    lq.line((-2, y), (6, y), stroke: (
      paint: colors.red,
      dash: "dashed",
    )),
    lq.line(
      (-1, y),
      (-1, 30),
      stroke: (paint: colors.red),
      tip: tiptoe.stealth,
    ),
    lq.place(
      -2.2,
      y,
      tr($S$),
    ),
    lq.line(
      (2, 5),
      (2 - del, 5),
      tip: tiptoe.stealth,
      stroke: (paint: colors.red, dash: "dashed"),
    ),
    lq.line(
      (2, 5),
      (2 + del, 5),
      tip: tiptoe.stealth,
      stroke: (paint: colors.red, dash: "dashed"),
    ),
    lq.place((2 + del / 2), 2, tr($+ delta$)),
    lq.place((2 - del / 2), 2, tr($- delta$)),
    lq.fill-between(
      xs,
      xs.map(_ => y),
      y2: xs.map(_ => 30),
      fill: shade(stroke: colors.red.transparentize(75%)),
    ),
  ),
)

#obsbox(
  [
    Für sehr grosse Argumente sind Funktionswerte sehr gross.
    $ forall x > X : f(x) > S => lim_(x->oo) f(x) = oo $
  ],
  [
    Für sehr grosse Argumente sind Funktionswerte stark negativ.
    $ forall x > X : f(x) < S => lim_(x->oo) f(x) = -oo $
  ],
  [
    Für stark negative Argumente sind Funktionswerte sehr gross.
    $ forall x < X : f(x) > S => lim_(x->-oo) f(x) = oo $
  ],
  [
    Für stark negative Argumente sind Funktionswerte stark negativ.
    $ forall x < X : f(x) < S => lim_(x->-oo) f(x) = -oo $
  ],
)

== Satz von Bernoulli und l'Hospital

Voraussetzung: Typ "$0/0$" (Zähler und Nenner streben gegen $0$) oder Typ "$oo/oo$"

Typ "$0/0$": $lim_(x-> a) f(x) = lim_(x-> a) g(x) = 0$

Typ "$oo/oo$": $lim_(x-> a) g(x) = oo or lim_(x-> a) g(x) = -oo$

Ableitung *ohne quotientenregel* (heisst, Zähler und Nenner separat ableiten) gibt dasselbe Resultat für den limes.

$
  lim_(x->a) f(x)/g(x) =^"Voraussetzung prüfen" lim_(x->a) (f'(x))/(g'(x))\
  a in RR union {oo,-oo} \
$

Beweis für $a in RR$, Typ $0/0$:

Linearisierung von $f$ und $g$ um $x = a$: $ &f(x) approx f(a) + f'(a) (x-a) \
&g(x) approx g(a) + g'(a) (x-a) \
&f(x)/g(x) approx (f(a) + f'(a) (x-a))/(g(a) + g'(a) (x-a)) \
&#tg($lim_(x -> a)$) f(x)/g(x) #tg($= lim_(x -> a)$) (cancel(f(a)) + f'(a) cancel((x-a)))/(cancel(g(a)) + g'(a) cancel((x-a))) && | f(x) -> 0 => f(a) = 0 \ $

#exbox(
  $
    & lim_(x->pi/2) overbrace(1 - sin(x), 0)/underbrace(2x - pi, 0)
      = & lim_(x->pi/2) (-cos(x))/2
          = & (-cos(pi/2))/2 = 0
  $,
)

Einen Grenzwert vom Typ $oo dot 0$ kann man mit der Umformung
$
  f(x) dot g(x) = f(x)/(1/g(x))
$
in den typ $oo/oo$ überführen, oder durch die Umformung
$
  f(x) dot g(x) = g(x)/(1/f(x))
$
auf die Form $0/0$ bringen.

== Rechnen mit unendlich grossen "Zahlen"

#align(center, table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  table-header($$, $z=-oo$, $-oo<z<0$, $z=0-$, $z=0+$, $0<z<oo$, $z=oo$),
  emph($z+oo=oo+z$),
  $?$,
  $oo$,
  $oo$,
  $oo$,
  $oo$,

  $oo$, emph($oo-z$), $oo$, $oo$, $oo$, $oo$, $oo$,
  $?$, emph($z-oo$), $-oo$, $-oo$, $-oo$, $-oo$, $-oo$,
  $?$, emph($z dot oo = oo dot z$), $-oo$, $-oo$, [B/L\*], [B/L\*], $oo$,
  $oo$, emph($oo/z$), [B/L], $-oo$, $-oo$, $oo$, $oo$,
  [B/L], emph($z/oo$), [B/L], $0-$, $0-$, $0+$, $0+$,
  [B/L], emph($z/(0+)$), $-oo$, $-oo$, [B/L], [B/L], $oo$,
  $oo$, emph($z/(0-)$), $oo$, $oo$, [B/L], [B/L], $-oo$,
  $-oo$,
))
\* Mit umformen

= Ableitung

#todo("polish, notes 28")

Differenzenquotient $(f(x) - f(x_0))/(x-x_0)$

#let xs = lq.linspace(-2, 3)
#lq.diagram(
  title: "steigung",
  lq.plot(xs, xs.map(x => x * x), mark: none),
  lq.place(1, 0, $x_0$),
  lq.place(2, 0, $x$),
  lq.place(1.5, 0, $<-$),
  lq.line((1, 1), (2, 4)),
  lq.line((1, 1), (2, 1), label: $x - x_0$, stroke: red),
  lq.line((2, 1), (2, 4), label: $f(x) - f(x_0)$, stroke: yellow),
  lq.line(
    (0, 4),
    (2, 4),
    stroke: (paint: green, dash: "dashed"),
    label: $f(x)$,
  ),
  lq.line(
    (0, 1),
    (1, 1),
    stroke: (paint: purple, dash: "dashed"),
    label: $f(x_0)$,
  ),
)

Differentialquotient $f'(x_0) = lr((dif f)/(dif x) |)_(x=x_0) = lim_(x-> x_0) (f(x) - f(x_0))/(x-x_0)$

= Interpolation durch Splines und Polynome

== Notizen

Recherchieren: Logistische regression

#todo("zusammenfassung diagramme FuelPerHour/SpeedOnSurface") (Fit mit Splines vs Fit mit Parabeln $a + b x + c x^2$)

Glossar: Kostenfunktion

== Bsp

Gegeben: Trainingsdaten = Wertetabelle

Ziel: Vorhersage der $y$ Werte durch $x$ in Form einer Funktion $y = f(x)$

#table(
  columns: 5,
  table-header($x$, $0$, $3$, $5$, []), tr[$y$], tr[$80$], tr[$90$], tr[$105$],
  [$<-$ gemessene Werte], tg[$f(x)$], tg[$f(0)$], tg[$f(3)$], tg[$f(5)$],
  [$<-$ vorhergesagte Werte],
  [Residuen],
  $#tg($f(0)$) - #tr($80$)$,
  $#tg($f(3)$) - #tr($90$)$,
  $#tg($f(5)$) - #tr($105$)$,

  [$<-$ "Güte" der Vorhersage],
)

Kostenfunktion: $(f(0) - 80)^2 + (f(3) - 90)^2 + (f(5) - 105)^2 = "RSS"$

Definition des Suchraums: Linearkombinationen einer vorgegebenen Liste von "Basisfunktionen"

#exbox(title: "Schiffsfahrt", [
  #let xs = (0, 3, 5, 7.5, 8, 11, 14, 18, 20, 22)
  #let ys = (80, 90, 105, 140, 131, 162, 197, 251, 280, 310)
  #let xs2 = lq.linspace(0, 22, num: 200)
  #grid(
    columns: xs.len() + 1,
    [SpeedOnSurface ($x_i$)], ..xs.map(x => [#x]),
    [FuelPerHour ($y_i$)], ..ys.map(x => [#x]),
  )
  #todo("")
  #let (m, b) = linear-regression(xs, ys)
  #lq.diagram(
    title: "Kubische interpolation",
    xaxis: (position: 80),
    lq.plot(xs, ys, stroke: none, mark-size: .5em),
  )
  #lq.diagram(
    title: "Lineare Regression mit quadratischer Basis",
    xaxis: (position: 80),
    lq.plot(xs, ys, stroke: none, mark-size: .5em),
    // lq.plot(xs2, xs2.map(x => x * m + b), mark: none),
  )
])

== Methode der kleinsten Quadrate

#deftbl(
  [Residuum],
  $r_i = f(x_i) - y_i$,
  [Quadratischer Fehler],
  $r^2_i = (f(x_i) - y_i)^2$,
  [Unabhängige Variable],
  [\= Prädiktorvariable

    Variable $x$ in der Funktion $y = f(x)$
  ],
  [Abhängige Variable],
  [\= Responsevariable

    Variable $y$ in der Funktion $y = f(x)$
  ],
  [Gesamtfehler],
  $ R S S = sum_(i=0)^(N - 1) (f(x_i) - y_i)^2 $,
)

== Linearer Ansatz mit Basisfunktionen

#deftbl(
  [Modellfunktion],
  [],
  [Basisfunktion],
  [],
  [Regressionskoeffizient],
  [],
  [Unkorrelierte Stichprobenvarianz],
  [],
  [Unkorrelierte Stichprobenkovarianz],
  [],
)
