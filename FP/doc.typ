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

#corr("TODO: ...")
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

```haskell
-- TODO
```

=== Functor

=== Applicative

=== Monad

== Lazy evaluation

== Equational reasoning

== List comprehension

== TODO:

- Effectful functions
- Dependent typing
- Mutable state + parallel programming

= Lambda Calculus

- Alonzo Church
