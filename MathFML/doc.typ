#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

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
    #todo("")
  ],
)

=== Affine transformations

All linear transformations share the property, that they map the null vector to null:

$ L_A (ve(0)) = ve(0) $

For many applications this is undesirable. Therefore linear transformations are often slightly extended to transformations, which are called *affine transformations*. An affine transformation is defined by an $r times c$ matrix $M$ and an $r$-dimensional vector $b$, which, in machine learning and statistics, is usually called *bias-vector* or *intercept*.

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
    #todo("check")
  ],
  [Nullity],
  [
    Number of vectors in the null space
    $ A in RR^(m times n) => nullity(A) = n - rho(A) = dim(ker A) $
    #todo("check")
  ],
  [Dimension],
  [$ dim(ker A) = nullity(A) \ ve(x) in RR^3 => dim ve(x) = 3 $],
  [Span],
  [
    Set of all finite linear combinations of the elements of $S$ of a vector space $V$.
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
      rowsp(A) = C(A^T) \
      A in RR^(m times n), dim(rowsp(A)) = m
    $
  ],
)
#exbox(todo(""))
#obsbox(
  $rank(T) + nullity(T) = dim V$,
  $dim(im T) + dim(ker T) = dim(domain T)$,
  $rank(A) = dim(rowsp(A)) = dim(colsp(A))$,
  $A in RR^(n times n) => dim(ker A) + rank A = n$,
  $A in RR^(n times n), ker A = {ve(0)} <=> rank A = n$,
)

=== Properties

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
Transposing: $ [(A dot B)^T]_(i j) = (A dot B)_(j i) = sum_k A_(j k) B_(i k) $

#exbox(
  title: [Let $X$ be a matrix for which $X^(-1)$ exists. Prove that the inverse of $X^T$ exists and is $(X^(-1))^T$],
  $
        & bb(1)^T = bb(1) \
     => & (X^(-1) X)^T = bb(1) \
    <=> & X^T (X^(-1))^T = bb(1)
  $,
)

== Tensors

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

=== Binary classification

#todo([
  $ f: X -> RR, x in X $
  $f(x)$ is called a one dimensional feature vector representing $x$. Afterwards $y=f(x)$ is mapped using a sigmoid function
  $ sigma: RR -> [0;1] $
  which allows us to interpret the resulting value as a probability for $x$ falling into the first category $A$. As soon as $sigma(f(x))$ exceeds a certain threshold value $tau$, the system predicts $x$ to fall into category $A$. Most of the time the logistic function
  $ sigma(x) = 1/(1+e^(-x)) $
  is used.

  ...

  ...
])

== Sigmoid function

#todo([
  #let xs = lq.linspace(-10, 10)
  #lq.diagram(
    title: $f(x) = sigma(x) = 1/(1 + e^(-x))$,
    lq.plot(
      xs,
      xs.map(x => calc.exp(x) / (1 + calc.exp(x))),
      mark: none,
    ),
  )
  #lq.diagram(
    title: $f(x) = tanh(x)$,
    lq.plot(
      xs,
      xs.map(calc.tanh),
      mark: none,
    ),
  )
])

== Residual sum of square

Residual sum of square (RSS) is a statistical method that helps identify the level of discrepancy in a dataset not predicted by a regression model. Thus, it measures the variance in the value of the observed data when compared to its predicted value as per the regression model.

$
  R S S = sum_(i=1)^N underbrace((#td($y_i$) - #tp($f(x_i)$))^2, #[Represented as #tr([red\ squares]) in the example]) \
  R S S(#tp($m,b$)) = sum_(i=1)^N (#td($y_i$) - #tp($(m x_i + b)$))^2 >= 0, R S S: RR^2 -> RR
$

#exbox(
  title: [Linear regression of salaries by age],
  [
    #let rng = suiji.gen-rng-f(42)
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
      // title: $R S S = #rss(xs, ysall)$,
      width: 10cm,
      height: 10cm,
      yaxis: (
        lim: (-0.5, 11),
        label: "Salary",
        format-ticks: (ticks, ..) => ticks.map(t => str(t * 10000 + 20000)),
      ),
      xaxis: (
        lim: (-0.5, 11),
        label: "Age",
        format-ticks: (ticks, ..) => ticks.map(t => str(t * 6 + 20)),
      ),
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

#let dfn = x => (x, calc.cos(x), calc.sin(x))
#let interpt = dfn(calc.pi / 3)
#let sin-diagram = pad(bottom: 1em, diagram3d(
  width: 8cm,
  height: 6cm,
  xaxis: (ticks: (6, 4, 2, 0)),
  yaxis: (nticks: 4),
  zaxis: (nticks: 4),
  rotations: (
    pt3d.mat-rotate-z(.2),
    pt3d.mat-rotate-y(-1),
    pt3d.mat-rotate-x(.5),
  ),
  pt3d.plane(
    pt3d.plane-normal((1, 0, 0), calc.pi / 3),
    stroke: colors.black,
    fill: colors.black.transparentize(80%),
  ),
  pt3d.vec(
    (calc.pi / 3, 0, 0),
    interpt,
    stroke: colors.red,
    tip: "o",
    toe: "o",
  ),
  pt3d.vec(
    (calc.pi / 3, interpt.at(1) / 2, interpt.at(2) / 2),
    (calc.pi / 3, 0, 0),
    stroke: colors.red,
    tip: m => text(fill: colors.red)[#v(3em) $t = pi / 3$],
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

== Visualizing functions

If $f: D -> R$ is a function from $D subset RR^n$ to $R subset RR^m$ its graph is defined as:

$
  graph (f) = {(ve(x),ve(y)) in D times R mid(|) x in D and ve(y) = f(ve(x))} subset D times R subset RR^n times RR^m = RR^(n+m)
$

Due to the fact that the visual imagination of humans is limited to at most 3 dimensions, the graph of a function is a useful concept for graphical illustration if and only if $n + m <= 3$.

#exbox([
  The graph of the function
  $ f: cases(RR &-> RR^2, t &|-> (cos t, sin t)) $
  is
  $
    graph (f) & = {(t,x,y) in RR^3 mid(|) (x,y) = f(t) and t in RR} \
              & ={(t, cos t, sin t) in RR^3 mid(|) t in RR}
  $
  It is displayed below and illustrates how $f$ maps $t$ to the corresponding values
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
  It is displayed below and illustrates how $f$ maps $(x,y)$ to the corresponding values
  #figure(
    [
      #diagram3d(
        width: 10cm,
        height: 8cm,
        xaxis: (lim: (-1, 1), nticks: 4),
        yaxis: (lim: (-1, 1), nticks: 4),
        zaxis: (lim: (0, 1), nticks: 2),
        title: $g((x,y)) = (x,y,sqrt(1 - x^2 - y^2))$,
        // rotations: (
        //   pt3d.mat-rotate-z(-.3),
        //   pt3d.mat-rotate-y(-1),
        //   pt3d.mat-rotate-x(.2),
        // ),
        pt3d.planeparam(
          (x, y) => {
            let z = 1 - x * x - y * y
            if z < 0 {
              z
            } else {
              calc.sqrt(z)
            }
          },
          steps: 30,
          fill: colors.blue,
          stroke: colors.darkblue,
        ),
      )
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

The graph of both, an $n$-dimensional curve and an $n$-dimensional hyper-surface, is a subset of $RR^(n+1)$. A graphical illustration of such a graph therefore requires $n <= 2$. However, unlike surfaces #context no-html[which are typically illustrated as in @figure-1], a curve $c : I -> RR^n$ is usually not illustrated through
$ graph c = {(t, y) in R times R^n mid(|) y = c (t) and t in I} $
Instead curves are typically visualized by skipping the independent variable $t$ from the graph, i.e. by visualizing the image of the curve
$ c (I) = {y in R^n mid(|) y = c (t) and t in I} $
which means that we are projecting the graph of the curve onto the gray plane that is spanned from the dependent variables. As this kind of plot saves one dimension we can also visualize curves for which the range $Z$ is a subset of $RR^3$.

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
  #todo("3d axis order")
  #grid(
    columns: (1fr, 1fr),
    sin-diagram,
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

Unlike for image processing, curves are of little importance in machine learning. On the contrary, hyper-surfaces belong to the most important functions in machine learning. This is because, to a large extend, machine learning can be thought of being a branch of statistics. In statistics the most important class of functions are probability distributions, which are functions mapping subsets of $R^n$ into $R^+$.

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
  #let (plane, points, xsteps, ysteps) = dist3d(
    xs,
    ys,
    yn: num,
    xn: num,
    xlim: xlim,
    ylim: ylim,
  )
  #let (xsd, ysd, zsd) = plane

  Consider having some amount of 2D datapoints:

  #align(center, lq.diagram(
    xlim: (0, 52),
    ylim: (-11, 11),
    lq.scatter(xs, ys),
  ))

  We can place a grid over the diagram and count, how many points are in each of the boxes.

  #todo("pt3d builtin")
  #align(center, lq.diagram(
    xlim: (0, 52),
    ylim: (-11, 11),
    lq.scatter(xsd, ysd, size: zsd.map(i => i * 10)),
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

  We can now plot a diagram that maps the $x$ and $y$ coordinate of the center of each of the boxes to the number of hits of this particular box and thus end up with a diagram that is called a _histogram_.

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
    pt3d.planeplot(
      ..plane,
      num: num,
      fill-color-fn: (x, y, z) => pt3d.rgb-clamp(
        z * 10,
        100,
        200,
      ),
      stroke: black + 0.25pt,
    ),
    // TODO: points
    // ..pts.map(p => pt3d.vec(p)),
  ))

  We can try to create a histogram with boxes of infinitely small size. The problem with this approach is, that the number of hits per box decreases when the size of the boxes is getting smaller.

  In order to compensate that, we therefore need more datapoints. If we do that, the histogram is being transformed into a function, that associates a number to each position on the diagram, that can be interpreted as likelihood for a point to be almost next to this position: the higher this number is, the more likely it is. This function is called the *probability density* of the experiment.

])

==== Vector similarity

In addition to probability theory, geometric concepts are used in machine learning. One approach to decide, whether two images are similar or not, is to first extract features (such as corner-points, edges, etc.) from each of the images, and store these features in a list of numbers, which is called _feature vector_. It is reasonable to assume, that similar images are mapped to similar feature vectors.

Two vectors $v$ and $w$ are *similar*, if both vectors head into the same direction and are of similar length, so if the difference $v-w$ between both vectors has a small length. In vector geometry, the length of a vector is called a *norm*, and the distance between two vectors is called a *metric*.
A norm $norm(dot)$ is thus a function that associates with a vector $x$ a positive number $norm(x)$ , which is interpreted as length of $x$.

$ norm(dot) : cases(RR^n &-> RR^(+), x &|-> sqrt(sum_(i=1)^n x^2_i)) $

$= n$-dimensional Euclidean norm or $l^2$-norm, written also as $norm(x)_2$.

Once a vector space is equipped with a norm $norm(.)$, we can also associate a metric with that vector space, which uses the notion of a length to measure the distance between pairs of vectors:

$ d(dot,dot): cases(RR^n times RR^n &-> RR^(+), (u,v) &|-> norm(u-v)) $

$=$ metric. The value $d(u,v)$ is identical to the length of the vector that heads from $v$ to $u$.

#align(center, lq.diagram(
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

#todo("function signature")

In machine learning many functions are vector valued functions of many variables. A very important example that falls into this category are linear transformations. Neural networks are typically defined to be a stack of unknown linear transformations, each of which being followed by a rather simple, predefined non-linear operation. Training a neural network is therefore almost equivalent to finding suitable linear transformations that make the network perform the desired operation.

Besides curves and surfaces there are functions that take multi-dimensional input and deliver multi-dimensional output. In order to get an idea how these functions look like, we often display low-dimensional "sections" of the function that can either be displayed as curves or as surfaces. There is however another way, how these functions can be displayed, namely using a *vector field*.

#exbox(title: "Spaceship (vector field)", [
  A space-ship traveling close to the sun is experiencing a gravitational force that - outside the sun - can be described using the following function:
  $
    F : cases({r in RR^3 mid(|) abs(r) > r_"Sun"} &-> RR^3, r &|-> -G dot m_"Sun" m_"Ship" r/norm(r)^3)
  $
  $r_"Sun" =$ radius of the sun, $G$ = gravitational constant, $m_"Sun",m_"Ship"$ = masses of the sun and space ship.

  If the center of the sun is located at $r=0$, the input vector $r$ denotes the position of the space ship as seen from the center of the sun and $F$ denotes the gravitational force that the space ship is experiencing.

  From a mathematical perspective the constants are not important. Therefore we simplify the formula by setting all of the constants to $1$, which leads to:

  $
    F : cases({r in RR^3 mid(|) abs(r) > 1} &-> RR^3, r &|-> -r/norm(r)^3)
  $

  In order to better understand the formula of the force field, we calculate the force experienced from the space ship at position $r= (1,2,2)^T$. Note first, that $r$ is in the domain of definition of $F$ , because its norm is greater than $r_"Sun" = 1$

  $ norm(r) = sqrt(1^2+2^2+2^2)=sqrt(9)=3 $

  This simply indicates, that the spaceship resides at a location exterior to the sun. We can therefore use this to calculate the force that the space ship is experiencing:

  $
    F vec(1, 2, 2) = -1/norm((1, 2, 2)^T)^3 vec(1, 2, 2) = -1/3^3 vec(1, 2, 2) = -1/27 vec(1, 2, 2)
  $

  We can now continue to calculate values of the force $F$ at other locations and try to graphically visualize the result. Since the graph of $F$

  $
    graph(F) = {(r,f) in RR^3 times RR^3 mid(|) norm(r) > 1 and f = - r/norm(r)^3}
  $

  is a subset of a $3+3=6$-dimensional space, we cannot however not draw the graph of $F$ directly in any meaningful way. A possibility to still visualize this function, is to draw the function as *vector field*. By this we mean that we place 3-dimensional arrows representing $F$ at different points in a 3-dimensional space that identify the physical location of the space ship. The arrow that is placed at position $r$ has a length proportional to the norm of the force $F(r)$ and a direction parallel to the direction of the force. It thus tells you the strength and direction in which the space ship is pulled due to the gravitational force.

  #let xs = lq.linspace(0, 10)
  #let ys = lq.linspace(0, 1)

  #grid(
    columns: 2,
    [#todo("pt3d vector field")
      #pt3d.diagram()
    ],
    [#todo("2d repr")
      #lq.diagram(
        width: 100%,
        // lq.plot(xs,ys, mark: none)
      )],
  )


  The mathematical tool for determining the "strength of the field" is the *norm of a vector*, which measures the length of a vector and thus encodes the strength of a field. If we calculate $norm(F(r))$ in our case, we get
  $ norm(F(r)) = norm(-r/norm(r)^3) = norm(r)/norm(r)^3 = 1/norm(r)^2 $
  which illustrates that the force is getting smaller, the larger $abs(r)$ is

  The mathematical tool for determining the "direction of a field" are *unit vectors*. The unit vector of $r$ is a vector of length one, that points into the same direction as $r$. It thus encodes information regarding the direction of $r$, but not regarding its length. The unit vector of $r$ is usually denoted by $e_r$. It can be calculated via

  $ e_r = 1/norm(r) dot r $

])

== Calculus of curves

#todo("function signature")

#defbox("Coordinate functions", [
  Let $I subset RR$ be an interval and $c:I->RR^n$ be an arbitrary curve. Then there are $n$ (contiguous) coordinate functions $c_i:I->RR$, such that
  $ c(t) = vec(c_1 (t), c_2 (t), dots.v, c_n (t)) $
  and vice versa: If $n$ real valued (continuous) functions $c_i:I->RR$ with a common interval $I$ as domain of definition are given, we can define a curve $c(t)$ whose coordinate functions are $c_1, c_2, ..., c_n$.
])

The decomposition of curves into coordinate functions allows us to generalize most of the concepts from previous analysis courses to curves:

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
    &dif/(dif t) f_1 (t) = dif/(dif t) cos (t) = -sin(t) \
    &dif/(dif t) f_2 (t) = dif/(dif t) sin(t)/t = (cos(t) dot t - sin(t) dot 1)/t^2 = cos(t)/t - sin(t)/t^2 \
    => &dif/(dif t) f(t) = vec(-sin(t), cos(t)/t - sin(t)/t^2)
  $,
)
#defbox(
  [Linearisation at $t = pi$],
  $
    &f_1 (t) approx f_1 (pi) + f'_1 (pi) (t - pi) = cos(pi) - sin(pi) (t - pi) = -1 \
    &f_2 (t) approx f_2 (pi) + f'_2 (pi) (t - pi) = sin(pi)/pi +(cos(pi)/pi - sin(pi)/pi^2)(t - pi) = -1/pi (t - pi)\
    => &f(t) approx f(pi) + f'(pi) (x - pi) = vec(-1, - 1/pi (t - pi)) = vec(-1, 0) - (t - pi) vec(0, 1/pi)
  $,
)

#todo("diagram")

For any $ve(a), ve(v) in RR^n$ a curve of the form $g:cases(RR &-> RR^n, t &|-> ve(a) + t dot ve(v))$ corresponds to a line going through the point $a$ in the direction of $v$.

#todo("Notes 30/31")

#defbox(
  "Reparametrization",
  [
    Let
    $ c: cases(I &-> RR^n, t &|-> c(t)) $
    be a curve and $h:J->I$ an arbitrary bijective function. Then the image of the curve
    $ d: cases(J &-> RR^n, s &|-> c(h(s))) $
    is identical to the image of the curve $c(t)$:
    $ c(I) = d(J) $
    We call $d(s)$ _reparametrization_ of $c(t)$ using $t = h(s)$
  ],
)

#todo("rest of chapter")

#defbox("Image of a curve", [
  The image of a curve
  $ c: cases(I &-> RR^n, t &|-> c(t)) $
  can be envisioned as a road that is passed from a passenger, who reaches position $c(t)$ at time $t$. Thus:

  - The *derivative* $c'(t)$ is a *measure of the speed* of the person at time $t$.
  - The *derivative* $c'(t)$ points into a *direction tangent to the road* at position $c(t)$
  - The *norm* $norm(c'(t))$ of the derivative is *a measure of the speed* with which the person is moving *at time* $t$.

  If we reparametrize the curve $c$ with a bijective function $t = h(s)$ the image of the curve
  $ d(s) = c(h(s)) $
  is identical to the image of $c$ and thus corresponds to the same road. It is however passed by another person, who is passing point $d(s) = c(h(s))$ with a velocity
  $ d'(s) = c'(h(s)) dot h'(s) $
  that is $h'(s)$ faster (or slower) than the velocity of the first person at time $t = h(s)$.
])

#todo("formal proof (Notes 33/34)")

== Calculus of real valued functions in many variables

#todo("function signature")

=== Partial derivative and gradient

Let $f: D -> RR$ be an arbitrary real valued function and $x in D subset RR^n$ be an arbitrary vector in the domain of $f$. We consider the domain $D$ of $f$ to be sufficiently large for doing calculus at $x$, if for every vector $v in RR^n$ there is a small interval $(-epsilon; epsilon), epsilon > 0$, such that for all $t in (-epsilon;epsilon)$ the vector $x + t dot v in D$. This condition guarantees that any curve that hits the domain of $f$, remains there for at least a short period of time, and is one of the properties that needs to be satisfied in order to denote $f$ as a hyper-surface. The other property that is required for $f$ to be a hyper-surface, is that $f$ is continuous at any point of its domain.

#defbox("Partial derivative", [

  The _partial derivative_ of $f$ with respect to the $i$-th coordinate function is defined through
  $ partial/(partial x_i) f(x) = lim_(t->0) (f(x + t dot e_i) - f(x))/t $
])
#defbox("Gradient", [
  The _gradient_ of $f$ is an $n$-dimensional row vector, whose components correspond to the various *partial derivatives*.
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

We can use the notion of dependent variables as an alternative representation of functions, this notion allows us to define functions without explicitly stating its arguments.
#todo("example (Notes 40)")

=== Partial and total derivative

#todo("")

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
    spacing: (10em, 0em),
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

illustrates that $f$ is a function from $D$ to $M$, $g$ is a function from $N$ to $R$ and $M$ is a subset of $N$. Alternatively, for every set $Q$, such that $M subset Q subset R$ we could also have written

#align(center, diagram(
  spacing: (5em, 0em),
  node-stroke: none,
  node((0, 0), $D$),
  edge($f$, "-|>", label-side: left),
  node((1, 0), $Q$),
  edge($g$, "-|>", label-side: left),
  node((2, 0), $R$),
))

indicating that $f$ maps $D$ into a subset of $Q$, which in turn is a subset of the domain of $g$ and thus can be mapped to $R$ using $g$.

A _commutative diagram_ is an extension of the previous diagram, in which we add an additional arrow pointing from $D$ to $R$.

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

By labeling this additional arrow with $h$, a commutative diagram can be used to define a function from $D$ to $R$, that is behaving such, that it maps every $x in D$ to exactly the same element as the composition of $g$ with $f$.

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

#todo("function signature")

=== Jacobian matrix and linearisation

In the theory of real valued functions in one variable the linearisation of $f : RR -> RR$ at $x_0 in RR$ is done via
$ f(x) approx f(x_0) + f'(x_0) dot (x - x_0), x approx x_0 $
and can be interpreted as:

+ First order Taylor polynomial of $f$, which implies that the linearisation of $f$ at $x_0$ is that first order polynomial which best approximates $f$ in the vicinity of $x_0$.
+ Identifying that particular line that fits best to the graph of $f$ in a neighborhood of $x_0$. This line is known as tangent of $f$ at $x_0$.
+ Definition of the derivative of $f$ at $x_0$. $ f'(x_0) approx (f(x) - f(x_0))/(x - x_0) "for" x approx x_0, x != x_0 $ tells us that both sides of this equation become equal for $x -> x_0$, and therefore equivalent to the definition of the derivative of $f$ at $x_0$ $ f'(x_0) = lim_(x->x_0) (f(x) - f(x_0))/(x - x_0) $

In the theory of vector valued functions of many variables, the linearisation of a vector valued function in $n$ variables $f: RR^n -> RR^m$, itself has to be a mapping from $RR^n$ to $RR^m$. Further, the right hand side has to be an affine transformation, i.e. a function of the form
$ A_(a,M) (x) = a + M dot x $
in which $M$ is a matrix and $a$ is a vector. Since we expect that $A_(a,M)$ to map $RR^n$ to $RR^m$, we can infer that $a in RR^m$ and $M in RR^(m times n)$.

The *derivative of a vector valued function* $f:RR^n->RR^m$ can thus be expected to be a matrix $M in RR^(m times n)$. This matrix is called _Jacobian matrix_ and it can be shown that this matrix is comprised of all partial derivatives of all component functions of $f$.

#defbox("Jacobian matrix", [
  Let $f:RR^n->RR^m$ be a some vector valued function and $x_0 in RR^n$ be a point, where the partial derivatives of all component functions $partial_x_k f_l (x_0)$ exist. The $(m times n)$-matrix that aggregates all partial derivatives of $f$ at $x_0$
  $
    J_f (x_0) = mat(
      partial_x_1 f_1 (x_0), partial_x_2 f_1 (x_0), ..., partial_x_n f_1 (x_0);
      partial_x_1 f_2 (x_0), partial_x_2 f_2 (x_0), ..., partial_x_n f_2 (x_0);
      dots.v, dots.v, dots.down, dots.v;
      partial_x_1 f_m (x_0), partial_x_2 f_m (x_0), ..., partial_x_n f_m (x_0);
    )
  $
  such that the $l$-th row of $J_f (x_0)$ corresponds to the gradient of the $l$-th coordinate function $f_l$, is called _Jacobian matrix_ of $f$ at $x_0$. Besides of the symbol $J_f (x_0)$ the following notations are also used for the Jacobin matrix at $x_0$:
  $ f'(x_0) = lr((partial f)/(partial x) |)_(x = x_0) = J_f (x_0) $
])

#exbox(title: "Jacobian matrix", todo[])

#defbox("Linearisation", [
  Let $f:RR^n->RR^m$ be a some vector valued function and $x_0 in RR^n$ be an arbitrary point from the domain of definition of $f$ If $J_f (x_0) = lr((partial f)/(partial x) |)_(x=x_0)$ is the Jacobin matrix of $f$ at $x_0$, then
  $ f(x) approx f(x_0) + J_f (x_0) dot (x - x_0) "for" x approx x_0 $
  The function on the right-hand side is called _linearisation_ of $f$ at $x_0$.
])

#exbox(title: "Linearisation", todo[])

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
