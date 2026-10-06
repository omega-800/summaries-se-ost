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
