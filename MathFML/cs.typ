#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)

= Vectors

#deftbl(
  [Norm/Length],
  $
    norm(v) = sqrt(scripts(sum)_(i=1)^n v_i^2) \
    norm(v) = sqrt(v^T v) \
    gradient norm(v) = 1/norm(v) v^T
  $,
  [Distance],
  $
    d(u,v) = norm(u - v) \
    #todo[$ gradient d(u,v) = 1/(d(u,v)) ((u-v) (u-v)) ???\
    gradient_u d(u,v) = (u − v)/norm(u − v) = (u − v)/(d(u,v)) \
    gradient_v d(u,v) = −(u − v) / norm(u − v) = (v − u)/(d(u,v)) $]
  $,
  [Scalar product],
  $
    u prod v = u^T v = sum_k u_k v_k
  $,
)

== Scalar product

= Matrices

/ Determinant: $
    & det mat(a) = a && det mat(a, b; c, d) = a d - c b \
    & det mat(a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33) = &&a_11 a_22 a_33 + a_12 a_23 a_31 + a_13 a_21 a_32 \
    & &&- a_31 a_22 a_13 - a_32 a_23 a_11 - a_33 a_21 a_12
  $
/ Inverting: $
    A = mat(a, b; c, d) => A^(-1) = 1/(a d - c b) mat(d, -b; -c, a)
  $
/ Transposing: $
    mat(1, 0; 0, 2; 3, 1)^T = mat(1, 0, 3; 0, 2, 1) , space vec(1, 4, 5)^T =mat(1, 4, 5)
  $
/ Matrix multiplication: $
    #tr($mat(2, 3, 1; 4, -1, 7)$) dot #tb($mat(6, 4; 1, 0; 8, 9)$) \ = mat(
      (#tr(2) dot #tb(6)+#tr(3) dot #tb(1)+#tr(1) dot #tb(8)), (#tr(2) dot #tb(4)+#tr(3) dot #tb(0)+#tr(1) dot #tb(9))
      ; (#tr(4) dot #tb(6)+#tr(-1) dot #tb(1)+#tr(7) dot #tb(8)), (#tr(4) dot #tb(4)+#tr(-1) dot #tb(0)+#tr(7) dot #tb(9))
    ) = mat(23, 17; 79, 79)
  $

== Indices

$
  A in RR^(n times m), &B in RR^(m times r), A dot B in RR^(n times r) \
  (A dot B)_(i j) = &sum_(k=1)^m A_(i k) B_(k j) = sum_k A_(i k) B_(k j) \
  ((A dot B)^T)_(i j) = &(A dot B)_(j i) = sum_k A_(j k) B_(i k) \
  a^T dot B dot a = &sum_(i j) (a^T)_i B_(i j) a_j = sum_(i j) a_i B_(i j) a_j \
  (B dot a) (C dot a) = &sum_i (B dot a)_i (C dot a)_i \
$

== Kronecker delta

$
  delta_(i j) = &(ve(e)_(i))_j = cases(1 space"," i = j, 0 space ", otherwise") \
  (E_(r s t))_(i j k) = &delta_(r i) delta_(s j) delta_(t k)
$

== Basis vectors

$
  RR^3 \
  e_1 = vec(1, 0, 0), e_2 = vec(0, 1, 0), e_3 = vec(0, 0, 1) \
$

== Unit matrices

$
  RR^2 \
  E_(1 1)= mat(1, 0; 0, 0), E_(1 2) = mat(0, 1; 0, 0), E_(2 1)= mat(0, 0; 1, 0), E_(2 2) = mat(0, 0; 0, 1) \
$

== Affine transformations

$
  A_(a,M) (x) = & a + M dot x \
  L_A (ve(0)) = & ve(0) \
$

= Derivatives

#{
  set text(size: .75em)
  grid(
    columns: (1.25fr, 1fr),
    stroke: (x, y) => if x == 1 { (left: colors.fg + .5pt) },
    gutter: 0pt,
    $
      & 1         && -> 0 \
      & x^2       && -> 2x \
      & 1/x       && -> -1/x^2 \
      & e^x       && -> e^x \
      & ln(x)     && -> 1/x "for" x>0 \
      & a^x       && -> ln(a) dot a^x "for" a > 0, a != 1 \
      & sin(x)    && -> cos(x) \
      & cos(x)    && -> -sin(x) \
      & tan(x)    && -> 1+tan^2(x) = 1/(cos^2(x)) \
      & cot(x)    && -> -1/(sin^2(x)) \
      & arccos(x) && -> -1/sqrt(1-x^2) \
    $,
    $
      & x           && -> 1 \
      & x^n         && -> n x^(n-1) \
      & sqrt(x)     && -> 1/(2 sqrt(x)) \
      & e^(-x)      && -> -e^(-x) \
      & ln(y dot x) && -> 1/x "for" x>0 \
      & log_b (x)   && -> 1/(ln(b) dot x) \
      & sin(2x)     && -> 2cos(2 x) \
      & cos(a x)    && -> -a sin(a x) \
      & arccot(x)   && -> -1/(1 + x^2) \
      & arcsin(x)   && -> 1/sqrt(1-x^2) \
      & arctan(x)   && -> 1/(1+x^2) \
    $,
  )
}

#deftbl(
  [Addition],
  $ (f(x) + g(x))' = f'(x) + g'(x) $,
  [Multiplication],
  $ (alpha dot f(x))' = alpha dot f'(x) $,
  [Product rule],
  $
    (f dot g)' = f' dot g + f dot g' \
    (f dot g dot h)' = f' dot g dot h + f dot g' dot h + f dot g dot h'
  $,
  [Chain rule],
  $ (f (g (x)))' = f'(g(x)) dot g'(x) $,
  [Quotient rule],
  $ (f/g)' = (f' g-f g')/g^2 $,
)

// #table(
//   align: center + horizon,
//   columns: (auto, 1.5fr, auto, 1fr),
//   table-header([Term], [Derivative], [Term], [Derivative]), $ 1 $, $ 0 $, $ x $,
//   $ 1 $, $ x^2 $, $ 2x $, $ x^n $,
//   $ n x^(n-1) $, $ 1/x $, $ -1/x^2 $, $ sqrt(x) $,
//   $ 1/(2 sqrt(x)) $, $ e^x $, $ e^x $, $ e^(-x) $,
//   $ -e^(-x) $, $ ln(x) $, $ 1/x "for" x>0 $, $ ln(y dot x) $,
//   $ 1/x "for" x>0 $,
//   $ a^x $,
//   $ ln(a) dot a^x "for" a > 0, a != 1 $,
//   $ log_b (x) $,
//
//   $ 1/(ln(b) dot x) $,
//
//   $ sin(x) $, $ cos(x) $, $ sin(2x) $, $ 2cos(2 x) $,
//   $ cos(x) $, $ -sin(x) $, $ cos(a x) $, $ -a sin(a x) $,
//   $ tan(x) $, $ 1+tan^2(x) = 1/(cos^2(x)) $, $ arcsin(x) $, $ 1/sqrt(1-x^2) $,
//   $ arccos(x) $, $ - 1/sqrt(1-x^2) $, $ arctan(x) $, $ 1/(1+x^2) $,
// )

= Functions of several variables

#deftbl(
  [Real valued function],
  $ R subset RR $,
  [Vector valued function],
  $ R subset RR^m $,
  [A function of $n$ variables],
  $ D subset RR^n $,
  [Softmax function],
  todo[],
  [RSS],
  $ RSS = sum_i (y_i - f(x_i))^2 $,
  [$n$-dimensional curve],
  $ c : RR -> RR^n $,
  [$n$-dimensional hyper-surface],
  $ s : RR^n -> RR $,
  [Reparametrization],
  $ c(t) -> d(s) = c(h(s)) $,
)

#grid(
  columns: 2,
  [
    / Sigmoid function: $ sigma(x) : RR -> [0;1] = 1/(1+e^(-x)) $
  ],
  [#let xs = lq.linspace(-10, 10)
    #diagram2d(
      width: 100%,
      height: 1.5cm,
      lq.plot(
        xs,
        xs.map(x => calc.exp(x) / (1 + calc.exp(x))),
        mark: none,
      ),
    )
  ],
)

== Derivatives

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
    f': &cases(RR^n &-> RR^(1 times n), x &|-> y) = gradient f \
    &= (partial/(partial x_1) f(x), partial/(partial x_2) f(x), dots, partial/(partial x_n) f(x))
  $,
  $ f: cases(RR^n &-> RR^m, x &|-> y) $,
  $
    f': & cases(RR^n &-> RR^(m times n), x &|-> y) = J_f = lr(
            (partial
            f)/(partial x)|
          )_(x=x_0) \
        & = vec(gradient f_1 (x), dots.v, gradient f_m (x)) = mat(
            partial/(partial x_1) f_1 (x), ..., partial/(partial x_n) f_1 (x);
            dots.v, dots.down, dots.v;
            partial/(partial x_1) f_m (x), ..., partial/(partial x_n) f_m (x);
          )
  $,
)

=== Partial vs total derivative

#todo[example FS2024]

$
  f(x,y) = & x^2 + 2y \
  (partial f)/(partial x) = & 2x \
  (dif f)/(dif x) = & (partial f)/(partial x) + (partial f)/(partial
  y) dot (dif y)/(dif x) = 2x + 2 dot (dif y)/(dif x) | ("y dependent on x") \
$

=== Gradients

/ Common gradients: $
    f(x) = & norm(x)^2                && => gradient f && = 2x \
    f(x) = & a^T x + c                && => gradient f && = a \
    f(x) = & x^T A x                  && => gradient f && = (A + A^T) x \
    f(x) = & 1/2 x^T A x + b^T x + c  && => gradient f && = (A + A^T)/2 x + b \
           &                          &&               && = A x + b "if" A^T = A \
    f(x) = & g(A x + b)               && => gradient f && = A^T gradient g(A x + b) \
           & g: RR^m -> RR            && \
    f(x) = & u(x) dot v(x)            && => gradient f && = (J_u)^T v + (J_v)^T u \
    f(x) = & norm(u(x)) = sqrt(u^T u) && => gradient f && = (J_u)^T u/norm(u) "if" norm(u)
                                                          != 0 \
    f(x) = & log p(x)                 && => gradient f && = 1/p(x) gradient p(x) \
  $

=== Jacobian Matrix

$
  f: RR^2 -> RR^2, space J_f (x, y) = mat(
    partial x_1, partial y_1;
    partial x_2, partial y_2;
  )
$

/ Linearisation: $
    f : RR^n -> RR^m, space x_0 in RR^n \
    L_f (x) = f(x_0) + J_f (x_0) dot (x - x_0)
  $
/ Chain rule: $
    f : RR^n -> RR^m, space g : RR^m -> RR^k, space h : RR^n -> RR^k = g compose f \
    J_h = J_g (f(x)) dot J_f (x)
  $
/ Common jacobians: $
    f(x) = & a + M dot x && => J_f = M \
    f(x) = & x           && => J_f = bb(1) \
    f(x) = & norm(x)^2   && => J_f = (2 x)^T \
  $

#todo[
  $J_x$ for softmax $s_i = e^(x_i)/Sigma e^(x_k): J_(i j) =
  s_i(delta_(i j) − s_j)$
]

=== Hyper-surfaces

/ Chain rule: $
    f : RR^n -> RR^m, space g : RR^m -> RR, space h : RR^n -> RR = g compose f \
    gradient h (x) = gradient g(f(x)) = gradient g(f)|_(f=f(x)) dot partial/(partial x) f(x)
  $
/ Differentiation properties: $
    f : RR^n -> RR, space & g : RR^n -> RR \
         gradient (f + g) & = gradient f + gradient g \
         gradient (f - g) & = gradient f - gradient g \
       gradient (f dot g) & = g gradient f + f gradient g \
             gradient f/g & = (g gradient f - f gradient g)/(g^2) \
  $

== Commutative diagrams

#grid(
  columns: (1fr, auto),
  $
    f : & D -> M \
    g : & N -> R \
    h : & D -> R \
        & = g compose f
  $,
  diagram(
    node-stroke: none,
    spacing: (5em, 0em),
    node((0, 0), $D$, name: <d>),
    edge("-|>", label: $f$, label-side: left),
    node((1, 0), $M$, name: <m>),
    edge("-|>", label: $g$, label-side: left),
    node((2, 0), $R$, name: <r>),
    edge(<d>, <r>, "-|>", label: $g compose f$, bend: 30deg, label-side: left),
  ),
)

== Geometry of hyper-surfaces

$ f : RR^2 -> RR $

/ Tangent space: $alpha, beta in RR, T =$
  $
    {
      vec(x_0, y_0, f(x_0, y_0))
      + alpha vec(1, 0, partial_x f(x_0, y_0))
      + beta vec(0, 1, partial_y f(x_0, y_0))
    }
  $
/ Graph of a linearisation: $
    l(x) = f(x_0) + gradient f (x_0) dot (x - x_0) = T_(p_0)
  $

=== Second derivative

$
  partial/(partial x) (partial/(partial x) (f(x,y))) = (partial^2 f(x,y))/(partial
  x^2) = partial_(x x) f(x,y)
$

=== Hessian matrix

$
  f : & RR^n -> RR \
  H(x,y) = &mat(f_(x x), f_(x y); f_(y x), f_(y y);) = J(gradient f)\
  (H(x))_(i j) = & partial/(partial x_i) partial/(partial x_j) f(x) \
  partial_i partial_j f = & partial_j partial_i f
$

/ Common hessians: $
    f(x) = & 1/2 x^T A x + b^T x + c && => H_f = (A + A^T)/2 \
    f(x) = & g(A x + b)              && => H_f = A^T H_g (A x + b) A \
           & g: RR^m -> RR           && \
  $

// f(x)=g(h(x)) with scalar g and vector h: H_f = (J_h)ᵀ H_g(h(x)) J_h + Σ_k (∂k g) H{h_k}(x) (index form).
// f(x)=u(x)·v(x): H_f = (J_u)ᵀ J_v + (J_v)ᵀ J_u + Σ_i v_i H_{u_i} + Σ_i u_i H_{v_i} (use index expansion).

=== Extremal points

Let $z = f(c(t)), space c$ a curve passing the stationary point\
$c_0 = (x_0, y_0)$ at $t = t_0$ and
$
  (dif^2 z)/(dif t^2) = underbrace(
    (accent(c, dot)_1 (t_0),
      accent(c, dot)_2 (t_0)), v^T
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

+ If $forall v in RR^2 without {ve(0)} (v^T H v > 0)$, then
  $(dif^2 z)/(dif t^2) > 0$ defines a _local minimum_
+ If $forall v in RR^2 without {ve(0)} (v^T H v < 0)$, then
  $(dif^2 z)/(dif t^2) < 0$ defines a _local maximum_
+ If $forall v in RR^2 without {ve(0)} (v^T H
    v < 0 or v^T H v > 0)$, the point $c_0 = (x_0,y_0)$ defines a
  _saddle point_

#todo[
  $
    (J_u)_(i j) = (partial u_i)/(partial x_j), (H_g)_(i j) = (partial^2 g)/(partial
    x_i partial x_j) \
    partial_j (u_i v_i) = (partial_j u_i) v_i + u_i (partial_j v_i)
  $
]

= Misc

$
  a x^2 + b x + c = 0 => x_(1,2)=(-b plus.minus sqrt(b^2 - 4a c))/(2a)
$

== Trigonometry

#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: center + horizon,
  table-header(
    $ x $,
    $ 0 $,
    $ 30 degree =pi/6 $,
    $ 45 degree = pi/4 $,
    $ 60 degree =pi/3 $,
    $ 90 degree = pi/2 $,
  ),

  emph[ $ sin(x) $ ], $ 0 $, $ 1/2 $, $ sqrt(2)/2 $, $ sqrt(3)/2 $, $ 1 $,
  emph[ $ cos(x) $ ], $ 1 $, $ sqrt(3)/2 $, $ sqrt(2)/2 $, $ 1/2 $, $ 0 $,
  emph[ $ tan(x) $ ], $ 0 $, $ 1/sqrt(3) $, $ 1 $, $ sqrt(3) $, $$,
)
#grid(
  columns: (auto, auto),
  $
    & tan(x) = sin(x)/cos(x) \
    & sin(2x) = 2 sin(x)cos(x) \
    & sin^2(x) + cos^2(x) = 1 \
    & #td[*$1$*], #tp[*$sin(alpha)$*], #tg[*$cos(alpha)$*] \
  $,
  {
    diagram2d(
      width: 3cm,
      height: 2cm,
      legend: (position: left + top, fill: colors.bg, inset: 0pt, pad: 0pt),
      ylim: (-0.25, 1),
      xlim: (-0.75, 1),

      lq.path(
        ..lqcircle(),
        closed: true,
      ),

      lq.plot(
        (0, calc.cos(calc.pi / 4)),
        (0, calc.sin(calc.pi / 4)),
        // label: $1$,
        mark: none,
        stroke: 2pt,
      ),

      lq.plot(
        (calc.cos(calc.pi / 4), calc.cos(calc.pi / 4)),
        (calc.sin(calc.pi / 4), 0),
        // label: $sin(alpha)$,
        mark: none,
        stroke: 2pt,
      ),

      lq.plot(
        (calc.cos(calc.pi / 4), 0),
        (0, 0),
        // label: $cos(alpha)$,
        mark: none,
        stroke: 2pt,
      ),

      lq.path(
        // eh hardcoded is fine for now
        ..lqcut(lqcircle(s: 1 / 4), (0, 0), (1, 0.18)),
      ),
      lq.path(
        // don't wanna waste more time here
        ..lqcut(
          lqcircle(s: 1 / 5, x: calc.cos(1) + 0.17),
          (0, 0),
          (calc.cos(calc.pi / 4), 1),
        ),
        stroke: colors.red,
      ),
      lq.plot(
        (calc.cos(calc.pi / 4) - 0.07,),
        (0.07,),
        stroke: colors.red,
      ),
      lq.plot(
        (0.12,),
        (0.13,),
        mark: mark => $alpha$,
      ),
    )
  },
)

= Gradient descent / Newton's method

$
  G D : x_(i + 1) = &x_i - gamma dot gradient f(x_i) \
  N : x_(i + 1) = &x_i - gamma dot (H_f(x_i))^(-1) dot gradient f(x_i) \
  gamma = &"step size" \
  "termination criterion" epsilon > &abs(x_(i+1) - x_i)
$

= Examples

#todo[]
