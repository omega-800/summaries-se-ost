#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Machine Learning (ML)

There are many different AI research fields and AI applications. Algorithms and
applications where a computer learns from data are typically in the field of
statistical machine learning (ML).

/ Computer: performs a mapping from input to output.
/ Processing: any sort of non-trivial "calculation" (mapping) or information
  processing
/ Input: any sort of data/information (sensory input, bits, mechanical
  configuration...)
/ Output: any sort of response (data, actions, new state of a system...)
/ Data Visualization: Gives intuitive understanding of structure in the data,
  helps in identifying patterns, detecting outliers and data quality. Raw data
  $->$ Information

#todo[
  plot examples

  https://ourworldindata.org/

  https://informationisbeautiful.net/
]

= Probability

== Random Variables

A random variable $X$ is a function from the sample space to the real numbers.
$ X : S -> RR $
Random Variables come in two flavours:
/ discrete: $X$ takes any of a finite or countable set of values, e.g.
  ${-8, 1.5,
    1.5, 2.693, 5, 6.3, 10}$
/ continuous: $X$ takes any value of an uncountable range, e.g. the real numbers
  in the interval $(2, 7)$.

$Pr(X=x)$ is the probability that the random variable $X$ takes the value $x$.
It's often written as $P(x)$ or $p(x)$ or $P_X (x)$ or $PP (x)$.

#todo[MathFML explained this a lot better]

#defbox("Range", [
  The range of a random variable $X$, shown by $"Range"(X)$ or $R_X$, is the set
  of possible values of $X$.
])

== Discrete random variables

The Probability Mass Function (PMF) of a discrete random variable is a function
$P(x)$ that provides the probability for each value $x$ of a discrete random
variable $X$.

#todo[
  $
                                  0 <= P_X (x) <= & 1 \
                         sum_(x in R_X) P_X (x) = & 1 \
    "for any set" A subset R_X, space P(X in A) = & sum_(x in A)P_X (x) \
  $
]

#exbox(table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.cell(colspan: 7)[Dice rolls],
  [Value $x$ of the random Variable $X$], $1$, $2$, $3$, $4$, $5$, $6$,
  $P(X=x)$, $1/6$, $1/6$, $1/6$, $1/6$, $1/6$, $1/6$,
))

From the PMF, we can calculate the expected value
$
  E[X] = sum_(i=1)^oo P(x_i)
  dot x_i
$

=== Multiple Random Variables

The (joint) properties of multiple random variables are defined by the _Joint
Probability Mass Function_, usually simply called Joint Probability.

For *independent* random variables, the joint probability is simply the product
of the individual probabilities
$ P(X inter Y) = P(X) dot P(Y) $

#exbox(
  title: [Rolling two dice],
  grid(
    columns: (1fr, auto),
    [
      The random experiment of rolling die 1 and die 2 together has $36$
      possible outcomes (events). The Joint Probability is:
      $
        P(X=5, Y=4) = 1/6 dot 1/6 = 1/36
      $
    ],
    table(
      columns: 7,
      table-header($$, $X=1$, $X=2$, $X=3$, $X=4$, $X=5$, $X=6$),
      emph[$Y=1$],
      $1/36$,
      $1/36$,
      $1/36$,
      $1/36$,
      $1/36$,

      $1/36$, emph[$Y=2$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      $1/36$, emph[$Y=3$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      $1/36$, emph[$Y=4$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      $1/36$, emph[$Y=5$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      $1/36$, emph[$Y=6$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      $1/36$,
    ),
  ),
)

== Conditional Probability

For *dependent* random variables we use the conditional probability of $X$ given
$Y$ defined as
$
  P(X|Y) = P(X inter Y)/P(Y), space "when" P(Y) > 0
$

#todo[
  $
             P(X inter Y) = & P(X|Y) dot P(Y) \
    X inter Y = emptyset => & P(X|Y) = 0 \
              Y subset X => & P(X|Y) = 1 \
              X subset Y => & P(X|Y) = P(X)/P(Y) \
             P(X inter Y) = & P(X) P(Y|X) = P(Y) P(X|Y) \
  $
]

/ Independence: Two events $X$ and $Y$ are independent iff $P(X inter Y) = P(X)
  P(Y)$
/ Law of Total Probability: If $Y_1,Y_2,Y_3,...$ is a partition of the sample
  space $S$, then for any event $X$ we have
  $ P(X) = sum_i P(X inter Y_i) = sum_i P(X|Y_i)P(Y_i) $
/ Bayes' Rule: For any two Events $X$ and $Y$, where $P(X) != 0$, we have
  $
    P(Y|X) = & (P(X|Y) dot P(Y))/(P(X)) \
    "Interpretation: " quad "Posterior" = & ("Likelihood" times "Prior")/"Normalizer"
  $
/ Conditional independence: Two events $X$ and $Y$ are conditionally independent
  given an event $Z$ with $P(Z) > 0$ if
  $
       P(X inter Y|Z) = & P(X|Z)P(Y|Z) \
    => P(X|Y inter Z) = & P(X|Z)
  $

#exbox(title: "Chance of rain", grid(
  columns: 2,
  [
    Let $X$ be the event to observe clouds (0=no clouds, 1=small clouds, 2=big
    clouds) and $Y$ the event that it rains (0=no rain, 1=light rain, 2=moderate
    rain, 3=heavy rain)

    #todo[
      Given a known joint distribution of two discrete random variables, say, X
      and Y, the marginal distribution of either variable – X for example – is
      the probability distribution of X when the values of Y are not taken into
      consideration. This can be calculated by summing the joint probability
      distribution over all values of Y.
    ]

    $
      P(X) = & sum_Y P(X,Y) \
      P(Y) = & sum_X P(X,Y) \
    $
  ],
  table(
    columns: 4,
    table-header($$, $X=0$, $X=1$, $X=2$), emph[$Y=0$], $0.35$, $0.21$,
    $0.03$, emph[$Y=1$], $0.10$, $0.07$,
    $0.04$, emph[$Y=2$], $0.00$, $0.05$,
    $0.05$, emph[$Y=3$], $0.00$, $0.02$,
    $0.08$,
  ),
))

== Continuous random variables

For a continuous random variable $X$ following holds:

$
  P(-oo < x < oo) = & 1 \
     P(a < x < b) = & integral_a^b f(x) dif x \
             P(x) = & 0 \
$

#shared.unifdef

#shared.cdfdef

#shared.pdfdef

#shared.cdfex

== Distributions

=== Univariate normal distribution

#shared.univariate-normal-def

#shared.rule-68-95-99

=== Bernoulli distribution

A random variable $X$ is said to be a Bernoulli random variable with parameter
$p$, shown as $X ∼ "Bernoulli"(p)$, if its PMF is given by
$
  P_X (x) = cases(p & "for" x = 1, 1 - p quad & "for" x = 0, 0 & "otherwise")
$
where $0<p<1$

A Bernoulli random variable is associated with a certain event $A$. If event $A$
occurs, then $X=1$; otherwise $X=0$. For this reason the Bernoulli random
variable is also called the indicator random variable. The indicator random
variable $I_A$ for an event $A$ is defined by
$ I_A=cases(1 quad & "if" A "occurs", 0 & "otherwise") $
The indicator random variable for an event $A$ has Bernoulli distribution with
parameter $p=P(A)$, so we can write $I_A∼"Bernoulli"(P(A))$.

#todo[https://www.probabilitycourse.com/chapter3/3_1_5_special_discrete_distr.php]

= Tree Diagrams and sequential events

A _probabilistic model_ that explains how data is generated (_generative
model_). Generative Models connect domain knowledge with data.

The 2-step model captures the causality of observable events.

- Step 1 lists all our _hypotheses_ (mutually exclusive, exhaustive) that could
  have caused an outcome. (Example: $U_1, U_2$)
- Step 2 is an enumeration of all possible observable _consequences_ (Example:
  $W, S$)

#exbox(title: "Urns: Tree Diagram", [
  There are two urns, $U_1$ and $U_2$. Urn $U_1$ contains 5 silver and 5 white
  balls, and urn $U_2$ contains 9 silver and 1 white ball. The probability of
  drawing a ball from $U_1$ or $U_2$ is equal (50/50). What is the probability
  of drawing a white ball?

  We can visualize the probabilities using a _tree diagram_:

  #shared.urndiag

  The probability of drawing a white ball is therefore $30\%$, assuming that
  each urn is chosen with equal probability.
])

We can use Bayes' theorem to "go backwards" and start with the observation and
deduce the cause.
$
  P("Hypothesis"|"Evidence") = & (P("Evidence"|"Hypothesis") dot P("Hypothesis"))/(P("Evidence")) \
$

_Bayesian inference_ is the statistical method that uses Bayes' theorem to
update the probability of a hypothesis after seeing new data. It starts with a
_prior probability_ (belief before the evidence) and combines it with a
likelihood to produce a _posterior probability_ (updated belief).

#exbox(title: "Urns: Bayesian inference", [
  We have seen that the choice of urns yield following probabilities (prior):

  $
    P(U_1) & = 0.5 \
    P(U_2) & = 0.5 \
  $

  If we observe the drawing of a white ball, we can deduce which urn was more
  likely to be chosen from (posterior):
  $
    P(U_1|W) = & (P(W|U_1) dot P(U_1))/(P(W)) = (0.5 dot 0.5) / 0.3 = 0.8overline(3) \
    P(U_2|W) = & (P(W|U_2) dot P(U_2))/(P(W)) = (0.1 dot 0.5) / 0.3 = 0.1overline(6) \
  $

  Thus the _prior distribution_ of equally distributed probabilities changes to
  the _posterior distribution_ favoring $U_1$ when provided with the observed
  data.
])

Given multiple observed results we can use _Recursive Bayesian estimation_ (also
called _Bayesian filtering_), which is a general probabilistic approach for
estimating an unknown PDF recursively.

$
  p(x_0, ..., x_k, z_1, ..., z_k) = p(x_0) product_(i=1)^k p(z_i|x_i) p(x_i|x_(i-1))
$

#exbox(title: "Urns: Recursive Bayesian estimation", [
  Given the observed outcomes of white, silver, white (${ W, S, W }$), we can
  construct our posterior distribution recursively. We start with the prior
  $P(U_1) = 0.5$ and $P(U_2) = 0.5$.

  + After the first white ball ($W$):
    $
      P(U_1|W) approx & 0.833 \
      P(U_2|W) approx & 0.167
    $
  + Using these as the new priors, we observe a silver ball ($S$):
    $
      P(U_1|W, S) = (P(S|U_1) dot 0.833) / P(S) = (0.5 dot 0.833) / (0.5 dot 0.833 + 0.9 dot 0.167) approx 0.73 \
      P(U_2|W, S) = (P(S|U_2) dot 0.167) / P(S) = (0.9 dot 0.167) / (0.5 dot 0.833 + 0.9 dot 0.167) approx 0.27
    $
  + Using these as the new priors, we observe another white ball ($W$):
    $
      P(U_1|W, S, W) = (0.5 dot 0.73) / (0.5 dot 0.73 + 0.1 dot 0.27) approx 0.93 \
      P(U_2|W, S, W) = (0.1 dot 0.27) / (0.5 dot 0.73 + 0.1 dot 0.27) approx 0.07
    $

  The evidence of two white balls strongly overwhelms the single silver ball,
  significantly increasing our confidence that the balls have been drawn from
  $U_1$.
])

#todo[
  Kahneman & Tversky
]

== Vocab for human experiments

/ Prevalence: Proportion of a population who have a specific characteristic in a
  given time period.
/ Specificity: Percentage of people who test negative for a specific condition
  among a group of people who do not have the condition. No test is 100%
  specific because some people who do not have the condition will test positive
  for it (false positive).
/ Sensitivity: How well a test can detect a specific condition in people who
  actually have condition. No test has 100% sensitivity because some people who
  have the condition will not be identified by the test (false-negative test
  result).

= Linear Regression

Linear Models are the most simple model to explain a relationship between
"Input" and "Output". Linear Regression is a standard method to find an optimal
linear model

== Ingredients of Machine Learning

=== The 4 main ones

/ Data: The dataset we are given plus the pre-processing pipe-line including
  cleansing, feature-engineering, data- augmentation etc.
/ Cost-Function (Loss): A formal (mathematical) expression for "good" and "bad".
  Mean Squared Error (MSE) is commonly used.
/ Model: As simple as a two parameter, linear model
  $accent(y, hat)_i = m x_i + b$ or as complicated as a million-parameter Neural
  Network. Different tasks require different models (e.g. regression,
  decision-tree, ...)
/ Optimization Procedure: An algorithm that changes the parameters of the model
  such that the cost-function is minimized. (e.g. Stochastic Gradient Descent
  (SGD), ADAM, ...)

=== Others

Sounds like generic slop ngl

/ DevOps/MLOps Versioning. Reproducability:
  Building efficient pipe-lines is difficult. Following tool-specific
  recommendations and reference- implementations helps.
/ Visualization and evaluation of the learning Process: Learning curves,
  Performance measures, Tensorboard
/ Cross-Validation & Regularization:
  The goal is to train models that generalize well to unseen data (and get an
  estimate of the generalization error)
/ Baselines and Performance Monitoring:
  Implement a trivial baseline model. Every advanced model you train should beat
  it. Define what "better" means, and keep track of the performance evaluations.
  Deployed models need monitoring.

#todo[CySec confusion matrix, ground truth, model prediction]
#todo[W4 S7 Different Machine Learning Techniques and applications]

== Linear Regression

Linear Regression is a simple method to analyse data and quantify a relationship
between variables. It has countless applications, most of them fall in one of
two categories:

/ Interpretation: We want to understand if some input has an effect on the
  output. E.g. Is there a relationship between smoking cigaretts and the risk of
  lung cancer?
/ Prediction: Given a new "x" (e.g. Smoking rate), use the model to predict
  (estimate) the "y" (e.g Death rate)

In ML, linear regression falls into the category of _supervised learning_: we
are given both input data (X) and labels (Y). The ML algorithm learns a linear
relationship between X and Y.

=== Residual sum of square

Residual sum of square (RSS) is a statistical method that helps identify the
level of discrepancy in a dataset not predicted by a regression model. Thus, it
measures the variance in the value of the observed data when compared to its
predicted value as per the regression model.

#context shared.rss-def
#block(breakable: false, [#context shared.rss-ex])

=== Model

In ML, we use the term _model_ for any mathematical function that "explains the
data". More formally:
$
  y_i approx & f(x_i) \
       y_i = & f(x_i) + epsilon_i
$
Where $epsilon_i$ is "unexplained noise". It is often assumed that $epsilon_i$
follows a normal distribution.

The function $f$ can be anything from a constant up to a multi-million parameter
deep neural network. The goal of ML is to find the model which explains the data
as good as possible. Instead of approximating $y_i$, we calculate an estimate
$accent(y, hat)_i$ of the (usually unknown) $y_i$
$ accent(y, hat)_i approx & f(x_i) $
In linear regression, we decide to only consider a linear relationship between
the inputs and outputs. That is, before starting any learning algorithm, we
constrain the model space to the family of linear functions. Such a design
decision imposes an inductive bias on the model

In the simplest case, $m$ and $b$ are scalars and the linear model therefore has
only two free parameters . The goal is to identify $m$ and $b$ for which the
linear model "best explains the data"
$
  accent(y, hat)_i = m x_i + b
$
$m$ is usually called _slope_, $b$ the _intercept_ (aka _bias_). Often $w$ for
"weights" is used: $accent(y, hat)_i = w_1 x_i + w_0$

#todo[
  Is $y$ a linear function of $x$ in this model?

  $ y = a x^2 + b x + c $

  No. But the model is linear in the parameters $a,b,c$ . Linear regression only
  needs this second property.

  We can apply linear regression to arbitrarily complex models, as long as the
  model is linear in the unknowns.
]

=== Mean squared error

Mean squared error (MSE) is the average of the squares of the errors. It is
usually divided by 2, which does not change the location of the minimum. It
cancels the factor 2 that appears when we take the derivative of the square.
This simplifies the gradient.
$
  MSE = & RSS/(2N)
          = & 1/(2N) sum_(i=1)^N e_i^2
$
where
$
               e_i = & y_i - accent(y, hat)_i \
  accent(y, hat)_i = & m x_i + b \
$
and $e_i$ (the difference) is called the _residual_.

=== Correlation and causality

Correlation refers to the degree to which a pair of variables are linearly
related. It can be quantified using the _Pearson correlation coefficient_.
Showing correlation is not hard, convincingly identifying causality on the other
hand is.

==== Pearson correlation coefficient

The Pearson correlation coefficient (PCC) is a correlation coefficient that
measures linear correlation between two sets of data. It is the ratio between
the covariance of two variables and the product of their standard deviations.
Thus, it is essentially a normalized measurement of the covariance, such that
the result always has a value between $−1$ and $1$.

$
  "PCC"_(X, Y) = (
  sum_(i=1)^N (x_i - overline(x)) (y_i - overline(y))
  )/(
  sqrt(sum_(i=1)^N (x_i - overline(x))^2)
  sqrt(sum_(i=1)^N (y_i - overline(y))^2)
  )
$
- $1$ shows a perfect positive correlation where both variables increase /
  decrease together at a constant rate
- $-1$ shows a perfect negative correlation where one variable increases as the
  other decreases proportionally
- $0$ shows no linear relationship, meaning changes in one variable do not
  predict changes in the other

#context shared.corrdiags

=== Multiple linear regression

Same concept but with more factors and weights:
$
  accent(y, hat)_i = beta_1 x_(1 i) + beta_2 x_(2 i) + ... + beta_N x_(N i) + alpha_i
$
where
- $y_i$ is an observed/measured quantity. Example: blood pressure
- $x_(1 i) ... x_(N i)$ are "factors". Examples: $x_(1 i) : "age", x_(2 i) :
  "weight", x_(3 i) : "sex", x_(4 i) : "drug_dosage", ...$
- $beta_1 ... beta_N$ are weights. How much does each factor $x$ explain the
  outcome $y$?

==== Matrix notation

The dataset can be written as $N$ points $(x,y)$, where $x$ is a vector with $p$
features.
$ accent(y, hat) = X beta + alpha $
where
$
  X = mat(
    x_(1 1), x_(1 2), ..., x_(1 p);
    x_(2 1), x_(2 2), ..., x_(2 p);
    dots.v, dots.v, dots.down, dots.v;
    x_(N 1), x_(N 2), ..., x_(N p);
  ), quad beta = vec(beta_1, beta_2, dots.v, beta_N), quad y = vec(y_1, y_2, dots.v, y_N)
$

#todo[W4 S18,20]

= Optimization

Optimization is the problem of finding a set of inputs to an objective function
that results in a maximum or minimum function evaluation. In our applications
the objective is to minimize the loss function.

== Partial derivative and gradient

#shared.pd-gradient

== Gradient Descent

#shared.gradientdescent

The standard gradient descent is also called _batch gradient descent_.

=== Stochastic Gradient Descent (SGD)

Batch Gradient Descent computes the gradient of the cost function using the
entire training dataset for each iteration. This approach ensures that the
computed gradient is precise, but it can be computationally expensive when
dealing with very large datasets ($O(n)$).

$
  x_(i+1) = & x_i - gamma dot gradient f(x_i) \
          = & x_i - gamma 1/n sum_(j=1)^n gradient f_j (x_i) \
$

The idea behind SGD is that we do not need the exact gradient to find a
trajectory toward the minimum. Instead, at each iteration we can randomly pick a
single training example at $j$ and use it to calculate an approximation of the
gradient:

$
  x_(i+1) = & x_i - gamma dot gradient f_j_i (x_i) \
$

Where $j_i$ is the index of the randomly chosen example at iteration $i$. This
brings our complexity down to $O(1)$. Due to the estimate being noisy (as it's
based on one sample) we can average $m$ samples to get $O(m)$ with a less noisy
result. This method is called _mini-batch SGD_.

$
  x_(i+1) = & x_i - gamma 1/m sum_(i in m_i) gradient f_j (x_i) \
$

#todo[batch diagrams]

#exbox(title: "Linear regression", [
  Let
  $
    l(a, b) = 1/(2 N) sum_(i=1)^N (y_i - (a dot x_i + b))^2
  $
  be our loss function. We can now optimize $a, b$ using gradient descent:

  $
    vec(a, b)_(i+1) = & vec(a, b)_i - gamma dot subst(
                          vec(
                            (partial l)/(partial a),
                            (partial l)/(partial b),
                          ), vec(a, b)_i
                        ) \
                    = & vec(a, b)_i - gamma dot subst(
                          vec(
                            1/N sum_(j=1)^N (y_j - (a dot x_j + b))(- x_j),
                            1/N sum_(j=1)^N (y_j - (a dot x_j + b))(-1),
                          ), vec(a, b)_i
                        ) \
                    = & vec(a, b)_i + gamma dot 1/N sum_(j=1)^N (y_j - (a_i dot x_j + b_i))
                        vec(x_j, 1) \
                    = & w_i + gamma/N sum_(j=1)^N (y_j - w^top_i accent(
                            x,
                            tilde
                          )_j) accent(x, tilde)_j \
  $
  where
  $
    w_i = & vec(a_i, b_i) quad
            accent(x, tilde)_j = & vec(x_j, 1) \
  $
  For the stochastic gradient descent we just choose a random $j in {1,2,...,N}$
  for each $i$:
  $
    w_(i+1) = w_i + (y_j - w^top_i accent(x, tilde)_j) accent(x, tilde)_j \
  $
])

==== Annealing

For a fixed learning rate $gamma$, SGD does not converge. Instead, the algorithm
keeps fluctuating around the minimum. One can set $gamma$ to a very small value,
in which case the fluctuations are smaller and SGD stays "close enough" to the
minimum during the "late iterations".

During the "early iterations", the situation is different: There is no benefit
staying close to the optimal trajectory. As long as SGD moves roughly in the
direction toward the minimum, fluctuations (even relatively large ones) around
the "optimal" trajectory are acceptable. One would therefore choose a large
$gamma$ in order to improve the speed of the algorithm.

_Annealing_ solves this apparent contradiction by adapting the learning rate. It
starts with a large $gamma$ and reduces it over time. There are many options (so
called _schedules_) how one can reduce the learning rate over time. Here we
decay the learning rate by multiplying it at each iteration by an annealing
factor.

#let gddiag2(g, s) = {
  let xs = lq.linspace(-1, 1)
  let fn = (x, y) => y * y * y - y + x * x - .5
  let dif-fn = (x, y) => (2 * x, 3 * y * y - 1)
  let gg = g
  let ge = 0.01
  let sp = (-0.7, 0.1)
  let gd = gradient-descent(
    ..sp,
    dif-fn,
    gamma: gg,
    epsilon: ge,
    schedule: s,
  )
  let (gxs, gys) = gd
  let px = 0
  let py = calc.sqrt(1 / 3)
  grid(
    columns: (2fr, 3fr),
    align: center + horizon,
    gutter: 2em,
    ctd(
      width: 170pt,
      height: 170pt,
      lq.ellipse(
        px,
        py,
        width: .05,
        height: .05,
        align: center + horizon,
        fill: colors.red,
        stroke: colors.red,
      ),
      contour(xs, xs, fn),
      lq.plot(
        ..gd,
        mark: none,
        stroke: colors.fg,
      ),
      lq.ellipse(
        ..sp,
        width: .05,
        height: .05,
        align: center + horizon,
        fill: colors.fg,
      ),
    ),
    align(left, diagram2d(
      width: 240pt,
      ylabel: "Error",
      xlabel: "Iterations",
      lq.plot(
        range(gxs.len()),
        gxs.zip(gys).map(((x, y)) => calc.abs(px - x) + calc.abs(py - y)),
      ),

      // lq.plot(range(gxs.len()), gxs),
      // lq.plot(range(gys.len()), gys),
    )),
  )
}
#block(breakable: false, [
  _Without annealing:_
  $
    gamma = 0.1
  $
  #gddiag2(0.1, none)
  _With annealing:_
  $
    gamma = 0.8, quad a(gamma) = gamma dot 9/10
  $
  #gddiag2(0.8, g => g * .9)
])



// TODO:
// #{
//   let a = 5
//   let b = 8
//   let fn = x => a * x + b
//   let xs = lq.linspace(0, 10)
//   let ys = xs.map(fn)
//   let dif-erfn = (a, b) => (x, y) => (
//     -(y - (a * x + b)) * x,
//     -(y - (a * x + b)),
//   )
//   let rng = suiji.gen-rng-f(42)
//   let ge = 0.01
//   let gg = 0.1
//   let sp = (a - 1, b + 1)
//   let (rng, dxs) = deviate-x-pn(rng, xs, m: 1 / 50)
//   let (rng, dys) = deviate-x-pn(rng, ys, m: 1 / 50)
//   let (rng, gd) = stochastic-gradient-descent(
//     rng,
//     ..sp,
//     dif-erfn,
//     dxs,
//     dys,
//     gamma: gg,
//     epsilon: ge,
//     // schedule: s,
//     n: 1,
//   )
//   let (gxs, gys) = gd
//   grid(
//     columns: (2fr, 3fr),
//     align: center + horizon,
//     gutter: 2em,
//     diagram2d(
//       lq.plot(xs, ys),
//       lq.scatter(dxs, dys),
//       lq.plot(xs, xs.map(x => gxs.at(-1) * x + gys.at(-1))),
//     ),
//     diagram2d(
//       lq.plot(range(gys.len()), gys),
//       lq.plot(range(gxs.len()), gxs),
//     ),
//
//     align(left, diagram2d(
//       width: 80%,
//       ylabel: "Error",
//       xlabel: "Iterations",
//       lq.plot(
//         range(gxs.len()),
//         gxs.zip(gys).map(((x, y)) => calc.abs(a - x) + calc.abs(b - y)),
//       ),
//     )),
//   )
// }

= Natural Language Processing (NLP)

#exbox(title: "NLP task, four ingredients", [
  / Task: Text Analysis, Sentiment Classification $->$ Supervised learning.
    Binary classification
  / Example (training data): "This is the worst movie I've ever seen" $->$
    label: 0 (=negative)
  #table(
    columns: (auto, 1fr),
    [Ingredient], [Description],
    [Data & Preprocessing],

    [Labeled sentences (text) from IMDB], [Model],
    [Multi-layer NN with \~160'000 parameters.\ Input Layer: sentences in an
      appropriate representation\ Output-Layer: single neuron. probability that
      the input belongs to class 1.
    ],
    [Loss],

    [Binary Crossentropy], [Optimizer],
    [Adam (a variant of SGD)],
  )])

== Large Language Model (LLM)

=== How a LLM generates text

The output is generated sequentially: the output is generated word-by-word (or
token-by-token). Sometimes multiple sequences of next-tokens are generated
(beam-search). The output is a probability distribution over a dictionary,
according to which the next word is sampled. Each output is added to the
input-context (this is called _auto-regressive_).

=== Where the LLM stores its "knowledge"

In the weights (aka "parametric memory"), data is not stored explicitly (no
"database"). This is a key limitation of LLMs, because one can't add data
easily, thus being never up to date.

== Representation of words

One can use vectors to represent words based on their meaning.

/ One-hot representation: Does not incorporate meaning
/ Distributed representation: vectors that capture (at least partially) the
  semantics of a word

=== One-hot representation

A one-hot vector is a vector with a single $1$-value and all others set to $0$.
One can count the number of different words and define one unique one-hot-vector
per word. This bears the following disadvantages:

/ Very high dimensional vector space: $n$ words have to be represented with
  $n$-dimensional vectors.
/ Sparse represesntation: The $n-1$ zeroes are memory-inefficient and ML
  algorithms cannot efficiently extract meaning from them.
/ No generalization: Using one-hot vectors, all words are completely unrelated
  to each other (because the vectors share no entries), and therefore we cannot
  generalize knowledge.

=== Indexing

Make a list of words and use the index to represent each word. Indexing is the
"dense equivalent" of one-hot encoding. Indexes are not more useful than one-hot
vectors, but it's often used as a preprocessing step. In LLMs, this index is
called "token ID".

=== Distributed Representation (dense vectors)

According to the distributional hypothesis, words that occur in similar contexts
(with the same neighboring words), tend to have similar meanings. Distributed
representations can be learned.

#let (
  bx,
  rb,
  gb,
  ob,
  pb,
  bb,
  nb,
) = bn-abbrevs

#exbox({
  stack(
    dir: ttb,
    stack(
      dir: ltr,
      nb(width: 8em, align(left, [#h(1em)King])),
      rb[],
      bx[],
      bx[],
      gb[],
      bx[],
      ob[],
      pb[],
      bx[],
      bx[],
      bx[],
      bb[],
      bx[],
    ),
    stack(
      dir: ltr,
      nb(width: 8em, align(left, [$-$ Man])),
      bx[],
      bb[],
      bx[],
      gb[],
      bx[],
      bx[],
      pb[],
      bx[],
      bx[],
      bx[],
      bb[],
      bx[],
    ),
    stack(
      dir: ltr,
      nb(width: 8em, align(left, [$+$ Woman])),
      bx[],
      ob[],
      bx[],
      bx[],
      bx[],
      bb[],
      bx[],
      bx[],
      gb[],
      bx[],
      bx[],
      pb[],
    ),
    stack(
      dir: ltr,
      nb(width: 8em, align(left, [$=$ Queen])),
      rb[],
      ob[],
      bx[],
      bx[],
      bx[],
      gb[],
      bx[],
      bx[],
      gb[],
      bx[],
      bx[],
      pb[],
    ),
  )
})

Word2Vec is a popular NLP algorithm to "embed" words (or longer strings of
characters) in a vector space. A mathematical function maps words to output
vectors, where similar semantics are represented by vectors in similar regions
of the vector-space. i

#exbox(align(center, diagram2d(
  xaxis: (ticks: none, lim: (0, 1.25)),
  yaxis: (ticks: none, lim: (0, 1.25)),
  width: 400pt,
  lq.place(0.1, 1, td[to]),
  lq.place(0.5, 1, td[by]),
  lq.place(0.3, 1, td[that]),
  lq.place(0.2, .8, td[with]),
  lq.place(0.4, .8, td[is]),
  lq.place(0.6, .8, td[i]),
  lq.place(0.1, .6, td[now]),
  lq.place(0.3, .6, td[a]),

  lq.place(.9, 1, tr[bad]),
  lq.place(1.1, 1, tr[dislike]),
  lq.place(.9, .8, tr[worse]),
  lq.place(1.1, .8, tr[worst]),
  lq.place(1, .6, tr[kill me please]),

  lq.place(0.7, .4, tg[good]),
  lq.place(0.3, .2, tg[amazing]),
  lq.place(0.5, .2, tg[wonderful]),
  lq.place(0.7, .2, tg[nice]),
  lq.place(0.9, .2, tg[terrific]),
)))

The output vectors have fewer dimensions (but still 100s to 1000s) than the
corresponding one-hot vectors. ML algorithms can learn this function. In neural
networks this function is implemented in a so called _Embedding Layer_.

This representation provides benefits such as the dot-product being a measure of
similarity and the ability to add/subtract vectors.

#todo[dot-product W6 S22,23]

/ Cosine-distance: $
    cos(theta) = (A dot B)/(norm(A) norm(B)) = (sum_(i=1)^n A_i
    B_i)/(sqrt(sum_(i=1)^n A_i^2) sqrt(sum_(i=1)^n B_i^2))
  $
  - $cos(theta) = 1$ when the angle $theta = 0 degree$ (the vectors point in
    exactly the same direction)
  - $cos(theta) = -1$ when the angle $theta = 180 degree$ (the vectors point in
    opposite directions)
  - $cos(theta) = 0$ when the angle $theta = 90 degree$ (the vectors are
    orthogonal to each other)


#todo[
  watch 3b1b and self-study because some professors are too lazy to provide the
  materials themselves ig
]

= Generalization

Given data from an unknown function that doesn't simply fit a straight line
needs a more flexible model. The challenge is choosing how flexible:
/ Underfitting: The model is too rigid and misses real structure.
/ Overfitting: The model is too flexible and follows noise.

== Recap

#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr),
  $i$,
  [```py sqft_living``` $= x_(i 1)$],
  [```py bedrooms``` $= x_(i 2)$],
  [```py yr_built``` $= x_(i 3)$],
  [```py price``` $= y_i$],

  $1$, $1180$, $3$, $1955$, $221900$,
  $2$, $2570$, $3$, $1951$, $538000$,
  $3$, $770$, $2$, $1933$, $180000$,
  $dots.v$, $dots.v$, $dots.v$, $dots.v$, $dots.v$,
)

#grid(columns: (1fr, 1fr))[
  $n$ samples, index $i in {1, 2, ..., n}$ \
  $d$ features, index $j in {1,2, ..., d}$ \
  $x_(i j)$: feature $j$ of sample $i$; one row is $x_i$ \
  $X in RR^(n times d)$ holds all rows, $y$ all targets \
][
  Model: $hat(y)_i = h(w, x_i) = w_0 + sum_(j=1)^d w_j x_(i j)$ \
  Intercept: $w_0$ \
  Coefficients: $w_1, ..., w_d$ \
]

== Polynomial features

One input $x$ becomes $p$ feature columns.
$ hat(y) = w_0 + sum_(j=1)^p w_j x^j $
Polynomial regression is just linear regression on the expanded feature set
${x, x^2, ..., x^p}$. This is convenient because the model is linear in the
weights, so minimizing MSE works on the wider feature matrix too.

== Error

#todo[W7A S11 diagrams]

A near zero training error means the model memorized these points and their
noise instead of the underlying function. A model must perform well on new,
unseen inputs, beyond the data it was trained on.

/ Inference: Using a trained model to make predictions on new, unseen data.
/ In-sample (training) error: on the data used for fitting
/ Out-of-sample (generalization) error: on unseen data

#todo[W7A S14 diagrams]

- A very complex model can have low training error but high test error.
- A very simple model can have both high training error and high test error.
The best model is usually somewhere in between.

=== Train/test split

The true generalization error needs future data we do not have. So we estimate
it from the data we already have:
- Shuffle first. The test rows must be a random sample, ordered data biases the
  estimate.
- Put $approx 80%$ in the training set $->$ fit the model.
- Hold out $approx 20%$ as the test set $->$ never touched during fitting.
- The test error estimates the generalization error.

=== Regression metrics

/ Mean squared error: squares each error, so large errors dominate. Unit of
  $y^2$.
  $ MSE = 1/n sum_(i=1)^n (y_i - hat(y)_i)^2 $
/ Mean absolute error: same unit as $y$, less sensitive to outliers.
  $ MAE = 1/n sum_(i=1)^n abs(y_i - hat(y)_i) $
/ Share of variance: 1 = perfect, 0 = as good as predicting the mean
  $overline(y)$, below 0 = worse.
  $
    R^2 = 1 - (sum_(i=1)^n (y_i - hat(y)_i)^2)/(sum_(i=1)^n (y_i - overline(y)_i)^2)
  $

#todo[W7A S18 diagrams]

=== Bias and variance

Perdiction error splits into two parts:

/ Bias: error from a too simple model (systematically off-target).
/ Variance: error from sensitivity to the particular training sample
  (predictions scatter).

#todo[W7A S20,21 diagrams]

Expected test error splits into three parts:

/ Bias#super[2]: falls as the model grows more complex
/ Variance: rises as the model grows more complex
/ Irreducible noise: stays constant, since no model can predict the noise in $y$

#todo[W7A S22 diagrams]

Their sum is U-shaped. The optimum complexity balances bias#super[2] and
variance, and even there the error stays above the noise level.

The goal is low bias and low variance, a model "as complex as the data permits".

#todo[W7A S23 diagrams, S24 code]

= Regularization

We could reduce the variance of a complex model by removing features (lowering $p$).
This might worsen the results though and would require manual intervention.
What one can do instead is apply weights to the features.

== Measuring complexity and size

We can measure model complexity in three ways:
/ Degree of the polynomial: $p$
/ Number of features: $d$
#todo[
  / Size of the weights: the degree-15 fit needs weights up to $approx$ 8,000 that
    cancel each other
]

We can measure the size in two ways:
/ Taxicab length: $ L_1 = sum_(j=1)^d abs(w_j) $
/ Squared length: $ L_2 = sum_(j=1)^d w^2_j $

== Adding a penalty to the loss

Training minimizes a _regularized loss_:
$
  L(w) = underbrace(1/n sum_(i=1)^n (y_i - hat(y)_i)^2, "fit the data using" MSE) +
  underbrace(lambda dot "penalty"(w), "keep weights small")
$

$lambda >= 0$ sets the balance, the penalty sums over $j = 1, ..., d$: the
intercept $w_0$ is not penalized.

Evaluation still happens with plain regression metrics (e.g. MSE) on held-out
data.

=== Parameters vs hyperparameters

#table(
  columns: (auto, auto, 1fr),
  [], [Parameters], [Hyperparameters],
  emph[Examples],
  $w_0, w_1, ..., w_d$,
  [degree $p$, regularization strength $lambda$],

  emph[Set by], [fit, minimizing the training loss], [you, before fit],
  emph[Learned from],
  [the training data],
  [a separate data set (never the training loss)],

  emph[sklearn],
  [```py coef_, intercept_```],
  [constructor arguments, e.g. ```py Ridge(alpha=...)```],
)

#todo[
  Why not learn $lambda$ by minimizing the training loss? The training loss is
  smallest at $lambda = 0$, so it would always pick overfitting.

  More hyperparameters follow the same pattern: learning rate $alpha$, epochs
  $E$, batch size $B$, $k$ in KNN
]

=== Ridge regression (L2)

$
  L_"Ridge" (w) = 1/n sum_(i=1)^n (y_i - hat(y)_i)^2 + lambda sum_(j=1)^d w^2_j
$
Large weights cost quadratically, so Ridge shrinks them smoothly. At
$lambda = 0$, the penalty disappears; larger $lambda$ favors smaller weights

#todo[W7B S7 question]
#todo[W7B S8,9]

=== Lasso regression (L1)

$
  L_"Lasso" (w) = 1/n sum_(i=1)^n (y_i - hat(y)_i)^2 + lambda sum_(j=1)^d abs(w_j)
$
$w_j = 0$: feature $x_j$ is not used, feature selection built into training.
#todo[W7B S11 diagrams]
#todo[W7B S12]

=== Ridge vs Lasso

#table(
  columns: (auto, auto, 1fr),
  [], [Ridge (L2)], [Lasso (L1)],
  emph[Penalty], $lambda sum_j w_j^2$, $lambda sum_j abs(w_j)$,
  emph[Effect on weights], [all shrink, stay nonzero], [many become exactly 0],
  emph[Use when],
  [many small effects, correlated features],
  [feature selection],

  emph[Closed form], [yes], [no (iterative solver)],
)

#todo[W7B S15 code]

=== Finding the weights

/ Closed form: for least squares: one matrix solve, no iterations
  (```py LinearRegression```)
  $ w = (X^top X)^(-1) X^top y $
/ Ridge: still has a closed form ($w_0$ left out of the penalty)
  $
    w = (X^top X + lambda I)^(-1) X^top y
  $
/ Lasso: has none: $abs(w_j)$ has a kink at $0$. ```py Lasso``` uses _coordinate
  descent_, updating one weight at a time until nothing changes.

With very large $n$ or $d$ the matrix solve gets too expensive, so we use
iterative methods such as SGD, ```py SGDRegressor(penalty="l2", alpha=...)```

#todo[W7B S17..]

= Project

#todo[put into appropriate sections]
/ Power law: A relationship where one quantity grows as a power of another. E.g.
  $
        q = & a dot x^b dot y^c \
    log q = & log a + b log x + c log y \
  $
/ Extrapolation: A model extrapolates when it predicts for inputs outside the
  range it saw during training.
/ Random forest model: An ensemble model: it builds many decision trees and
  combines their predictions. It can capture nonlinear relationships.
  #todo[research]
/ Standardizing features: Transforming each feature so it has mean 0 and
  standard deviation 1. This makes feature weights easier to compare. If
  features are standardized, "one unit" means one standard deviation.
/ Folds: Data partitions
/ Cross-validation: Repeatedly evaluates a model on held-out data to estimate
  how well it generalizes to unseen data.
/ Log-loss: Measures how wrong the probabilities are. It grows when
  probabilities are badly calibrated. #tr[kinda wrong/too specific]
/ K‑fold cross‑validated RMSE: Square‑root of the average squared prediction
  error obtained when a model is evaluated using k‑fold cross‑validation.
  + Split the data into k approximately equal "folds"
  + Iterate k times: each iteration treats one fold as the test set and the
    remaining k – 1 folds as the training set
  + Fit the model on the training folds, generate predictions for the held‑out
    test fold, and compute the MSE (mean squared error) for that fold
  + Average the MSEs across all k folds
  + Take the square root to obtain the cross‑validated RMSE
  The resulting value estimates how well the model is expected to perform on
  unseen data, while reducing variance compared to a single train‑test split.
/ Mean log-loss over 5 cross-validation folds: Split the data into 5 folds,
  train on 4 folds and test on the remaining fold, repeat 5 times, compute
  log-loss for each fold, then average them. This gives a more reliable estimate
  of model performance than a single train/test split.
/ Calibrating probabilities: A model is calibrated if its predicted
  probabilities match actual frequencies. For example, among data predicted to
  have $p approx 0.3$, about $30%$ should actually have that feature
/ TPR: True Positive Rate, also called _sensitivity_ or _recall_. "How many
  actual positives did the model correctly identify?"
  $ "TPR" = "TP"/("TP" + "FN") $
/ FPR: False Positive Rate, also called _fallout_. "How many actual negatives
  did the model incorrectly label as positive?"
  $ "FPR" = "FP"/("FP" + "TN") $
/ ROC: Receiver Operating Characteristic. A ROC curve plots TPR against FPR and
  shows how well a model separates two classes as you vary the decision
  threshold. A perfect classifier has a curve going straight up and then across:
  $"TPR" = 1 and "FPR" = 0$
/ AUC: Area Under the (ROC) Curve. It measures ranking ability: "Does the model
  put positive cases above negative cases?" \
  $"AUC" = 1$: perfect separation \
  $"AUC" = 0.5$: no better than random guessing \
  $"AUC" < 0.5$: worse than random

AUC tells you how well the model ranks risk. Calibration tells you whether the
predicted probabilities are numerically correct.
