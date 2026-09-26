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
  $ P(Y|X) = (P(X|Y))/(P(X)) $
/ Conditional independence: Two events $X$ and $Y$ are conditionally independent
  given an event $Z$ with $P(Z) > 0$ if
  $
       P(X inter Y|Z) = & P(X|Z)P(Y|Z) \
    => P(X|Y inter Z) = & P(X|Z)
  $

#exbox(title: "chance of rain", grid(
  columns: 2,
  [
    Let $X$ be the event to observe clouds (0=no clouds, 1=small clouds, 2=big
    clouds) and $Y$ the event that it rains (0=no rain, 1=light rain, 2=moderate
    rain, 3=heavy rain)

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
