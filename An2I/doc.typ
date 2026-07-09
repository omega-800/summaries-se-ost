#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Taylorpolynom

Dient zur Approximation von Funktionen durch Polynome. Innerhalb vom
Konvergenzradius sind Funktionen immer durch unendliche Polynome perfekt
approximierbar.

== Berechnung

Jede Ableitung ist die nächste Unbekannte:
$
  & p(x) = && #tp($a_0$) && + #tp($a_1$) (x - x_0) && + #tp($a_2$) (x - x_0)^2 && + #tp($a_3$) (x - x_0)^3 \
  & p'(x) = && #td(0) && + #tp($a_1$) 1 && + #tp($a_2$) 2(x - x_0) && + #tp($a_3$) 3(x - x_0)^2 \
  & p''(x) = && #td(0) && + #td(0) && + #tp($a_2$) 2 && + #tp($a_3$) 6(x - x_0) \
  & p'''(x) = && #td(0) && + #td(0) && + #td(0) && + #tp($a_3$) 6 \
  & p''''(x) = && #td(0) && + #td(0) && + #td(0) && + #td(0) \
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

  NR:
  $
    p(x) = 3x^3 - 2x^5 \
    p'(x) = 9x^2 - 2
  $
  Linearisierung:
  $
    p(x_0) = 3x_0^3 - 2x_0^5 = 3 - 2 + 5 = 6\
    p'(x_0) = 9x_0^2 - 2 = 9 - 2 = 7
  $
  Ergo: $p(x) approx 6 + 7(x-1)$ = Taylor-Polynom von Grad 1 \
  Taylor-Polynom von Grad 3:
  $p(x) approx underbrace(6 + 7(x-1), "Linearisierung") + ? (x-1)^2 + ? (x-1)^3$
  \
  $
    & p(x_0) && = 3x_0^3 - 2x_0^5 = 3 - 2 + 5 && = 6 && = a_0 && => a_0 = 6 \
    & p'(x_0) && = 9x_0^2 - 2 = 9 - 2 && = 7 && = 1 dot a_1 && => a_1 = 7 \
    & p''(x_0) && = 18x_0 && = 18 && = 1 dot 2 dot a_2 && => a_2 = 9 \
    & p'''(x_0) && = 18 && && = 1 dot 2 dot 3 dot a_3 && => a_3 = 3 \
  $
  Gibt uns:
  $ p(x) approx 6 + 7(x-1) + 9(x-1)^2 + 3(x-1)^3 $
])

== Generalisierung

Für ein Polynom $p(x)$ vom Grad $n$ und einem Entwicklungspunkt $x_0$ gilt:
$ p(x) = sum_(k=0)^n (p^((k)) (x_0)) / (k!) (x-x_0)^k $
Für eine Funktion #td($f(x)$) und einen EWP $x_0$ heisst
$ sum_(k=0)^n (#td($f$)^((k)) (x_0))/(k!) (x-x_0)^k $
Taylor-Polynom von Grad $n$ für $f(x)$ um EWP $x_0$

#let xs = lq.linspace(-3 * calc.pi, 3 * calc.pi, num: 100)
#exbox(title: $#td($f(x)$) = sin(x), x_0 = 0$, diagram2d(
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
  [In der Nähe des EWP $x_0$ gilt
    $f(x) approx sum_(k=0)^n (f^((k)) (x_0))/(k!) (x-x_0)^k$
  ],
  [Je grösser $n$ ist, umso kleiner ist der Unterschied der beiden Seiten],
  [Der Unterschied ist umso kleiner, je näher $x$ bei $x_0$ liegt],
)

#block(breakable: false, exbox(title: [$f(x) = e^x$, EWP $x_0 = 0$], [
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
]))

== Taylorreihe

Die Taylor-Reihe von $f(x)$ um den Entwicklungspunkt $x_0$ ist
$ sum_(k=0)^#tp($oo$) (p^((k)) (x_0)) / (k!) (x-x_0)^k $
Es gibt eine Zahl $R>0$, so dass
$f(x) = sum_(k=0)^oo (p^((k)) (x_0)) / (k!) (x-x_0)^k$, für $abs(x-x_0) < R$ \
($R$ = Konvergenzradius)

== Fehlerabschätzungen

Wie weit liegt der vom Taylor-Polynom mit Grad $n$ vorhergesagte Funktionswert
vom richtigen Wert entfernt? \

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
  canvas({
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
    Gegeben: $f(x) = sin(x)$ auf $I = [0;pi]$ durch Taylor-Polynom mit
    Rechenfehler $Delta = 0.01$. berechnet werde: $x_0 = pi/2$
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
    (n!)/((n-1)!) = & n dot (n - 1) \
    (n!)/((n-2)!) = & n dot (n - 1) dot (n - 2) \
  n! dot (n + 1)! = & (n + 1)!
$

= Grenzwerte

== Eigentliche Grenzwerte im Unendlichen

Die Zahl $#tp($F$) in RR$ heisst Grenzwert von #td($f(x)$) für $x$ gegen $oo$,
wenn für alle #ty($epsilon > 0$) eine "Grenze" #tg($X$) existiert, so dass für
alle "noch grössere Zahlen" $x > #tg($X$)$ gilt:
$abs(#td($f(x)$) - #tp($F$)) < #ty($epsilon$)$.

$
  exis(F, fora(epsilon in RR, epsilon > 0 and abs(f(x) - F) < epsilon))
  => lim_(x->oo) f(x) = F <=> f(x) -->^(x->oo) F \
$

#obsbox(
  $fora(x > X, abs(f(x) - F) < epsilon => lim_(x->oo) f(x) = F)$,
  $fora(x < X, abs(f(x) - F) < epsilon => lim_(x->-oo) f(x) = F)$,
)

#let xs = lq.linspace(-calc.pi, 3 * calc.pi, num: 100)
#let eps = calc.pi / 2 - calc.atan(calc.pi / 2).rad()
#exbox(
  title: $
    #td($f(x)$) = arctan(x), #tp($F$) = pi/2, #tg($X$) = tan(pi/2 - #ty($epsilon$))
  $,
  [#diagram2d(
      height: 8cm,
      width: 100%,
      title: $
        fora(x > tan(pi/2 - epsilon), abs(arctan(x) - pi/2) < epsilon)
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
  [Falls $epsilon$ bei $F$ anders gewählt wird, verschiebt sich $X$ aber die
    Funktionswerte bleiben im Bereich $abs(f(x) - F)$],
  [Falls $F$ anders gewählt wird, kommen Funktionswerte ausserhalb vom erlaubten
    Bereich],
)

Bei $lim -> oo$ kann man alle Terme, die sich nach $0$ bewegen, ignorieren.

#exbox(
  title: $ lim_(x -> oo) (2x+3)/(x^2-3x+5) $,
  $
    lim_(x -> oo) (2x+3)/(x^2-3x+5) \
                                  = & lim_(x -> oo) (x(2+3/x))/(x^2(1-3/x+5/x^2)) \
                                  = & lim_(x -> oo) 1/x ((2+3/x))/(1-3/x+5/x^2) \
                                  = & 0 dot 2/1 = 0
  $,
)

== Eigentliche Grenzwerte im Endlichen

$lim_(x->#tg($q$)) #td($f(x)$) =$ Wert der stetigen Fortsetzung von
$#td($f$) _(| D_f without #tg($q$)) (x)$ an der Stelle $x = #tg($q$)$. #td($f$)
ist stetig in #tg($q$) $<=> lim_(x->q) f(x) = f(q)$


#let eps = 5
#let del = .5
#let xs = lq.linspace(-5, 5, num: 100).filter(x => x != 2)
#exbox(
  title: $ f(x) = (x^3 + 3 x^2 - 6 x - 8)/(x - 2) $,
  diagram2d(
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

#block(breakable: false, exbox(title: $ lim_(x->0) sig^2 (x) = 1 $, grid(
  columns: (35%, 1fr),
  align: center + horizon,
  [
    $
      sig: cases(RR &-> RR, x &|-> cases(+1 &"für" x > 0, 0 &"für" x = 0, -1 &"für" x < 0))
    $
  ],
  diagram2d(
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
)))

#obsbox(
  [$sig^2(x)$ ist an der Stelle $0$ nicht stetig, denn $lim_(x->0) f(x) != f(0)$
  ],
  [$lim_(x->0) sig^2(x) = 1$, obwohl der Funktionswert bei $x=0$ nicht $1$
    sondern $y=0$ ist.],
)

=== Einseitige Grenzwerte

$lim_(x->0) sig(x)$ existiert nicht. Das ändert sich aber, wenn man den
Definitionsbereich auf $RR^+$ oder $RR^-$ einschränkt.

#grid(
  columns: (35%, 1fr),
  align: center + horizon,
  [
    Rechtsseitiger Grenzwert
    $ lim_(x -> 0\ x > 0) sig(x) = lim_(x -> 0+) sig(x) = 1 $

    Linksseitiger Grenzwert
    $ lim_(x -> 0\ x < 0) sig(x) = lim_(x -> 0-) sig(x) = -1 $
  ],
  diagram2d(
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
  [Wenn sich der rechtsseitige und linksseitige Grenzwert unterscheiden,
    existiert der beidseitige Grenzwert nicht.],
)

== Rechenregeln

Seien $f(x)$ und $g(x)$ zwei Funktionen und $q in RR union {-oo,oo}$ eine
beliebige reelle Zahl oder Unendlich.
$
  lim_(x->q) (c dot f(x)) & = c dot lim_(x->q) f(x) && "für" c in RR \
  lim_(x->q) (f(x) + g(x)) & = lim_(x->q) f(x) + lim_(x->q) g(x) \
  lim_(x->q) (f(x) dot g(x)) & = lim_(x->q) f(x) dot lim_(x->q) g(x) \
  lim_(x->q) (f(x) / g(x)) & = (lim_(x->q) f(x)) / (lim_(x->q) g(x)) && "falls" lim_(x->q) g(x) != 0 \
  lim_(x->q) (f(x)^(g(x))) & = (lim_(x->q) f(x))^(lim_(x->q) g(x)) && "falls" lim_(x->q) f(x) > 0 \
$

All diese Formeln gelten auch für einseitige Grenzwerte.

Gilt $G = lim_(x ->q) g(x)$ (an dieser Stelle ist ein einseitiger Grenzwert
nicht ausreichend), so gilt ausserdem:
$ lim_(x->q) f(g(x)) lim_(g->G) f(g) $
falls der Grenzwert auf der rechten Seite existiert.

== Uneigentliche Grenzwerte im Endlichen

$ lim_(x -> q) f(x) = oo $

Für jedes $S in RR$ gibt es ein $delta > 0$, so dass
$fora(x\, 0 < abs(x - q) < delta, f(x) > S)$


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
  diagram2d(
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
    $ fora(x > X, f(x) > S => lim_(x->oo) f(x) = oo) $
  ],
  [
    Für sehr grosse Argumente sind Funktionswerte stark negativ.
    $ fora(x > X, f(x) < S => lim_(x->oo) f(x) = -oo) $
  ],
  [
    Für stark negative Argumente sind Funktionswerte sehr gross.
    $ fora(x < X, f(x) > S => lim_(x->-oo) f(x) = oo) $
  ],
  [
    Für stark negative Argumente sind Funktionswerte stark negativ.
    $ fora(x < X, f(x) < S => lim_(x->-oo) f(x) = -oo) $
  ],
)

== Satz von Bernoulli und l'Hospital

Voraussetzung: Typ "$0/0$" (Zähler und Nenner streben gegen $0$) oder Typ
"$oo/oo$"

Typ "$0/0$": $lim_(x-> a) f(x) = lim_(x-> a) g(x) = 0$

Typ "$oo/oo$": $lim_(x-> a) g(x) = oo or lim_(x-> a) g(x) = -oo$

Ableitung *ohne quotientenregel* (heisst, Zähler und Nenner separat ableiten)
gibt dasselbe Resultat für den limes.

$
  lim_(x->a) f(x)/g(x) =^"Voraussetzung prüfen" lim_(x->a) (f'(x))/(g'(x))\
  a in RR union {oo,-oo} \
$

Beweis für $a in RR$, Typ $0/0$:

Linearisierung von $f$ und $g$ um $x = a$:
$
  &f(x) approx f(a) + f'(a) (x-a) \
  &g(x) approx g(a) + g'(a) (x-a) \
  &f(x)/g(x) approx (f(a) + f'(a) (x-a))/(g(a) + g'(a) (x-a)) \
  &#tg($lim_(x -> a)$) f(x)/g(x) #tg($= lim_(x -> a)$) (cancel(f(a)) + f'(a) cancel((x-a)))/(cancel(g(a)) + g'(a) cancel((x-a))) && | f(x) -> 0 => f(a) = 0 \
$

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

// = Ableitung
//
// #todo("polish, notes 28")
//
// Differenzenquotient $(f(x) - f(x_0))/(x-x_0)$
//
// #let xs = lq.linspace(-2, 3)
// #diagram2d(
//   xlim: (-2.5, 6),
//   width: 75%,
//   title: "steigung",
//   lq.plot(xs, xs.map(x => x * x), mark: none),
//   lq.place(1, 0, $x_0$),
//   lq.place(2, 0, $x$),
//   lq.place(1.5, 0, $<-$),
//   lq.line((1, 1), (2, 4)),
//   lq.line((1, 1), (2, 1), label: $x - x_0$, stroke: red),
//   lq.line((2, 1), (2, 4), label: $f(x) - f(x_0)$, stroke: yellow),
//   lq.line(
//     (0, 4),
//     (2, 4),
//     stroke: (paint: green, dash: "dashed"),
//     label: $f(x)$,
//   ),
//   lq.line(
//     (0, 1),
//     (1, 1),
//     stroke: (paint: purple, dash: "dashed"),
//     label: $f(x_0)$,
//   ),
// )

Differentialquotient
$f'(x_0) = lr((dif f)/(dif x) |)_(x=x_0) = lim_(x-> x_0) (f(x) - f(x_0))/(x-x_0)$

#defbox("Ableitung definiert durch Grenzwerte", [
  Eine in $x_0$ stetige Funktion $f$ ist genau dann in $x_0$ differenzierbar,
  wenn einer (und damit beide) der folgenden Grenzwerte existieren. Der Wert
  dieser Grenzwerte ist dann identisch dem Wert der Ableitung von $f$ and der
  Stelle $x_0$:
  $
    f'(x_0) = lim_(x->x_0) (f(x) - f(x_0))/(x - x_0) = lim_(h->0) (f(x_0 + h) -
    f(x_0))/h
  $
])

= Interpolation

#deftbl(
  [Interpolation],
  [
    - Füllt Lücken in einer Wertetabelle
    - Benötigt kein Systemverständnis
    // #todo("diagram")
  ],
  [Extrapolation],
  [
    - Dehnt den Definitionsbereich der Funktion über den Messbereich hinaus aus
    - Benötigt Systemverständnis. Beispiel: Klimamodelle
    // #todo("diagram")
  ],
)

// #todo[
//   Recherchieren: Logistische regression
//
//   Glossar: Kostenfunktion
//
//   Fit mit Splines vs Fit mit Parabeln $a + b x + c x^2$
// ]

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
  [Quadrat Fehler],
  $(#tg($f(0)$) - #tr($80$) )^2$,
  $(#tg($f(3)$) - #tr($90$) )^2$,
  $(#tg($f(5)$) - #tr($105$))^2$,

  [$<-$ Schafft Vorzeichen weg],
)

Kostenfunktion:
$(#tg($f(0)$) - #tr($80$) )^2 + (#tg($f(3)$) - #tr($90$) )^2 + (#tg($f(5)$) - #tr($105$))^2 = RSS$

Definition des Suchraums: Linearkombinationen einer vorgegebenen Liste von
"Basisfunktionen"

// #exbox(title: "Schiffsfahrt", [
//   #let xs = (0, 3, 5, 7.5, 8, 11, 14, 18, 20, 22)
//   #let ys = (80, 90, 105, 140, 131, 162, 197, 251, 280, 310)
//   #let xs2 = lq.linspace(0, 22, num: 200)
//   #grid(
//     columns: xs.len() + 1,
//     [SpeedOnSurface ($x_i$)], ..xs.map(x => [#x]),
//     [FuelPerHour ($y_i$)], ..ys.map(x => [#x]),
//   )
//   #todo("")
//   #let (m, b) = linear-regression(xs, ys)
//   #diagram2d(
//     title: "Kubische interpolation",
//     xaxis: (position: 80),
//     lq.plot(xs, ys, stroke: none, mark-size: .5em),
//   )
//   #diagram2d(
//     title: "Lineare Regression mit quadratischer Basis",
//     xaxis: (position: 80),
//     lq.plot(xs, ys, stroke: none, mark-size: .5em),
//     // lq.plot(xs2, xs2.map(x => m * x + b), mark: none),
//   )
// ])

== Methode der kleinsten Quadrate (RSS)

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
  [
    \= Residual Sum of Squares
    #context shared.rss-def
  ],
)

#context shared.rss-ex

== Lineare Regression

#deftbl(
  [Basisfunktionen],
  [Raum der "besonders einfachen Funktionen"
    $ b_1 (x), b_2 (x), ..., b_(n) (x) $],
  [Modellfunktionen],
  [Linearkombinationen aus Basisfunktionen
    $ lambda_1 b_1 (x), lambda_2 b_2 (x), ..., lambda_n b_(n) (x) $],
  [Regressionskoeffizient],
  [Konstanten $lambda_k$ der Modellfunktionen],
  [Mittelwert],
  $ overline(x) = 1/N sum_(i=0)^(N-1) x_i $,
  [Unkorrigierte Stichprobenvarianz\ der Variable $x$],
  $ sigma^2 = 1/N sum_(i=0)^(N-1) x_i^2 - overline(x)^2 $,
  [Unkorrigierte Stichprobenkovarianz\ der Variablen $x$ und $y$],
  $ "var"(x,y) = 1/N sum_(i=0)^(N-1) x_i y_i - overline(x) dot overline(y) $,
)

// #todo[Examples (19.03.26)]

Ziel ist es, eine *besonders einfache* Funktion (_Modellfunktion_) zu finden,
die eine Wertetabelle am besten interpoliert. *"Am besten" $!=$ exakt!*

Zentral ist, dass die Ergebnisfunktionen eine einfache Struktur aufweist.

Genauer: Die Ergebnisfunktion muss eine *Linearkombinationen* (=gewichtete
Summe) von *wählbaren* _Basisfunktionen_ $b_1 (x) ... b_n (x)$ d.h. von der Form
$f(x) = sum_(k=1)^n lambda_k dot b_k (x)$ sein.

Die Gewichte $lambda_k$ heissen _Regressionskoeffizienten_

Alternativ (Vereinfacht): Gesucht sind die Zahlen $lambda_1 ... lambda_n$ , für
die $f(x) = sum_(k=1)^n lambda_k dot b_k (x)$ die Einträge der Wertetabelle am
genauesten wiedergibt (= den RSS minimiert)

// $
//   sum_(i=1)^"# Messwerte" (sum_(k=1)^n lambda_k dot b_k (x_i) - y_i)^2 \
//   -> lambda "sind die Unbekannten"
// $

_Gegeben_

#table(
  columns: (1fr, 1fr),
  align: center + horizon,
  table-header([Wertetabelle], [Geeignete Funktionen]),
  grid(
    columns: 6,
    gutter: 0pt,
    stroke: colors.fg,
    inset: .5em,
    emph[$x$], $x_0$, $x_1$, $x_2$, $...$, $x_(N-1)$,
    emph[$y$], $y_0$, $y_1$, $y_2$, $...$, $y_(N-1)$,
  ),

  $ b_0 (x), ..., b_(m-1) (x) $,
)

_Aufgabe_

Bestimme die besten Regressionsparameter der Modellfunktion
$ f(x) = sum_(k=0)^(m - 1) underbrace(lambda_k, "gesucht") b_k (x) $ <eq-rp-mf>

_Methode_

Bestimme das globale Minimum des von $lambda_k$ abhängigen quadratischen Fehlers
$
  RSS = sum_(i = 0)^(N - 1) (f(x_i) - y_i)^2 = sum_(i = 0)^(N - 1) ( sum_(k = 0)^(m-1) lambda_k b_k (x_i) - y_i)^2
$ <eq-rss>

#exbox(title: "Ausgleichsgerade", [
  #table(
    columns: (1fr, 1fr, 2fr),
    [Modellfunktionen ], [Basisfunktionen], [Regressionskoeffizienten],
    $ f(x) = m dot x + b $,
    $ b_0 (x) = x \ b_1 (x) = 1 $,
    $ RSS (b, m) = sum_(i = 0)^(N - 1) (m dot x_i + b - y_i)^2 $,
  )

  // Frage: Welche Gerade $f(x) = m x + b$ passt am besten zur Wertetabelle
  Ziel: Minimiere RSS

  Stationäre Stellen von $RSS = RSS (m,b)$
  $
    (dif RSS)/(dif b) = &sum_(i=0)^(N-1) 2 (m x_i + b - y_i) = 2 dot ((sum_(i=0)^(N-1) m x_i) + (sum_(i=0)^(N-1) b) - (sum_(i=0)^(N-1) y_i)) \ =^! 0
    <=>&(sum_(i=0)^(N-1) x_i) m + N dot b = sum_(i=0)^(N-1) y_i && | div N\
    <=>&underbrace(
      (1/N sum_(i=0)^(N-1) x_i), #[Mittelwert aller
        $x$-Werte]
    ) m + b = underbrace(1/N sum_(i=0)^(N-1) y_i, #[Mittelwert aller $y$-Werte])\
    <=> &overline(x) dot m + b = overline(y) \
    (dif RSS )/(dif m) = &sum_(i=0)^(N - 1) 2(m x_i + b - y_i) x_i = 2((sum_(i=0)^(N - 1) m x_i^2) + (sum_(i=0)^(N - 1) b x_i) - (sum_(i=0)^(N - 1) y_i x_i))\ =^! 0
    <=> &(sum_(i=0)^(N - 1) x_i^2) m + (sum_(i=0)^(N - 1) x_i) b = (sum_(i=0)^(N - 1) y_i x_i) && | div N \
    <=> &underbrace(
      (1/N sum_(i=0)^(N - 1) x_i^2), #[Mittelwert aller $x$-Quadrate]
    ) m + (1/N sum_(i=0)^(N - 1) x_i) b = underbrace(
      (1/N sum_(i=0)^(N - 1) y_i x_i), #[Mittelwert der $x$-$y$-Produkte]
    )\
    <=> &(sigma^2 + overline(x)^2) dot m + overline(x) dot b = "var"(x,y) + overline(x) dot overline(y)\
    => &m sigma^2 = "var"(x,y) \
    => &m = "var"(x,y)/sigma^2 \
    => &b = overline(y) - m overline(x) \
    // &cases(
    //   reverse: #true, mat(
    //     augment: #2,
    //     overline(x), 1, overline(y);
    //     underbrace(overline(x^2), m), underbrace(overline(x), b), overline(x dot y);
    //   ) ~>
    //   mat(
    //     augment: #2,
    //     overline(x), 1, overline(y);
    //     underbrace(overline(x^2) - overline(x)^2, #[Varianz $"var"(x)$]), 0, underbrace(overline(x dot y) - overline(x) dot overline(y), "var"(x dot y));
    //   )
    // )
    // => cases(b = overline(y) - overline(x) dot m, m = ("var"(x,y))/("var"(x)))
  $
])

=== Generalisierung

Das Ziel der linearen Regression ist es, die Regressionskoeffizienten so zu
bestimmen, dass die Wertetabelle möglichst genau wiedergegeben wird, d.h. dass

$
  fora(i in [0;N-1], y_i approx y_i^"berechnet" = sum_(k=0)^(m-1) lambda_k b_k (x_i))
$ <eq-lr-gen>

Eine lineare Regression kann durchgeführt werden, sobald $N >= m$ Datensätze
$(x_i, y_i)$ vorliegen.

Eine geschlossene Formel für die Regressionskoeffizienten zu finden verlangt
Matrizenrechnung. Die Daten und Basisfunktionen können wie folgt in Matrizenform
dargestellt werden:

#grid(
  gutter: 1pt,
  align: center + horizon,
  columns: (1fr, auto, auto),
  emph[Wertetabelle], emph[Designmatrix], emph[Ergebnis-\ vektor],
  table(
    stroke: (x, y) => (
      left: if y < 5 and (x == 1 or x == 5) { 0.07em },
      top: if y == 1 { 0.07em },
    ),
    columns: (.5fr, 1fr, 1fr, .25fr, 1fr, .5fr),
    $x$, $b_0 (x)$, $b_1 (x)$, $...$, $b_(m-1) (x)$, $y$,
    $x_0$, $b_0 (x_0)$, $b_1 (x_0)$, $dots$, $b_(m-1) (x_0)$, $y_0$,
    $x_1$, $b_0 (x_1)$, $b_1 (x_1)$, $dots$, $b_(m-1) (x_1)$, $y_1$,
    $dots.v$, $dots.v$, $dots.v$, $dots.down$, $dots.v$, $dots.v$,
    $x_(N-1)$,
    $b_0 (x_(N-1))$,
    $b_1 (x_(N-1))$,
    $dots$,
    $b_(m-1) (x_(N-1))$,
    $y_(N-1)$,
    $$,
    table.cell(colspan: 4, align(
      center,
      $
        underbrace(#box(width: 100%, [ ]))\
        (N times m)" - Matrix"
      $,
    )),
    $$,
  ),
  $
    B = \ mat(
      b_0 (x_0), b_1 (x_0), dots, b_(m-1) (x_0);
      b_0 (x_1), b_1 (x_1), dots, b_(m-1) (x_1);
      dots.v, dots.v, dots.down, dots.v;
      b_0 (x_(N-1)), b_1 (x_(N-1)), dots, b_(m-1) (x_(N-1))
    )
  $,
  $
    ve(y) = \ vec(y_0, y_1, dots.v, y_(N-1))
  $,
)

Zusätzlich definiert man den _Koeffizientenvektor_
$
  ve(lambda) = vec(lambda_0, lambda_1, dots.v, lambda_(m-1))
$
wodurch die @eq-lr-gen in eine Matrixgleichung umgeschrieben werden kann:
$
  underbrace(ve(y), in RR^N) approx underbrace(B, in RR^(N times m)) dot underbrace(ve(lambda), in RR^m)
$
Auch der RSS (@eq-rss) lässt sich nun in Matrixform darstellen:
$
  RSS = (ve(y) - B dot ve(lambda))^2 = (ve(y) - B dot ve(lambda)) prod (ve(y) - B dot ve(lambda))
$
Ferner: Die Modellfunktion der @eq-rp-mf minimiert den quadratischen Fehler
$RSS$ genau dann, wenn der Koeffizientenvektor $ve(lambda)$ eine Lösung der
Gleichung
$
  B^top ve(y) = & B^top B ve(lambda) quad && | "Eine der Lösungen" \
  <=>^(Rang B = m) (B^top B)^(-1) B^top ve(y) = & ve(lambda) && | "Die einzige Lösung, falls" Rang B = m
$
ist.

#exbox[
  #let xs = lq.linspace(0, 5)
  #align(center, diagram2d(
    legend: (position: (-30%, 0%)),
    lq.plot(
      xs,
      xs.map(x => -661 / 19 + 3291 / 38 * x),
      mark: none,
      label: $f$,
    ),
    lq.plot(
      xs,
      xs.map(interpolate-quadratic((0, 2, 5), (0, 69, 420))),
      mark: none,
      label: $g$,
    ),
    lq.plot(
      (0, 2, 5),
      (0, 69, 420),
      stroke: none,
      mark-size: 1em,
      label: $P_(x,y)$,
    ),
  ))
  #grid(
    columns: (1fr, auto, 3fr, auto, 2fr),
    align: center + horizon,
    table(
      columns: 2,
      table-header($x$, $y$), $0$,
      $0$, $2$,
      $69$, $5$,
      $420$,
    ),
    $and$,
    $
         f(x) = & lambda_0 b_0 (x) + lambda_1 b_1 (x) = lambda_0 + lambda_1 x \
      b_0 (x) = & 1 \
      b_1 (x) = & x \
    $,
    $=>$,
    table(
      columns: 4,
      table-header($x$, $b_0 (x)$, $b_1 (x)$, $y$), $0$, $1$, $0$,
      $0$, $2$, $1$, $2$,
      $69$, $5$, $1$, $5$,
      $420$,
    ),
  )
  $
    => && B = & mat(
      1, 0;
      1, 2;
      1, 5;
    ) \
    && B^top B = & mat(
      1, 1, 1;
      0, 2, 5,
    ) mat(
      1, 0;
      1, 2;
      1, 5;
    ) = mat(3, 7; 7, 29) \
    && B^top B ve(lambda) = & B^top ve(y) \
    <=> && mat(3, 7; 7, 29) vec(lambda_0, lambda_1) = & mat(
      1, 1, 1;
      0, 2, 5,
    ) vec(0, 69, 420) \
    <=> && mat(3, 7; 7, 29) vec(lambda_0, lambda_1) = & vec(489, 2238,)
    &<=> && mat(21, 49; 21, 87) vec(lambda_0, lambda_1) = & vec(3423, 6714,) \
    <=> && mat(21, 49; 0, 38) vec(lambda_0, lambda_1) = & vec(3423, 3291)
    &<=> && mat(21, 49; 0, 1) vec(lambda_0, lambda_1) = & vec(3423, 3291/38) \
    <=> && mat(21, 0; 0, 1) vec(lambda_0, lambda_1) = & vec(-27762/38, 3291/38)
    &<=> && mat(1, 0; 0, 1) vec(lambda_0, lambda_1) = & vec(-661/19, 3291/38) \
    => && lambda_0 = & -661/19 \
    => && lambda_1 = & 3291/38 \
    => && f(x) = & -661/19 + 3291/38 x \
  $
]

== Overfitting

Wenn ein Modell nur über *wenige Konfigurationsparameter* verfügt, ist seine
"Lernfähigkeit" eingeschränkt. Eine lineare Regression, die nur die
Basisfunktonen $1$ und $x$ enthält, führt zwangsweise auf lineare Modellfunktion
$f(x) = m x + b$ und kann kompliziertere Abhängigkeiten nicht wiedergeben. Man
spricht in diesem Fall von einer "Unteranpassung" oder einem _Underfitting_.

Allerdings kann es auch vorkommen, dass ein Modell *zu viele
Konfigurationsparameter* besitzt, um gute Vorhersagen zu leisten. Da die
Notwendigkeit, zu generalisieren, verschwindet, wenn es weniger Messwerte als
Regressionsparameter gibt, kann die Modellfunktion im Fall $m >= N$ die
Messdaten (inkl. eventuell vorhandener Fehler) einfach "auswendig lernen".
Dieser Effekt heisst "Überanpassung" (_Overfitting_).

// #todo[diagrams]

== Wahl der Basisfunktion

Neben den bis jetzt besprochenen linearen Basisfunktionen gibt es Polynomiale
Basisfunktionen vom Typ
$ x^k $
Gauss'sche Basisfunktionen vom Typ
$ e^(-1/(2 sigma^2) (x - mu)^2) $
Sigmoid-Basisfunktionen vom Typ
$ 1/(1 + e^(- (x - mu)/s)) $
und trigonometrischen Basisfunktionen vom Typ
$ sin(k omega x) "oder" cos(k omega x), k in ZZ $

// #todo[diagrams]

Dabei fällt auf, dass sich die Regressionskurven in dem Bereich, in dem
Messdaten zur Verfügung stehen kaum voneinander unterscheiden, während
ausserhalb dieses Bereichs grosse Unterschiede zwischen den verschiedenen
Regressionskurven sichtbar werden.

#table(
  columns: 3,
  table-header([Funktion], [Eignung], [Beispiel]),
  [Fourierbasis\ (trigonometrische\ Basisfunktion)],
  [Periodische Zyklen],

  [Wetterdaten],
  [Sigmoid-Basis],
  [Daten, die für sehr grosse und sehr kleine Argumente gegen zwei
    unterschiedliche endliche Grenzwerte streben],

  [Welcher Bevölkerungsanteil ein gewisses Jahreseinkommen unterschreitet],
  [Gauss'sche Basis],
  [Eine abhängige Variable, die für grosse und kleine Argumente annähernd Null
    ist],

  [Wahrscheinlichkeit, dass ein Mensch eine bestimmte Körpergrösse besitzt],
  [Polynomiale Basis],
  [
    Wenn die Daten nur innerhalb des Messbereichs interpoliert werden sollen
    oder wenn man von vornherein weiss, dass der Zusammenhang zwischen zwei
    Messgrössen linear oder quadratisch ist
  ],

  [Machinelles Lernen],
)

= Integration

== Stammfunktionen

#let xs = lq.linspace(-5, 5)
#grid(
  columns: (2fr, 3fr),
  [
    Eine Funktion $F(x)$ heisst _Stammfunktion_ (SF) von $f(x)$, wenn
    $F'(x) = f(x)$.

    Wenn $F_1 (x)$ eine SF von $f(x)$ ist, dann ist auch
    $F_2 (x) = F_1 (x) + c$
    eine SF von $f(x)$.

    Beweis: \
    $
      F'_2 (x) = & dif /(dif x) (F_1 (x) + c) \
               = & underbrace(F'_1 (x), "Ist SF von" f) + 0 \
               = & f(x)
    $
  ],
  diagram2d(
    width: 100%,
    height: 5cm,
    title: $ f(x) = sin(x) + 1/2 x^2, F_1 (x) = cos(x) + x $,
    legend: (position: top + left),
    lq.plot(
      xs,
      xs.map(x => calc.sin(x) + calc.pow(x, 2) / 2),
      mark: none,
      label: $f (x)$,
      stroke: (paint: colors.darkblue, dash: "dashed"),
    ),
    lq.plot(xs, xs.map(x => calc.cos(x) + x), mark: none, label: $F_1 (x)$),
    lq.plot(
      xs,
      xs.map(x => (calc.cos(x) + x + 5)),
      mark: none,
      label: $F_2 (x)$,
    ),
  ),

  diagram2d(
    width: 100%,
    lq.plot(xs, xs.map(_ => 1), mark: none, label: $G(x)$),
  ),
  [
    Sei $I$ ein Intervall und $f:I->RR$ eine Funktion. Wenn $F_1 (x)$ und
    $F_2 (x)$ SFen von $f(x)$ sind, dann gibt es eine Zahl $c in RR$, so dass
    $F_2 (x) = F_1
    (x) + c$.

    $
       G(x) = & F_1 (x) - F_2(x) \
      G'(x) = & F'_1 (x) - F'_2 (x) = f(x) - f(x) = 0 \
    $
    $G(x)$ ist eine Funktion, deren Steigung permanent $0$ ist.
  ],

  diagram2d(
    width: 100%,
    lq.plot(
      xs.slice(0, 20),
      xs.slice(0, 20).map(_ => 1),
      mark: none,
      label: $G(x)$,
      stroke: colors.darkblue,
    ),
    lq.plot(
      xs.slice(30),
      xs.slice(30).map(_ => -1),
      mark: none,
      stroke: colors.darkblue,
    ),
    lq.ellipse(
      xs.at(19),
      1,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.bg,
    ),
    lq.ellipse(
      xs.at(30),
      -1,
      width: 2.5%,
      height: 5%,
      align: center + horizon,
      stroke: colors.darkblue,
      fill: colors.bg,
    ),
  ),
  [
    $=> G(x)$ ist konstant

    $
      => & F_1 (x) - F_2 (x) = -c \
      => & F_2 (x) = F_1 (x) -c = F_1 (x) + c \
    $

    $G(x)$ muss nicht stetig sein! (Falls $D_f$ kein Intervall ist).
  ],
)


$
  f : cases(RR without {0} &-> RR without {0}, x &|-> 1/x) \
  F_(c,d) : cases(
    RR without {0} & -> RR without {0}, x &|-> ln(abs(x)) +
    cases(c "für" x > 0, d "für" x < 0)
  )
$

== Unbestimmtes Integral

$
      & f(x) = F' (x) \
  <=> & f(x) #[ist *die* Ableitung von] F(x) \
  <=> & F(x) #[ist *eine* Stammfunktion von] f(x) \
  <=> & underbrace(integral, #[unbestimmtes\ Integral])
        underbrace(f(x), "von" f(x)) underbrace(
          dif x,
          dif x
        ) = underbrace(F(x) + const, F(x) #[plus eine\ Konstante]) \
      & underbrace(integral, #[unbestimmtes\ Integral])
        underbrace(f(x), "Integrand") dif underbrace(
          x,
          #[Integrations-\ variable]
        )
$

#exbox(
  $
    integral y + x^2 dif x + const#comment($(y)$) \
    f(x) = y + x^2 ~> "SF" : F(x) = y x + x^3/3 \
    \
    integral y + x^2 dif y + const#comment($(x)$) \
    f(y) = y + x^2 ~> "SF" : F(y) = y^2/2 + y x^2 \
  $,
)

$integral f(x) dif x$ ist die Menge aller SF von $f(x)$ bezüglich der Variable
$x$.

$
  integral f(x) dif x = & {F_c (x) mid(|) F_c (x) = F(x) + c, c in RR, F(x)
    "ist SF"} && #tr("Deckt nicht alle Fälle ab!") \
  = & {F(x) mid(|) F' (x) = f(x)} && "Diese Definition schon"
$
In der Praxis schreibt man aber
$
  integral f(x) dif x = & F(x) + const
$

Die Konstante $const$ repräsentiert eine nicht näher bestimmte, (vorerst)
unbekannte Zahl, welche man auch als _Integrationskonstante_ bezeichnet.

#exbox(
  $
    integral 3 (x - 1)^2 dif x = & (x-1)^3 + const = x^3 - 3x^2 + 3x #tr($-1$) + const \
    integral 3 x^2 - 6x + 3 dif x = & x^3 - 3x^2 + 3x + const \
    -1 + const = & const \
    -1 + c != & c \
    => & "Deswegen verwendet man" const "anstatt" c
  $,
)

== Integrationsregeln

=== Umkehrung

Da das Integral und die Ableitung in Beziehung zueinander stehen, kann man diese
wie folgt umkehren:

$
  & tr(dif / (dif x) tg(underline(tr(F(x))))) && = f(x) <=> && F(x) + const =
  tg(integral tr(underline(tg(f(x)))) dif x) \
  & tr(dif / (dif x)) tg(integral f(x) dif x) = cancel(
    dif/ (dif x) (F(x) +
      const)
  ) && = f(x)
  <=> && F(x) + const = tg(integral tr(dif / (dif x) F(x)) dif x) \
$

=== Regeln

Den erste Regelblock findet man in erster Linie dadurch, dass man die bereits
bekannte Ableitungstabelle "rückwärts" liest.

// #todo[table]

$
  integral x^a dif x = & 1/(a+1) x^(a+1) + const && "für" a != -1 \
  integral 1/x dif x = & ln(abs(x)) + const \
  integral e^x dif x = & e^x + const \
  integral a^x dif x = & 1/ln(a) a^x + const && "wegen" a^x = e^(ln(a)
  dot x) \
  integral a^(b dot x) dif x = & 1/ln(a^b) a^x + const \
  integral ln(x) dif x = & x ln(x) - x + const \
  integral tan(x) dif x = & -ln(abs(cos(x))) + const \
  integral sin(x) dif x = & -cos(x) + const \
  integral cos(x) dif x = & sin(x) + const \
  integral 1/(1+x^2) dif x = & arctan(x) + const \
  integral -1/sqrt(1-x^2) dif x = & arccos(x) + const \
  integral 1/sqrt(1-x^2) dif x = & arcsin(x) + const \
  integral arctan(x) dif x = & x arctan(x) - 1/2 ln(abs(1+x^2)) + const \
  integral arccos(x) dif x = & x arccos(x)-sqrt(1-x^2) + const \
  integral arcsin(x) dif x = & x arcsin(x)+sqrt(1-x^2) + const \
$

=== Linearitätsregel

Das unbestimmte Integral einer Linearkombination mehrerer Funktionen darf
komponentenweise berechnet werden:

$
  dif / (dif x) (alpha F(x) + beta G(x)) = &alpha F'(x) + beta G'(x) && |
  "Linearkombination" \
  tr(integral) dif / (dif x) (alpha F(x) + beta G(x)) tr(dif x) = &tr(integral) alpha F'(x) +
  beta G'(x) tr(dif x) \
  tr(
    alpha F(x) + beta G(x) + const = & integral alpha F'(x) +
                                       beta G'(x) dif x
  ) \
  tg(alpha integral f(x) dif x + beta integral g(x) dif x cancel(+ const)) =
  & tg(integral alpha f(x) + beta g(x) dif x) && | "Linearitätsregel"
$

=== Substitutionsregel

$
  dif / (dif x) F(g(x)) = &F'(g(x)) dot g'(x) && | "Kettenregel" \
  tr(integral) dif / (dif x) F(g(x)) tr(dif x) = &tr(integral) F'(g(x)) dot g'(x) tr(dif x) \
  tr(F(g(x)) + const = &integral F'(g(x)) dot g'(x) dif x) \
  tg(F(g(x)) + const = &integral f(g(x)) dot g'(x) dif x) && | "Substitutionsregel" \
  /*= & subst(integral f(u) dif u, u = f(x))*/
$

#exbox[
  $
    integral td(cos(tp(ln(x)))) tp(dot 1/x) dif x = td(sin(tp(ln(x)))) + const \
    td(f(x) = cos(x)), tp(g(x) = ln(x)), tp(g'(x) = 1/x)
  $
]

==== Spezialfälle

Wird eine Funktion $f$ mit bekannter Stammfunktion $F$ auf einen linearen Term
angewendet $a x + b$ angewendet, so lässt sich auch die Funktion $f (a x + b)$
integrieren:

$
  integral f(a x + b) dif x = & 1/a F (a x + b) + const = tr(1/a) integral f(a x + b) tr(a) dif x \
$
Besteht der Integrand aus dem Produkt einer Funktion $f$ mit seiner eigenen
Ableitung, so lässt sich dieser Term ohne Kenntnis der Stammfunktion von $f$
integrieren:
$
  integral f(x) dot f'(x) dif x = & 1/2 f(x)^2 + const = integral tr(id(text(fill: #black, f(x)))) f'(x) dif x \
  "denn" \
  integral id(x) dif x = integral x dif x = & 1/2 x^2 + const \
$
Dasselbe gilt auch, wenn eine Potenz von $f$ mit der Ableitung von $f$
multipliziert wird. Für $q != −1$ gilt:
$
  integral f^q (x) dot f'(x) dif x = & 1/(q+1) f^(q+1)(x) + const \
$
Besteht der Integrand aus einem Bruch, dessen Zähler gleich der Ableitung des
Nenners ist, so lässt sich dieser Term ohne Kenntnis einer Stammfunktion
integrieren:
$
  integral (f'(x))/(f(x)) dif x = & ln(abs(f(x))) + const
$

// #todo[cleanup]
#exbox[
  $
    integral sin(x^2 + x) (2x + 1) dif x = & -cos(x^2 + x) + const \
    integral (ln(u))/u dif u = ln^1(u) dot 1/u dif u = & 1/2 ln^2(u) + const \
    integral (ln(x - 3))/(x - 3) dif x = & 1/2 ln^2(x-3)+ const \
    integral ln(x^2) x dif x = 1/2 subst(
      integral ln(u)
      dif u, u = x^2
    ) = subst(1/2 u ln(u) - u, u = x^2) + const = & 1/2
    x^2 ln(x^2) - 1/2 x^2 + const \
    integral (3x^2)/(7 - 4x^3)^3 dif x = -1/4 integral (7 - 4x^3)^(-3) (-12 x^2)
    dif x = & -1/4 dot (-1/2) dot (7 - 4x^3)^(-2) + const \
  $
]

=== Partielle Integration

$
  dif / (dif x) (F(x) g(x)) = &F'(x) g(x) + F(x) g'(x)&& | "Produktregel" \
  tr(integral) dif / (dif x) (F(x) g(x)) tr(dif x) = &tr(integral) F'(x) g(x) +
  F(x) g'(x) tr(dif x) \
  tr(F(x) g(x) + const = & integral F'(x) g(x) dif x + integral F(x) g'(x) dif x) \
  tg(F(x) g(x) + const = & integral f(x) g(x) dif x + integral F(x) g'(x) dif x) \
  tg(
    integral f(x) g(x) dif x = & F(x) g(x) cancel(+ const) - integral F(x) g'(x)
                                 dif x
  ) && | "Partielle Integrationsregel" \
$

// #todo[wann welcher term integriert werden soll]

== Bestimmtes Integral

$
  integral_a^b f(x) dif x = (F(b) cancel(comment(+ c))) - (F(a) cancel(
      comment(
        +
        c
      )
    )) = underbrace(F(b) - F(a), "Dieselben Stammfunktionen")
$
Voraussetzung: $fora(x in [a;b], f(x) "muss definiert sein")$ \
Neues Symbol: $[F(x)]_(x=a)^b = F(b) - F(a)$
$
  integral f(x) dif x = & F(x) tr(+ const) \
  integral_a^b f(x) dif x = & tr([ text(fill: #colors.fg, F(x))]_(x=a)^b) = F(b) - F(a)
$

// #exbox(todo[notes 26.04.23])

#obsbox(
  [
    Das bestimmte Integral repräsentiert eine Zahl, nämlich die Differenz zweier
    Funktionswerte einer Stammfunktion; das unbestimmte Integral steht dagegen
    für eine Menge aller Stammfunktionen.
  ],
)

=== Substitution

Bei der Substitutionsregel werden die Intervallgrenzen $a,b$ mit dem
Funktionswert des substituierten Terms $u(a),u(b)$ ersetzt.

#exbox(
  title: $ 1/(3 pi) integral_0^(3 pi) cos(2/3 t - pi) dif t $,
  $
     u(t) = & 2/3 t - pi \
    u'(t) = & dif/(dif t) (2/3 t - pi) \
          = & 2/3 \
    1/(3 pi) integral_0^(3 pi) cos(underbrace(2/3 t - pi, u))
    dif t = & 1/(3 pi) integral_(u(0))^(u(3 pi)) cos(u) dot 1/u'
              dif u \
          = & 1/(3 pi) integral_(-pi)^pi cos(u) 3/2 dif u \
          = & 1/(3 pi) 3/2 integral_(-pi)^pi cos(u) dif u \
          = & 1/(2 pi) [sin(u)]_(-pi)^pi \
          = & 0
  $,
)

#exbox(
  title: $ integral_(ln(1/2))^0 e^x/sqrt(1-e^(2x)) $,
  $
    u(x) = & e^x \
    (dif u)/(dif x) = & e^x \
    <=> 1/e^x dif u = & dif x \
    integral_(ln(1/2))^0 e^x/sqrt(1-e^(2x)) dif x = &
    integral_(ln(1/2))^(0) e^x/sqrt(1-e^(2x)) underbrace(1/e^x dif u, dif x) \
    = & integral_(e^ln(1/2))^(e^0) 1/sqrt(1-u^2) dif u \
    = & [arcsin(u)]_(1/2)^1 \
    = & arcsin(1) - arcsin(1/2) \
    = & pi/3
  $,
)

=== Rechenregeln

$
  integral_a^b f(x) dif x = & - integral_b^a f(x) dif x \
  integral_a^a f(x) dif x = & 0 \
  integral_a^c f(x) dif x = & integral_a^b f(x) dif x + integral_b^c f(x) dif x \
  F_a (x) = & integral_a^x f(t) dif t \
  dif / (dif x) (integral_a^x f(t) dif t) = & f(x)
$

=== Bestimmtes Integral als Grenzwert

#let n = 10
#let xs = lq.linspace(0, 1, num: n + 1)
#let fn = x => (
  calc.sin(x * 2.3) * calc.pow(x * 2, 2)
)
#grid(
  columns: (1fr, auto),
  [Das Integral kann man näherungsweise berechnen, indem man das Intervall in
    $n$ gleich grosse Segmente unterteilt und die jeweiligen Funktionswerte
    summiert (= Riemann Summe). Beispielsweise ist folgende Geschwindigkeit
    eines Zuges gegeben:

    Intervall: $[0;1]$

    Breite: $td(Delta t = 1/n)$
  ],

  diagram2d(
    xaxis: (
      format-ticks: (ticks, ..) => ticks.map(t => {
        tr($#if t == 1 { "n" } else { str(calc.floor(t * 10)) }\/n$)
      }),
      ticks: range(n + 1).map(i => i / 10),
    ),
    lq.plot(xs, xs.map(fn), stroke: colors.fg),
    ..xs
      .enumerate()
      .slice(1)
      .map(((i, x)) => {
        let y = fn(x)
        let x1 = (x - 1 / n) + .01

        let lbl = $#if i == n { "n" } else { str(i) }$
        (
          lq.fill-between(
            (x1, x, x, x1),
            (y, y, 0, 0),
            // y2: xs.filter(x => x > calc.pi / 2).map(_ => calc.pi / 2 - eps),
            fill: shade(stroke: colors-l.green),
            stroke: colors.green,
          ),
          lq.line((x1, y), (x, y), stroke: colors.darkblue + 2pt),
          lq.line((x, y), (x, 0), stroke: colors.red + 2pt),
          ..(
            if i > 4 {
              (
                lq.plot(
                  (x1,),
                  (.4,),
                  mark: mark => box(fill: colors.bg, height: 1em, if i == 5 {
                    tg($space ...$)
                  } else {
                    tg($Delta s_#lbl$)
                  }),
                ),
              )
            } else { () }
          ),
        )
      })
      .join(),
  ),
)

Endgeschwindigkeit pro Segment: #tr($v_k = v(k/n)$).

Zurückgelegte Strecke im $k$ Segment:
$tg(Delta s_k) = tr(v_k) td(Delta t) = tr(v(k/n)) td(1/n)$

Gesamtstrecke des "blauen Zuges"
$
  s = & sum_(k=1)^n Delta s_k = sum_(k=1)^n v(k/n) 1/n = 1/n sum_(k=1)^n v(k/n)
$

Gesamtstrecke des "schwarzen Zuges" $[v = v(t)]$

$
  s = & lim_(n -> oo) sum_(k=1)^n Delta s_k = lim_(n->oo) 1/n sum_(k=1)^n v(k/n)
$
Dies führt uns zur Neudefinition des bestimmten Integrals:
$
  integral_0^1 v(t) dif t = lim_(n-> oo) 1/n sum_(k=1)^n v(k/n)
$

=== Flächenberechnungen

#let fr = 3
#let to = 9
#grid(
  columns: (1fr, auto),
  [
    Näherung von $A$

    Teile Intervall $[a;b]$ in $n$ gleich grosse Teile

    Breite: $Delta x = (b - a)/n$

    Intervall des $k$ Segments $[a + (k-1) Delta x; underbrace(
        a + k Delta x,
        x_k
      )]$
  ],
  diagram2d(
    legend: (position: center + top),
    xaxis: (
      format-ticks: (ticks, ..) => ticks.map(t => {
        if t >= fr / 10 and t < to / 10 {
          tr(
            $x_#if t * 10 == to - 1 { "n" } else { str(calc.floor(t * 10) - fr) }#if t * 10 == to - 1 { $= b$ } else if t * 10 == fr { $= a$ }$,
          )
        } else { str(t) }
      }),
      ticks: range(n + 1).map(i => i / 10),
    ),
    lq.fill-between(
      range(to - fr).map(i => (i + fr) / 10),
      xs.map(fn).slice(fr, to),

      // y2: xs.filter(x => x > calc.pi / 2).map(_ => calc.pi / 2 - eps),
      fill: shade(stroke: colors-l.green),
      stroke: colors.green,
      label: $ A = integral_a^b f(x) dif x $,
    ),
    lq.plot(xs, xs.map(fn), stroke: colors.fg),
    lq.plot(xs.slice(fr, to), xs.map(fn).slice(fr, to), stroke: colors.green),
  ),
)

Fläche des Rechtecks über dem $k$ Segment habe die Höhe $f(x_n)$
$
  Delta A_k = f(x_k) dot Delta x = f(a+k dot Delta x) dot (b - a)/n = f(a+k dot (b-a)/n) dot (b-a)/n
$
Näherungsweise Flächeninhalt:
$
  & A approx sum_(k=1)^n Delta A_k = (b-a)/n dot sum_(k=1)^n f(a+k dot (b-a)/n) \
  => "exakter Flächeninhalt*: " & A = lim_(n->oo) sum_(k=1)^n Delta A_k \
  & A = integral_a^b f(x) dif x = lim_(n->oo) ((b-a)/n dot sum_(k=1)^n f(a+k dot (b-a)/n) )
$
\* Kann negativ sein. Fürs Integral ist das korrekt, für die Fläche müsste der
absolute Wert genommen werden

Somit können wir das bestimmte Integral definieren wie folgt:
$
  integral_a^b f(x) dif x = lim_(n-> oo) (b-a)/n dot sum_(k=1)^n f(a+k dot
    (b-a)/n)
$

=== Hauptsatz der Differential- und Integralrechnung


Hauptsatz: Jede Integralfunktion ist eine Stammfunktion ihres Integranden:

$
  F_a (x) = integral_a^x f(t) dif t = lim_(n-> oo) (x-a)/n dot sum_(k=1)^n f(a+k dot
    (x-a)/n)\
$

$F'_a (x) = f(x)$

#let tt = 4
// #lq.diagram(
//   xaxis: (
//     format-ticks: (ticks, ..) => ticks.map(t => {
//       if t == fr {
//         "a"
//       } else if t == to {
//         "x"
//       } else if t == tt {
//         "x + h"
//       } else { str(calc.floor(t * 10)) }
//     }),
//   ),
//   lq.plot(xs, xs.map(fn), stroke: black),
//   ..xs
//     .enumerate()
//     .slice(fr + 1, to)
//     .map(((i, x)) => {
//       let y = fn(x)
//       let x1 = x - 1 / n
//       let y1 = fn(x1)
//
//       let lbl = $#if i == to { "n" } else { str(i + 1) }$
//       (
//         ..(
//           if i == (fr + 1) {
//             (
//               lq.line((x1, y1), (x1, 0), stroke: green),
//             )
//           } else if i == (to - 1) {
//             (
//               lq.line((x, y), (x, 0), stroke: green),
//             )
//           }
//         ),
//         ..(
//           if i == 5 {
//             (
//               lq.plot(
//                 (x1,),
//                 (1,),
//                 mark: mark => tg($ A = integral_a^b f(x) dif x $),
//               ),
//             )
//           } else { () }
//         ),
//         lq.line((x1, y1), (x, y), stroke: green),
//         lq.line((x1, 0), (x, 0), stroke: green),
//       )
//     })
//     .join(),
// )
// #tr[TODO: diagram]

"Beweis":
$
  F'_a (x) = & lim_(h->0) (F_a (x+h) - F_a (X))/h = lim_(h->0) 1/h dot
  (integral_a^(x+h) f(x) dif t - integral_a^x f(x) dif t) \
  F'_a (x) = & lim_(h->0) 1/h integral_x^(x+h) f(t) dif t \
  integral_x^(x+h) f(t) dif t approx & f(x) dot h => F'_a(x) = lim_(h->0) (cancel(1/h) dot f(x)
    dot cancel(h)) = f(x)
$

//   #tr[TODO: Zwischenwertsatz]
//
//   $ integral_a^b f(t) dif t = (b - a) f(xi), a <= xi <= b $
//
//   asdf
//
//   $ integral_b^a f(x) dif x = - integral_a^b f(x) dif x $
//
// ]
//
// #todo[p. 103+]

=== Äquivalenz beider Definitionen des bestimmten Integrals

$
  && attach(integral, bl: "neu")_a^x f(t) dif t = & attach(integral, bl: "alt")_a^x
  f(t) dif t + c \
  <=> && c = & attach(integral, bl: "neu")_a^x f(t) dif t - attach(integral, bl: "alt")_a^x
  f(t) dif t #h(2em) && c "hängt nicht von" x "ab" \
  =>^(x=a) && c = & attach(integral, bl: "neu")_a^a f(t) dif t - attach(integral, bl: "alt")_a^a
  f(t) dif t \
  <=> && c = & 0 - 0 \
$

=== Verbesserungen der Approximation:

Trapezregel (lineare Splines):

$
  integral_a^b s(x) dif x = (b - a)/n dot ((f(a) + f(b))/2 + sum_(k=1)^(n-1) f(a+k dot
      (b-a)/n))
$

Fassregel / Simpson regel (polynome):

$
  integral_a^b f(x) dif x = (b - a)/6 dot (f(a) + 4 f((a+b)/2) + f(b))
$
$->$ Annäherung der Funktion $f$ durch eine Parabel, bestimmt durch die drei
Punkte $(a;f(a)), space (b;f(b)), space ((a+b)/2;f((a+b)/2))$

=== Mittlerer Funktionswert

#grid(columns: 2)[
  Für jede im Intervall $[a;b]$ definierte stetige Funktion $f(x)$ nennen wir
  $
    overline(f) = 1/(b-a) dot integral_a^b f(x) dif x
  $
  den _mittleren Funktionswert_ von $f$ im Intervall $[a;b]$.

  $=>$ Fläche #tr[unterhalb] der mittellinie bis $b$ und #tg[oberhalb] bis $a$
  ist gleich.
][
  #let f = 0
  #let t = 5
  #let xs = lq.linspace(0, t)
  #let a = 1
  #let b = 4
  #let fn = x => calc.cos(x / 2) + t - 4
  #let mid = (fn(a) - fn(b)) / 2 + fn(b)
  #let midx = 2.7
  #let xs1 = lq.linspace(a, midx)
  #let xs2 = lq.linspace(midx, b)
  #diagram2d(
    legend: lq.legend(
      inset: 0pt,
      pad: 0pt,
      circle(stroke: colors.green, fill: colors.green, radius: .25em),
      $a$,
      circle(stroke: colors.red, fill: colors.red, radius: .25em),
      $b$,
    ),
    width: 6cm,
    height: 3cm,
    xlim: (f - .5, t + .5),
    ylim: (-.25, 2.5),
    lq.fill-between(
      xs1,
      xs1.map(fn),
      y2: xs1.map(_ => mid),
      fill: shade(stroke: colors.green),
    ),
    lq.fill-between(
      xs2,
      xs2.map(fn),
      y2: xs2.map(_ => mid),
      fill: shade(stroke: colors.red),
    ),
    lq.plot(xs, xs.map(fn), mark: none, stroke: colors.darkblue),
    lq.ellipse(
      a,
      fn(a),
      align: center + horizon,
      width: 0.2,
      height: .2,
      fill: colors.green,
      label: $a$,
    ),
    lq.ellipse(
      b,
      fn(b),
      align: center + horizon,
      width: 0.2,
      height: .2,
      fill: colors.red,
      label: $b$,
    ),
    lq.line((a, mid), (b, mid)),
  )
]

$
  overline(f) = 1/(b-a) integral_a^b f(x) dif x = & 1/cancel(b-a) lim_(n->oo) sum_(k=1)^n
  f(a+(b-a)/n k) dot cancel(b-a)/n \
  = & lim_(n->oo) (1/n sum_(k=1)^n f(a+ (b-a)/n k)) \
$

= Fourierreihen

Die _Fourier-Analyse_, die auch als klassische harmonische Analyse bekannt ist,
befasst sich mit der Zerlegung von Signalen in ihre harmonischen Komponenten,
welche aus mathematischer Sicht gewöhnliche Sinusschwingungen darstellen.

_Fourierreihen_ zerlegen periodische Funktionen in trigonometrische Komponenten

$
  f(x) = a_0 + sum_(n=1)^oo a_n cos((2pi)/T dot n dot x) + b_n sin(
    (2pi)/T dot n
    dot x
  )
$

== Periodische Funktionen

// / Primitive Periode: Kürzeste Zeit, bis die Wiederholung eintrifft (erste
//   Wiederholung)
// / Rundkreisfrequenz: Gegenteil der Periode


Gegeben einer Funktion $f:RR->RR$ heisst $p>0$ _Periode_ von $f$, wenn $fora(
  x
  in RR, f(x+p) = f(x)
)$. Die Funktion $f$ heisst in diesem Fall $p$-periodisch.

Ist $p$ die kleinste Zahl mit dieser Eigenschaft, heisst $p$ _primitive
Periode_.

#let xs = lq.linspace(0, 4, num: 200)
#let fn = x => calc.sin(x * (2 * calc.pi))
#let pline = (x, c: colors.fg) => (
  lq.line((x, fn(x)), (x + 1, fn(x)), tip: tiptoe.stealth, stroke: c),
  lq.place(x + .5, fn(x) - .1, text(fill: c, $+1$)),
)
#let period = o => {
  let xs = lq.linspace(o, o + 1)
  let c = color-cycle.at(o + 1)
  (
    lq.plot(xs, xs.map(fn), mark: none, stroke: c),
    ..pline(c: c, o + .125),
    ..pline(c: c, o + .25),
    ..pline(c: c, o + .6),
  )
}
#let xs1 = lq.linspace(0, 1)
#let xs2 = lq.linspace(1, 3)
#let xs3 = lq.linspace(2, 3)
#exbox(grid(columns: (auto, 1fr))[
  #diagram2d(
    width: 12cm,
    lq.plot(xs, xs.map(fn), mark: none, label: $f(x)$),
    ..range(3).map(period).join(),
  )
][
  $f$ hat primitive Periode $p = 1$ und Perioden $k in NN without {0}$
])

Sei $f(x)$ $p$-periodisch. Dann ist $g(x) = f(alpha x)$ auch periodisch, und
zwar mit Periode $q=p/alpha$
$
  g(x+q) = f(alpha (x+q)) = f(alpha x + underbrace(
      alpha q,
      tr(alpha q = p)
    )) tr(=^!) f(alpha x) = g(x)
$
Seien $f(x)$ und $g(x)$ zwei Funktionen mit der gemeinsamen Periode $p$. Dann
ist auch die Funktion
$
  h(t) = alpha f(t) + beta g(t)
$
$p$-periodisch.

#obsbox(
  [Ist eine periodische Funktion $f$ stetig und nicht konstant, so besitzt die
    Funktion eine primitive Periode $P$ und jede andere Periode von $f$ ist ein
    ganzzahliges Vielfaches von $P$.],
  [Die konstanten Funktionen sind periodisch zu jeder Zahl $p>0$, besitzen aber
    keine primitive Periode.],
  [$sin$ und $cos$ haben Periode $p=2pi$],
)

== Fourierreihen

Die Funktionen
$
  c_0 (t) = & 1 \
  c_k (t) = & cos((2pi)/T dot k dot t) \
  s_k (t) = & sin((2pi)/T dot k dot t) \
$
heissen _Fouriermoden_ mit $T > 0 and k in NN without {0}$ und haben die Periode
$T$.

// Setze $alpha = (2pi)/T dot k => s_k$ und $c_k$ haben Periode $q=p/alpha =
// (2pi)/((2pi)/T dot k) = T/k$

// Da $k in NN without {0}$ haben $s_k$ und $c_k$ auch die Periode $T/k dot k = T$

Da Linearkombinationen $T$-periodischer Funktionen wieder $T$-periodisch sind,
hat auch
$ f(t) = a_0 c_0 (t) + sum_(k=1)^oo a_k c_k (t) + b_k s_k (t) $
die Periode $T$.

$a_k$ und $b_k$ heissen _Fourierkoeffizienten_. Die Menge aller
Fourierkoeffizienten heisst _Spektrum_.

Die Zahl $omega_1 = (2pi)/T$ heisst _Grundkreisfrequenz_ der Fourierreihe.

Ziel ist nun, die Fourierkoeffizienten so zu bestimmen, dass die gesuchte
Funktion näherungsweise erfüllt ist.

#let xs = lq.linspace(-1.5 * calc.pi, 3 * calc.pi, num: 100)
#align(center, diagram2d(
  legend: (position: top + left),
  width: 100%,
  height: 6cm,
  lq.plot(
    xs,
    xs.map(x => calc.cos(x)),
    mark: none,
    label: $cos(x)$,
  ),
  lq.plot(
    xs,
    xs.map(x => calc.cos(2 / 3 * x)),
    mark: none,
    label: $cos(2/3 x)$,
  ),
  lq.plot(
    xs,
    xs.map(x => 2 / 3 * calc.cos(x)),
    mark: none,
    label: $2/3 cos(x)$,
  ),
  lq.place(calc.pi * 2.5, 1.2, tp($T = 3 pi, omega_1 = 2/3$)),
  lq.line(
    (0, 1),
    (3 * calc.pi, 1),
    stroke: color-cycle.at(1) + 1.5pt,
    tip: tiptoe.stealth,
  ),
  lq.place(calc.pi, 1.3, td($T = 2 pi, omega_1 = 1$)),
  lq.line(
    (0, 1.1),
    (2 * calc.pi, 1.1),
    stroke: color-cycle.at(0) + 1.5pt,
    tip: tiptoe.stealth,
  ),
  lq.place(calc.pi, .7, tg($T = 2 pi, omega_1 = 1$)),
  lq.line(
    (0, .9),
    (2 * calc.pi, .9),
    stroke: color-cycle.at(2) + 1.5pt,
    tip: tiptoe.stealth,
  ),

  lq.place(1.7 * calc.pi, .3, box(fill: colors.bg, inset: .3em, tg(
    $a_k = 2/3$,
  ))),
  lq.line(
    (2 * calc.pi, 0),
    (2 * calc.pi, 2 / 3),
    stroke: color-cycle.at(2) + 1.5pt,
    tip: tiptoe.stealth,
  ),

  lq.place(2.3 * calc.pi, .3, box(fill: colors.bg, inset: .3em, td($a_k = 1$))),
  lq.line(
    (2.1 * calc.pi, 0),
    (2.1 * calc.pi, 1),
    stroke: color-cycle.at(0) + 1.5pt,
    tip: tiptoe.stealth,
  ),

  lq.place(2.8 * calc.pi, .3, box(fill: colors.bg, inset: .3em, tp($a_k = 1$))),
  lq.line(
    (3 * calc.pi, 0),
    (3 * calc.pi, 1),
    stroke: color-cycle.at(1) + 1.5pt,
    tip: tiptoe.stealth,
  ),
))

#exbox[
  $
    f(t) = & cos(2/3 t - pi) = - cos(2/3 t) \
         = & underbrace(-1, =^! a_k = a_1) cos(
               frac(
                 2pi, underbrace(3pi, =^! T),
                 style: "horizontal"
               ) dot
               underbrace(1, =^! k) dot t
             ) \
  $

  Wähle $T = 3pi, omega_1 = 2/3, a_1 = -1,$ alle anderen $a_k = 0,$ alle
  $b_k = 0$.
]

=== Fourierreihen mit endlichem Spektrum

Sei $omega_1 = (2pi)/T$. Dann gilt laut den _Orthogonalitätsbedingungen_ für
alle $k,l in NN without {0}$:
$
  integral_0^top cos(k omega_1 t) sin(l omega_1 t) dif t = & 0 \
  integral_0^top sin(k omega_1 t) sin(l omega_1 t) dif t = & cases(
                                                               0 & "falls" k !=
                                                                   l, T/2 &"falls" k = l
                                                             ) \
  integral_0^top cos(k omega_1 t) cos(l omega_1 t) dif t = & cases(
                                                               0 & "falls" k !=
                                                                   l, T/2 &"falls" k = l
                                                             ) \
$
// #todo[Diese können auch als Basisvektoren $ve(e)_1 = vec(1, 0, 0), ve(e)_2 =
//   vec(0, 1, 0), ve(e)_3 = vec(0, 0, 1)$ interpretiert werden.]

/ Additionstheoreme:
$
  cos(a plus.minus b) = & cos(a) cos(b) minus.plus sin(a) sin(b) \
  sin(a plus.minus b) = & sin(a) cos(b) plus.minus cos(a) sin(b) \
$
/ Produktformeln:
$
  cos(a) cos(b) = & 1/2 (cos(a-b) + cos(a+b)) \
  sin(a) sin(b) = & 1/2 (cos(a-b) - cos(a+b)) \
  cos(a) sin(b) = & 1/2 (sin(a+b) - sin(a-b)) \
$

Funktionen der Form
$
  S_(oo) (t) = a_0 + sum_(k=1)^oo a_k cos(omega_1 dot k dot t) + b_k sin(omega_1 dot k dot t)
$
heissen _Fourierreihe_ der Funktion $f(t)$.

Funktionen mit Periode $T = (2pi)/omega_1$ und endlichem Fourier-Spektrum der
Form
$
  S_N (t) = a_0 + sum_(k=1)^N a_k cos(omega_1 dot k dot t) + b_k sin(omega_1 dot k dot t)
$
heissen _Fourierreihe der $N$-ten Ordnung_. Ihre Fourierkoeffizienten lassen
sich mit den folgenden Formeln berechnen:
$
  a_0 = & 1/T integral_0^top f(t) dif t \
  a_k = & 2/T integral_0^top f(t) cos(omega_1 k t) dif t \
  b_k = & 2/T integral_0^top f(t) sin(omega_1 k t) dif t \
$ <fou>
// FIXME: pt3d labels
#exbox[
  #let xs = lq.linspace(0, 18, num: 500)
  #diagram3d(
    width: 17cm,
    height: 8cm,
    xaxis: (nticks: 10, label: $x #h(1em)$),
    yaxis: (nticks: 6, label: $#h(1em)#v(1em) N$),
    zaxis: (ticks: (-3, 0, 3), label: $#h(1em)f(x)$),
    rotations: (
      (
        (-1, 0, 2),
        (-.75, 2, -.75),
        (0, 0, 0),
      ),
    ),
    ..(
      pt.lineplot(
        xs,
        xs.map(_ => 7),
        xs.map(x => 3 - calc.rem-euclid(x, 6)),
        stroke: 1pt + (5 / 2 * 1pt) + color-cycle.at(6),
      ),
    ),
    ..range(0, 5)
      .map(
        n => pt.lineplot(
          xs,
          xs.map(_ => n + 2),
          xs.map(fourier(0, t => 0, t => 6 / (t * calc.pi), n: n + 2)),
          label: $S_#{ n + 2 }$,
          stroke: 1pt + (n / 2 * 1pt) + color-cycle.at(n),
        ),
      )
      .rev(),
  )
  // #diagram2d(
  //   height: 6cm,
  //   width: 100%,
  //   lq.plot(
  //     xs,
  //     xs.map(x => 3 - calc.rem-euclid(x, 6)),
  //     mark: none,
  //     label: $f$,
  //     stroke: 3.5pt,
  //   ),
  //   ..range(0, 5).map(n => lq.plot(
  //     xs,
  //     xs.map(fourier(0, t => 0, t => 6 / (t * calc.pi), n: n + 2)),
  //     label: $S_#{ n + 2 }$,
  //     stroke: 1pt + (n / 2 * 1pt),
  //   )),
  // )
]

=== Fourierreihen periodischer Funktionen

Sei $S_N (t)$ die Fourierreihe der $N$-ten Ordnung der Funktion $f(t)$. Ziel ist
es nun, die Ausgangsfunktion möglichst genau durch $S_N (t)$ zu approximieren.
$
  "Fehler" = integral_0^top (f(t) - S_N (t))^2 dif t
$
#let fsdiag(n: 4, a: true) = {
  let (f, t) = if a { (-3, 3) } else { (-2, 2) }
  let xs = lq.linspace(f, t, num: 500)
  let fn = x => if calc.sin(x * calc.pi) >= 0 { 1 } else { -1 }
  let ffn = fourier(
    0,
    t => 0,
    t => (2 - 2 * calc.cos(t * calc.pi)) / (t * calc.pi),
    T: 2,
    n: n,
  )
  let mark = mark => place(
    center + horizon,
    circle(fill: colors.bg, stroke: colors.darkblue, radius: 2pt),
  )
  diagram2d(
    legend: (position: (if a { 100% } else { 80% }, 0pt)),
    width: if a { 100% } else { 49% },
    lq.plot(
      (f + .0001, f + .999),
      (f + .0001, f + .999).map(fn),
      mark: mark,
      label: if a { $sig(sin(pi x))$ },
    ),
    ..range(f + 1, t).map(x => {
      let xxs = (x + .0001, x + .999)
      lq.plot(
        xxs,
        xxs.map(fn),
        mark: mark,
        stroke: colors.darkblue,
      )
    }),
    lq.plot(
      xs,
      xs.map(ffn),
      mark: none,
      label: $S_#n (x)$,
      stroke: colors.purple,
    ),
    if a {
      lq.fill-between(
        xs,
        xs.map(fn),
        y2: xs.map(ffn),
        fill: shade(stroke: colors.red.transparentize(50%), x: 5pt, y: 5pt),
        label: $"Fehler"$,
      )
    },
  )
}
#exbox(align(center, [
  #fsdiag(n: 2)
  #fsdiag(n: 6)
]))
Es lässt sich zeigen, dass der Fehler
$
  integral_0^oo (f(t) - S_N (t))^2 dif t ->^(N->oo) 0
$
mit wachsendem $N$ gegen null strebt und erfüllt somit die Eigenschaft der
_Vollständigkeit_.

=== Kovergenz von Fourierreihen (Satz von Dirichlet) <dirichlet>

Sei $f (t)$ eine stückweise stetig differenzierbare, $T$-periodische Funktion,
d.h. eine $T$-periodische Funktion, die im Intervall $[0; T]$ bis auf an endlich
vielen Stellen stetig differenzierbar ist, für die an allen Unstetigkeitsstellen
jeweils der rechtsseitige und der linksseitige Grenzwert existiert. Dann stimmt
die Funktion $f (t)$ überall dort mit der Fourierreihe $S_oo (t)$ überein, wo
die Funktion $f (t)$ stetig ist. Überall dort, wo $f (t)$ stetig ist, gilt also
$ S_oo (t) = f(t) $
Ist $t$ dagegen eine Unstetigkeitsstelle von $f (t)$, so liefert die
Fourierreihe an dieser Stelle dagegen den Mittelwert der beiden einseitigen
Grenzwerte, d.h. an diesen Stellen gilt:
$
  S_oo (t) = 1/2 (lim_(tau -> t+) f(tau) + lim_(tau->t-) f(tau))
$

#block(breakable: false, obsbox[
  Entwickelt man eine Fourierreihe einer unstetigen, periodischen Funktion, so
  ergeben sich an den Unstetigkeitsstellen typische Über- und Unterschwinger,
  die sich auch dann nicht verringern, wenn man versucht, die Funktion durch
  weitere Summenglieder anzunähern. Dieses Verhalten nennt man _Gibbssches
  Phänomen_.

  #fsdiag(n: 10, a: false)
  #fsdiag(n: 50, a: false)
])

// === Fourierreihe eines Rechtecksignals

// #todo[p.144-147]

=== Symmetrieeigenschaften

#defbox("Gerade, ungerade funktion", [
  Eine Funktion $f: D->Z$ heisst _gerade_, wenn
  $ fora(t\,-t in D, f(-t) = f(t)) $
  und _ungerade_ wenn
  $ fora(t\,-t in D, f(-t) = -f(t)) $
])

Das Produkt von zwei geraden Funktionen und das Produkt von zwei ungeraden
Funktionen ist gerade. Das Produkt einer geraden und einer ungeraden Funktion
ist ungerade.

Integriert man eine $T$-periodische Funktion $f$ über eine ganze Periode, so ist
der Wert des Integrals unabhängig von der Wahl der unteren Integrationsgrenze
$a$, d.h. es gilt
$
  integral_a^(a+T) f (t) dif t = integral_0^top f (t) dif t
$

#let a = -calc.pi * 1.5
#let b = calc.pi * 1.5
#let xs = lq.linspace(a, b)
#let g-diag = fn => diagram2d(
  lq.plot(xs, xs.map(fn), mark: none),
  lq.place(a - .5, 1, tp[$-a$]),
  lq.place(b + .5, 1, tp[$a$]),
  lq.line((a, 1), (a, -1), stroke: (paint: colors.purple, dash: "dashed")),
  lq.line((b, 1), (b, -1), stroke: (paint: colors.purple, dash: "dashed")),
  lq.fill-between(
    xs,
    xs.map(x => if fn(x) < 0 { 0 } else { fn(x) }),
    y2: xs.map(_ => 0),
    fill: shade(stroke: colors-l.green),
  ),
  lq.fill-between(
    xs,
    xs.map(x => if fn(x) > 0 { 0 } else { fn(x) }),
    y2: xs.map(_ => 0),
    fill: shade(stroke: colors-l.red),
  ),
)

==== Gerade Funktionen

#grid(
  columns: 2,
  [
    Sei $g : D -> Z$ eine gerade Funktion und $a in RR$ so gewählt, dass das
    Intervall $(-a,a) subset D$. Dann gilt
    $
      integral_(-a)^a g(x) dif x = 2 integral_0^a g(x) dif x
    $
    Beispiel: $g(x) = cos(x)$
  ],
  g-diag(calc.cos),
)

Sei $f$ eine $T$-periodische, gerade Funktion. Dann gilt für die
Fourierkoeffizienten von $f$
$
  a_0 = & 2/T integral_0^(T/2) f (t) dif t \
  a_k = & 4/T integral_0^(T/2) f (t) cos(omega_1 k t) dif t \
  b_k = & 0 \
$ <foug>
Die Fourierreihe einer geraden Funktion enthält also nur den konstanten Term und
Kosinusterme, d.h. keine Sinusterme.

==== Ungerade Funktionen

#grid(
  columns: 2,
  [
    Sei $h : D -> Z$ eine ungerade Funktion und $a in RR$ so gewählt, dass das
    Intervall $(-a,a) subset D$. Dann gilt
    $
      integral_(-a)^a h(x) dif x = 0
    $
    Beispiel: $h(x) = sin(x)$
  ],
  g-diag(calc.sin),
)

Ist $f$ eine $T$-periodische, ungerade Funktion, so gilt für die
Fourierkoeffizienten von $f$
$
  a_0 = & 0 \
  a_k = & 0 \
  b_k = & 4/T integral_0^(T/2) f (t) sin(omega_1 k t) dif t \
$ <fouu>

=== Sinus-Kosinus und Amplituden-Phasen-Form

Neben der _Sinus-Kosinus Darstellung_ gibt es noch eine zweite Darsellungsart:
die _Amplituden-Phasen-Form_. Die Amplituden-Phasen-Form ist stärker mit der
komplexwertigen Darstellung von Fourierreihen verwandt und erlaubt eine
kompaktere Darstellung der Fourierreihen von Funktionen, die von mehreren
Variablen abhängen. Zum anderen lassen sich die Fourierkoeffizienten in dieser
zweiten Darstellungsform besser interpretieren.

#let p = 1
#let xs = lq.linspace(-2 * calc.pi, 2 * calc.pi, num: 100)
#diagram2d(
  width: 100%,
  lq.plot(xs, xs.map(calc.cos), mark: none, stroke: colors-l.darkblue),
  lq.plot(
    xs,
    xs.map(x => calc.cos(x - p)),
    mark: none,
    stroke: colors.darkblue,
  ),
  lq.line(
    (p, 0),
    (p, 1),
    tip: tiptoe.stealth,
    toe: tiptoe.stealth,
  ),
  lq.place(p + .4, .5, $A_k$),
  lq.line(
    (2, calc.cos(2)),
    (2 + p, calc.cos(2)),
    tip: tiptoe.stealth,
  ),
  lq.place(2.6, calc.cos(2) - .2, $phi_k$),
)

#defbox("Amplituden-Phasen-Form", [
  Sei $f (t)$ eine stückweise stetig differenzierbare, $T$-periodische Funktion,
  für die an allen Unstetigkeitsstellen jeweils der rechtsseitige und der
  linksseitige Grenzwert existiert. Dann lässt sich die Funktion nach @dirichlet
  als Fourierreihe $S_oo (t)$ entwickeln. Die Fourierreihe kann dabei auf zwei
  Arten angegeben werden. Entweder (wie bisher) in der Sinus-Kosinus-Form
  $
    S_oo (t) = a_0 + sum_(k=1)^oo a_k cos(k omega_1 t) + b_k sin(k omega_1 t)
  $
  oder in der _Amplituden-Phasen-Form_
  $
    S_oo (t) = A_0 + sum_(k=1)^oo A_k cos(k omega_1 t - phi_k)
  $
  In diesen Formeln ist wie üblich $omega_1 = (2 pi)/T$. Ferner sind die
  _Amplituden_ $A_k$ in der Amplituden-Phasen-Form so gewählt, dass $A_k >= 0$
  gilt und die _Phasen_ $phi_k$ nur bis auf ganzzahlige Vielfache von $2 pi$
  bestimmt. Man kann die Phasen aber durch eine Zusatzforderung eindeutig
  festlegen. Gebräuchlich sind in diesem Fall entweder $phi_k in [0;2pi)$ oder
  $phi_k in (-pi;pi]$.

  Die Gesamtheit aller Amplituden bzw. aller Phasen nennt man auch _Amplituden-_
  bzw. _Phasenspektrum_.
])
Die Berechnung der Fourierkoeffizienten in der Sinus-Kosinus-Form geschieht mit
Hilfe von @fou oder im Fall von geraden oder ungeraden Ausgangsfunktionen auch
mit Hilfe von @foug oder @fouu. Die Berechnung der Fourierkoeffizienten in der
Amplituden-Phasen-Form geschieht danach, in einem zweiten Schritt mit Hilfe der
vorgängig berechneten Koeffizienten mit Hilfe des Additionstheorems.

Dies geschieht nach dem folgenden Schema:
$
    A_k = & sqrt(a_k^2 + b_k^2) \
  phi_k = & cases(
              "irrelevant" & a_k = b_k = 0,
              0 & a_k > 0\, b_k = 0,
              pi & a_k < 0\, b_k = 0,
              arccos(a_k/A_k) & b_k > 0,
              -arccos(a_k/A_k) quad & b_k < 0,
            )
$
Die umgekehrte Umrechnung (Amplituden-Phasen- zu Sinus-Kosinus-Form) erfolgt mit
den folgenden Formeln:
$
  a_k = & A_k cos(phi k) \
  b_k = & A_k sin(phi k) \
$

Dies lässt sich geometrisch als Umrechnung von 2 dimensionalen kartesischen
Koordinaten in polare Koordinaten deuten. Um diesen "geometrischen Weg" zur
Bestimmung der Amplituden und Phasen einer Fourierreihe zu beschreiten, tragen
wir das Koeffizientenpaar $(a_k; b_k)$ als Punkt in einem 2-dimensionalen
kartesischen Koordinatensystem ab. Der Abstand, den dieser Punkt dann vom
Ursprung des Koordinatensystems hat, lässt sich dann als Amplitude $A_k$
interpretieren und der Winkel, unter dem dieser Punkt im Koordinatensystem zu
finden ist, als Phase.

// #todo[diagram]

#exbox(title: $ f(x) = A dot cos(x - phi) $, [
  $
    f(x) = & A dot cos(x - phi) \
         = & A dot (cos(x)cos(phi) + sin(x)sin(phi)) \
         = & A cos(x)cos(phi) + A sin(x)sin(phi) \
    => a = & A cos(phi) \
    => b = & A sin(phi) \
  $
  $A$ muss grösser als $0$ sein:
  $
      a^2 + b^2 = & A^2 cos^2 (phi) + A^2 sin^2 (phi) \
    <=>^(A>0) A = & sqrt(a^2 + b^2) \
  $
])

// #todo[berechnung durch komplexe Zahlen]
//
// == Diskrete Fouriertransformationen (DFT)
//
// #todo[p.165-180]
//
//
// #todo[$b_k = & 2/T integral_(-T/2)^(T/2) f(t) sin(omega_1 k t) dif t$]
//
// #todo[diagram $omega_1$, $T$]
