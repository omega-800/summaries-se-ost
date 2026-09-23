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

There are many different AI research fields and AI applications. Algorithms
and applications where a computer learns from data are typically in the field of
statistical machine learning (ML).

/ Computer: performs a mapping from input to output.
/ Processing: any sort of non-trivial "calculation" (mapping) or information processing
/ Input: any sort of data/information (sensory input, bits, mechanical configuration...)
/ Output: any sort of response (data, actions, new state of a system...)

#todo[W1 slides2 14..17]

= Probability

#todo[merge with MathFML, DigCod, WrStat]

== Random Variables

A random variable $X$ is a variable that takes a numerical value $x$, which depends on a random experiment.
Random Variables come in two flavours:
- discrete: $X$ takes any of a finite or countable set of values, e.g. ${-8, 1.5,
    1.5, 2.693, 5, 6.3, 10}$
- continuous: $X$ takes any value of an uncountable range, e.g. the real numbers
  in the interval $(2, 7)$.

Before observing the outcome of a random experiment, the 'best we can know' about a random
variable is a "list" of all possible values, and a second "list" which tells us for each possible value
how likely each value will occur.

$Pr(X=x)$ is the probability that the random variable $X$ takes the value $x$.
It's often written as $P(x)$ or $p(x)$ or $P_X (x)$.

== Probability Mass Function (PMF)

The Probability Mass Function (PMF) of a discrete random
variable is a function $f(x)$ that provides the probability for each value $x$ of a discrete random
variable $X$.

#exbox(table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.cell(colspan: 7)[Dice rolls],
  [Value $x$ of the random Variable $X$], $1$, $2$, $3$, $4$, $5$, $6$,
  $P(X=x)$, $1/6$, $1/6$, $1/6$, $1/6$, $1/6$, $1/6$,
))

#todo[table s7,8,10]

From the PMF, we can calculate the expected value $ E[X] = sum_(i=1)^oo P(x_i)
dot x_i $

=== Multiple Random Variables

We can study two random variables simultaneously.

#todo[slides 12,13]

The (joint) properties of two random variables are defined by the
_Joint Probability Mass Function_, usually simply called Joint Probability.

For *independent* random variables, the joint probability is
simply the product of the individual probabilities
$ P(X, Y) = P(X) dot P(Y) $

#exbox(
  title: [Rolling two dice],
  grid(
    columns: (1fr, auto),
    [
      The random experiment of rolling die 1 and die 2 together
      has $36$ possible outcomes (events). The Joint Probability is:
      $
        P(X=5, Y=4) = 1/6 dot 1/6 = 1/36
      $
    ],
    table(
      columns: 7,
      $$, $X=1$, $X=2$, $X=3$, $X=4$, $X=5$, $X=6$,
      emph[$Y=1$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      emph[$Y=2$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      emph[$Y=3$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      emph[$Y=4$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      emph[$Y=5$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
      emph[$Y=6$], $1/36$, $1/36$, $1/36$, $1/36$, $1/36$, $1/36$,
    ),
  ),
)

#todo[
  For *dependent* random variables,
  $ P(Y|X) = (P(X,Y))/(P(X)) $
  slides 17,18,20,22
]

== Probability Density Function (PDF)

$
  P(-oo < x < oo) = & 1 \
     P(a < x < b) = & integral_a^b f(x) dif x \
             P(x) = & 0 \
$

#todo[
  https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule
]
