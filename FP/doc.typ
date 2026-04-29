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

= Functional Language

#deftbl(
  [Functional programming],
  [Style of programming with the focus on application of functions to
    arguments],
  [Functional language],
  [Languages that encourage functional programming],
)

== Terms

#deftbl(
  [Mutual recursion],
  [Two or more functions defined recursively in terms of each other (=calling
    each other)],
  [Higher-order functions],
  [A function is called higher-order if it takes a function as an argument or
    returns a function as a result.],
  [Effectful programming],
  [
    "Effectual" simply means that arguments and return values are no longer just
    plain (pure) values, but may also have so-called "effects" such as:
    - The possibility of failure, e.g. using the option type Maybe
    - Aggregating multiple results, e.g. using the list type []
    - Performing IO, e.g. using the action type IO
  ],
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
- Pure: No (or controlled) mutable state. Expressions are (by default) side
  effect free.

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

Patterns consist of variables and data constructors. They are matched in order,
so more specific patterns should come first.

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
The term "point-free" does not refer to the "." character used for function
composition (the number of which typically increase), refers to the fact that
the definition does not mention the data points on which functions act.

Every definition has a point-free form that can be computed automatically!
#link("http://pointfree.io")

== Operators

- Prefix notation is used for function application: ```haskell max 7 2```
- If infix notation is desired, one may use so-called operators (e.g. +):
  ```haskell 7 + 2```
- Functions can be converted into operators using backticks:
  ```haskell 7 `div` 2```
- Operators can be converted into functions using brackets:
  ```haskell (+) 7 2```

Notes:

- Operator symbols are formed from one or more symbol characters
  !\#\$%&\*+./<=>?@\^|-~: (or any Unicode symbol or punctuation).
- An operator symbol starting with : may only be used for data constructors
  (e.g. : is the constructor for lists).
- A so-called fixity declaration is used to specify the associativity and
  precedence level (1 (highest) to 9 (lowest) ) of an operator. E.g.:
  - ```haskell infixl 6 +``` specifies (+) to be left associative with level 6
  - ```haskell infixr 5 :``` specifies (:) to be right associative with level 5
  - ```haskell infix 4 ==``` specifies (==) to be neither left nor right
    associative (making parentheses mandatory while nesting), and with level 4
- Any operator lacking a fixity declaration is assumed to be
  ```haskell infixl 9```.
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

In Haskell, a new name for an existing type can be defined using a type
declaration.

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

We can define new custom data types by declaring new types and functions that
return values of these types. These functions (a.k.a. "data constructors" or
"constructors") are special since they cannot have a definition that results in
a reduction rule. Thery therefore remain unchanged during execution and can be
used to hold information.

```haskell
data List a = Nil | Cons a (List a)
```

```haskell List``` has values of the form of ```haskell Nil``` and
```haskell Cons``` where $a$ is a generic. ```haskell Nil``` and
```haskell Cons``` can be viewed as functions that construct values of type
```haskell List```.


A completely new type can be defined by specifying its values using a data
declaration.

```haskell
data Bool = False | True
```

- The two values ```haskell False``` and ```haskell True``` are called the
  constructors for the type ```haskell Bool```.
- Type and constructor names must always begin with an upper-case letter.
- Data declarations are similar to context free grammars. The former specifies
  the values of a type, the latter the sentences of a language.

Such data types are often referred to as algebraic datatypes.


- Type variables within types are implicitly universally quantified at the
  topmost level. For example, \
  ```haskell a -> Maybe a``` actually denotes
  ```haskell forall {a}. a -> Maybe a```. The `{}` brackets around `a` denotes
  that its instantiation can only be done automatically.
- You may ask ghci to explicitly print universal quantifiers as follows:
`Prelude> :set -fprint-explicit-foralls
Prelude> :t Just
Just :: forall {a}. a -> Maybe a`
- You may explicitly specify the universal quantification in polymorphic type
  signatures using the `ExplicitForAll` extension.


Maybe and Pair are called Type Constructors since they construct one type from
another. This behaviour is expressed using kinds, which is the type of a "type".
The type system for kinds is very simple:

`K ::= * | K -> K` \
`*` Kind of ordinary/proper/concrete/basic types \
`->` Kind of "type constructor" or "type operators"

- This is essentially the "simply typed lambda calculus" one level up, with one
  base type.
- Ordinary/proper/concrete/basic types are nothing more than nullary type
  constructors/operators. Analogy: A constant is nothing more than a nullary
  function.
- The word "type" is therefore often used for any type-level expression:
  ordinary/proper/concrete/basic types, and for type constructors/operators.

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
- In the context of a type (e.g. id::a->a ), it denotes the type constructor for
  function types.
- In the context of a kind (e.g. List::\*->\* ), it denotes the kind constructor
  for type constructors.

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
  [Function with the same name denotes different implementations (function
    overloading, Interfaces)],
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

- All members of the type class ```haskell Ord``` are also members of the type
  class ```haskell Eq```.
- Members of ```haskell Ord``` therefore also require ```haskell (==)``` to be
  defined.

A type can be declared to be an instance of a type class using an instance
declaration:

```haskell
-- In order for (Maybe m) to be a member of the type class Eq, it is
-- required that the type m belongs to the type class Eq
instance Eq m => Eq (Maybe m) where
  Just x == Just y   = x == y
  Nothing == Nothing = True
  _ == _             = False
```

Just like it is possible to have higher- order functions, it is also possible to
have higher-kinded types.

As far as the compiler is concerned, the only requirement for a type to be a
member of a type class is that it should have a type correct instance
declaration. There are of course additional semantic requirements that need to
hold. These additional requirements are expressed as type class laws within the
documentation of each type class.

Default implementations for some type classes can be generated automatically for
data declarations using the deriving keyword:

```haskell
data Bool = False | True
  deriving (Eq, Ord, Show, Read)
```

=== Newtype declarations

In cases where a datatype only has one constructor, a newtype declaration is
used.

#todo("")

=== Instances

==== Functor

_Functors_ are types that can be used to *wrap and extract values* of other
types, and allow us to *lift unary functions* over the wrapped value.

_Definition_
```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
  {-# MINIMAL fmap #-}
```
_Type Class Laws_

The `fmap` function *should not change the structure* of the Functor, *only its
elements*.

An instance of Functor has to abide by the following laws:

+ `fmap` has to preserve identity
  - ```haskell fmap id == id```
+ `fmap` has to preserve function composition
  - ```haskell fmap (g . h) == fmap g . fmap h```

_fmap_
```haskell
-- <$> == fmap
(<$>) :: Functor f => (a -> b) -> f a -> f b
```
_Examples_
```haskell
(+1) <$> Nothing                            -- Nothing
(+1) <$> Just 1                             -- Just 2
```
_Instances_
```haskell
instance Functor Maybe where
  fmap _ Nothing = Nothing
  fmap f (Just x) = Just (f x)
```

==== Applicative

What if we want to lift an n-ary function?

_Applicative_ Functors provide a *generic function to wrap values* (`pure`) and
*generalized function application* (`<*>`).

_Definition_
```haskell
class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  liftA2 :: (a -> b -> c) -> f a -> f b -> f c
  (*>) :: f a -> f b -> f b
  (<*) :: f a -> f b -> f a
  {-# MINIMAL pure, ((<*>) | liftA2) #-}
```
_Type Class Laws_

+ Identity: `pure` has to preserve *identity*
  - ```haskell pure id <*> x == x```
+ Homomorphism: `pure` has to preserve *function application*
  - ```haskell pure (g x) == pure g <*> pure x```
+ Interchange: *Order of evaluation* must not matter when applying an effectful
  function to a pure argument
  - ```haskell x <*> pure y == pure (\f -> f y) <*> x```
+ Composition: `<*>` has to be *associative*
  - ```haskell x <*> (y <*> z) == (pure (.) <*> x <*> y) <*> z```

_pure_

We also need a function pure to lift 0-ary functions (constants):

```haskell
pure :: a -> f a
f <$> x == (pure f) <*> x
```
_Similarities to plain function application_
```haskell
($)   ::   (a -> b) ->   a ->   b
(<*>) :: f (a -> b) -> f a -> f b

(+) $ 11 $ 31                               -- 42
Just (+) <*> Just 11 <*> Just 31            -- Just 42
```
_Examples_
```haskell
(+) <$> Nothing <*> Just 2                  -- Nothing
(+) <$> Just 1 <*> Just 2                   -- Just 3

(,) <$> [1,2] <*> [6,7]                     -- [(1,6),(1,7),(2,6),(2,7)]

-- intuition: all possible ways of multiplying the two input lists
pure (*) <*> [1,2] <*> [3,4]                -- [3,4,6,8]

-- in the context of lists, pure (*) == [(*)]
[(*),(+)] <*> [1,2] <*> [3,4]               -- [3,4,6,8,4,5,5,6]
```
_Instances_
```haskell
instance Applicative Maybe where
  pure x = Just x
  Nothing <*> _ = Nothing
  (Just f) <*> mx = fmap f mx

instance Applicative IO where
  pure = return
  mf <*> mx = do
    f <- mf
    x <- mx
    return (f x)
```

==== Monad

So far, we have seen how functors and applicative functors help us to:

- apply pure functions to "effectful" arguments
- compose function application with multiple "effectful" arguments

What is missing is how to apply and compose "effectful" functions with
"effectful" arguments.

_Definition_
```haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
  {-# MINIMAL (>>=) #-}
```
_Type Class Laws_

+ Left identity
  - ```haskell return x >>= f = f x```
+ Right identity
  - ```haskell mx >>= return == mx```
+ Associativity
  - ```haskell (mx >>= f) >>= g == mx >>= (\x -> (f x >>= g))```

_Bind_

Function that binds an effectful value into an effectful function
```haskell
(>>=) :: m a -> (a -> m b) -> m b
```

_Kleisi arrow_

The Kleisli arrow (`<=<`) is analogous to normal function composition, except
that it works on monadic functions
```haskell
(.)   ::            (b ->   c) -> (a ->   b) -> a ->   c
(<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
(f <=< g) x =  g x >>= f
```

_Examples_
```haskell
safediv 8 0 >>= flip safediv 2              -- Nothing
safediv 8 2 >>= flip safediv 2              -- Just 2

safediv :: Int -> Int -> Maybe Int
safediv n m = if m == 0 then Nothing else Just $ div n m

do {x <- [1,2]; y <- [3,4]; return (x,y)}   -- [(1,3),(1,4),(2,3),(2,4)]
-- <=>
[1,2] >>= \x -> [3,4] >>= \y -> return (x,y)
-- <=>
[1,2] >>= \x -> [3,4] >>= return . (x,)
-- <=>
[1,2] >>= \x -> (x,) <$> [3,4]
-- <=>
(,) <$> [1,2] <*> [3,4]
```
_Instances_
```haskell
instance Monad Maybe where
  Nothing >>= _ = Nothing
  (Just x) >>= f = f x

instance Monad [] where
  xs >>= f = [y | x <- xs, y <- f x]
```

==== Comparison

#table(
  columns: 6,
  table-header(
    [],
    [Application operator],
    [Type of application operator],
    [Function],
    [Argument],
    [Result],
  ),
  emph[Pure function application],
  [juxtapose, ```haskell ($)```],
  ```haskell (a -> b) -> a -> b```,
  [pure],
  [pure],

  [pure],
  emph[Functor],
  ```haskell fmap, (<$>)```,
  ```haskell (a -> b) -> f a -> f b```,
  [pure],
  [effectual],

  [effectual],
  emph[Applicative functor],
  ```haskell (<*>)```,
  ```haskell f (a -> b) -> f a -> f b```,
  [pure],
  [effectual],

  [effectual],
  emph[Monad],
  ```haskell (>>=)```,
  ```haskell m a -> (a -> m b) -> m b```,
  [effectual],
  [effectual],

  [effectual],
)

== Modules

- A collection of related values, types, classes, etc.
- Name: Identifier that starts with a capital letter.
- Naming convention for hierarchy: separated using "." (e.g. `Data.List`,
  `Data.List.NonEmpty`, `Data.Set`, ...)
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

Interactive programs can be written in Haskell by using types to distinguish
pure expressions from impure actions that may involve side effects.

```haskell
IO a -- The type of actions that return a value of type a
```

One may also use a let statement within a do block to perform a pure
computation. Note that the let statement here is #link(
  "https://www.haskell.org/onlinereport/haskell2010/haskellch3.html#x8-470003.14",
  "different",
) from the let ... in ... statement for expresisons.

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
getChar >>= putChar
```

= Lambda Calculus

#let sc = math.op("succ")
#let pred = math.op("pred")
#let lapp = (m, n, p: false) => if p { $(#m space #n)$ } else { $#m space #n$ }
#let labs = (x, m, p: false) => if p { $(lambda #x . space #m)$ } else {
  $lambda #x .
  space #m$
}
#let plapp = lapp.with(p: true)
#let plabs = labs.with(p: true)

- Creator: Alonzo Church

== Syntax

#raw(
  lang: "bnf",
  `  <M>       ::= <id> | `.text
    + to-string($lambda$)
    + `<id>. <M> | <M> <M> | ( <M> )
  <id> ::= a | b | c | ... | 0 | 1 | 2 | ... | + | - | * | ...
`.text,
)

Reserved words: "$lambda$", ".", "(", ")"

$
  <=> \
  underbrace(M, lambda-"term") ::= underbrace(
    x,
    "Id"
  ) | underbrace(
    labs(x, M), lambda
    "abstraction"
  ) | underbrace(lapp(M, M), "Application") \
  <=>
$

```haskell
type Id = String
data Term
  = Var Id
  | Abs Id Term
  | App Term Term
```

Rules:

- The scope of a $lambda$ abstraction extends as far right as possible:
  $labs(x, lapp(x, labs(y, lapp(y, x)))) <=> plabs(
    x, plapp(
      x, plabs(
        y, plapp(
          y,
          x
        )
      )
    )
  )$
- Application is left associative:
  $lapp(lapp(M_1, M_2), M_3) <=> lapp(plapp(M_1, M_2), M_3)$

== Definitions

/ Bound variables: Bound variables are placeholders that refer to their binding
  occurrences. Their names have no significance and can be renamed
  ($alpha$-conversion).
  $
    labs(
      underbrace(x, #[binding\ occurrence]), lapp(
        underbrace(
          x,
          "bound"
        ), underbrace(z, "free")
      )
    )
  $
/ Free variables: Variables that aren't bound
/ Open: A lambda term *with at least one free variable* is said to be _open_
/ Closed: A lambda term *without any free variables* is said to be _closed_
/ Combinators: *Closed lambda terms* are also called _combinators_, since all
  they do is combine their parameters in different ways
/ Closure: A lambda term whose free variables are bound by its enclosing scope
/ ($beta$) Normal form: A $lambda$ term is said to be in _normal form_ if *no
  further reductions* can be applied to it
/ Confluence: Every $lambda$ term has *at most one normal form*. This property
  is sometimes referred to the _confluence property_ of $beta$ reduction

=== nfin

"Not Free In"

```haskell
nfin :: Id -> Term -> Bool
x `nfin` (Var y) = x /= y
x `nfin` (Abs y m) = x == y || nfin x m
x `nfin` (App m n) = x `nfin` m && x `nfin` n
```

=== substitution

The term $[x := L]M$ denotes the term $M$ with all free occurrences of the
variable $x$ replaced by the term $L$.

```haskell
-- NOTE: renameBoundVars does what it sounds like
type Subst = (Id, Term)
applySubst :: Subst -> Term -> Term
applySubst (x, l) (Var y) = if x == y then l else Var y
applySubst (x, l) (Abs y m)
  | x == y                = Abs y m
  | x /= y && y `nfin` l  = Abs y $ applySubst (x, l) m
  | otherwise
    =
      applySubst (x, l) $ alphaConvert (Abs y m) newId -- newId `nfin` m
applySubst s (App m n)    = App (applySubst s m) (applySubst s n)
```

=== $alpha$ conversion

$
  labs(x, M) = labs(
    y, underbrace(
      [x := y],
      "substitution"
    ) M
  ) " if " underbrace((y nfin labs(x, M)), #[needed to avoid\ variable capture])
$

```haskell
alphaConvert :: Term -> Id -> Term
alphaConvert (Abs x m) y =
  if y `nfin` m
    then Abs y $ applySubst (x, Var y) m
    else Abs x m
alphaConvert x _ = x
```

#exbox(
  $
      & labs(x, lapp(x, z)) && \
    = & labs(b, lapp(b, z)) && because alpha \
    = & labs(n, lapp(n, z)) && because alpha \
  $,
)

#todo[haskell]

=== $beta$ reduction

Replacing formal parameters (placeholders) with actual parameters (values)

$ lapp(plabs(x, M), N) = [x := N] M $

```haskell
betaReduce :: Term -> Maybe Term
betaReduce (App (Abs x m) n) = applySubst (x, n) m
betaReduce = id
```

#exbox(todo[])

=== $delta$ reduction

Although not strictly necessary, it is very useful to introduce abbreviations
for $lambda$ terms to make them more readable. This can be done by introducing
definitions as equalities of the following form to a context within which a term
can be reduced.

$ x = M $

The substitution of a defined symbol with its definition is referred as $delta$
reduction

#todo[]

=== $eta$ contraction

For any $f$ that does not contain any free occurances of $x$ the following
equality holds:
```haskell
(\x -> f x) == f     -- TODO: rewrite in lambda notation
\x -> f (g x) == f . g
```

$
            labs(x, lapp(f, x)) & <=> f \
  labs(x, lapp(f, plapp(g, x))) & <=> lapp(f, g)
$

== Evaluation

/ Innermost Redex: Every redex not containing any other redex. A term can contain several innermost redexes
/ Outermost Redex: Every redex not contained in any other redex A term can contain several outermost redexes
/ Leftmost Innermost Redex: The leftmost redex
  not containing any other redex. A term can contain at most one leftmost
  innermost redex
/ Leftmost Outermost Redex: The leftmost redex
  not contained in any other redex. A term can contain at most one leftmost
  outermost redex
/ Leftmost Innermost Strategy: The leftmost innermost redex
  is reduced in each step
/ Leftmost Outermost Strategy: The leftmost outermost redex
  is reduced in each step

=== Relation to parameter passing

/ Call by value: Leftmost innermost reduction except that no reductions are
  performed within $lambda$ abstractions.
/ Call by name: leftmost outermost reduction except that no reductions are
  performed within $lambda$ abstractions.
/ Lazy evaluation: Used in order to make call by name more efficient. Terms that are
  duplicated during function application are shared such that they are
  evaluated at most once.

== Encoding data and operations

#deftbl(
  definition: "Encoding",
  [True],
  $ top = labs(x, lapp(y, x)) $,
  [False],
  $ bot = labs(x, lapp(y, y)) $,
  [Conjunction],
  $ and = labs(p, labs(q, lapp(lapp(p, q), p))) $,
  [Disjunction],
  $ or = labs(p, labs(q, lapp(lapp(p, p), q))) $,
  [Negation],
  $ not = labs(p, lapp(lapp(p, bot), top)) $,
  [Zero],
  $ 0 = labs(f, labs(x, x)) $,
  [One],
  $ labs(f, labs(x, lapp(f, x))) $,
  [Two],
  $ labs(f, labs(x, lapp(f, plapp(f, x)))) $,
  [Successor],
  $ sc = labs(n, labs(f, labs(x, lapp(f, plapp(lapp(n, f), x))))) $,
  [Addition],
  $ + = labs(m, labs(n, lapp(lapp(m, sc), n))) $,
  [Multiplication],
  $ * = labs(m, labs(n, lapp(lapp(m, plapp(+, n)), 0))) $,
  [Power],
  $ "power" = labs(b, labs(e, lapp(e, b))) $,
  [Predecessor],
  $
    pred = labs(
      n, labs(
        f, labs(
          x, lapp(
            lapp(
              lapp(
                n, plabs(
                  g, labs(
                    h, lapp(
                      h, plapp(
                        g,
                        f
                      )
                    )
                  )
                )
              ), plabs(u, x)
            ), plabs(u, u)
          )
        )
      )
    )
  $,
  [Minus],
  $ - = labs(m, labs(n, lapp(lapp(n, pred), m))) $,
  [Is zero],
  $ "isZero" = labs(n, lapp(lapp(n, plabs(x, bot)), top)) $,
  [Less than or equal],
  $ <= = labs(m, labs(n, lapp("isZero", (lapp(lapp(-, m), n))))) $,
  [Are equal],
  $
    "areEqual" = labs(
      m, labs(
        n, (lapp(
            lapp(and, (lapp(lapp(<=, m), n))),
            (lapp(lapp(<=, m), n))
          ))
      )
    )
  $,
  [Pair],
  $ "pair" = labs(x, labs(y, labs(f, lapp(lapp(f, x), y)))) $,
  [First],
  $ "fst" = labs(p, lapp(p, top)) $,
  [Second],
  $ "snd" = labs(p, lapp(p, bot)) $,
)

== Lambda Cube

#link(
  "https://www.cs.uoregon.edu/research/summerschool/summer23/_lectures/oplss-lambda-cube1.pdf",
)

#{
  let edge = edge.with(marks: "-|>")
  set text(size: 1.5em)
  align(
    center,
    diagram(
      node-stroke: none,
      spacing: (2em, 2em),
      node((1, 0), name: <lo>, $lambda omega$),
      node((3, 0), name: <lpo>, $lambda Pi omega$),
      node((0, 1), name: <l2>, $lambda 2$),
      node((2, 1), name: <lp2>, $lambda Pi 2$),
      node((1, 2), name: <luo>, $lambda underline(omega)$),
      node((3, 2), name: <lupo>, $lambda Pi underline(omega)$),
      node((0, 3), name: <l>, $lambda ->$),
      node((2, 3), name: <lp>, $lambda Pi$),

      edge(<l>, <lp>),
      edge(<l>, <l2>),
      edge(<l>, <luo>),

      edge(<lp>, <lupo>),
      edge(<lp>, <lp2>),

      edge(<luo>, <lupo>),
      edge(<luo>, <lo>),

      edge(<l2>, <lo>),
      edge(<l2>, <lp2>),

      edge(<lo>, <lpo>),

      edge(<lp2>, <lpo>),

      edge(<lupo>, <lpo>),
    ),
  )
}

/ Origin:
  $lambda ->$: Simply typed lambda calculus
  Terms may only depend on Terms
  Curry-Howard correspondence for $lambda ->$: Propositional calculus restricted to only use implication.
/ Going up (2):
  $lambda 2$: System F, second-order lambda calculus
  Terms may depend on Types
  (polymorphism, e.g. (Church-style) $lambda α : * . lambda x : α . x : forall α . α -> α$ , or (Curry-style) $lambda x . x : forall α . α -> α$)
  Curry-Howard correspondence for $lambda 2$: fragment of second-order intuitionistic logic that uses only universal
  quantification.
/ Going inwards ($omega$):
  Types may depend on Types
  (type operators, e.g. `List α` is a type, where List is a type operator with
  kind `* -> *`)
  Not very interesting in isolation.
  Normally combined with $lambda 2$ (System F) to give $lambda omega$ (System F
  $omega$) (a variant of this (System FC) is used in Haskell)
  Curry-Howard correspondence for $lambda omega$ (System F$omega$): Higher-Order Logic
/ Going rightwards ($Pi$, or P):
  Types may depend on values
  (dependent types, e.g. `FloatList 3` is a type denoting a list of floats with
  length 3, where `Floatlist : Nat -> *` )
  $lambda Pi$ : also called $lambda$P, LF
  Curry-Howard correspondence for $lambda Pi$: A form of predicate calculus that only uses implication and universal
  quantification.
/ Richest calculus of all 8:
  $lambda Pi omega$ : Calculus of Constructions (CC, CoC, $lambda$C)

= Proofs

PAT:
- Propositions As Types
- Proofs As Terms

== Induction

$approx$ recursion

Logical inference rule / proof rule syntax:
$
  (["Base Case"] space overbrace(
    (["Induction Hypothesis"]=>
      ["Induction Step"]), "Inductive Case"
  ))/(["Main goal to be proven"])
$

#todo[lists (slides moodle)]

#exbox(
  title: $sum_(k=0)^n k = (k(k+1))/2$,
  [
    - Base case: $0 = (0(0+1))/2$
    - Induction step: Show that for every $k>=0$, if $P(k)$ holds, then $P(k+1)$
      also holds $ (k(k+1))/2 + (k+1) = & (k(k+1)+2(k+1))/2 \
                         = & ((k+1)(k+2))/2 \
                         = & ((k+1)((k+1)+1))/2 = sum_(k=0)^n k + (k + 1) \ $
    Logical inference rule:
    $
      (P 0 #h(1em) forall n. (P n => P (n + 1)))/(forall n. (P n)) \
      P n = (sum_(k=0)^n k = (k(k+1))/2)
    $
  ],
)

#exbox(
  title: ```haskell data [a] = [] | a:[a]```,
  $
    (P #`[]` #h(1em) forall #`x xs`.(P #`xs` => P (#`x:xs`)))/(forall #`xs`.(P #`xs`))
  $,
)

#exbox(
  title: $lambda ->$,
  $
    ()/(Gamma, x : sigma tack.r x : sigma) "var" #h(2em)
    (Gamma tack.r M : sigma -> tau space Gamma tack.r N : sigma)/(Gamma tack.r M
    N : tau) "app"_"term" #h(2em)
    (Gamma , x : sigma tack.r M : tau)/(Gamma tack.r lambda x . M : sigma -> tau) "abs"_"term"
  $,
)

#todo[

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
]

#pagebreak()
= #link(
  "https://www.youtube.com/watch?v=TVNos1W65O0",
  "some cursed typescript ig",
)

```ts
type And<A extends boolean, B extends boolean> = A extends true ? B : false;
type Or<A extends boolean, B extends boolean> = A extends true ? true : B;

type Num = { prev?: Num };
type Zero = Num & { prev: undefined };

type Next<N extends Num> = Num & { prev: N };
type Prev<N extends Num> = N extends Zero ? Zero : Num & N["prev"];

type One = Next<Zero>;
type Two = Next<One>;
type Three = Next<Two>;

type Add<A extends Num, B extends Num> = A extends Zero
  ? B
  : A extends Zero
    ? B
    : Add<Prev<A>, Next<B>>;
type Sub<A extends Num, B extends Num> = B extends Zero
  ? A
  : A extends Zero
    ? Zero
    : Sub<Prev<A>, Prev<B>>;

type ToTuple<N extends Num, Acc extends any[] = []> = N extends {
  prev: infer P extends Num;
}
  ? ToTuple<P, [...Acc, "_"]>
  : Acc;
type ToLiteral<N extends Num> = ToTuple<N>["length"];

type ToLiteralTest = ToLiteral<Three>; // 3
type AddTest = ToLiteral<Add<Three, Two>>; // 5
type SubTest = ToLiteral<Sub<Three, Two>>; // 1
```
