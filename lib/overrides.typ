#import "./const.typ": colors
#import "@preview/chronos:0.2.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/plotsy-3d:0.2.1": plot-3d-parametric-curve

// TODO: PR: only element functions can be used in set rules

#let diagram = diagram.with(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  mark-scale: 60%,
  spacing: (1em, 1em),
  node-shape: rect,
)
#let edge = edge.with(label-side: center)
#let _par = chronos._par.with(color: colors.blue)

// TODO:

#let plot-3d-parametric-curve = plot-3d-parametric-curve.with(
  xyz-colors: (
    colors.blue,
    colors.green,
    colors.red,
  ),
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
)
