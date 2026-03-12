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

== Terms

#deftbl(
  [Mutual recursion],
  [Two or more functions defined recursively in terms of each other (=calling each other)],
  [Higher-order functions],
  [A function is called higher-order if it takes a function as an argument or returns a function as a result.],
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

=== Point-free notation

\== Function composition

```haskell
odd x = not (even x)
odd = not . even
```
The term "point-free" does not refer to the "." character used for function composition (the number of which typically increase), refers to the fact that the definition does not mention the data points on which functions act.

Every definition has a point-free form that can be computed automatically! #link("http://pointfree.io")

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

== Types

A Type in Haskell is a name for a collection of related values.

=== Type declarations

In Haskell, a new name for an existing type can be defined using a type declaration.

```haskell
type String = [Char]
```

Type declarations can also have type parameters

```haskell
type Pair a = (a, a)

mult :: Pair Int -> Int
mult (m, n) = m * n
```

Type declarations can be nested but cannot be recursive

```haskell
type Pos = (Int, Int)
type Trans = Pos -> Pos     -- OK

type Tree = (Int, [Tree])   -- NOK
```

=== Data declarations

We can define new custom data types by declaring new types and functions that return values of these types. These functions (a.k.a. "data constructors" or "constructors") are special since they cannot have a definition that results in a reduction rule. Thery therefore remain unchanged during execution and can be used to hold information.

```haskell
data List a = Nil | Cons a (List a)
```

```haskell List``` has values of the form of ```haskell Nil``` and ```haskell Cons``` where $a$ is a generic. ```haskell Nil``` and ```haskell Cons``` can be viewed as functions that construct values of type ```haskell List```.


A completely new type can be defined by specifying its values using a data declaration.

```haskell
data Bool = False | True
```

- The two values ```haskell False``` and ```haskell True``` are called the constructors for the type ```haskell Bool```.
- Type and constructor names must always begin with an upper-case letter.
- Data declarations are similar to context free grammars. The former specifies the values of a type, the latter the sentences of a language.

Such data types are often referred to as algebraic datatypes.


- Type variables within types are implicitly universally quantified at the topmost level. For example, \
  ```haskell a -> Maybe a``` actually denotes ```haskell forall {a}. a -> Maybe a```.  The `{}` brackets around `a` denotes that its instantiation can only be done automatically.
- You may ask ghci to explicitly print universal quantifiers as follows:
`Prelude> :set -fprint-explicit-foralls
Prelude> :t Just
Just :: forall {a}. a -> Maybe a`
- You may explicitly specify the universal quantification in polymorphic type signatures using the `ExplicitForAll` extension.


Maybe and Pair are called Type Constructors since they construct one type from another. This behaviour is expressed using kinds, which is the type of a "type". The type system for kinds is very simple:

`K ::= * | K -> K` \
`*` Kind of ordinary/proper/concrete/basic types \
`->` Kind of "type constructor" or "type operators"

- This is essentially the "simply typed lambda calculus" one level up, with one base type.
- Ordinary/proper/concrete/basic types are nothing more than nullary type constructors/operators. Analogy: A constant is nothing more than a nullary function.
- The word "type" is therefore often used for any type-level expression: ordinary/proper/concrete/basic types, and for type constructors/operators.

Examples: (Only types of kind \* can have a value)

#table(
  columns: 8,
  inset: .4em,
  emph[Kind],
  ```haskell *```,
  ```haskell *```,
  ```haskell *```,
  ```haskell *```,
  ```haskell *```,
  ```haskell * -> *```,
  ```haskell * -> * -> * ```,

  emph[Type],
  ```haskell Bool```,
  ```haskell Char```,
  ```haskell [a] -> [a]```,
  ```haskell Maybe Char```,
  ```haskell a -> Maybe a```,
  ```haskell Maybe```,
  ```haskell (,)```,

  emph[Value],
  ```haskell True```,
  ```haskell 'a'```,
  ```haskell reverse```,
  ```haskell Just 'a'```,
  ```haskell Just```,
  [],
  [],
)

```haskell (->)``` is also a type constructor!

#table(
  columns: (auto, 1fr, 1fr, 1fr, auto, auto),
  inset: .4em,
  emph[Kind],
  ```haskell *```,
  ```haskell *```,
  ```haskell * -> * -> * ```,
  ```haskell * -> *```,
  ```haskell * -> *```,

  emph[Type],
  ```haskell Bool -> Bool```,
  ```haskell (->) Bool Bool```,
  ```haskell (->)```,
  ```haskell (->) Bool```,
  ```haskell (->) a```,

  emph[Value], ```haskell not```, ```haskell not```, [], [], [],
)

The operator ```haskell (->)``` is overloaded:
- In the context of a type (e.g. id::a->a ), it denotes the type constructor for function types.
- In the context of a kind (e.g. List::\*->\* ), it denotes the kind constructor for type constructors.

==== Records

Convenient syntax when data constructors have multiple parameters:

```haskell
data Person = Person
  { name :: String
  , age :: Int
  , children :: [Person]
  } deriving (Show)

-- <=>

data Person = Person String Int [Person] -- positional constructor
  deriving (Show)
-- v selector functions v
name :: Person -> String
name (Person n _ _) = n

age :: Person -> Int
age (Person _ a _) = a

children :: Person -> [Person]
children (Person _ _ c) = c
```

Construction:

```haskell
alice :: Person
alice = Person "Alice" 5 []

bob :: Person
bob = Person {name = "Bob", age = 35, children = [alice]}
```

Derived show contains labels and updates can use field labels:

```haskell
-- >>> alice{age = age alice + 1}
-- Person {name = "Alice", age = 6, children = []}
```

=== Polymorphism

\= "Many forms"

#deftbl(
  [Ad-hoc Polymorphism],
  [Function with the same name denotes different implementations (function overloading, Interfaces)],
  [Parametric Polymorphism],
  [Code written to work with many possible types (OO: generics)],
  [Subtype Polymorphism],
  [One type (subtype) can be substituted for another (supertype)],
)

=== Typeclasses

Haskell uses type classes to achieve ad-hoc polymorphism.

```haskell
elem :: Eq a => a -> [a] -> Bool -- Eq is a typeclass
```

Type classes are declared using class declarations:

```haskell
-- Eq = name of the declared type class
class Eq a where               -- a = type parameter
  (==), (/=) :: a -> a -> Bool -- Required to be a member of Eq
  x /= y = not (x == y)        -- Default implementation (optional)
```

Type classes may be extended:

```haskell
-- Eq = name of the type class to be extended
class Eq a => Ord a where      -- Ord = name of resulting type class
  (<), (<=), (>=), (>) :: a -> a -> Bool -- Additional requirements
```

- All members of the type class ```haskell Ord``` are also members of the type class ```haskell Eq```.
- Members of ```haskell Ord``` therefore also require ```haskell (==)``` to be defined.

A type can be declared to be an instance of a type class using an instance declaration:

```haskell
-- In order for (Maybe m) to be a member of the type class Eq, it is
-- required that the type m belongs to the type class Eq
instance Eq m => Eq (Maybe m) where
  Just x == Just y   = x == y
  Nothing == Nothing = True
  _ == _             = False
```

Just like it is possible to have higher- order functions, it is also possible to have higher-kinded types.

As far as the compiler is concerned, the only requirement for a type to be a member of a type class is that it should have a type correct instance declaration. There are of course additional semantic requirements that need to hold. These additional requirements are expressed as type class laws within the documentation of each type class.

Default implementations for some type classes can be generated automatically for data declarations using the deriving keyword:

```haskell
data Bool = False | True
  deriving (Eq, Ord, Show, Read)
```

=== Newtype declarations

In cases where a datatype only has one constructor, a newtype declaration is used.

#todo("")

=== Instances

==== Functor

```haskell
(<$>) :: Functor f => (a -> b) -> f a -> f b -- fmap

(+1) <$> (Just 1)               -- Just 2
```

#todo("")

==== Applicative

```haskell
(<*>) :: Applicative f => f (a -> b) -> f a -> f b

((+) <$> (Just 1)) <*> (Just 2) -- Just 3
```

#todo("")

==== Monad

```haskell
(>>=) :: Monad m => m a -> (a ->  m b) ->  m b

safediv 8 2 >>= flip safediv 2  -- Just 2
```

#todo("")

== Modules

- A collection of related values, types, classes, etc.
- Name: Identifier that starts with a capital letter.
- Naming convention for hierarchy: separated using "." (e.g. `Data.List`, `Data.List.NonEmpty`, `Data.Set`, ...)
- Each module `Dir.Name` must be contained in a file `Dir/Name.hs`.

```haskell
module BinarySearchTree
( T, toList
) where

data T a = Leaf | Node (T a) a (T a)
  deriving Show

toList :: T a -> [a]

-- ...

import qualified BinarySearchTree
  as Set (T, toList)
```

== Lazy evaluation

#todo("")

== Equational reasoning

#todo("")

== Side effects

Interactive programs can be written in Haskell by using types to distinguish pure expressions from impure actions that may involve side effects.

```haskell
IO a -- The type of actions that return a value of type a
```

One may also use a let statement within a do block to perform a pure computation. Note that the let statement here is #link("https://www.haskell.org/onlinereport/haskell2010/haskellch3.html#x8-470003.14", "different") from the let ... in ... statement for expresisons.

```haskell
act :: IO (Char, Char)
act = do {x <- getChar;
          y <- getChar;
          let {p = (x,y)};
          return p}
-- <=>

act = do
        x <- getChar
        y <- getChar
        let p = (x,y)
        return p
```

Composing IO actions

```haskell
(>>=) :: Monad m => m a -> (a ->  m b) ->  m b

do {x <- getChar; putChar x}
-- <=>
getChar >>=  (\x -> putChar x)
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

#deftbl(
  [free occurrence],
  [],
  [$eta$ conversion],
  [
    a.k.a. $eta$ contraction denotes that for any $f$ that does not contain any free occurances of $x$ the following equality holds:
    ```haskell
    (\x -> f x ) == f     -- TODO: rewrite in lambda notation
    f . g = \y -> f (g x)
    ```
  ],
  [],
  [],
)
