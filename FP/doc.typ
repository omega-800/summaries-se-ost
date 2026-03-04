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

== Basic features of Functional Programming

- Referential transparency
- Functions as first-class citizens
- Higher-order functions
- Algebraic data types
- Pattern matching
- Recursion
- Types & type inference
- Haskell Specific: Type classes, Functors, Applicatives, Monads
- A Declarative Programming Paradigm.
- Foundation: Church’s Lambda calculus.
- Pure: No (or controlled) mutable state. Expressions are (by default) side effect free.

== Programming Paradigms

#todo("")

== Algebra

#todo("")

- Equational reasoning
- Proving correctness of programs

= Haskell

== Function definition

```haskell
funName :: (TypeBound a) => a -> b        -- type definition
funName x = show x                        -- implementation

complexFun :: (Ord a) => [a] -> [a] -> [a]
complexFun [] _                 = []      -- pattern matching
complexFun _ []                 = []
complexFun (x:xs) (y:ys)        = [x, y]  -- list patterns
complexFun xs ys
                | length xs > 3 = xs      -- guards
                | otherwise     = ys
```

=== Guarded Equations

```haskell
abs n
    | n >= 0 = n
    | otherwise = -n
```

=== Pattern matching

Patterns consist of variables and data constructors. They are matched in order, so more specific patterns should come first.

```haskell
not :: Bool -> Bool
not False = True
not True = False
-- ==
not b = case b of
          True -> False
          False -> True
```

=== List patterns

```haskell
head :: [a] -> a
head (x : _) = x
tail :: [a] -> [a]
tail (_ : xs) = xs
```

=== Lambda expressions

```haskell
-- \boundvar -> body
(\x -> x + x) 5
```

== Function application

```haskell
sum [1..5]
```

== Operators

- Prefix notation is used for function application: ```haskell max 7 2```
- If infix notation is desired, one may use so-called operators (e.g. +): ```haskell 7 + 2```
- Functions can be converted into operators using backticks: ```haskell 7 `div` 2```
- Operators can be converted into functions using brackets: ```haskell (+) 7 2```

Notes:

- Operator symbols are formed from one or more symbol characters !\#\$%&\*+./<=>?@\^|-~: (or any Unicode symbol or punctuation).
- An operator symbol starting with : may only be used for data constructors (e.g. : is the constructor for lists).
- A so-called fixity declaration is used to specify the associativity and precedence level (1 (highest) to 9 (lowest) ) of an operator. E.g.:
  - ```haskell infixl 6 +``` specifies (+) to be left associative with level 6
  - ```haskell infixr 5 :``` specifies (:) to be right associative with level 5
  - ```haskell infix 4 ==``` specifies (==) to be neither left nor right associative (making parentheses mandatory while nesting), and with level 4
- Any operator lacking a fixity declaration is assumed to be ```haskell infixl 9```.
- Function application has a higher precedence than any infix operator.

== Conditional expressions

Always ternary.

```haskell
abs :: Int -> Int
abs n = if n >= 0 then n else –n
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

```haskell
[x ^ 2 | x <- [1 .. 5]]                 -- [1, 4, 9, 16, 25]
-- guards
[x | x <- [1 .. 12], 12 `mod` x == 0]   -- [2, 3, 4, 6, 12]
-- multiple generators
[(x, y) | x <- [1, 2], y <- [4, 5]]     -- [(1,4),(1,5),(2,4),(2,5)]
-- dependant generators
[(x, y) | x <- [1 .. 2], y <- [x .. 2]] -- [(1,1),(1,2),(2,2)]
```

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
