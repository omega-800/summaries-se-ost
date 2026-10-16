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

