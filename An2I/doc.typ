#import "@preview/cetz:0.4.1"
#import "@preview/tiptoe:0.3.1" as tiptoe
#import "../lib.typ": *

#show: project.with(
  module: "An2I",
  name: "Analysis für Informatik 2",
  semester: "FS26",
)

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
Für eine Funktion #tp($f(x)$) und einen EWP $x_0$ heisst $ sum_(k=0)^n (#tp($f$)^((k)) (x_0))/(k!) (x-x_0)^k $ Taylor-Polynom von Grad $n$ für $f(x)$ um EWP $x_0$

#todo("Diagram")

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

#comment(
  $
    (n!)/((n-1)!) = n dot (n - 1) \
    (n!)/((n-2)!) = n dot (n - 1) dot (n - 2) \
    n! dot (n + 1)! = (n + 1)!
  $,
)

= Grenzwerte

Die Zahl $#tp($F$) in RR$ heisst Grenzwert von #td($f(x)$) für $x$ gegen $oo$, wenn für alle #ty($epsilon > 0$) eine "Grenze" #tg($X$) existiert, so dass für alle "noch grössere Zahlen" $x > #tg($X$)$ gilt: $abs(#td($f(x)$) - #tp($F$)) < #ty($epsilon$)$.

$ forall epsilon in RR: epsilon > 0 and abs(f(x) - F) < epsilon $

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
