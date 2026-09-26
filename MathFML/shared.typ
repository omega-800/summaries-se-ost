#import "../lib.typ": *

#let xs = lq.linspace(-1, 2, num: 100)

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
