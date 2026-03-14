#import "@preview/suiji:0.5.1"
#import "./const.typ": *

#let rfc(num) = link(
  "https://www.rfc-editor.org/info/rfc" + str(num),
  text(font: code-font)[RFC #num],
)
#let todo(body) = {
  pad(x: 1em, block(
    fill: colors.red.transparentize(80%),
    stroke: (top: colors.red),
    width: 100%,
    inset: 0.5em,
    [
      #text(fill: colors.red, weight: "bold", style: "italic")[TODO:\ ]
      #body
    ],
  ))
}
#let corr(body) = {
  set text(fill: colors.red, weight: "bold")
  body
}
#let comment(body) = {
  set text(fill: colors.comment, style: "italic")
  body
}
#let cr = table.cell(fill: colors-l.red, sym.crossmark)
#let cg = table.cell(fill: colors-l.green, sym.checkmark)
#let cb = table.cell(fill: colors-l.blue, sym.star)
#let tp = body => {
  set text(fill: colors.purple)
  body
}
#let tr = body => {
  set text(fill: colors.red)
  body
}
#let tg = body => {
  set text(fill: colors.green.darken(20%))
  body
}
#let tb = body => {
  set text(fill: colors.blue.darken(50%))
  body
}
#let td = body => {
  set text(fill: colors.darkblue)
  body
}
#let ty = body => {
  set text(fill: colors.yellow)
  body
}

#let ve = b => math.accent(b, math.arrow)
#let num(prefix: none, postfix: none, n) = {
  if prefix != none {
    set text(fill: colors.comment)
    "0"
    prefix
  }
  // set text(fill: colors.fg, weight: "bold")
  if postfix != none { $#{ n } _#postfix$ } else { n }
}

// TODO: negative and decimal? enc?
// TODO: pad param
#let fromdec(n, b, g: none, gpre: "0", d: " ") = {
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, b)
    res += if rem > 9 and b > 10 { str.from-unicode(55 + rem) } else {
      str(rem)
    }
    n = calc.floor(n / b)
    i += 1
    if g != none and calc.rem(i, g) == 0 and n > 0 {
      res += d
    }
  }
  if g != none and calc.rem(i, g) > 0 {
    res += gpre * (g - calc.rem(i, g))
  }
  res.rev()
}

#let oct(n, prefix: true, postfix: false) = {
  num(fromdec(n, 8, g: 3), prefix: if prefix { "o" }, postfix: if postfix { 8 })
}
#let hex(n, prefix: true, postfix: false) = {
  num(
    fromdec(n, 16, g: 2),
    prefix: if prefix { "x" },
    postfix: if postfix { 16 },
  )
}
#let bin(n, prefix: true, postfix: false) = {
  num(fromdec(n, 2, g: 4), prefix: if prefix { "b" }, postfix: if postfix { 2 })
}
#let dec(n, prefix: true, postfix: false) = {
  let i = 0
  let res = ""
  for d in str(n).rev() {
    res += d
    i += 1
    if calc.rem(i, 3) == 0 and i != str(n).len() {
      res += "'"
    }
  }
  num(res.rev(), prefix: if prefix { "d" }, postfix: if postfix { 10 })
}

#let no-ligature(t) = {
  text(features: (calt: 0), t)
}

#let lqcircle(s: 1, x: 0, y: 0, f: 0) = {
  let n = 100
  let p = i => i * 2 * calc.pi / n
  range(0, n).map(i => (calc.sin(p(i + f)) * s + x, calc.cos(p(i + f)) * s + y))
}

#let lqcut(points, (x1, y1), (x2, y2)) = {
  points.filter(((x, y)) => {
    x >= x1 and x <= x2 and y >= y1 and y <= y2
  })
}

#let deviate-x(rng, xs) = {
  let (rng, ys) = suiji.integers(rng, size: xs.len())
  (rng, ys.zip(xs).map(((y, x)) => y / 25 + x))
}

#let linear-regression(xs, ys) = {
  let n = ys.len()
  let sumx = xs.sum()
  let sumy = ys.sum()
  let sumxy = xs.zip(ys).map(((x, y)) => x * y).sum()
  let sumxsq = xs.map(x => calc.pow(x, 2)).sum()
  let m = (n * sumxy - sumx * sumy) / (n * sumxsq - calc.pow(sumx, 2))
  let b = (sumy - m * sumx) / n
  (m, b)
}

#let rss(xs, ys) = {
  let (m, b) = linear-regression(xs, ys)
  let ypred = xs.map(x => m * x + b)
  let resid = ys.zip(ypred).map(((y, yp)) => y - yp)
  resid.map(r => calc.pow(r, 2)).sum()
}

#let merge-deep(a1, a2) = {
  if type(a1) == dictionary and type(a2) == dictionary {
    for (k, v) in a2.pairs() {
      a1.insert(k, if k in a1 { merge-deep(a1.at(k), v) } else { v })
    }
  }
  a1
}

#let merge-args = (a1, a2) => (
  (..a1.pos(), a2.pos()),
  merge-deep(a1.named(), a2.named()),
)

#let interpolate-quadratic = (xs, ys) => {
  let linfns = ()
  let pairs = xs.zip(ys)
  let z = 0
  for ((x, y), (xn, yn)) in pairs.windows(2) {
    let zn = 2 * (yn - y) / (xn - x) - z
    linfns.push(xx => (
      y + z * (xx - x) + (zn - z) / (2 * (xn - x)) * calc.pow((xx - x), 2)
    ))
    z = zn
  }
  linfns.push(linfns.last())
  let getpos = x => {
    let i = xs.windows(2).position(((f, t)) => f <= x and x <= t)
    return if i == none { linfns.len() - 1 } else { i }
  }
  return x => linfns.at(getpos(x))(x)
}

#let interpolate-cubic = (xs, ys) => {
  // let diff = l => l.windows(2).map(((f, s)) => s - f)
  // let searchsorted = (l, n) => l.map(x => {
  //   let p = l.position(n => x <= n)
  //   if p != none { p } else { l.len() }
  // })
  // let clip = (l, minv, maxv) => l.map(x => if x < minv { minv } else if x
  //   > maxv { maxv } else { x })
  // let subtract = (a, b) => a - b
  //
  // let size = xs.len()
  // let xdiff = diff(xs)
  // let ydiff = diff(ys)
  //
  // let Li = (calc.sqrt(2 * xdiff.at(0)),)
  // let Li_1 = (0.0,)
  // let B0 = 0.0
  // let z = (B0 / Li.at(0),)
  //
  // for i in range(1, size - 1) {
  //   Li_1.at(i) = xdiff.at(i - 1) / Li.at(i - 1)
  //   Li.at(i) = calc.sqrt(
  //     2 * (xdiff.at(i - 1) + xdiff.at(i)) - Li_1.at(i - 1) * Li_1.at(i - 1),
  //   )
  //   let Bi = 6 * (ydiff.at(i) / xdiff.at(i) - ydiff.at(i - 1) / xdiff.at(i - 1))
  //   z.at(i) = (Bi - Li_1.at(i - 1) * z.at(i - 1)) / Li.at(i)
  // }
  // let i = size - 1
  // Li_1.at(i - 1) = xdiff.at(-1) / Li.at(i - 1)
  // Li.at(i) = calc.sqrt(
  //   2 * xdiff.at(-1) - Li_1.at(i - 1) * Li_1.at(i - 1),
  // )
  // let Bi = 0.0
  // z.at(i) = (Bi - Li_1.at(i - 1) * z.at(i - 1)) / Li.at(i)
  //
  // i = size - 1
  // z.at(i) = z.at(i) / Li.at(i)
  //
  // for i in range(-1, size - 2).rev() {
  //   z.at(i) = (z.at(i) - Li_1.at(i - 1) * z.at(i + 1)) / Li.at(i)
  // }
  //
  // return x => {
  //   let index = searchsorted(x, xs)
  //   index = clip(index, 1, size - 1)
  //   let xi1 = index.map(i => xs.at(i))
  //   let xi0 = index.map(i => xs.at(i - 1))
  //   let yi1 = index.map(i => ys.at(i))
  //   let yi0 = index.map(i => ys.at(i - 1))
  //   let zi1 = index.map(i => z.at(i))
  //   let zi0 = index.map(i => z.at(i - 1))
  //   let hi1 = xi1.zip(xi0).map(subtract)
  //   return hi1
  //     .enumerate()
  //     .map(((i, h)) => (
  //       zi0.at(j) / (6 * hi1.at(j)) * calc.pow((xi1.at(j) - x0.at(j)), 3)
  //         + zi1.at(j) / (6 * hi1.at(j)) * calc.pow((x0.at(j) - xi0.at(j)), 3)
  //         + (yi1.at(j) / hi1.at(j) - zi1.at(j) * hi1.at(j) / 6)
  //           * (x0.at(j) - xi0.at(j))
  //         + (yi0.at(j) / hi1.at(j) - zi0.at(j) * hi1.at(j) / 6)
  //           * (xi1.at(j) - x0.at(j))
  //     ))
  // }
  x => x
}
