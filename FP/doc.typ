#import "../lib.typ": *

#show: project.with(
  module: "FP",
  name: "Functional Programming",
  semester: "FS26",
  language: "en",
)

= Functional Language

#deftbl(
  [Functional programming],
  [Style of programming with the focus on application of functions to arguments],
  [Functional language],
  [Languages that encourage functional programming],
)

== Algebra

#todo("...")

- Equational reasoning
- Proving correctness of programs

= Haskell

== Function definition

```haskell
funName :: (TypeBound a) => a -> b  -- type definition
funName x = show x                  -- implementation
```

== Function application

```haskell
sum [1..5]
```

== Types

A Type in Haskell is a name for a collection of related values.

== Typeclasses

#todo("")

=== Functor

#todo("")

=== Applicative

#todo("")

=== Monad

#todo("")

== Lazy evaluation

#todo("")

== Equational reasoning

#todo("")

== List comprehension

#todo("")

== TODO:

- Effectful functions
- Dependent typing
- Mutable state + parallel programming

- denotative language / semantics (central passages)
- Referential transparency
  - *no* (mutable) variables
  - *no* assignments
  - *no* imperative control structures
  - all data structures are *immutable*

- Haskell generics

= Lambda Calculus

- Alonzo Church
