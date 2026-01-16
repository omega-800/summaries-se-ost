#import "./const.typ": *

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

// yoinked from plotst bc not exposed

#let float_range(min, max, step: 1) = {
    if type(min) == "float" or type(max) == "float" or type(step) == "float" {
      let it = ()
      it.push(min)
      if step < 0 {
        while it.last() + step > max {
          assert(it.last() + step < it.last(), message: "step size too small to decrease float")
          it.push(calc.round(it.last() + step, digits: 2))
        }
      } else {
        while it.last() + step < max {
          assert(it.last() + step > it.last(), message: "step size too small to increase float")
          it.push(calc.round(it.last() + step, digits: 2))
        }
      }
      it
    } else {
      range(int(min * 100), int(max * 100), step: int(step * 100)).map(i => i / 100)
    }
}
#let function_plotter(equation, start, end, precision: 100) = {
  let points = ()
  for step in float_range(start, end, step: (end - start) / precision) {
    points.push((step, equation(step)))
  }
  points.push((end, equation(end)))
  return points
}
