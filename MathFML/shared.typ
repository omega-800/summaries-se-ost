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
