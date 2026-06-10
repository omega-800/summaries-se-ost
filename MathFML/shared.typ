#import "../lib.typ": *

#let m = 4
#let sig = 1
#let npdf = pdf(m, sig)
#let ncdf = cdf(m, sig)
#let xs = lq.linspace(-1, 2, num: 100)
#let lmrk = mark => place(
  center + horizon,
  circle(fill: colors.bg, stroke: colors.darkblue, radius: 2pt),
)

#let ctd = (..args) => {
  // show: lq.theme.skyline
  html.frame(lq.diagram(
    xaxis: (tick-distance: 0.25),
    yaxis: (tick-distance: 0.25),
    width: 6cm,
    height: 6cm,
    ..args,
  ))
}

#let contour = lq.contour.with(
  levels: 20,
  map: colors-hmap,
  stroke: 1pt,
)

#let diagrams = (w, h) => (
  pdfunif: diagram2d(
    height: h,
    width: w,
    xlim: (-1.2, 2.2),
    legend: (position: top + left),
    title: $P D F quad "unif"(0,1)$,
    lq.plot(
      (-2, 0),
      (0, 0),
      stroke: colors.darkblue,
      label: $f(x)$,
      mark: lmrk,
    ),
    lq.plot((0, 1), (1, 1), stroke: colors.darkblue, mark: lmrk),
    lq.plot((1, 3), (0, 0), stroke: colors.darkblue, mark: lmrk),
  ),
  cdfunif: diagram2d(
    height: h,
    width: w,
    legend: (position: top + left),
    title: $C D F quad "unif"(0,1)$,
    lq.plot(
      xs,
      xs.map(unifcdf(0, 1)),
      mark: none,
      label: $F(x)$,
    ),
  ),
  dfdiag: c => {
    let xs = lq.linspace(0, 8, num: 100)
    let (fn, l, n) = if c { (ncdf, $C D F$, $F(x)$) } else {
      (npdf, $P D F$, $f(x)$)
    }
    diagram2d(
      height: h,
      width: w,
      title: l,
      ylim: (-.05, 1.05),
      yaxis: (tick-distance: .1),
      lq.plot(
        xs,
        xs.map(fn),
        mark: none,
        label: n,
      ),
      lq.plot(
        (m, m),
        (0, fn(m)),
        stroke: (
          paint: colors.purple,
          dash: "dashed",
        ),
        mark: none,
      ),
      ..if c {
        (
          lq.plot(
            (0, m),
            (fn(m), fn(m)),
            stroke: (
              paint: colors.purple,
              dash: "dashed",
            ),
            mark: none,
          ),
          lq.fill-between(
            xs.filter(x => x < m),
            xs.filter(x => x < m).map(fn),
            fill: shade(
              x: 5pt,
              y: 5pt,
              stroke: colors.darkblue.transparentize(50%),
            ),
            label: $A = 1/2 = F(tp(mu))$,
          ),
        )
      } else {
        (
          lq.fill-between(
            xs,
            xs.map(fn),
            fill: shade(
              x: 5pt,
              y: 5pt,
              stroke: colors.darkblue.transparentize(50%),
            ),
            label: $A = 1$,
          ),
        )
      },
      lq.place(m, fn(m) + .15, tp[$mu$]),
      lq.place(m + sig / 2, .06, box(
        fill: colors.bg,
        inset: (x: 2pt),
        tg[$sigma$],
      )),
      lq.place(m - sig / 2, .06, box(
        fill: colors.bg,
        inset: (x: 2pt),
        tg[$sigma$],
      )),
      lq.plot(
        (m + sig, m + sig),
        (0, fn(m + sig)),
        stroke: (
          paint: colors.green,
          dash: "dashed",
        ),
        mark: none,
      ),
      lq.plot(
        (m - sig, m - sig),
        (0, fn(m - sig)),
        stroke: (
          paint: colors.green,
          dash: "dashed",
        ),
        mark: none,
      ),
      lq.line(
        (m - sig, .1),
        (m, .1),
        stroke: colors.green,
        toe: tiptoe.stealth,
        tip: tiptoe.stealth,
      ),
      lq.line(
        (m + sig, .1),
        (m, .1),
        stroke: colors.green,
        toe: tiptoe.stealth,
        tip: tiptoe.stealth,
      ),
    )
  },
)
#let gddiag = (w, h) => {
  let xs = lq.linspace(-1, 1)
  let fn = (x, y) => y * y * y - y + x * x - .5
  let dif-fn = (x, y) => (2 * x, 3 * y * y - 1)
  let dif-dif-fn = (x, y) => ((2, 0), (0, 6 * y))
  let ng = 0.01
  let ne = 0.001
  let gg = 0.1
  let ge = 0.01
  (
    ctd(
      width: w,
      height: h,
      lq.ellipse(
        0,
        calc.sqrt(1 / 3),
        width: .05,
        height: .05,
        align: center + horizon,
        fill: colors.red,
        stroke: colors.red,
      ),
      lq.ellipse(
        0,
        -calc.sqrt(1 / 3),
        width: .05,
        height: .05,
        align: center + horizon,
        fill: colors.red,
        stroke: colors.red,
      ),
      contour(xs, xs, fn),
      ..((-0.8, 0.05), (-0.75, 0.9), (-0.9, -0.2), (0.9, -0.5))
        .map(sp => (
          // TODO: comparison with newton
          lq.plot(
            ..gradient-descent(..sp, dif-fn, gamma: gg, epsilon: ge),
            mark: none,
            stroke: colors.fg,
          ),
          lq.ellipse(
            ..sp,
            width: .05,
            height: .05,
            align: center + horizon,
            fill: colors.fg,
          ),
          // TODO: fine-tune parameters
          lq.plot(
            ..newtons-method(
              ..sp,
              dif-fn,
              dif-dif-fn,
              gamma: ng,
              epsilon: ne,
            ),
            mark: none,
            stroke: colors.red,
          ),
        ))
        .join(),
    ),
    [
      $
        f(x,y) = y^3 - y + x^2 - 1/2 \
      $

      Black lines starting from the black points lead to the local minimum,
      calculated using gradient descent. Red lines are calculated using Newton's
      method.

      The parameters chosen are as follows:

      Newton's method: $gamma = #ng, epsilon = #ne$ \
      Gradient descent: $gamma = #gg, epsilon = #ge$ \
    ],
  )
}
