#import "./deps.typ": *

#let deviate-x(rng, xs) = {
  let (rng, ys) = suiji.integers(rng, size: xs.len())
  (rng, ys.zip(xs).map(((y, x)) => y / 25 + x))
}

#let sort-by-x(xs, ys) = (
  xs
    .zip(ys)
    .sorted(by: ((x1, _), (x2, _)) => x1 < x2)
    .fold(((), ()), (acc, (x, y)) => ((..acc.at(0), x), (..acc.at(1), y)))
)

// #let transpose-mat(m) = range(m.at(0).len()).map(j => range(m.len()).map(i => m.at(i).at(j)))
// #let another-lerp(xs, ys, bs: (x => 1, x => x, x => x * x)) = {
//   let DT = bs.map(b => xs.map(b))
//   let D = transpose-mat(DT)
// TODO:
// $ (D^top D)^(-1) D^top y $
// }

// TODO: merge larps

#let lerp(xs, ys) = {
  let y-avg = ys.sum() / ys.len()
  let x-avg = xs.sum() / xs.len()
  let var-x = xs.map(x => x * x).sum() / 7 - x-avg * x-avg
  let var-x-y = xs.zip(ys).map(((x, y)) => x * y).sum() / 7 - x-avg * y-avg
  let m = var-x-y / var-x
  let b = y-avg - x-avg * m
  x => m * x + b
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

#let rss(xs, ys) = (
  ys.zip(xs.map(lerp(xs, ys))).map(((y, yp)) => calc.pow(y - yp, 2)).sum()
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

#let gradient-descent = (sx, sy, dif-fn, gamma: 0.1, epsilon: 0.01) => {
  let gdxs = (sx,)
  let gdys = (sy,)

  while true {
    let lx = gdxs.at(-1)
    let ly = gdys.at(-1)
    let (nx, ny) = dif-fn(lx, ly).map(i => i * gamma)
    let nx = lx - nx
    let ny = ly - ny
    if (calc.abs(ny - ly) + calc.abs(nx - lx)) / 2 < epsilon {
      break
    }
    gdxs.push(nx)
    gdys.push(ny)
  }

  (gdxs, gdys)
}


// TODO: pt3d generic
#let mat-mult-vec(m, v) = m.map(r => r
  .enumerate()
  .map(((i, x)) => v.at(i) * x)
  .sum())

#let newtons-method = (
  sx,
  sy,
  dif-fn,
  dif-dif-fn,
  gamma: 0.1,
  epsilon: 0.01,
) => {
  let gdxs = (sx,)
  let gdys = (sy,)

  while true {
    // TODO:
    let lx = gdxs.at(-1)
    let ly = gdys.at(-1)

    let (nx, ny) = mat-mult-vec(
      dif-dif-fn(lx, ly),
      dif-fn(lx, ly).map(i => i * gamma),
    )

    let nx = lx - nx
    let ny = ly - ny
    if (calc.abs(ny - ly) + calc.abs(nx - lx)) / 2 < epsilon {
      break
    }
    gdxs.push(nx)
    gdys.push(ny)
  }

  (gdxs, gdys)
}

#let pdf = (m, s) => x => (
  calc.exp(
    -calc.pow(x - m, 2) / (2 * calc.pow(s, 2)),
  )
    / calc.sqrt(2 * calc.pi * calc.pow(s, 2))
)
// approximation through hyperbolic functions
#let erf = x => calc.tanh(
  2 / calc.sqrt(calc.pi) * (x + 11 / 123 * calc.pow(x, 3)),
)
#let cdf = (m, s) => x => (
  (1 + erf((x - m) / calc.sqrt(2 * calc.pow(s, 2)))) / 2
)
#let unifpdf = (a, b) => x => if x > b or x < a { 0 } else { 1 / (b - a) }
#let unifcdf = (a, b) => x => if x > b { 1 } else if x < a { 0 } else {
  (x - a) / (b - a)
}
#let fourier = (
  a0,
  ak,
  bk,
  c0: t => 1,
  ck: none,
  sk: none,
  n: 10,
  T: 2 * calc.pi,
) => {
  import calc: *
  let ck = if ck == none { (k, t) => cos((2 * pi) / T * k * t) } else { ck }
  let sk = if sk == none { (k, t) => sin((2 * pi) / T * k * t) } else { sk }

  x => (
    a0 * c0(x) + range(1, n).map(k => ak(k) * ck(k, x) + bk(k) * sk(k, x)).sum()
  )
}
