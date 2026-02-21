#import "../lib.typ": *

#show: project.with(
  module: "MathFML",
  name: "Mathematical Foundations for Machine Learning",
  semester: "FS26",
  language: "en",
)

= Linear algebra

#defbox("Linear combination", $ sum_(i=1)^k lambda_i ve(v)_i $)

== Standard basis

Basis vectors ${ve(e)_1, ve(e)_2,...,ve(e)_n}$ in $RR^n$ where $ve(e)_i = (0,0,...,underbrace(1, #[$i$th position]),...,0)^T$

#exbox($ [vec(1, 0, 0), vec(0, 1, 0), vec(0, 0, 1)] = RR^3 $)

It can be shown that any basis of $RR^n$ consists of exactly $n$ linear independent vectors and that conversely any set of $n$ linear independent vectors is a basis of $RR^n$.

== Vectors

#todo("group and clean this up")

$
  lambda ve(0) = ve(0) \
  ve(v) + ve(0) = ve(v) \
  -ve(v) = -1 dot ve(v) \
  -ve(v) + ve(v) = ve(0) \
  (lambda mu)ve(v) = lambda(mu ve(v)) = lambda mu ve(v) \
  lambda(ve(v)+ve(w)) = lambda ve(v) + lambda ve(w) \
  ve(v) + (ve(u)+ve(w)) = (ve(v) + ve(u))+ve(w) = ve(v) + ve(u)+ve(w) \
$

== Matrices

#deftbl(
  definition: "Rules",
  [Associativity],
  $
    (A + B) + C = A + (B + C) = A + B + C \
    (A dot B) dot C = A dot (B dot C) = A dot B dot C \
  $,
  [Distributivity],
  $
    C dot (A + B) = C dot A + C dot B \
    (A + B) dot C = A dot C + B dot C
  $,
  [Commutativity],
  $
    A + B = B + A \
    A dot B != B dot A \
  $,
  [Transposing],
  $
    (A^T)^T = A \
    (A+B)^T = A^T + B^T \
    (lambda A)^T = lambda A^T \
    (A dot B)^T = B^T dot A^T \
    A_(i j) = A^T_(j i) \
  $,
  [Identity matrix],
  $
    bb(1) dot A = A dot bb(1) = A "for" A in RR^(n times n) \
  $,
  [Inverting],
  $
    A dot A^(-1) = A^(-1) dot A = bb(1) \
  $,
  [Determinate],
  $
    det(lambda M) = lambda^n det(M), M in RR^(n times n) \
    det mat(A, *; 0, B) = det(A) dot det(B) \
    det(A dot B) = det(A) dot det(B) \
    det(A^(-1)) = 1/det(A) \
    det(A^T) = det(A)
  $,
  [Scalars],
  $
    (lambda + mu) A = lambda A + mu A \
    (lambda mu) A = lambda (mu A) \
    lambda (B + C) = lambda B + lambda C \
    lambda (B C) = (lambda B) C = B (lambda) C
  $,
)

=== Unit matrices

Let $M$ be the set of all $2 times 2$ matrices. How could the basis of $M$ look? $mat(a, b; c, d)$ \
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
Shorthand: $ (A dot B)_(i j) = sum_k a_(i k) b_(k j) $


#exbox(
  title: [Let $X$ be a matrix for which $X^(-1)$ exists. Prove that the inverse of $X^T$ exists and is $(X^(-1))^T$],
  $
        & bb(1)^T = bb(1) \
     => & (X^(-1) X)^T = bb(1) \
    <=> & X^T (X^(-1))^T = bb(1)
  $,
)

=== Tensors

Vectors = tensors of rank 1, matrices = tensors of rank 2

The standart basis for $RR^(n times m times l)$ consists of $n dot m dot l$ basis vectors $E_(i j k)$ where $1<=i<=n, 1<=j<=m, 1<=k<=l$, such that all components of $E_(i j k)$ are zero except at position $i,j,k$ where the value of the component is $1$.


= Functions of several variables

Let $D$ and $R$ be two sets. A mapping $f: D -> R$ that associates to each element $x in D$ exactly one element of $f(x) in R$ is called function.

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

== Image classification

A $128 times 256$ pixel image $I$ with $3$ color channels (RGB) can be represented as a $128 times 256 times 3$ matrix (tensor of rank 3). The red value of a pixel at row $100$, column $12$ can be indexed with $I_(100,12,1)$. A function to determine whether the image was taken at day ($0$) or night ($1$) would have the following signature: $ f: RR^(128 times 256 times 3) -> {0,1} $

== Residual sum of square

Residual sum of square (RSS) is a statistical method that helps identify the level of discrepancy in a dataset not predicted by a regression model. Thus, it measures the variance in the value of the observed data when compared to its predicted value as per the regression model.

$
  R S S = sum_(i=1)^N underbrace((#td($y_i$) - #tp($f(x_i)$))^2, #[Represented as #tr([red\ squares]) in the example]) \
  R S S(#tp($a,b$)) = sum_(i=1)^N (#td($y_i$) - #tp($(m x_i + b)$))^2 >= 0, R S S: RR^2 -> RR
$

#exbox(
  title: [Linear regression of salaries by age],
  [#let rng = suiji.gen-rng-f(42)
    #let xs = range(0, 10)
    #let (rng, ys1) = deviate-x(rng, xs)
    #let (rng, ys2) = deviate-x(rng, xs)
    #let (rng, ys3) = deviate-x(rng, xs)
    #let (rng, ys4) = deviate-x(rng, xs)
    #let ysall = ys1.zip(ys2, ys3, ys4).map(ys => ys.sum() / ys.len())
    #let (m, b) = linear-regression(xs, ysall)
    #let rss-rect = (ys, n) => {
      let y = m * xs.at(n) + b
      let w = ys4.at(n) - y
      (
        lq.rect(
          n,
          y,
          width: -w,
          height: w,
          stroke: colors.red,
          fill: colors.red.transparentize(80%),
          label: $R S S_#n$,
        ),
        lq.line(
          (n, y),
          (n, ys4.at(n)),
          stroke: (
            paint: colors.darkblue,
            thickness: 2pt,
            cap: "round",
            dash: "dashed",
          ),
        ),
        lq.plot(
          (n, n),
          (ys4.at(n), ys4.at(n)),
          mark: mark => place(
            center + horizon,
            circle(fill: colors.darkblue, stroke: colors.darkblue, radius: 2pt),
          ),
          mark-color: colors.black,
          z-index: 99,
        ),
      )
    }

    #align(center, lq.diagram(
      title: $R S S = #rss(xs, ysall)$,
      ylim: (-0.5, 11),
      xlim: (-0.5, 11),
      width: 10cm,
      height: 10cm,
      ylabel: "Salary",
      xlabel: "Age",
      legend: (position: horizon + right),
      lq.scatter(xs, ys1, color: colors.darkblue),
      lq.scatter(xs, ys2, color: colors.darkblue),
      lq.scatter(xs, ys3, color: colors.darkblue),
      lq.scatter(xs, ys4, color: colors.darkblue),
      lq.plot(
        xs,
        xs.map(x => m * x + b),
        color: colors.purple,
        label: "Linear regression",
      ),
      ..rss-rect(ys4, 6),
      ..rss-rect(ys4, 2),
    ))],
)

== Visualizing functions

If $f: D -> R$ is a function from $D subset RR^n$ to $R subset RR^m$ its graph is defined as:

$
  "graph" (f) = {(ve(x),ve(y)) in D times R mid(|) x in D and ve(y) = f(ve(x))} subset D times R subset RR^n times RR^m = RR^(n+m)
$

Due to the fact that the visual imagination of humans is limited to at most 3 dimensions, the graph of a function is a useful concept for graphical illustration if and only if $n + m <= 3$.

#exbox([
  The graph of the function
  $ f: cases(RR &-> RR^2, t &|-> (cos t, sin t)) $
  is
  $
    "graph" (f) & = {(t,x,y) in RR^3 mid(|) (x,y) = f(t) and t in RR} \
                & ={(t, cos t, sin t) in RR^3 mid(|) t in RR}
  $
  It is displayed below and illustrates how $f$ maps $t$ to the corresponding values
  #pad(bottom: 1em, align(center, diagram3d(
    width: 10cm,
    height: 6cm,
    yaxis: (nticks: 4),
    zaxis: (nticks: 4),
    title: $f(t) = (cos t, sin t)$,
    rotations: (
      pt3d.mat-rotate-z(.2),
      pt3d.mat-rotate-y(-1),
      pt3d.mat-rotate-x(.5),
    ),
    pt3d.path(
      ..pt3d.linspace(0, calc.pi * 2).map(x => (x, calc.cos(x), calc.sin(x))),
    ),
  )))
])

#exbox([
  The graph of the function
  $
    g: cases({(x,y) in RR^2 mid(|) x^2 + y^2 <= 1} &-> RR^2, (x,y) &|-> sqrt(1 - x^2 - y^2))
  $
  is
  $
    "graph" (g) & = {(x,y,z) in RR^3 mid(|) z = sqrt(1 - x^2 - y^2) and x^2 + y^2 <= 1} \
    & ={(x,y,sqrt(1 - x^2 - y^2)) in RR^3 mid(|)x^2 + y^2 <= 1}
  $
  It is displayed below and illustrates how $f$ maps $(x,y)$ to the corresponding values
  #figure(
    [
      // FIXME: pt3d limit calculation
      // #pad(bottom: 1em, align(center, diagram3d(
      //   width: 10cm,
      //   height: 6cm,
      //   xaxis: (lim: (0, 0.5)),
      //   yaxis: (lim: (0, 0.5)),
      //   title: $g((x,y)) = (x,y,sqrt(1 - x^2 - y^2))$,
      //   rotations: (
      //     pt3d.mat-rotate-z(.2),
      //     pt3d.mat-rotate-y(-1),
      //     pt3d.mat-rotate-x(.5),
      //   ),
      //   pt3d.planeparam((x, y) => (x, y, calc.sqrt(1 - x * x - y * y))),
      // )))
    ],
  ) <figure-1>
])

=== Curves and surfaces

#deftbl(
  [Curves],
  [Vector valued functions of one variable, i.e. they map one-dimensional input to multi-dimensional output],
  [$n$-dimensional curve],
  [A continuous function $f : I -> Z$ that maps an interval $I subset RR$ into a subset $Z subset RR^n$],
  [Surfaces],
  [Real valued functions of multiple variables, i.e. they map multi-dimensional input to one dimensional output],
  [$n$-dimensional\ hyper-surface],
  [
    A continuous real valued function $f : D -> Z$ that maps a sufficiently large subset $D subset RR^n$ into a subset $Z subset RR$

    If $n = 2$ a hypersurface is also simply called surface. If $n = 1$ a hyper-surface is simply a continuous real valued function of one variable.
  ],
)

The graph of both, an $n$-dimensional curve and an $n$-dimensional hyper-surface, is a subset of $RR^(n+1)$. A graphical illustration of such a graph therefore requires $n <= 2$. However, unlike surfaces which are typically illustrated as in @figure-1, a curve $c : I -> RR^n$ is usually not illustrated through
$ "graph" c = {(t, y) in R times R^n mid(|) y = c (t) and t in I} $
Instead curves are typically visualized by skipping the independent variable $t$ from the graph, i.e. by visualizing the image of the curve
$ c (I) = {y in R^n mid(|) y = c (t) and t in I} $
which means that we are projecting the graph of the curve onto the gray plane that is spanned from the dependent variables. As this kind of plot saves one dimension we can also visualize curves for which the range $Z$ is a subset of $RR^3$.

#todo("pt3d bugfixes")

#exbox([
  The graph of the function
  $ f: cases(RR &-> RR^2, t &|-> (cos t, sin t)) $
  is
  $
    "graph" (f) & = {(t,x,y) in RR^3 mid(|) (x,y) = f(t) and t in RR} \
                & ={(t, cos t, sin t) in RR^3 mid(|) t in RR}
  $
  and its image is the set
  $
    f(RR) & = {f(t) in RR^2 mid(|) t in RR} \
          & = {(cos t, sin t) in RR^2 | t in RR}
  $
  #grid(
    columns: (1fr, 1fr),
    pad(bottom: 1em, diagram3d(
      width: 8cm,
      height: 6cm,
      yaxis: (nticks: 4),
      zaxis: (nticks: 4),
      rotations: (
        pt3d.mat-rotate-z(.2),
        pt3d.mat-rotate-y(-1),
        pt3d.mat-rotate-x(.5),
      ),
      // TODO:
      pt3d.plane(
        pt3d.plane-normal((1, 0, 0), calc.pi / 3),
        stroke: colors.black,
        fill: colors.black.transparentize(80%),
      ),
      pt3d.path(
        stroke-color-fn: (x, y, z) => if x < calc.pi / 3 { colors.red } else {
          colors.darkblue
        },
        ..pt3d.linspace(0, calc.pi * 2).map(x => (x, calc.cos(x), calc.sin(x))),
      ),
    )),
    lq.diagram(
      width: 6cm,
      height: 6cm,
      yaxis: (tick-distance: 0.5),
      legend: (position: bottom + right),
      // lq.path(..lqcut(lqcircle(s: 1, f: -7.4), (-0.5, 0.4), (1, 1.1))),
      lq.path(..lqcircle(f: calc.pi * 3), stroke: colors.darkblue),
      lq.path(
        ..lqcut(lqcircle(f: calc.pi * 3), (0.55, 0), (1, 1)),
        stroke: colors.red,
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
    ),
  )
])

Unlike for image processing, curves are of little importance in machine learning. On the contrary, hyper-surfaces belong to the most important functions in machine learning. This is because, to a large extend, machine learning can be thought of being a branch of statistics. In statistics the most important class of functions are probability distributions, which, from a technical perspective, are functions mapping subsets of $R^n$ into $R+$.

#exbox([
  #todo("scatter plot + distribution 3d (p22)")
])
