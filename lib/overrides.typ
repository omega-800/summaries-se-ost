#import "./const.typ": colors
#import "@preview/chronos:0.2.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

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

