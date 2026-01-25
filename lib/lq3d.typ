#import "./const.typ": color-cycle, colors
#import "@preview/plotsy-3d:0.2.1": (
  default-line-color-func, get-parametric-curve-points, get-surface-zpoints,
  plot-3d-parametric-curve, render-3d-vector-field, render-front-axis,
  render-parametric-curve, render-rear-axis, render-surface,
)
#import "@preview/cetz:0.4.1": canvas, draw, matrix

#let legacy-dim = ps => (
  (
    // TODO: figure out what this actually did
    calc.min(..ps.map(p => p.at(0))),
    calc.max(..ps.map(p => p.at(0))),
  ),
  (
    calc.min(..ps.map(p => p.at(1))),
    calc.max(..ps.map(p => p.at(1))),
  ),
  (
    calc.min(..ps.map(p => p.at(2))),
    calc.max(..ps.map(p => p.at(2))),
  ),
)
// TODO:
// mark etc.
#let vector = (..pts) => (vector: pts.pos(), dim: legacy-dim(pts.pos()))
#let surface = pts => (surface: pts, dim: ((0, 0), (0, 0), (0, 0)))
#let path = (..pts) => (path: pts.pos(), dim: legacy-dim(pts.pos()))

#let diagram(
  // width:6cm,
  // height:4cm,
  // title: none,
  //
  // xlim: auto,
  // ylim: auto,
  // zlim: auto,
  //
  // xlabel: $x$,
  // ylabel: $y$,
  // zlabel: $z$,
  //
  // xscale: auto,
  // yscale: auto,
  // zscale: auto,
  //
  // margin: 6%,
  ..children,
  cycle: color-cycle,
  xyz-colors: color-cycle.slice(0, 3),
  axis-label-offset: (0.5, 0.4, 0.45),
  axis-text-offset: 0.25,
  axis-label-size: 2em,
  subdivisions: 30,
  dot-thickness: 0.05em,
  front-axis-dot-scale: (0.04, 0.04),
  front-axis-thickness: 1pt,
  rear-axis-text-size: 1em,
  rear-axis-dot-scale: (0.08, 0.08),
  rotation-matrix: ((-2, 2, 4), (0, -1, 0)),
  color-func: default-line-color-func,
  scale-dim: (1, 1, 0.5),
  tdomain: (0, 1),
  xaxis: (0, 10),
  yaxis: (0, 10),
  zaxis: (0, 10),
  axis-step: (5, 5, 5),
  axis-labels: ($x$, $y$, $z$),
) = {
  context [#canvas({
      import draw: *
      let (xscale, yscale, zscale) = scale-dim
      set-transform(matrix.transform-rotate-dir(
        rotation-matrix.at(0),
        rotation-matrix.at(1),
      ))
      scale(
        x: xscale * text.size.pt(),
        y: yscale * text.size.pt(),
        z: zscale * text.size.pt(),
      )

      let (xaxis-low, xaxis-high) = xaxis
      let (yaxis-low, yaxis-high) = yaxis
      let (zaxis-low, zaxis-high) = zaxis

      // TODO: fix this
      let (
        (xcurve-lo, xcurve-hi),
        (ycurve-lo, ycurve-hi),
        (zcurve-lo, zcurve-hi),
      ) = children.pos().at(0).dim

      render-rear-axis(
        axis-low: (
          calc.min(xcurve-lo, xaxis-low),
          calc.min(ycurve-lo, yaxis-low),
          calc.min(zcurve-lo, zaxis-low),
        ),
        axis-high: (
          calc.max(xcurve-hi, xaxis-high),
          calc.max(ycurve-hi, yaxis-high),
          calc.max(zcurve-hi, zaxis-high),
        ),
        axis-step: axis-step,
        dot-thickness: dot-thickness,
        axis-dot-scale: rear-axis-dot-scale,
        axis-text-size: rear-axis-text-size,
        axis-text-offset: axis-text-offset,
      )

      let i = 0
      for c in children.pos() {
        let (
          (xcurve-lo, xcurve-hi),
          (ycurve-lo, ycurve-hi),
          (zcurve-lo, zcurve-hi),
        ) = c.dim
        let cf = (..b) => cycle.at(calc.rem(i, cycle.len()))
        if "path" in c {
          render-parametric-curve(
            curve-points: c.path,
            color-func: cf,
          )
        }
        if "vector" in c {
          render-3d-vector-field(
            (c.vector,),
            cf,
            vector-size: 0.1em,
          )
        }
        if "surface" in c {
          let step = 1 / 2
          let samples = 1
          let render-step = 1

          let (zdomain, zpoints) = get-surface-zpoints(
            c.surface,
            samples: samples,
            render-step: render-step,
            xdomain: xaxis,
            ydomain: yaxis,
            axis-step: axis-step,
          )

          let (zaxis-low, zaxis-high) = zdomain
          render-surface(
            c.surface,
            cf,
            samples: samples,
            render-step: render-step,
            xdomain: xaxis,
            ydomain: yaxis,
            zdomain: zaxis,
            axis-step: axis-step,
            zpoints: zpoints,
          )
          // render-surface(
          //   c.surface,
          //   cf,
          //   zpoints: get-surface-zpoints(c.surface),
          // )
        }

        i = i + 1
      }

      render-front-axis(
        axis-low: (
          calc.min(xcurve-lo, xaxis-low),
          calc.min(ycurve-lo, yaxis-low),
          calc.min(zcurve-lo, zaxis-low),
        ),
        axis-high: (
          calc.max(xcurve-hi, xaxis-high),
          calc.max(ycurve-hi, yaxis-high),
          calc.max(zcurve-hi, zaxis-high),
        ),
        axis-label-size: axis-label-size,
        front-axis-dot-scale: front-axis-dot-scale,
        front-axis-thickness: front-axis-thickness,
        axis-label-offset: axis-label-offset,
        xyz-colors: xyz-colors,
        axis-labels: axis-labels,
      )
    })
  ]
}
