#import "../lib.typ": *
#import "./info.typ": info
#import "./shared.typ": contour, diagrams, gddiag

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
#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

#let diags = diagrams(49%, 4cm)

// TODO: into pt3d
#let h-color-fn = (_, _, z, lim: (-1, 1)) => {
  let (min, max) = lim
  let z = (z - min) / (max - min)
  let l = colors-hmap.len()
  let i = (l - 1) * z
  let f = colors-hmap.at(calc.floor(i))
  let t = colors-hmap.at(calc.ceil(i))
  let r = (calc.rem(z, 1 / (l - 1)) * l) * 100%
  color.mix((f, 100% - r), (t, r))
}

= Linear algebra

#defbox("Linear combination", $ sum_(i=1)^k lambda_i ve(v)_i $)

== Standard basis

Basis vectors ${ve(e)_1, ve(e)_2,...,ve(e)_n}$ in $RR^n$ where
$ve(e)_i = (0,0,...,underbrace(1, #[$i$th position]),...,0)^top$

#exbox($ [vec(1, 0, 0), vec(0, 1, 0), vec(0, 0, 1)] = RR^3 $)

It can be shown that any basis of $RR^n$ consists of exactly $n$ linear
independent vectors and that conversely any set of $n$ linear independent
vectors is a basis of $RR^n$.

== Vectors

// #todo("group and clean this up")

#context shared.vec-rules

== Linear transformations

$ T : V -> W $

#deftbl(
  [Image / range],
  grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    $
      im T = {T(v) mid(|) v in V} = T(V)
    $,
    diagram(
      node-shape: fletcher.shapes.ellipse,
      node($V$, enclose: ((-4, -2), (0, 2)), name: <v>),
      edge("-|>", label: "T"),
      node((4, 0), $im T$, name: <im>, shape: circle),
      node(pad(left: 3em, $W$), enclose: ((4, -2), <im>, (5, 2))),
      edge(<v>, <im>, "-|>", shift: (2.6, 1.5)),
      edge(<v>, <im>, "-|>", shift: (-2.6, -1.5)),
    ),
  ),
  [Kernel / nullspace],
  grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    $
      ker T = {v in V mid(|) T(v) = 0}
    $,
    diagram(
      node-shape: fletcher.shapes.ellipse,
      node((0, 0), $ker T$, name: <ker>, shape: circle),
      node(pad(right: 3.5em, $V$), enclose: ((-1, -2), (-1, 2), <ker>)),
      edge("-|>", label: "T"),
      node((4, 0), $0$, name: <o>, shape: circle),
      node(pad(left: 2.5em, $W$), enclose: ((4, -2), <o>, (5.5, 2))),
      edge(<ker>, <o>, "-|>", shift: (1.7, 1)),
      edge(<ker>, <o>, "-|>", shift: (-1.7, -1)),
    ),
  ),
)

#obsbox(
  $im T subset W$,
  $ker T subset V$,
  $ve(0) in ker A$,
)

#exbox(
  [$
      A in RR^(n times n), T_A : cases(RR^n &-> RR^n, ve(x) &|-> A ve(x))\
      ker A = {ve(x) in RR^n | A ve(x) = ve(0)} = {ve(x) in RR^n | T_A (ve(x)) = ve(0)}
    $
    // #todo("")
  ],
)

=== Affine transformations

All linear transformations share the property, that they map the null vector to
null:

$ L_A (ve(0)) = ve(0) $

For many applications this is undesirable. Therefore linear transformations are
often slightly extended to transformations, which are called *affine
transformations*. An affine transformation is defined by an $r times c$ matrix
$M$ and an $r$-dimensional vector $b$, which, in machine learning and
statistics, is usually called *bias-vector* or *intercept*.

$ A_(b, M) : cases(RR^c &-> RR^r, x &|-> b + M dot x) $

#exbox(
  title: "Straight line in one dimension",
  $
    A_(b, m) : cases(RR&->RR, x&|-> m x + b)
  $,
)

== Matrices

#deftbl(
  [Rank],
  [
    Maximum number of linearly independent rows or columns
    $ A in RR^(m times n) => rank(A) = rho(A) <= n $
    // #todo("check")
  ],
  [Nullity],
  [
    Number of vectors in the null space
    $ A in RR^(m times n) => nullity(A) = n - rho(A) = dim(ker A) $
    // #todo("check")
  ],
  [Dimension],
  [$ dim(ker A) = nullity(A) \ ve(x) in RR^3 => dim ve(x) = 3 $],
  [Span],
  [
    Set of all finite linear combinations of the elements of $S$ of a vector
    space $V$.
    $
      span(S) = {lambda_1 ve(v)_1 + lambda_2 ve(v)_2 + ... + lambda_n ve(v)_n mid(|) n in NN, v_1, ..., v_n in S, lambda_1, ..., lambda_n in K} \
      span {(1,0,0),(0,1,0),(0,0,1)} = RR^3
    $
  ],
  [Column space],
  [
    Span of the column vectors of a matrix
    $
      colsp(A) = C(A) \
      A in RR^(m times n), dim(colsp(A)) = n
    $
  ],
  [Row space],
  [
    Span of the row vectors of a matrix
    $
      rowsp(A) = C(A^top) \
      A in RR^(m times n), dim(rowsp(A)) = m
    $
  ],
  [Quadratic Matrix],
  $ M in RR^(n times n) $,
  [Symmetric Matrix],
  $ M in RR^(n times n) and M^top = M $,
)

#obsbox(
  $rank(T) + nullity(T) = dim V$,
  $dim(im T) + dim(ker T) = dim(domain T)$,
  $rank(A) = dim(rowsp(A)) = dim(colsp(A))$,
  $A in RR^(n times n) => dim(ker A) + rank A = n$,
  $A in RR^(n times n), ker A = {ve(0)} <=> rank A = n$,
)

=== Properties

#context shared.mat-rules

=== Unit matrices

Let $M$ be the set of all $2 times 2$ matrices. How could the basis of $M$ look?
$mat(a, b; c, d)$ \
Unit matrices:
$
  E_(1 1)= mat(1, 0; 0, 0), E_(1 2) = mat(0, 1; 0, 0), E_(2 1)= mat(0, 0; 1, 0), E_(2 2) = mat(0, 0; 0, 1) \
  M = {E_(1 1),E_(1 2),E_(2 1),E_(2 2)} \
  (E_(1 1))_(2 2) = 0, (E_(1 1))_(1 1) = 1 \
  ve(e)_1 = vec(1, 0, 0) in RR^3, (ve(e)_1)_1 = 1 \
$

=== Kronecker Delta

$ delta_(i j) = cases(1 "," i = j, 0 ", otherwise") $

#exbox(
  $
    delta_(2 3) = 0, delta_(1 1) = 1, (ve(e)_1)_j = delta_(1 j) = cases(1 "," 1 = j, 0 ", otherwise")
  $,
)

$
  delta_(m 1) delta_(m 2) = 0 \
  delta_(k l) - delta_(l k) = 0 \
  (e_k)_i = delta_(k i) = delta_(i k) \
  (E_(k l))_(i j) = delta_(k i) delta_(l j) \
  (E_(r s t))_(i j k) = delta_(r i) delta_(s j) delta_(t k)
$

=== Matrix product

$
  A in RR^(n times m), B in RR^(m times r), A dot B in RR^(n times r) \
  A dot B = mat(
    a_(1 1), a_(1 2), dots, a_(1 m);
    dots.v, dots.v, dots.down, dots.v;
    a_(i 1), a_(i 2), dots, a_(i m);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), dots, a_(n m)
  )
  dot
  mat(
    b_(1 1), b_(1 2), dots, b_(1 r);
    dots.v, dots.v, dots.down, dots.v;
    b_(i 1), b_(i 2), dots, b_(i r);
    dots.v, dots.v, dots.down, dots.v;
    b_(m 1), b_(m 2), dots, b_(m r)
  ) \
  (A dot B)_(1 1) = a_(1 1) b_(1 1) + a_(1 2) b_(1 2) + ... + a_(1 m) b_(m 1) = sum_(k=1)^m a_(1 k) b_(k 1) \
  (A dot B)_(i j) = sum_(k=1)^m a_(i k) b_(k j) \
$
Shorthand:
$ (A dot B)_(i j) = sum_k a_(i k) b_(k j) $
Transposing:
$ [(A dot B)^top]_(i j) = (A dot B)_(j i) = sum_k a_(j k) b_(i k) $

#exbox(
  title: [Let $X$ be a matrix for which $X^(-1)$ exists. Prove that the inverse
    of $X^top$ exists and is $(X^(-1))^top$],
  $
        & bb(1)^top = bb(1) \
     => & (X^(-1) X)^top = bb(1) \
    <=> & X^top (X^(-1))^top = bb(1)
  $,
)

== Tensors

Vectors = tensors of rank 1, matrices = tensors of rank 2

The standart basis for $RR^(n times m times l)$ consists of $n dot m dot l$
basis vectors $E_(i j k)$ where $1<=i<=n, 1<=j<=m, 1<=k<=l$, such that all
components of $E_(i j k)$ are zero except at position $i,j,k$ where the value of
the component is $1$.

= Residual sum of square

Residual sum of square (RSS) is a statistical method that helps identify the
level of discrepancy in a dataset not predicted by a regression model. Thus, it
measures the variance in the value of the observed data when compared to its
predicted value as per the regression model.

#context shared.rss-def

#block(breakable: false, [#context shared.rss-ex])

#let dfn = x => (x, calc.cos(x), calc.sin(x))
#let interpt = dfn(calc.pi / 3)
#let sin-diagram = pad(bottom: 1em, diagram3d(
  width: 8cm,
  height: 6cm,
  xaxis: (ticks: (6, 4, 2, 0)),
  yaxis: (nticks: 4),
  zaxis: (nticks: 4),
  rotations: (
    (
      (-1, 0, 2),
      (-.5, 2, -.5),
      (0, 0, 0),
    ),
  ),
  pt3d.plane(
    pt3d.plane-normal((1, 0, 0), calc.pi / 3),
    stroke: colors.black,
    fill: colors.black.transparentize(80%),
  ),
  pt3d.vec(
    (calc.pi / 3, 0, 0),
    interpt,
    // TODO: fix pt3d stroke2fill bugs
    // stroke: (paint: colors.red, dash: "dashed"),
    stroke: colors.red,
    tip: "o",
    toe: "o",
  ),
  pt3d.vec(
    (calc.pi / 3, interpt.at(1) / 2, interpt.at(2) / 2),
    (calc.pi / 3, 0, 0),
    stroke: colors.red,
    tip: m => text(fill: colors.red)[#v(3em) #box(
        fill: colors.black.lighten(70%),
        inset: .25em,
        $t = pi / 3$,
      )],
  ),
  pt3d.path(
    ..lqcircle().map(((y, z)) => (calc.pi / 3, y, z)),
    stroke-color-fn: (x, y, z) => if y > interpt.at(1) and z > 0 {
      colors.red
    } else {
      colors.darkblue
    },
  ),
  pt3d.path(
    stroke-color-fn: (x, y, z) => if x < calc.pi / 3 { colors.red } else {
      colors.darkblue
    },
    ..pt3d.linspace(0, calc.pi * 2).map(dfn),
  ),
))

= Functions of several variables

Let $D$ and $R$ be two sets. A mapping $f: D -> R$ that associates to each
element $x in D$ exactly one element of $f(x) in R$ is called function.

#deftbl(
  [Domain of $f$],
  $D$,
  [Range of $f$],
  $R$,
  [Real valued function],
  $R subset RR$,
  [Vector valued function],
  $R subset RR^m$,
  [A function of $n$ variables],
  $D subset RR^n$,
)

== Visualizing functions

If $f: D -> R$ is a function from $D subset RR^n$ to $R subset RR^m$ its graph
is defined as:

$
  graph (f) = {(ve(x),ve(y)) in D times R mid(|) x in D and ve(y) = f(ve(x))} subset D times R subset RR^n times RR^m = RR^(n+m)
$

Due to the fact that the visual imagination of humans is limited to at most 3
dimensions, the graph of a function is a useful concept for graphical
illustration if and only if $n + m <= 3$.

#exbox([
  The graph of the function
  $ f: cases(RR &-> RR^2, t &|-> (cos t, sin t)) $
  is
  $
    graph (f) & = {(t,x,y) in RR^3 mid(|) (x,y) = f(t) and t in RR} \
              & ={(t, cos t, sin t) in RR^3 mid(|) t in RR}
  $
  It is displayed below and illustrates how $f$ maps $t$ to the corresponding
  values
  #pad(bottom: 1em, align(center, sin-diagram))
])



#exbox([
  The graph of the function
  $
    g: cases({(x,y) in RR^2 mid(|) x^2 + y^2 <= 1} &-> RR^2, (x,y) &|-> sqrt(1 - x^2 - y^2))
  $
  is
  $
    graph (g) & = {(x,y,z) in RR^3 mid(|) z = sqrt(1 - x^2 - y^2) and x^2 + y^2 <= 1} \
    & ={(x,y,sqrt(1 - x^2 - y^2)) in RR^3 mid(|)x^2 + y^2 <= 1}
  $
  It is displayed below and illustrates how $f$ maps $(x,y)$ to the
  corresponding values #figure([
    #diagram3d(
      width: 10cm,
      height: 8cm,
      // FIXME:
      xaxis: (lim: (-1.25, 1.25), ticks: (-1, -.5, 0, .5, 1)),
      yaxis: (lim: (-1.25, 1.25), ticks: (-1, -.5, 0, .5, 1)),
      zaxis: (lim: (0, 1), nticks: 3),
      title: $g((x,y)) = (x,y,sqrt(1 - x^2 - y^2))$,
      // rotations: (
      //   pt3d.mat-rotate-z(-.3),
      //   pt3d.mat-rotate-y(-1),
      //   pt3d.mat-rotate-x(.2),
      // ),
      pt3d.planeparam(
        (x, y) => {
          let z = 1 - x * x - y * y
          if z < 0 { z } else { calc.sqrt(z) }
        },
        steps: 30,
        fill: colors.blue,
        stroke: colors.darkblue,
      ),
    )
  ]) <figure-1>
])

=== Curves and surfaces

#deftbl(
  [Curves],
  [Vector valued functions of one variable, i.e. they map one-dimensional input
    to multi-dimensional output],
  [$n$-dimensional curve],
  [A continuous function $f : I -> Z$ that maps an interval $I subset RR$ into a
    subset $Z subset RR^n$],
  [Surfaces],
  [Real valued functions of multiple variables, i.e. they map multi-dimensional
    input to one dimensional output],
  [$n$-dimensional\ hyper-surface],
  [
    A continuous real valued function $f : D -> Z$ that maps a sufficiently
    large subset $D subset RR^n$ into a subset $Z subset RR$

    If $n = 2$ a hypersurface is also simply called surface. If $n = 1$ a
    hyper-surface is simply a continuous real valued function of one variable.
  ],
)

The graph of both, an $n$-dimensional curve and an $n$-dimensional
hyper-surface, is a subset of $RR^(n+1)$. A graphical illustration of such a
graph therefore requires $n <= 2$. However, unlike surfaces
#context no-html[which are typically illustrated as in @figure-1], a curve
$c : I -> RR^n$ is usually not illustrated through
$ graph c = {(t, y) in R times R^n mid(|) y = c (t) and t in I} $
Instead curves are typically visualized by skipping the independent variable $t$
from the graph, i.e. by visualizing the image of the curve
$ c (I) = {y in R^n mid(|) y = c (t) and t in I} $
which means that we are projecting the graph of the curve onto the gray plane
that is spanned from the dependent variables. As this kind of plot saves one
dimension we can also visualize curves for which the range $Z$ is a subset of
$RR^3$.

#exbox([
  The graph of the function
  $ f: cases(RR &-> RR^2, t &|-> (cos t, sin t)) $
  is
  $
    graph (f) & = {(t,x,y) in RR^3 mid(|) (x,y) = f(t) and t in RR} \
              & ={(t, cos t, sin t) in RR^3 mid(|) t in RR}
  $
  and its image is the set
  $
    f(RR) & = {f(t) in RR^2 mid(|) t in RR} \
          & = {(cos t, sin t) in RR^2 | t in RR}
  $
  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    sin-diagram,
    diagram2d(
      width: 6cm,
      height: 6cm,
      yaxis: (tick-distance: 0.5),
      legend: (position: bottom + right),
      // lq.path(..lqcut(lqcircle(s: 1, f: -7.4), (-0.5, 0.4), (1, 1.1))),
      lq.path(..lqcircle(f: calc.pi * 3), stroke: colors.darkblue),
      lq.path(
        ..lqcut(lqcircle(f: calc.pi * 3, n: 500), (0.55, 0), (1, 1)),
        stroke: colors.red + 2pt,
      ),
      lq.plot(
        (0.53, 0.53),
        (0.84, 0.84),
        stroke: colors.red,
        mark: mark => place(
          center + horizon,
          circle(fill: colors.red, stroke: colors.red, radius: 2pt),
        ),
        mark-color: colors.red,
        z-index: 99,
        label: $t=pi/3$,
      ),
      lq.plot(
        (0, 0.53),
        (0, 0.84),
        stroke: colors.red,
        mark: mark => place(
          center + horizon,
          circle(fill: colors.red, stroke: colors.red, radius: 2pt),
        ),
        mark-color: colors.red,
        z-index: 99,
      ),
    ),
  )
])

Unlike for image processing, curves are of little importance in machine
learning. On the contrary, hyper-surfaces belong to the most important functions
in machine learning. This is because, to a large extend, machine learning can be
thought of being a branch of statistics. In statistics the most important class
of functions are probability distributions, which are functions mapping subsets
of $R^n$ into $R^+$.

#defbox("Histogram", [
  #let rng = suiji.gen-rng-f(26)
  #let (rng, xs) = suiji.normal-f(rng, size: 400, loc: 35, scale: 5)
  #let (rng, ys) = suiji.normal-f(rng, size: 400, scale: 3)
  #let dist3d = (xp, yp, xn: 10, yn: 10, xlim: auto, ylim: auto) => {
    // TODO: fold init
    let (xmin, xmax) = (calc.min(..xp), calc.max(..xp))
    let (ymin, ymax) = (calc.min(..yp), calc.max(..yp))

    if xlim != auto {
      (xmin, xmax) = xlim
      // xmin = calc.min(xmin, xlim.at(0))
      // xmax = calc.max(xmax, xlim.at(1))
    }
    if ylim != auto {
      (ymin, ymax) = ylim
      // ymin = calc.min(ymin, ylim.at(0))
      // ymax = calc.max(ymax, ylim.at(1))
    }

    let xstep = (xmax - xmin) / (xn)
    let ystep = (ymax - ymin) / (yn)
    let xsteps = range(0, xn).map(x => xmin + xstep * x)
    let ysteps = range(0, yn).map(y => ymin + ystep * y)
    let xres = xsteps.map(x => ysteps.map(_ => x + xstep / 2)).join()
    let yres = xsteps.map(_ => ysteps.map(y => y + ystep / 2)).join()
    // panic(xmin, xstep, xsteps.map(x => x + xstep / 2))

    let xy = xp.zip(yp)
    // TODO: performance or sth
    // FIXME: center the x,y coords, also in pt3d
    let zres = xsteps
      .map(xm => ysteps.map(ym => xy
        .filter(((x, y)) => (
          x >= xm and x < xm + xstep and y >= ym and y < ym + ystep
        ))
        .len()))
      .join()

    let plane = (xres, yres, zres).map(n => n.rev())
    (
      plane: plane,
      points: plane
        .at(0)
        .zip(plane.at(1), plane.at(2))
        .filter(((x, y, z)) => z == 1),
      xsteps: xsteps,
      ysteps: ysteps,
      xstep: xstep,
      ystep: ystep,
    )
  }

  #let num = 11
  #let xlim = (0, 50)
  #let ylim = (-10, 10)
  // TODO: pt3d.distribution
  #let (plane, points, xsteps, ysteps, xstep, ystep) = dist3d(
    xs,
    ys,
    yn: num,
    xn: num,
    xlim: xlim,
    ylim: ylim,
  )
  #let (xsd, ysd, zsd) = plane

  Consider having some amount of 2D datapoints:

  #let xys = xs.zip(ys)
  #align(center, diagram2d(
    xlim: (0, 52),
    ylim: (-11, 11),
    lq.scatter(
      xs,
      ys,
      // color: xys.map(((x, y)) => xys
      //   .filter(((xx, yy)) => {
      //     let yf = y - ystep / 2
      //     let yt = y + ystep / 2
      //     let xf = x - xstep / 2
      //     let xt = x + xstep / 2
      //
      //     yy > yf and yy < yt and xx > xf and xx < xt
      //   })
      //   .len()),
      map: colors-hmap,
    ),
  ))

  We can place a grid over the diagram and count, how many points are in each of
  the boxes.

  #align(center, diagram2d(
    xlim: (0, 52),
    ylim: (-11, 11),
    lq.scatter(
      xsd,
      ysd,
      color: zsd,
      map: colors-hmap,
      size: zsd.map(i => i * 10),
    ),
    ..(..xsteps, xlim.at(1)).map(x => lq.line(
      stroke: colors.comment,
      (x, ylim.at(0)),
      (x, ylim.at(1)),
    )),
    ..(..ysteps, ylim.at(1)).map(y => lq.line(
      stroke: colors.comment,
      (xlim.at(0), y),
      (xlim.at(1), y),
    )),
  ))

  We can now plot a diagram that maps the $x$ and $y$ coordinate of the center
  of each of the boxes to the number of hits of this particular box and thus end
  up with a diagram that is called a _histogram_.

  #align(center, diagram3d(
    xaxis: (lim: xlim, nticks: 5),
    yaxis: (lim: ylim, nticks: 4),
    zaxis: (lim: (0, 50), nticks: 5),
    // rotations: (
    //   pt3d.mat-rotate-x(1),
    // ),
    // pt3d.plane(
    //   pt3d.plane-normal((0, 0, 1), 0),
    //   fill: rgb(0, 125, 125),
    //   stroke: rgb(0, 125, 125),
    // ),
    // TODO: pt3d builtin
    pt3d.planeplot(
      ..plane,
      num: num,
      fill-color-fn: h-color-fn.with(lim: (0, calc.max(..zsd))),
      stroke: black + 0.25pt,
    ),
    // TODO: points
    // ..pts.map(p => pt3d.vec(p)),
  ))

  We can try to create a histogram with boxes of infinitely small size. The
  problem with this approach is, that the number of hits per box decreases when
  the size of the boxes is getting smaller.

  In order to compensate that, we therefore need more datapoints. If we do that,
  the histogram is being transformed into a function, that associates a number
  to each position on the diagram, that can be interpreted as likelihood for a
  point to be almost next to this position: the higher this number is, the more
  likely it is. This function is called the *probability density* of the
  experiment.

])

==== Vector similarity

One approach to decide, whether two images are similar or not, is to first
extract features (such as corner-points, edges, etc.) from each of the images,
and store these features in a list of numbers, which is called _feature vector_.
It is reasonable to assume, that similar images are mapped to similar feature
vectors.

Two vectors $v$ and $w$ are *similar*, if both vectors head into the same
direction and are of similar length, so if the difference $v-w$ between both
vectors has a small length. In vector geometry, the length of a vector is called
a *norm*, and the distance between two vectors is called a *metric*. A norm
$norm(dot)$ is thus a function that associates with a vector $x$ a positive
number $norm(x)$ , which is interpreted as length of $x$.

$ norm(dot) : cases(RR^n &-> RR^(+), x &|-> sqrt(sum_(i=1)^n x^2_i)) $

$= n$-dimensional Euclidean norm or $l^2$-norm, written also as $norm(x)_2$.

Once a vector space is equipped with a norm $norm(.)$, we can also associate a
metric with that vector space, which uses the notion of a length to measure the
distance between pairs of vectors:

$ d(dot,dot): cases(RR^n times RR^n &-> RR^(+), (u,v) &|-> norm(u-v)) $

$=$ metric. The value $d(u,v)$ is identical to the length of the vector that
heads from $v$ to $u$.

#align(center, diagram2d(
  lq.line(
    tip: tiptoe.stealth,
    stroke: color-cycle.at(0),
    (0, 0),
    (1, 2),
    label: $ve(u)$,
  ),
  lq.line(
    tip: tiptoe.stealth,
    stroke: color-cycle.at(1),
    (0, 0),
    (2, -1),
    label: $ve(v)$,
  ),
  lq.line(
    tip: tiptoe.stealth,
    stroke: (paint: color-cycle.at(2), dash: "dashed"),
    (2, -1),
    (1, 2),
  ),
  lq.line(
    tip: tiptoe.stealth,
    stroke: color-cycle.at(2),
    (0, 0),
    (-1, 3),
    label: $ve(u) - ve(v)$,
  ),
))

=== Vector valued functions of several variables

In machine learning many functions are vector valued functions of many
variables, like linear transformations. Neural networks are typically defined to
be a stack of unknown linear transformations, each of which being followed by a
rather simple, predefined non-linear operation. Training a neural network is
therefore almost equivalent to finding suitable linear transformations that make
the network perform the desired operation.

Besides curves and surfaces there are functions that take multi-dimensional
input and deliver multi-dimensional output. In order to get an idea how these
functions look like, we often display low-dimensional "sections" of the function
that can either be displayed as curves or as surfaces. There is however another
way, how these functions can be displayed, namely using a *vector field*.

// #exbox(title: "Spaceship (vector field)", [
//   A space-ship traveling close to the sun is experiencing a gravitational force
//   that - outside the sun - can be described using the following function:
//   $
//     F : cases({r in RR^3 mid(|) abs(r) > r_"Sun"} &-> RR^3, r &|-> -G dot m_"Sun" m_"Ship" r/norm(r)^3)
//   $
//   $r_"Sun" =$ radius of the sun, $G$ = gravitational constant,
//   $m_"Sun",m_"Ship"$ = masses of the sun and space ship.
//
//   If the center of the sun is located at $r=0$, the input vector $r$ denotes the
//   position of the space ship as seen from the center of the sun and $F$ denotes
//   the gravitational force that the space ship is experiencing.
//
//   From a mathematical perspective the constants are not important. Therefore we
//   simplify the formula by setting all of the constants to $1$, which leads to:
//
//   $
//     F : cases({r in RR^3 mid(|) abs(r) > 1} &-> RR^3, r &|-> -r/norm(r)^3)
//   $
//
//   In order to better understand the formula of the force field, we calculate the
//   force experienced from the space ship at position $r= (1,2,2)^top$. Note first,
//   that $r$ is in the domain of definition of $F$ , because its norm is greater
//   than $r_"Sun" = 1$
//
//   $ norm(r) = sqrt(1^2+2^2+2^2)=sqrt(9)=3 $
//
//   This simply indicates, that the spaceship resides at a location exterior to
//   the sun. We can therefore use this to calculate the force that the space ship
//   is experiencing:
//
//   $
//     F vec(1, 2, 2) = -1/norm((1, 2, 2)^top)^3 vec(1, 2, 2) = -1/3^3 vec(1, 2, 2) = -1/27 vec(1, 2, 2)
//   $
//
//   We can now continue to calculate values of the force $F$ at other locations
//   and try to graphically visualize the result. Since the graph of $F$
//
//   $
//     graph(F) = {(r,f) in RR^3 times RR^3 mid(|) norm(r) > 1 and f = - r/norm(r)^3}
//   $
//
//   is a subset of a $3+3=6$-dimensional space, we cannot however not draw the
//   graph of $F$ directly in any meaningful way. A possibility to still visualize
//   this function, is to draw the function as *vector field*. By this we mean that
//   we place 3-dimensional arrows representing $F$ at different points in a
//   3-dimensional space that identify the physical location of the space ship. The
//   arrow that is placed at position $r$ has a length proportional to the norm of
//   the force $F(r)$ and a direction parallel to the direction of the force. It
//   thus tells you the strength and direction in which the space ship is pulled
//   due to the gravitational force.
//
//   #let xs = lq.linspace(0, 10)
//   #let ys = lq.linspace(0, 1)
//
//   #grid(
//     columns: 2,
//     [#todo("pt3d vector field")
//       #diagram3d()
//     ],
//     [#todo("2d repr")
//       #diagram2d(
//         width: 100%,
//         // lq.plot(xs,ys, mark: none)
//       )],
//   )
//
//
//   The mathematical tool for determining the "strength of the field" is the *norm
//   of a vector*, which measures the length of a vector and thus encodes the
//   strength of a field. If we calculate $norm(F(r))$ in our case, we get
//   $ norm(F(r)) = norm(-r/norm(r)^3) = norm(r)/norm(r)^3 = 1/norm(r)^2 $
//   which illustrates that the force is getting smaller, the larger $abs(r)$ is
//
//   The mathematical tool for determining the "direction of a field" are *unit
//   vectors*. The unit vector of $r$ is a vector of length one, that points into
//   the same direction as $r$. It thus encodes information regarding the direction
//   of $r$, but not regarding its length. The unit vector of $r$ is usually
//   denoted by $e_r$. It can be calculated via
//
//   $ e_r = 1/norm(r) dot r $
//
// ])

== Calculus of curves

#defbox("Coordinate functions", [
  Let $I subset RR$ be an interval and $c:I->RR^n$ be an arbitrary curve. Then
  there are $n$ (contiguous) coordinate functions $c_i:I->RR$, such that
  $ c(t) = vec(c_1 (t), c_2 (t), dots.v, c_n (t)) $
  and vice versa: If $n$ real valued (continuous) functions $c_i:I->RR$ with a
  common interval $I$ as domain of definition are given, we can define a curve
  $c(t)$ whose coordinate functions are $c_1, c_2, ..., c_n$.
])

The decomposition of curves into coordinate functions allows us to generalize
most of the concepts from previous analysis courses to curves:

We consider the curve
$ f: cases((0;oo)&->RR^2, t&|->vec(cos(t), sin(t)/t)) $
The component functions are
$
  f_1 (t): cos(t) \
  f_2 (t): sin(t)/t\
$
We can thus argue:
#defbox("Continuity", [
  Since both of the component functions are continuous, $f$ is continuous.
])
#defbox(
  "Limit point",
  $
    &lim_(t->0) f_1 (t) = lim_(t->0) cos(t) = cos(0) = 1 \
    &lim_(t->0) f_2 (t) = lim_(t->0) sin(t)/t =^"\"0/0\"" lim_(t->0) (dif/(dif t) sin(t))/(dif/(dif t) t) = lim_(t->0) (cos(t))/1 = cos(0) = 1 \
    => &lim_(t->0) f(t) = vec(1, 1)
  $,
)
#defbox(
  "Derivative",
  $
    & dif/(dif t) f_1 (t) = dif/(dif t) cos (t) = -sin(t) \
    & dif/(dif t) f_2 (t) = dif/(dif t) sin(t)/t = (cos(t) dot t - sin(t) dot 1)/t^2 = cos(t)/t - sin(t)/t^2 \
    => & dif/(dif t) f(t) = vec(-sin(t), cos(t)/t - sin(t)/t^2)
  $,
)
#defbox(
  [Linearisation at $t = pi$],
  $
    & f_1 (t) approx f_1 (pi) + f'_1 (pi) (t - pi) = cos(pi) - sin(pi) (t - pi) = -1 \
    & f_2 (t) approx f_2 (pi) + f'_2 (pi) (t - pi) = sin(pi)/pi +(cos(pi)/pi - sin(pi)/pi^2)(t - pi) = -1/pi (t - pi) \
    => & f(t) approx f(pi) + f'(pi) (x - pi) = vec(-1, - 1/pi (t - pi)) = vec(-1, 0) - (t - pi) vec(0, 1/pi)
  $,
)

// #todo("diagram")

For any $ve(a), ve(v) in RR^n$ a curve of the form
$g:cases(RR &-> RR^n, t &|-> ve(a) + t dot ve(v))$ corresponds to a line going
through the point $a$ in the direction of $v$.

// #todo("Notes 30/31")

#defbox(
  "Reparametrization",
  [
    Let
    $ c: cases(I &-> RR^n, t &|-> c(t)) $
    be a curve and $h:J->I$ an arbitrary bijective function. Then the image of
    the curve
    $ d: cases(J &-> RR^n, s &|-> c(h(s))) $
    is identical to the image of the curve $c(t)$:
    $ c(I) = d(J) $
    We call $d(s)$ _reparametrization_ of $c(t)$ using $t = h(s)$
  ],
)

// #todo("rest of chapter")

#defbox("Image of a curve", [
  The image of a curve
  $ c: cases(I &-> RR^n, t &|-> c(t)) $
  can be envisioned as a road that is passed from a passenger, who reaches
  position $c(t)$ at time $t$. Thus:

  - The *derivative* $c'(t)$ is a *measure of the speed* of the person at time
    $t$.
  - The *derivative* $c'(t)$ points into a *direction tangent to the road* at
    position $c(t)$
  - The *norm* $norm(c'(t))$ of the derivative is *a measure of the speed* with
    which the person is moving *at time* $t$.

  If we reparametrize the curve $c$ with a bijective function $t = h(s)$ the
  image of the curve
  $ d(s) = c(h(s)) $
  is identical to the image of $c$ and thus corresponds to the same road. It is
  however passed by another person, who is passing point $d(s) = c(h(s))$ with a
  velocity
  $ d'(s) = c'(h(s)) dot h'(s) $
  that is $h'(s)$ faster (or slower) than the velocity of the first person at
  time $t = h(s)$.
])

// #todo("formal proof (Notes 33/34)")

== Calculus of real valued functions in many variables

=== Partial derivative and gradient

Let $f: D -> RR$ be an arbitrary real valued function and $x in D subset RR^n$
be an arbitrary vector in the domain of $f$. We consider the domain $D$ of $f$
to be sufficiently large for doing calculus at $x$, if for every vector
$v in RR^n$ there is a small interval $(-epsilon; epsilon), epsilon > 0$, such
that for all $t in (-epsilon;epsilon)$ the vector $x + t dot v in D$. This
condition guarantees that any curve that hits the domain of $f$, remains there
for at least a short period of time, and is one of the properties that needs to
be satisfied in order to denote $f$ as a hyper-surface. The other property that
is required for $f$ to be a hyper-surface, is that $f$ is continuous at any
point of its domain.

#defbox("Partial derivative", [

  The _partial derivative_ of $f$ with respect to the $i$-th coordinate function
  is defined through
  $ partial/(partial x_i) f(x) = lim_(t->0) (f(x + t dot e_i) - f(x))/t $
])
#defbox("Gradient", [
  The _gradient_ of $f$ is an $n$-dimensional row vector, whose components
  correspond to the various *partial derivatives*.
  $
    gradient f(x) = (partial/(partial x_1) f(x), partial/(partial x_2) f(x), ..., partial/(partial x_n) f(x))
  $
])

#exbox(
  title: $
    f : cases(RR times RR &-> RR, (x,y) &|-> x^2 y^3) \
  $,
  $
    f'_x (x,y) = (partial f)/(partial x) = 2x dot y^3 \
    f'_y (x,y) = (partial f)/(partial y) = x^2 dot 3y^2 \
    gradient f(x,y) = ((partial f)/(partial x),(partial f)/(partial y)) = (2x dot y^3, x^2 dot 3y^2)
  $,
)

=== Compositions of functions

We can use the notion of dependent variables as an alternative representation of
functions, this notion allows us to define functions without explicitly stating
its arguments.
// #todo("example (Notes 40)")

// === Partial and total derivative
//
// #todo("")

=== Commutative diagrams

#grid(
  columns: 2,
  align: center + horizon,
  diagram(
    node-shape: fletcher.shapes.ellipse,
    node(
      text(fill: colors.darkblue)[$D$],
      enclose: ((-4, -2), (0, 2)),
      name: <v>,
      stroke: colors.darkblue,
    ),
    edge(
      <v>,
      <im>,
      "-|>",
      label: text(fill: colors.darkblue)[$f$],
      stroke: colors.darkblue,
    ),
    node(
      (4, 0),
      text(fill: colors.darkblue)[$M$],
      name: <im>,
      shape: circle,
      stroke: colors.darkblue,
    ),
    node(
      pad(left: 3em, text(fill: colors.red)[$N$]),
      enclose: ((4, -2), <im>, (5, 2)),
      stroke: colors.red,
    ),
    edge("-|>", label: text(fill: colors.red)[$g$], stroke: colors.red),
    node(
      text(fill: colors.red)[$R$],
      enclose: ((8, -1), (9, 1)),
      stroke: colors.red,
    ),
  ),
  diagram(
    node-stroke: none,
    spacing: (9em, 0em),
    node((0, 0), $D$, name: <d>),
    edge("-|>", label: $f$, label-side: left),
    node((1, 0), $M$, name: <m>),
    edge("-|>", label: $g$, label-side: left),
    node((2, 0), $R$, name: <r>),
    edge(<d>, <r>, "-|>", label: $g compose f$, bend: 25deg, label-side: left),
  ),
)

Let us assume that
$
  f : cases(D &-> M, x &|-> f(x)), space space
  g : cases(N &-> R, y &|-> g(y)), space space
  h : cases(D &-> R, x &|-> g(f(x))) = g compose f
$
The graph

#align(center, diagram(
  spacing: (5em, 0em),
  node-stroke: none,
  node((0, 0), $D$),
  edge($f$, "-|>", label-side: left),
  node((1, 0), $M subset N$),
  edge($g$, "-|>", label-side: left),
  node((2, 0), $R$),
))

illustrates that $f$ is a function from $D$ to $M$, $g$ is a function from $N$
to $R$ and $M$ is a subset of $N$. Alternatively, for every set $Q$, such that
$M subset Q subset R$ we could also have written

#align(center, diagram(
  spacing: (5em, 0em),
  node-stroke: none,
  node((0, 0), $D$),
  edge($f$, "-|>", label-side: left),
  node((1, 0), $Q$),
  edge($g$, "-|>", label-side: left),
  node((2, 0), $R$),
))

indicating that $f$ maps $D$ into a subset of $Q$, which in turn is a subset of
the domain of $g$ and thus can be mapped to $R$ using $g$.

A _commutative diagram_ is an extension of the previous diagram, in which we add
an additional arrow pointing from $D$ to $R$.

#align(center, diagram(
  node-stroke: none,
  spacing: (5em, 0em),
  node((0, 0), $D$, name: <d>),
  edge("-|>", label: $f$, label-side: left),
  node((1, 0), $N$, name: <m>),
  edge("-|>", label: $g$, label-side: left),
  node((2, 0), $R$, name: <r>),
  edge(<d>, <r>, "-|>", label: $h$, bend: 40deg, label-side: left),
))

By labeling this additional arrow with $h$, a commutative diagram can be used to
define a function from $D$ to $R$, that is behaving such, that it maps every
$x in D$ to exactly the same element as the composition of $g$ with $f$.

#exbox(
  title: $$,
  grid(
    align: center + horizon,
    columns: (1fr, 1fr),
    [
      $
           #td($g(x)$) & = x^2 \
           #tp($f(x)$) & = sqrt(x) \
        #tr($f(g(x))$) & = sqrt(x^2)   && = abs(x) \
        #tr($g(f(x))$) & = (sqrt(x))^2 && = abs(x)
      $
    ],
    diagram(
      node-stroke: none,
      node((0, 0), text(size: 1.5em)[$RR^+$], name: <r1>),
      node((4, 0), text(size: 1.5em)[$RR^+$], name: <r2>),
      node((0, 4), text(size: 1.5em)[$RR^+$], name: <r3>),
      node((4, 4), text(size: 1.5em)[$RR^+$], name: <r4>),
      edge(
        <r1>,
        <r2>,
        "->",
        label: td($dot^2$),
        label-side: left,
        stroke: colors.darkblue,
      ),
      edge(
        <r3>,
        <r4>,
        "->",
        label: td($dot^2$),
        label-side: right,
        stroke: colors.darkblue,
      ),
      edge(
        <r1>,
        <r3>,
        "->",
        label: tp($sqrt(dot)$),
        label-side: right,
        stroke: colors.purple,
      ),
      edge(
        <r2>,
        <r4>,
        "->",
        label: tp($sqrt(dot)$),
        label-side: left,
        stroke: colors.purple,
      ),
      edge(
        <r1>,
        <r4>,
        "..>",
        label: tr($abs(dot)$),
        label-side: left,
        stroke: colors.red,
      ),
    ),
  ),
)

== Calculus of vector valued functions of many variables

=== Jacobian matrix and linearisation

In the theory of real valued functions in one variable the linearisation of
$f : RR -> RR$ at $x_0 in RR$ is done via
$ f(x) approx f(x_0) + f'(x_0) dot (x - x_0), x approx x_0 $
and can be interpreted as:

+ First order Taylor polynomial of $f$, which implies that the linearisation of
  $f$ at $x_0$ is that first order polynomial which best approximates $f$ in the
  vicinity of $x_0$.
+ Identifying that particular line that fits best to the graph of $f$ in a
  neighborhood of $x_0$. This line is known as tangent of $f$ at $x_0$.
+ Definition of the derivative of $f$ at $x_0$.
  $ f'(x_0) approx (f(x) - f(x_0))/(x - x_0) "for" x approx x_0, x != x_0 $
  tells us that both sides of this equation become equal for $x -> x_0$, and
  therefore equivalent to the definition of the derivative of $f$ at $x_0$
  $ f'(x_0) = lim_(x->x_0) (f(x) - f(x_0))/(x - x_0) $

In the theory of vector valued functions of many variables, the linearisation of
a vector valued function in $n$ variables $f: RR^n -> RR^m$, itself has to be a
mapping from $RR^n$ to $RR^m$. Further, the right hand side has to be an affine
transformation, i.e. a function of the form
$ A_(a,M) (x) = a + M dot x $
in which $M$ is a matrix and $a$ is a vector. Since we expect that $A_(a,M)$ to
map $RR^n$ to $RR^m$, we can infer that $a in RR^m$ and $M in RR^(m times n)$.

The *derivative of a vector valued function* $f:RR^n->RR^m$ can thus be expected
to be a matrix $M in RR^(m times n)$. This matrix is called _Jacobian matrix_
and it can be shown that this matrix is comprised of all partial derivatives of
all component functions of $f$.

#defbox("Jacobian matrix", [
  Let $f:RR^n->RR^m$ be a some vector valued function and $x_0 in RR^n$ be a
  point, where the partial derivatives of all component functions
  $partial_x_k f_l (x_0)$ exist. The $(m times n)$-matrix that aggregates all
  partial derivatives of $f$ at $x_0$
  $
    J_f (x_0) = mat(
      partial_x_1 f_1 (x_0), partial_x_2 f_1 (x_0), ..., partial_x_n f_1 (x_0);
      partial_x_1 f_2 (x_0), partial_x_2 f_2 (x_0), ..., partial_x_n f_2 (x_0);
      dots.v, dots.v, dots.down, dots.v;
      partial_x_1 f_m (x_0), partial_x_2 f_m (x_0), ..., partial_x_n f_m (x_0);
    )
  $
  such that the $l$-th row of $J_f (x_0)$ corresponds to the gradient of the
  $l$-th coordinate function $f_l$, is called _Jacobian matrix_ of $f$ at $x_0$.
  Besides of the symbol $J_f (x_0)$ the following notations are also used for
  the Jacobin matrix at $x_0$:
  $ f'(x_0) = subst((partial f)/(partial x), x = x_0) = J_f (x_0) $
])

// #exbox(title: "Jacobian matrix", todo[])

#defbox("Linearisation", [
  Let $f:RR^n->RR^m$ be a some vector valued function and $x_0 in RR^n$ be an
  arbitrary point from the domain of definition of $f$ If
  $J_f (x_0) = subst((partial f)/(partial x), x=x_0)$ is the Jacobin matrix of
  $f$ at $x_0$, then
  $ f(x) approx f(x_0) + J_f (x_0) dot (x - x_0) "for" x approx x_0 $
  The function on the right-hand side is called _linearisation_ of $f$ at $x_0$.
])

// #exbox(title: "Linearisation", todo[])

== Summary derivatives

#deftbl(
  align: center + horizon,
  term: "Function",
  definition: "Derivative",
  $ f: cases(RR &-> RR^n, x &|-> y) $,
  $
    f': cases(RR &-> RR^n, x &|-> y) = vec(dif/(dif x) f_1(x), dif/(dif x) f_2(x), dots.v, dif/(dif x) f_n (x))
  $,
  $ f: cases(RR^n &-> RR, x &|-> y) $,
  $
    f': cases(RR^n &-> RR^(1 times n), x &|-> y) = (partial/(partial x_1) f(x), partial/(partial x_2) f(x), dots, partial/(partial x_n) f(x)) = gradient f
  $,
  $ f: cases(RR^n &-> RR^m, x &|-> y) $,
  $
    f': cases(RR^n &-> RR^(m times n), x &|-> y) = vec(gradient f_1 (x), gradient f_2 (x), dots.v, gradient f_m (x)) = mat(
      partial/(partial x_1) f_1 (x), partial/(partial x_2) f_1 (x), ..., partial/(partial x_n) f_1 (x);
      partial/(partial x_1) f_2 (x), partial/(partial x_2) f_2 (x), ..., partial/(partial x_n) f_2 (x);
      dots.v, dots.v, dots.down, dots.v;
      partial/(partial x_1) f_m (x), partial/(partial x_2) f_m (x), ..., partial/(partial x_n) f_m (x);
    ) = J_f
  $,
)

=== Chain-rule for vector valued functions in many variables

#defbox("Jacobian matrix chain rule", [
  Let $f$ and $g$ be given such that the following diagram commutes

  #let edge = edge.with(crossing-fill: colors.purple.lighten(95%))
  #align(center, diagram(
    node-stroke: none,
    spacing: (3em, 1em),
    node((0, 0), $RR^n$, name: <rn>),
    edge("->", label: $f$, label-side: left),
    node((1, 0), $RR^k$),
    edge("->", label: $g$, label-side: left),
    node((2, 0), $RR^m$, name: <rm>),
    edge(<rn>, <rm>, "->", label: $g compose f$, bend: 40deg, label-side: left),
  ))

  Then we can calculate the Jacobian matrix of $g compose f$ using the chain
  rule
  $
    (partial g(f(x)))/(partial x) = subst((partial g(f))/(partial f), f=f(x)) dot (partial f(x))/(partial x) = J_g (f(x)) dot J_f (x)
  $
])

#defbox("Chain rule for hyper-surfaces", [
  Let $f : RR^m -> RR$ be a hyper-surface and $g : RR^n -> RR^m$ a vector valued
  function, such that $h = f compose g$ is defined. Then
  $
    gradient h(x) = gradient f(g(x)) = subst(gradient f(g), g=g(x)) dot partial/(partial x) g(x)
  $
])

#defbox("Properties of differentiation of hyper-surfaces", [
  Let $f:RR^n -> RR$ and $g:RR^n-> RR$ be hyper-surfaces. Then
  $
      gradient (f + g) & = gradient f + gradient g \
      gradient (f - g) & = gradient f - gradient g \
    gradient (f dot g) & = g gradient f + f gradient g \
          gradient f/g & = (g gradient f - f gradient g)/(g^2) \
  $
])

// #todo[notes 26.03.26]

// #todo[
//   BIAS: We say that a model has low bias if it leads to a good approximation of
//   reality, and that a model has high bias if it cannot accurately reflect our
//   measurements.
//
//   NOISE: Typically the data in the training dataset is the outcome of some
//   measurement and thus contains noise. “Noise” has a negative effect during
//   training, and in general we do not want the system to “learn noise”. One way
//   to prevent a machine learning system from learning “noise” is to use large
//   datasets, as statistics tells us that the average amount of noise tends to
//   zero for large datasets.
//
//   COST FUNCTION: To measure the deviation between prediction and expectation we
//   use cost functions. Technically speaking, a cost function is a real valued
//   function that maps model parameters to $RR^+$ in such a way that parameter
//   choices resulting in lower bias correspond to lower values of the cost
//   function (low bias = low cost). One way to define a cost function, is to use
//   the Euclidean distance between the (column) vector of predicted results and
//   the (column) vector of expected results. We can do this by first adding a
//   column containing the values of the predicted results, which depends on the
//   model parameters and a column that measures the deviation of the prediction
//   from the expectation, which is called the residuum $r$:
// ]

= Geometry of hyper-surfaces

== Introduction

#deftbl(
  [Training sample],
  [Knowledge of in- and outputs prior to learning],
  [Supervised learning],
  [A process for finding suitable values of parameters that make the system
    respond as desired for as many training samples as possible],
  [Cost functions],
  [
    Process of finding the values in supervised learning. Function of $n$
    parameters that maps them to a high value if the misclassification is high
    and low if otherwise:
    $
      c : RR^n -> RR
    $],
  [Train],
  [Feed the system with training samples and find the best parameters in the
    process in searching for the (global) minimum of the cost function],
)

=== Visualizing surfaces

To a large extend, the world we live in can be envisioned as a two dimensional
surface that is embedded in three dimensional space. Using this analogy you can
take away two important methods for visualizing surfaces: surface-plots (3d) and
contour-plots (2d).

$ f(x,y) = x^2 y^3 $

// FIXME: pt.linspace
#let xs = lq.linspace(-1, 1, num: 25)
#let ticks = lq.linspace(-1, 1, num: 5)
#let fn = (x, y) => calc.pow(x, 2) * calc.pow(y, 3)

#grid(
  columns: (1fr, 1fr),
  [Surface-plot], [Contour-plot],
  diagram3d(
    width: 9cm,
    height: 7cm,
    xaxis: (lim: (-1, 1), ticks: ticks),
    yaxis: (lim: (-1, 1), ticks: ticks),
    zaxis: (lim: (-1, 1), ticks: ticks),
    rotations: (
      pt3d.mat-rotate-y(-.5),
      pt3d.mat-rotate-x(.5),
      // pt3d.mat-rotate-z(.5),
    ),
    pt3d.planeparam(
      steps: 40,
      stroke-color-fn: h-color-fn,
      fill-color-fn: h-color-fn,
      fn,
    ),
    // pt3d.planeparam(
    //   steps: 30,
    //   stroke-color-fn: (x, y, z) => if z == 0 { black } else { none },
    //   fill-color-fn: none,
    //   fn,
    // ),
  ),
  ctd(
    width: 7cm,
    height: 7cm,
    xaxis: (tick-distance: .5),
    yaxis: (tick-distance: .5),
    contour(xs, xs, fn, levels: 30),
  ),
)

=== Tangent space and linearisation of a surface

// Let $f : & RR^2 -> RR$ be a surface and $graph(f) = & {(x,y,f(x,y)) in RR^3
//   mid(|) (x,y) in RR^2}$ its graph. We want to study curves that reside
// completely within this surface, i.e. we want to study curves
// $
//   c : & cases(RR &-> graph (f) subset RR^3, t &|-> (x(t),y(t),z(t))^top) \
// $
// for which ${c(t) mid(|) t in RR} subset graph (f) <=> & z(t) = f(x(t), y(t))$.
// Or - phrased differently - that the diagram
//
// #align(center, diagram(
//   node-stroke: none,
//   spacing: (3em, 1em),
//   node((0, 0), $RR$, name: <r1>),
//   node((2, 0), $RR^2$, name: <r2>),
//   node((2, 2), $RR$, name: <r3>),
//   edge(<r1>, <r2>, "->", label-side: left, label: $(x(t),y(t))$),
//   edge(<r2>, <r3>, "->", label-side: left, label: $f(x,y)$),
//   edge(<r1>, <r3>, "->", label-side: right, label: $z(t)$),
// ))
//
// commutes.
//
// #todo[diagram (script 81)]

#defbox("Set of all tangent directions", [
  Let $f:RR^2->RR$ be a surface and $p = (x_0,y_0, f(x_0,y_0)) in graph f$. Then
  the set of all tangent directions to curves $c(t)$ with $c(t) = p$ that reside
  entirely inside graph $f$ is given by
  $
    T = {alpha vec(1, 0, partial_x f(x_0, y_0)) + beta vec(0, 1, partial_y f(x_0, y_0)) mid(|) alpha, beta in RR}
  $
])

#defbox("Tangent space", [
  The set of all points
  $
    T = {
      vec(x_0, y_0, f(x_0, y_0))
      + alpha vec(1, 0, partial_x f(x_0, y_0))
      + beta vec(0, 1, partial_y f(x_0, y_0))
      mid(|) alpha, beta in RR
    }
  $
  that can be reached from $p$ by traveling into a tangent direction, is a
  2-dimensional plane, which is called _tangent space_ of $f$ at $p$.
])

#defbox("Graph of a linearisation", [
  Let $f: RR^n -> RR$ be a real valued function in $n$ variables and $x_0 in
  RR^n$. Then the graph of the linearisation
  $
    l(x) = f(x_0) + gradient f (x_0) dot (x - x_0)
  $
  is identical to the tangent space $T_p_0$ of $f$ at $p_0 = (((x_0))_1,
    ((x_0))_2, ..., ((x_0))_n, f(x_0))^top$.
])

== Optimization problems

=== Extreme values and stationary points

Let $f:D -> RR$ with $D subset RR^n$ be a hyper-surface.

#deftbl(
  [Upper bound],
  [
    Any number $u in RR$, such that $f(x) <= u$ for all $x in D$ is called an
    _upper bound_ of $f$
  ],
  [Lower bound],
  [
    Any number $l in RR$, such that $f(x) >= l$ for all $x in D$ is called a
    _lower bound_ of $f$
  ],
  [Global maximum],
  [
    An upper bound $u$ is called _global maximum value_ or _absolute maximum
    value_ of $f$, if $u in f(D)$. The value $x_0$ is called the _global maximum
    point_ or _absolute maximum point_
  ],
  [Global minimum],
  [
    A lower bound $l$ is called _global minimum value_ or _absolute minimum
    value_ of $f$, if $l in f(D)$. The value $x_0$ is called the _global minimum
    point_ or _absolute minimum point_
  ],
  [Local maximum],
  [
    Any point $x_0 in D$ such that, whenever $x approx x_0 and f(x) <= f(x_0)$
    is called _local maximum point_ and the value $f(x_0)$ is called _local
    maximum value_
  ],
  [Local minimum],
  [
    Any point $x_0 in D$ such that, whenever $x approx x_0 and f(x) >= f(x_0)$
    is called _local minimum point_ and the value $f(x_0)$ is called _local
    minimum value_
  ],
)

#defbox("Stationary", [
  Let $f:D -> RR$ with $D subset RR^n$ be a hyper-surface that can be
  differentiated. Any point $x_0 in D$ with $gradient f (x_0) = 0$ is called
  _stationary_.
])

#obsbox([
  If $x_0$ is a local extremal point, then $f$ is stationary at $x_0$, i.e.
  $gradient f (x_0) = 0$.
])

Stationary points can also identify positions, at which a function is becoming
flat into one direction without loosing its monotony.

Finally, there is a third scenario, which can occur: _saddle points_. Saddle
points require functions that depend on at least two variables, because the
domain of such functions is sufficiently large to move into at least two
different directions without leaving the graph. In such a case it can happen,
that a stationary point appears to be as a maximum value in one direction, and
as a minimum value in another direction.

// #todo[diagrams (script 90) + head of page 91]

=== Necessary and sufficient conditions for extremal values

Notation for second derivative:
$
  partial/(partial x) (partial/(partial x) (f(x,y))) = (partial^2 f(x,y))/(partial
  x^2) = partial_(x x) f(x,y)
$

#defbox("Hessian matrix", [
  Let $f:D -> RR$ with $D subset RR^n$ be a hyper-surface. The matrix $H(x)$,
  whose components are
  $
    (H(x))_(i j) = partial/(partial x_i) partial/(partial x_j) f(x)
  $
  is called _Hessian matrix_. The Hessian matrix is the generalization of the
  second order derivation to hyper-surfaces.
])


Let $z = f(c(t))$, $c$ a curve passing our stationary point $c_0 = (x_0, y_0)$
at $t = t_0$ and
$
  (dif^2 z)/(dif t^2) = underbrace(
    (accent(c, dot)_1 (t_0),
      accent(c, dot)_2 (t_0)), v^top
  ) dot
  underbrace(
    mat(
      f_(x x) (c_0), f_(x y) (c_0); f_(y x) (c_0), f_(y y)
      (c_0)
    ), H
  ) dot underbrace(
    vec(
      accent(c, dot)_1 (t_0), accent(
        c,
        dot
      )_2 (t_0)
    ), v
  )
$
then
- If $forall v in RR^2 without {ve(0)} (v^top H v > 0)$, then
  $(dif^2 z)/(dif t^2) > 0$ defines a _local minimum_ at $c_0$ and $H$ is called
  _positive definite_
- If $forall v in RR^2 without {ve(0)} (v^top H v >= 0)$, then
  $(dif^2 z)/(dif t^2) >= 0$ defines either a _local minimum_ or _non-extremal_
  at $c_0$ and $H$ is called _positive semi-definite_
- If $forall v in RR^2 without {ve(0)} (v^top H v < 0)$, then
  $(dif^2 z)/(dif t^2) < 0$ defines a _local maximum_ at $c_0$ and $H$ is called
  _negative definite_
- If $forall v in RR^2 without {ve(0)} (v^top H v <= 0)$, then
  $(dif^2 z)/(dif t^2) <= 0$ defines either a _local maximum_ or _non-extremal_
  at $c_0$ and $H$ is called _negative semi-definite_
- In both of those cases, i.e. $forall v in RR^2 without {ve(0)} (v^top H
    v < 0 or v^top H v > 0)$, the point $c_0$ is a _saddle point_ and $H$ is
  called _indefinite_
- In all other cases it defines nothing and further investigation is needed

#obsbox(
  [
    The Hessian matrix is always symmetric, i.e. that $partial_i partial_j f =
    partial_j partial_i f$
  ],
  [
    Eigenvalues of Hessian matrices will thus always be $in RR$
  ],
)

// #exbox(todo[finding extremal points])

=== Analyzing the Hessian Matrix

Let $M in RR^(n times n)$ be a quadratic matrix and
$ q_M (v) = v^top M v $
its associated quadratic form. Then the quadratic matrix
$ H = 1/2 (M + M^top) $
is symmetric and satisfies
$ forall v in RR^n (q_M (v) = q_H (v)) $

#defbox("Monomial", [
  Let $alpha in RR$ and $k_1, k_2, ..., k_n in NN$. The real valued function
  $
    f: cases(
      RR^n & -> RR, (x_1, x_2, ..., x_n) &|-> alpha x_1^(k_1) dot
      x_2^(k_2) dot ... dot x_n^(k_n)
    )
  $
  is called _monomial in $n$ variables_. The value $alpha$ is called the
  _coefficient of the monomial_. If $alpha != 0$ the number $k=k_1+k_2+...+k_n$
  is called the _degree of the monomial_. Note that this definition implies that
  a constant function $f(x) = alpha != 0$ is a monomial of degree zero. As
  $f(x)$ is also constant in the case $alpha = 0$, we will also refer to $f(x) =
  0$ as a monomial of degree zero, although there are books that refer to $f(x)
  = 0$ as monomial of degree $-1$.
])

#defbox("Polynomial of several variables", [
  A real valued function $p:RR^n -> RR$ that can be written as a sum of finitely
  many monomials $m_1 (x), m_2 (x), ... m_r (x)$
  $ p(x) = sum_(l=1)^r m_l (x) $
  is called a _polynomial of several variables_. $p$ is said to be a _polynomial
  of degree $k$_, if at least one of the monomials has degree $k$, but none of
  the monomials has a degree higher than $k$.

  Further we say that $p$ is a _homogeneous polynomial of degree $k$_, if all
  monomials in the definition of $p$ are of identical degree $k$, and we refer
  to a polynomial of degree $0$ as _constant function_, a polynomial of degree
  $1$ as _linear function_, and a polynomial of degree $2$ as _quadratic
  function_ or _quadratic polynomial_.
])

#obsbox(
  [
    We can see that any quadratic form is a sum of monomials of degree $2$, and
    hence a homogeneous polynomial of degree $2$.
    $
      q_H (v) = & v^top H v \
              = & sum_(i=1)^n (v_i sum_(j=1)^n H_(i j) v_j) \
              = & sum_(i,j=1)^n H_(i j) v_i v_j \
    $
  ],
  [
    Conversely if $q : RR^n -> RR$ is a homogeneous polynomial of degree $2$, it
    is a sum of monomials of degree $2$. As any monomial is of the form
    $alpha v_i v_j$, we can simply identify $H_(i j)$ with the factor $alpha$ in
    front of the monomial $alpha v_i v_j$.
  ],
)

// #exbox(todo[p. 103])

#let ci1 = tp(1)
#let ci2 = td(2)
#let ci3 = tg(3)
$
  & (tp(v_1),td(v_2),tg(v_3)) dot mat(
    h_(#ci1 #ci1), h_(#ci1 #ci2), h_(#ci1 #ci3);
    h_(#ci2 #ci1), h_(#ci2 #ci2), h_(#ci2 #ci3);
    h_(#ci3 #ci1), h_(#ci3 #ci2), h_(#ci3 #ci3);
  ) dot vec(tp(v_1), td(v_2), tg(v_3)) \
  = & (tp(v_1),td(v_2),tg(v_3)) vec(
    tp(v_1) h_(#ci1 #ci1)+ td(v_2)h_(#ci1 #ci2)+ tg(v_3)h_(#ci1 #ci3),
    tp(v_1) h_(#ci2 #ci1)+ td(v_2)h_(#ci2 #ci2)+ tg(v_3)h_(#ci2 #ci3),
    tp(v_1) h_(#ci3 #ci1)+ td(v_2)h_(#ci3 #ci2)+ tg(v_3)h_(#ci3 #ci3)
  ) \
  = & tp(v_1^2) h_(#ci1 #ci1)+tp(v_1) td(v_2)h_(#ci1 #ci2)+tp(v_1) tg(v_3)h_(#ci1 #ci3) \
  & + tp(v_1)td(v_2) h_(#ci2 #ci1)+td(v_2^2)h_(#ci2 #ci2)+tg(v_3)td(v_2)h_(#ci2 #ci3) \
  & + tp(v_1)tg(v_3) h_(#ci3 #ci1)+td(v_2)tg(v_3)h_(#ci3 #ci2)+tg(v_3^2)h_(#ci3 #ci3) \
  = & tp(v_1^2) h_(#ci1 #ci1)+td(v_2^2)h_(#ci2 #ci2)+tg(v_3^2)h_(#ci3 #ci3)+
  2tp(v_1)td(v_2) h_(#ci1 #ci2)+2 td(v_2)tg(v_3)h_(#ci2 #ci3)+2tp(v_1)tg(v_3) h_(#ci1 #ci3) \
$

==== Technique of completing squares

$
    & td(underbrace(td(x^2), sqrt(dot))) - tp(
        underbrace(
          4x y,
          div 2x
        )
      ) + 1 \
  = & (td(x) - tp(2y))^2 - tp((-2y)^2) + 1 \
  = & (x - 2y)^2 - 4y^2 + 1
$

// #exbox(todo[p. 105-107])

Special case: A polynomial that does not contain any square factors at all, i.e.
with a polynomial such as
$ n = x y + 4 x z + 2 y z $
it is guaranteed to be indefinite.

#defbox(
  "LDL decomposition for positive definite and negative definite matrices",
  [
    Let $H in RR^(n times n)$ be positive definite or negative definite. Then
    there exists a diagonal matrix
    $
      Lambda = mat(
        lambda_1, 0, dots, 0;
        0, lambda_2, dots.down, dots.v;
        dots.v, dots.down, dots.down, 0;
        0, dots, 0, lambda_n
      )
    $
    and a lower unit triangular matrix
    $
      L = mat(
        1, 0, dots, 0;
        *, 1, dots.down, dots.v;
        dots.v, dots.down, dots.down, 0;
        *, dots, *, 1
      )
    $
    such that
    $ H + L Lambda L^top $
    In the formula of $L$, the asterisk $∗$ represents an arbitrary number.
    Furthermore, $H$ is positive definite if and only if
    $lambda_1, lambda_2, ..., lambda_n > 0$, and negative definite, if and only
    if $lambda_1, lambda_2, ..., lambda_n < 0$.
  ],
)

// #todo[109]

== Approximate search for extremal values

=== Gradient and contour surfaces

The set of all points of a hyper-surface $f: RR^n -> RR$ for which $f$ results
in the same value
$
  f^(-1) (c) = {x in RR^n mid(|) f(x) = c}
$
is called _contour surface_, or a _contour line_, if $n = 2$.

Let $s : RR -> RR^n$ be a curve, that resides entirely within $f^(-1) (c)$. In
this case the real valued function
$h(t) = f(s(t))$
is constant, and thus its derivative
$h'(t) = 0$
is zero.

#let xs = lq.linspace(-1, 1)
#let cdiags = (fnrep, fn) => exbox(title: fnrep, grid(
  columns: (1fr, 1fr),
  align: horizon + center,
  diagram3d(
    width: 8cm,
    height: 6cm,
    rotations: (
      pt.mat-rotate-iso,
      pt.mat-rotate-y(.2),
      pt.mat-rotate-x(-.2),
      pt.mat-rotate-z(.13),
    ),
    xaxis: (lim: (-1, 1), nticks: 5),
    yaxis: (lim: (-1, 1), nticks: 5),
    zaxis: (lim: (-1, 1), nticks: 5),
    pt.planeparam(
      fn,
      steps: 40,
      fill-color-fn: h-color-fn,
      stroke-color-fn: h-color-fn,
    ),
  ),
  ctd(contour(xs, xs, fn)),
))

#cdiags($ f(x,y) = x^2 - y^2 $, (x, y) => x * x - y * y)
#cdiags($ f(x,y) = x^2 + y^2 - 1 $, (x, y) => x * x + y * y - 1)
#block(breakable: false, cdiags($ f(x,y) = 1/5 x^2 + y^3 $, (x, y) => (
  (x * x) / 5 + y * y * y
)))
#cdiags($ f(x,y) = y^3 - y + x^2 - 1/2 $, (x, y) => y * y * y - y + x * x - .5)

// #todo[Visualize

$
  gamma: & RR -> RR^2 , gamma subset DD_f = "One of the curves on the contour plot" \
  f(gamma(t)) = & c \
  => & gradient f(gamma(t)) dot gamma'(t) = 0 \
  = & (gradient f(gamma(t)))^top prod gamma'(t) = 0 \
  => & (gradient f(gamma(t)))^top bot gamma'(t) \
$
// ]

The chain rule for surfaces and curves tells us that
$
  h'(t) = dif/(dif t) f(s(t)) = gradient f(s(t)) dot s'(t)
$
We can thus conclude
$
  gradient f (s(t)) dot s'(t) = 0
$
which tells us, that the gradient of $f$ is orthogonal to any curve that
completely resides within a contour surface, and thus orthogonal to the contour
surface, itself.

// #todo[diagrams (Notes 111), Notes 112]

$a prod b = abs(a) dot abs(b) dot cos angle (a,b)$

The formula for the growth of $f$ at $x_0$
$
  (g'(0))/abs(v) = abs(gradient f(x_0)^top) dot cos angle (gradient f(x_0)^top, v)
$
tells us:
- In the vicinity of $x_0$, the values of $f$ grow most rapidly in that
  direction $v$, in which $cos angle (gradient f(x_0)^top, v)$ is maximal, i.e. in
  a direction that is parallel to $gradient f(x_0)^top$
- In this direction, the growth of $f$ is proportional to
  $(g'(0))/abs(v) = abs(gradient f(x_0)^top)$

// #todo[proposition 76 (Notes 112)]

=== Minimizing cost functions using gradient descent

Goal: $gradient f(x) approx 0$

Iterative approach:
$
  x_(i + 1) = x_i - gamma dot gradient f(x_i)
$
where $gamma > 0$ is the _step size_ or _learning rate_ of gradient descent.
Large values of $gamma$ allow us to move quickly at the price that we may jump
over local minimum points with out notice.

We also need a _termination criterion_ through which we control the precision
$epsilon > 0$ of the approximation:
$ abs(x_(i+1) - x_i) < epsilon $
or equivalently
$ abs(gradient f(x_i)) < epsilon/gamma $
leading to gradient descent terminating at a point where $gradient f(x) approx
0$. The algorithm is guaranteed to stop at a stationary point, but there is *no
guarantee that the stationary point is in fact a local minimum*.

Comparison to Newton's method:
$
  x_(i + 1) = x_i - gamma dot underbrace((H_f(x_i))^(-1), "Too expensive
  in ML!") dot gradient f(x_i)
$
#block(breakable: false, exbox(
  grid(
    columns: (auto, 1fr),
    ..gddiag(8cm, 8cm)
  ),
))
// #todo[
Procedures for finding good values for $epsilon, gamma$ can include:
- Conjugate gradient method
- Stochastic gradient descent
// ]

== Putting it all together (Image classification)

A $128 times 256$ pixel image $I$ with $3$ color channels (RGB) can be
represented as a $128 times 256 times 3$ matrix (tensor of rank 3). The red
value of a pixel at row $100$, column $12$ can be indexed with $I_(100,12,1)$. A
function to determine whether the image was taken at day ($0$) or night ($1$)
would have the following signature:
$ f: RR^(128 times 256 times 3) -> {0,1} $

=== Feature extraction

#deftbl(
  [Feature],
  [functions encapsulating domain knowledge],
  [Training set],
  [Data samples for which the output category is already known],
  [Supervised learning],
  [Answering how features can be used for predictions by means of a training
    process usng a training set],
)


#grid(
  columns: 2,
  [There are many different approaches to solving the image classification
    problem. We could calculate the average brightness $b$ of an image, and then
    argue, that the image has been taken during the day if $b$ exceeds some
    threshold $t$.],

  diagram(
    node-stroke: none,
    node((0.5, 2), $0$),
    node((0.5, 1), $1$),
    node((11, 2.5), $1$),
    node((1, 2.5), $0$),
    node((5, 2.5), tr[$t$]),
    node((12, 2), $b$),

    edge((1, 2.5), (1, 0), "->"),
    edge((0.5, 2), (12, 2), "->"),
    edge((1, 2), (5, 2), stroke: colors.darkblue + 2pt),
    edge((5, 1), (11, 1), stroke: colors.darkblue + 2pt),
    edge((5, 1), (5, 2), stroke: stroke(
      dash: "dashed",
      paint: colors.darkblue,
    )),

    edge((11, 2.5), (11, 1.9)),
    edge((.5, 1), (1.1, 1)),

    edge((5, 2.5), (5, 1.9), stroke: colors.red + 2pt),

    node(enclose: ((1.5, 1), (4.5, 1)), shape: fletcher.shapes.brace.with(
      dir: top,
      label: [Night],
    )),
    node(enclose: ((5.5, 1), (10.5, 1)), shape: fletcher.shapes.brace.with(
      dir: top,
      label: [Day],
    )),
  ),
)

#block(breakable: false, defbox("Indicator function", [
  Let $A subset RR^n$ be a set. The _indicator function_ $bb(1)_A (x)$ is
  defined as
  $
    bb(1)_A : cases(RR^n &-> {0,1}, x &|-> cases(1 "," x in A, 0 "," x in.not A))
  $
]))

Using indicator functions we can split the categorization function into a
_feature-function_ $b(x)$ which calculates the average brightness and an
_indicator function_ $bb(1)_((t;oo))$ which maps high brightness values to
category $1$:

#let node = node.with(stroke: none)
#let edge = edge.with(label-side: left)

#align(center, diagram(
  spacing: (14em, 4em),
  node((0, 0), $RR^(128 times 256 times 3)$, name: <i>),
  node((1, 0), $RR$, name: <t>),
  node((1, 1), ${0;1}$, name: <o>),
  edge(<i>, <t>, "->", label: $b$),
  edge(<i>, <o>, "->", label: $c a t$),
  edge(<t>, <o>, "->", label: $bb(1)_((t;oo))$),
))

Thus $b(x)$ encapsulates *domain knowledge* and $bb(1)_((t;oo))$ parameterizes
*ignorance*, i.e. that we do not yet know a brightness threshold $t$.

It is the responsibility of the training phase, to find a suitable value of $t$,
such that the system works well for the data provided in the training set. Once
we have found such a value and the system also works for other data sets, we say
that the system is able to _generalize_.

=== Logistic regression

Logistic regression introduces a further layer $p_t (b)$, which calculates
the *probability* that an image with a particular feature falls into a specific
category. We can still associate the image to the most likely category using the indicator
function $bb(1)_((1/2;oo))$. However, in this case, we have the additional
information that we are somewhat uncertain about this choice.

#align(center, diagram(
  spacing: (14em, 4em),
  node((0, 0), $RR^(128 times 256 times 3)$, name: <i>),
  node((.6, 0), $RR$, name: <tt>),
  node((1, 0), $[0;1]$, name: <t>),
  node((1, 1), ${0;1}$, name: <o>),
  edge(<i>, <tt>, "->", label: $b$),
  edge(<tt>, <t>, "->", label: $p_t$),
  edge(<i>, <o>, "->", label: $c a t$),
  edge(<t>, <o>, "->", label: $bb(1)_((1/2;oo))$),
))

Here, $b$ and $bb(1)_((1/2;oo))$ are deterministic. There is, however,
flexibility to later-on adapt the indicator function to a specific use-case,
e.g. it might be useful to have a preference for putting objects into category
"DAY" by using an indicator function such as $bb(1)_((1/4;oo))$.

In logistic regression the task of identifying a probability distribution $p_t
(b)$ that serves our needs is always solved with the help of the sigmoid
function:

#let xs = lq.linspace(-10, 10)
#block(breakable: false, defbox("Sigmoid function", [
  #grid(
    columns: (1fr, 1fr),
    align: horizon,
    [
      The _sigmoid function_ is defined as follows:
      $
        sigma: cases(RR & -> (0;1), t &|->1/(1 + e^(-t)))
      $
      If interpreted as probability distribution, the sigmoid function
      associates negative values to low probabilities ($< 0.5$) and positive
      values to high probabilities ($>
      0.5$), because $sigma(0) = 1/2$ Therefore the number zero is associated
      with a probability of $0.5$.
    ],

    diagram2d(
      width: 100%,
      lq.plot(
        xs,
        xs.map(x => calc.exp(x) / (1 + calc.exp(x))),
        mark: none,
      ),
    ),
  )
]))

#obsbox(
  [
    The choice of a particular indicator function does not impact the choice of
    the brightness threshold that is required to calculate $p_t$
  ],
  grid(
    columns: (1fr, 1fr),
    [
      Although in logistic regression the sigmoid function is almost always
      used, other functions exist, as long as they map $RR -> (0;1)$. Another
      example would be:
      $
        tanh: cases(
          RR & -> (0;1),
          t & |-> (e^t − e^(−t)) / (e^t + e^(−t))
        )
      $
    ],
    diagram2d(
      width: 100%,
      height: 3cm,
      title: $f(x) = (tanh(x) + 1)/2$,
      lq.plot(
        xs,
        xs.map(x => (calc.tanh(x) + 1) / 2),
        mark: none,
      ),
    ),
  ),
)

In logistic regression, the sigmoid function is applied to a linear combination
of the features, which is eventually adjusted by adding a constant value (known
as the _bias_).

$
  p_(m,q) (b) = sigma (m b - q)
$

The _weight_ $m$ controls how strongly $b$ influences the classification; larger
$abs(m)$ makes the sigmoid transition steeper with respect to $b$ and indicates
that brightness is a good concept for distinguishing the images. The _bias
correction term_ $q$ shifts the sigmoid left/right along the $b$ axis and thus
changes the threshold boundary.

The task of training logistic regression thus boils down to the challenge of
finding suitable values for $m$ and $b$, such that $p_m,p$ is compatible with
the training data set.

#align(center, diagram(
  node-stroke: none,
  node((0.5, 2), $0$),
  node((0.5, 1), $1$),
  node((11, 2.5), $1$),
  node((1, 2.5), $0$),
  node((5, 2.5), tr[$t = q/m$]),
  node((12, 2), $b$),

  edge((1, 2.5), (1, 0), "->"),
  edge((0.5, 2), (12, 2), "->"),
  edge((1, 2), (3.5, 2), stroke: colors.darkblue + 2pt),
  edge((6.5, 1), (11, 1), stroke: colors.darkblue + 2pt),

  edge(
    (3.5, 2),
    (4.5, 2),
    (5.5, 1),
    (6.5, 1),
    stroke: colors.darkblue + 2pt,
    corner-radius: 15pt,
  ),

  edge((5, 1.5), (5, 2), stroke: stroke(
    dash: "dashed",
    paint: colors.red,
  )),
  edge((5, 1.5), (1, 1.5), stroke: stroke(
    dash: "dashed",
    paint: colors.red,
  )),

  edge((11, 2.5), (11, 1.9)),
  edge((.5, 1), (1.1, 1)),

  edge((5, 2.5), (5, 1.9), stroke: colors.red + 2pt),

  node(enclose: ((1.5, 1), (4.5, 1)), shape: fletcher.shapes.brace.with(
    dir: top,
    label: [Night],
  )),
  node(enclose: ((5.5, 1), (10.5, 1)), shape: fletcher.shapes.brace.with(
    dir: top,
    label: [Day],
  )),
))

=== The maximum likelihood principle

Using logistic regression we now have the following:

#align(center, diagram(
  spacing: (14em, 4em),
  node((0, 0), $RR^(128 times 256 times 3)$, name: <i>),
  node((.5, 0), $RR$, name: <tt>),
  node((1, 0), $[0;1]$, name: <t>),
  node((1, 1), ${0;1}$, name: <o>),
  edge(<i>, <tt>, "->", label: $b(x)$),
  edge(<tt>, <t>, "->", label: $sigma(m dot b - q)$),
  edge(<i>, <o>, "->", label: $c a t (x)$),
  edge(<t>, <o>, "->", label: $bb(1)_((1/2;oo)) (sigma)$),
))

where \
$b(x) ->$ Average brightness \
$sigma(m dot b - q) ->$ Probability to fall into either category \
$bb(1)_((1/2;oo)) (sigma) ->$ Map probability to $0$ or $1$

What still has to be done is to find suitable values for $m$ and $q$. The
likelihood for them being properly chosen is
$
  "proportional to" & p_(m,q) (b(x))     && "if" x "falls into category DAY" \
  "proportional to" & 1 - p_(m,q) (b(x)) && "if" x "falls into category NIGHT" \
$
With $D$ and $N$ being the set of images pre-classified as DAY and NIGHT
respectively, we can argue that the _likelihood function_
$
  l(m,q) = underbrace(
    (product_(x in D) p_(m,q) (b(x))),
    "Probability of all DAY pictures"
  ) dot underbrace(
    (product_(x in N) (1 -
        p_(m,q) (b(x)))), "Probability of all NIGHT pictures"
  )
$
measures the combined likelihood that $m$ and $q$ work well for the entire
training set. The _maximum likelihood principle_ states the best choice of $m$
and $q$ maximizes the likelihood function $l$.

Instead of calculating $J_l$, which requires the product rule, we can seek to
maximize the _log-likelihood function_ which poses less of a challenge:
$
                      ln (l(m,q)) = & sum_(x in D) ln(p_(m,q) (b(x))) + sum_(x in N) ln(
                                        1 - p_(m,q)
                                        (b(x))
                                      ) \
  partial/(partial m) ln (l(m,q)) = & sum_(x in D) (partial/(partial m)
                                      (p_(m,q) (b(x))))/(p_(m,q) (b(x))) - sum_(x in N) (partial/(partial m)
                                      (p_(m,q) (b(x))))/(1 - p_(m,q) (b(x))) \
  partial/(partial q) ln (l(m,q)) = & sum_(x in D) (partial/(partial q)
                                      (p_(m,q) (b(x))))/(p_(m,q) (b(x))) - sum_(x in N) (partial/(partial q)
                                      (p_(m,q) (b(x))))/(1 - p_(m,q) (b(x))) \
$
This is possible, because the logarithm is _strictly monotonic_, and thus
preserves the location of maximum and minimum points.

=== Cost function for logistic regression

As in machine learning we typically seek to minimize cost, we therefore use the
_negative-log-likelihood_ function as cost function for logistic regression:

$
  c(m,q) = -ln (l(m,q)) = & -(sum_(x in D) ln(p_(m,q) (b(x))) + sum_(x in N) ln(
                                1 - p_(m,q)
                                (b(x))
                              )) \
$

=== Enhancing the classifier

We can add more _features_, eg. the average brightness of the individual $r,g,b$
color channels. WARNING: On small amounts of training samples this may result in
*overfitting*.

$
  f:cases(RR^(128 times 256 times 3) &-> RR^3, x &|-> vec(r(x), g(x), b(x)))
$

#align(center, diagram(
  spacing: (14em, 4em),
  node((0, 0), $RR^(128 times 256 times 3)$, name: <i>),
  node((.5, 0), $RR^4$, name: <tt>),
  node((1, 0), $[0;1]$, name: <t>),
  node((1, 1), ${0;1}$, name: <o>),
  edge(<i>, <tt>, "->", label: $f(x)$),
  edge(<tt>, <t>, "->", label: $sigma(m prod f - q)$),
  edge(<i>, <o>, "->", label: $c a t (x)$),
  edge(<t>, <o>, "->", label: $bb(1)_((1/2;oo)) (sigma)$),
))

As a consequence, we now have to find suitable values for all components of $m$
and the bias correction term $q$. By introducing a fourth "constant feature", we
can further unify the treatment of bias and features. By using the feature
vector
$
  f:cases(RR^(128 times 256 times 3) &-> RR^4, x &|-> vec(r(x), g(x), b(x), -1))
$
and using $m = (m_r, m_g, m_b, m_"bias")$ for the parameters as well as
introducing the linear map
$
  L_m : cases(RR^4 &-> RR, f &|-> m dot f)
$
we can further expand the structure of the logistic regression algorithm:

#align(center, diagram(
  spacing: (14em, 4em),
  node((0, 0), $RR^(128 times 256 times 3)$, name: <i>),
  node((.4, 0), $RR^4$, name: <tt>),
  node((.7, 0), $RR$, name: <ttt>),
  node((1, 0), $[0;1]$, name: <t>),
  node((1, 1), ${0;1}$, name: <o>),
  edge(<i>, <tt>, "->", label: $f(x)$),
  edge(<tt>, <ttt>, "->", label: $L_m (f)$),
  edge(<ttt>, <t>, "->", label: $sigma(L_m)$),
  edge(<i>, <o>, "->", label: $c a t (x)$),
  edge(<t>, <o>, "->", label: $bb(1)_((1/2;oo)) (sigma)$),
))

This is the final form of any multi-feature regression algorithm:

+ Extract $n$ features from an input data point
+ Choose one parameter per feature and apply $L_m$ to the feature vector.
+ Apply sigmoid function to obtain probability of the category that input
  belongs to
+ Use indicator function to associate input with a category

To find the suitable values for $m$ through the feature vectors $f_1,...,f_N$
that are already mapped to the categories $c_1,...,c_N$ we can finally minimize
$
  "cost"(m) = -(sum_(r in {i|c_i=1}) ln(sigma(m dot f_r))) - (sum_(s in
    {i|c_i=1})
    ln(1 - sigma(m dot f_s)))
$

// === Multi-class categorization
//
// #todo[p. 129-131]

= Multivariate Gaussian distribution

== Probability theory

#deftbl(
  [Experiment],
  [Procedure thet terminates with a non-deterministic but well defined outcome],
  [Sample space],
  [Set of all possible outcomes $Omega = {e_1,e_2,...}$],
  [Event],
  [$E subset Omega$],
  [Set of all events],
  [$cal(F) = {E | E subset Omega} = P(Omega)$],
  [Probability density],
  [],
  [Probability measure],
  [
    A function
    $
      PP : P(Omega) -> [0;1]
    $
    such that the following conditions hold
    $
      PP(Omega) = & 1 \
      PP(emptyset) = & 0 \
      forall A,B subset Omega, space A inter B = emptyset space (PP(A union B) = & PP(A) + PP(B)) \
      forall A,B subset Omega space (PP(A union B) = & PP(A) + PP(B) - PP(A inter B))
    $
    Its value can be interpreted as probability for the event $E$ to occur when
    conducting the experiment.
  ],
)

=== Discrete probability distribution

$
  Omega = {e_1,e_2,...,e_n}, quad PP({e_k}) = p_k, quad k in {1,2,...,n} \
$

Let $Omega$ be an *enumerable* sample space, then $p:Omega->[0;1]$ is called
_discrete probability distribution_, if
$
  sum_(i=1)^n p(e_i) = 1
$
Any discrete probability distribution uniquely identifies a probability measure,
i.e. the probability measure that maps the event $S subset Omega$ to the
probability
$
  PP(E) = sum_(e in E) p(e)
$

=== Univariate probability distribution

The _uniform probability distribution_ $unif(0, 1)$ characterizes an experiment
in which one number is chosen from the sample space $Omega = [0;1]$ in such a
way, that all numbers of $Omega$ have an equal chance to occur.

Whenever $Omega subset RR$, we can use $PP$ to define the _cumulative
distribution function_ (CDF)
$
                     F(alpha) = & PP((-oo;alpha] inter Omega) \
  lim_(alpha -> -oo) F(alpha) = & 0 \
   lim_(alpha -> oo) F(alpha) = & 1 \
$

#exbox(
  title: [Cumulative distribution function $F$ and probability density function
    $f$ for $unif(a, b)$],
  [
    $
                 F : & cases(
                         RR & -> [0;1],
                         x & |-> bb(1)_[a;b] (x) dot (x - a)/(b - a) +
                             bb(1)_((b;oo)) (x)
                       ) \
      F'(x) = f(x) = & cases(1/(b-a) &"if" a < x < b, 0 &"else")
                       = (bb(1)_((a;b)) (x))/(b-a) = "density for" X ~ unif(a, b) \
       PP (X <= x) = & integral_(-oo)^x f(t) dif t = integral_(-oo)^x (bb(1)_((a;b)) (t))/(b-a) dif t =^(a < x < b) integral_a^x 1/(a-b) dif t =
                       (x-a)/(b-a)
    $

    #diags.pdfunif
    #diags.cdfunif
  ],
)

A function $f : RR -> RR^+$, such that
$
  integral_(-oo)^oo f(t) dif t = 1
$
is called _probability density function_ (PDF). With any PDF we can associate a
CDF
$
  F(alpha) = integral_(-oo)^alpha f(t) dif t
$
and a probability measure $PP$ that associates the probability of the event $E
subset RR$ to occur with the area of all points underneath the function $f(t)$
whose $t$-values reside in $E$:
$
  PP(E) = integral_(t in E) f(t) dif t
$

// #todo[p. 150, 152, 153]

=== Univariate normal distribution

The probability density of the normal / Gaussian distribution is given by
$
  f(x) = 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) (x - mu)^2)
$
in which $mu$ and $sigma$ are parameters, denoted as #tp[mean value ($mu$)] and
#tg[standard deviation ($sigma$)].

$
  integral_(mu-sigma)^(mu+sigma) 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) (x - mu)^2) dif t approx 0.68
$

#let m = 4
#let sig = 1
#(diags.dfdiag)(false)
#(diags.dfdiag)(true)
$
  tp(mu = #m), #h(2em) tg(sigma = #sig)
$
The value of the CDF evaluated at $x$ represents the area of the PDF from $-oo$
to $x$, thus giving the probability of an experiment be in $(-oo;x]$.

All normal distributions can be defined with the help of the so called _standard
normal distribution_
$
  phi(x) = 1/sqrt(2 pi) e^(-1/2 x^2)
$
for which $mu = 0$ and $sigma = 1$. The general normal distribution can then be
expressed in terms of the standard normal distribution using the formula
$
  f(x|mu,sigma) = 1/sigma phi ((x-mu)/sigma)
$

The _error function_ is defined through
$
  erf(x) = 2/sqrt(pi) integral_0^x e^(-t^2) dif t
$
or its Taylor series
$
  erf(x) = 2/sqrt(pi) sum_(k=0)^oo (-1)^k/(k! (2k+1)) x^(2k+1)
$
and can be approximated through hyperbolic functions
$
  erf(x) approx tanh(2 / sqrt(pi) (x + 11 / 123 x^3))
$
Given this function, one can show, that the CDF of the normal distribution is
given by
$
  F(x|mu,sigma) = 1/2 (1+erf((x-mu)/sqrt(2 sigma^2)))
$

== Estimation of probability measures

// === Parameter estimation

// #todo[p. 156,157]

// The DAY-NIGHT image classifier was using the sigmoid function to map an image
// $x$ to a number $sigma in [0; 1]$ which was then interpreted as probability for
// this image to be taken during the day. Using the sample space
// $Omega= {"DAY", "NIGHT"}$, we could convert this number into a discrete
// probability distribution by defining
// $
//     p("DAY") = & sigma \
//   p("NIGHT") = & 1 - sigma \
// $

=== Maximum likelihood principle for normal distributed data

#exbox(
  title: "Likelihood of an american person having a certain height",
  lbl: "example24",
  [
    Using the data from the US National Health and Nutrition Examination Survey
    (NHANES, 1999-2004) providing us with heights of $3602$ adult male persons
    we can find the likelohood for person $k$ having height $x_k$ is
    $
      f(x_k | mu, sigma) = 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) (x_k - mu)^2)
    $
    and therefore the likelihood for finding $3602$ people of height
    $x_1,x_2,...,x_3602$ is
    $
      p(mu,sigma) = product_(k=1)^3602 f(x_k | mu, sigma) = (1/sqrt(2 pi sigma^2))^3602
      e^(-1/(2 sigma^2) sum_(k=1)^3602 (x_k - mu)^2)
    $
  ],
)

If $x_1, x_2, ..., x_n$ are outcomes of $n$ independent runs of an experiment
hat is known to produce normal distributed results, we can estimate the
parameters $mu$ and $sigma^2$ of the normal distribution with the help of the
maximum likelihood principle:
$
       mu_"MLE" = & 1/n sum_(k=1)^n x_k \
  sigma^2_"MLE" = & 1/n sum_(k=1)^n (x_k - mu)^2 \
$
/ MLE: Maximum Likelihood Estimators

It is possible to slightly improve maximum likelihood estimators through a
procedure called _bias correction_. For instance, the bias-corrected maximum
likelihood estimator
$
  sigma^2_"MLE" = & 1/(n-1) sum_(k=1)^n (x_k - mu)^2 \
$
for the variance of normal distributed data is much more popular than the
MLE-estimator, al- though both estimators do not differ much in practice. Much
more important than bias correction are the following properties which are
demanded by most statistical methods: namely, that subsequent experiments are
_statistically independent_
and _identically distributed_ (the combination of those terms is often
abbreviated with the acronym _iid_).

== Vector valued random variables

Experiments that have vector valued outcomes instead of having a discrete set as
a sample space (eg. ${"DAY", "NIGHT"}$).

=== Multiple measurements and statistical independence

In @example24, the height $x$ is called a _random variable_. Typically one uses
capital letters to identify random variables and would thus write
$
  X ~ cal(N) (mu=175.85,sigma=7.49)
$
to indicate that the random variable $X$ is normal distributed with mean $mu =
175.84$ and standard deviation $sigma = 7.49$. Once the random variable $X$ has
been introduced, we use the corresponding lower case letter (here $x$) as a
placeholder for particular values of that random variable.

==== Composite measurements

The experiments of measuring the weight and height of an adult male are not
_statistically independent_: a tall person is usually heavier than a small
person. Here the elements of sample space consist of pairs of real numbers,
which implies that the associated random variable $V$ is vector-valued: its
first component represents the height $X$ of the person and its second component
represents his weight $Y$. Similar to real valued-random variables, we can
associate probability densities to vector valued random variables. However,
since the sample space of $V$ is $RR^2$ the probability density of $V$ now needs
to be a function of two variables $f_V : RR^2 -> RR$.

=== Random variables

A random variable is a mapping that maps a (randomly) chosen sample (here: a
male adult), to some well defined properties of that sample (here: height or
weight value of that person). Formally, random variables are therefore defined
to be functions from the set of all possible samples $Omega$ into some other
space. The random variables $X$ (=height), $Y$ (=weight) and $V$ (=both values)
are therefore functions
$
  X : & Omega -> RR \
  Y : & Omega -> RR \
  V : & Omega -> RR^2 \
$
We can now use a random variable such as $X$ to define an associated probability
measure $PP_X$, whose events are subsets $V subset RR$ from the range of $X$,
through
$
  PP_X (V) = PP({omega in Omega | X(omega) in V})
$
As we often rely on such probability measures, we also abbreviate it by
$
  PP_X (V) = PP(X(omega) in V)
$
or
$
  PP_X (V) = PP(X^(-1) (V))
$
#defbox("Random variables", [
  Let $Omega$ be a sample space with probability measure $PP$, and $S$ be a set.
  Then we call any function
  $ T: Omega -> S $
  a _random variable_. Specifically we call a function
  $
          & X : && Omega -> RR   && "real valued random variable" \
    "and" & V : && Omega -> RR^n && "vector valued random variable"
  $

  For any random variable $T : Omega -> S$ the probability measure $PP$ on
  $Omega$ results in an associated probability measure $PP_T$ on $S$, which is
  given by
  $
    forall Q subset S space (PP_T (Q) = PP(T(omega) in Q))
  $
  If $X : Omega -> RR$ is a real valued random variable, we can also associate a
  CDF with $X$, which is given by
  $
    F_X (x) = PP(X(omega) <= x)
  $
  and in case that $F_X$ is continuous a PDF $f_X (x)$, such that
  $
    PP(a<X(omega)<x) = integral_a^b f_X (x) dif x
  $
])

#defbox("Cumulative distribution function", [
  If $V : Omega -> RR^n$ is a vector valued random variable, we define the
  _cumulative distribution function_ of $V$ to be
  $
    F_V (v) = PP(forall i = 1, 2, ..., n space (V_i (omega) <= v_i))
  $
  and if $F_V$ is continuous, the probability density function
  $
    f_V (v) = partial/(partial v_1) partial/(partial v_2) ... partial/(partial
    v_n) F_V (v)
  $
])

#defbox("Statistically independent", [
  Two real valued random variables $X : Omega -> RR$ and $Y : Omega -> RR$ are
  _statistically independent_, if the probability density of the random variable
  $
    V:cases(Omega &-> RR^2, omega &|->vec(X(omega), Y(omega)))
  $
  satisfies
  $
    f_V (x,y) = f_X (x) dot f_Y (y)
  $
])

== Multivariate normal distribution

#defbox("Multivariate normal distribution", [
  A vector valued random variable $V : Omega -> RR^n$ is said to be distributed
  according to the _multivariate normal distribution_
  $ V ~ cal(N) (mu, Sigma) $
  with mean $mu$ and covariance matrix $Sigma$, if the PDF of $V$ is
  $
    f_V (v) = 1/sqrt((2pi)^n det Sigma) e^(-1/2 (v-mu)^top Sigma^(-1) (v-mu))
  $
])
#obsbox(
  $
    q_(Sigma^(-1)) (v-mu)= -1/2 (v-mu)^top Sigma^(-1) (v-mu)
  $,
  [
    $Sigma$ is always a positive definite symmetric matrix.
  ],
)
// #todo[p. 170]

== Coordinate transformations

/ Cartesian coordinate system: $(O; e_1, e_2)$, where $O$ is the origin and
  $e_1,e_2$ are orthogonal basis vectors of same length starting from $O$.

#block(breakable: false, defbox("Coordinate map", [
  Let $S$ be an arbitrary set and let $U$ be a sufficiently large subset of
  $RR^n$. $U$ is sufficiently large, if from any element $x in U$ it is possible
  to move a bit into an arbitrary direction without leaving $U$. A bijective
  mapping $f : S -> U subset RR^n$ is called a _coordinate map_ of $S$ or
  _coordinate chart_ of $S$. The coordinate functions
  $f_1 (s), f_2 (s), ..., f_n (s)$ of $f (s)$ are also called the _coordinates_
  of $f$.

  Further, if $U, V subset RR^n$ are sufficiently large, $f : S -> U$ is a
  coordinate map and $t : U -> V$ is a bijection, then $g = t compose f$ is a
  coordinate map, too, and $t$ is called a _coordinate transformation_.
]))

As every coordinate map $f : S -> U$ associates elements of $S$ 1-to-1 with
elements of $U$, we can think of a coordinate map as a method of attaching
(unique) labels to all elements of $S$. In the light of this, a coordinate
transformation is essentially resulting in a different, but yet unique
alternative labeling of the data.

// === Coordinate transformations of random variables
//
// #todo[p. 176+]
