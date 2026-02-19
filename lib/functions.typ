#import "./const.typ": *

#let rfc(num) = link(
  "https://www.rfc-editor.org/info/rfc" + str(num),
  "RFC " + str(num),
)
#let todo(body) = {
  pad(left: 1em, right: 1em, block(
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

#let ve = b => math.accent(b, math.arrow)
#let num(p, n) = {
  set text(fill: colors.comment)
  "0"
  p
  set text(fill: colors.black, weight: "bold")
  n
}
#let hex(n) = {
  // TODO: pad & split
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, 16)
    res += if rem > 9 { str.from-unicode(55 + rem) } else { str(rem) }
    n = calc.floor(n / 16)
    i += 1
    if calc.rem(i, 2) == 0 and n > 0 {
      res += " "
    }
  }
  res += "0" * (calc.rem(i, 2))
  num("x", res.rev())
}
#let bin(n) = {
  // TODO: pad & split
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, 2)
    res += str(rem)
    n = calc.floor(n / 2)
    i += 1
    if calc.rem(i, 4) == 0 and n > 0 {
      res += " "
    }
  }
  if calc.rem(i, 4) > 0 {
    res += "0" * (4 - calc.rem(i, 4))
  }
  num("b", res.rev())
}
#let dec(n) = {
  let i = 0
  let res = ""
  for d in str(n).rev() {
    res += d
    i += 1
    if calc.rem(i, 3) == 0 and i != str(n).len() {
      res += "'"
    }
  }
  num("d", res.rev())
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
