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
#let ul = math.underline

#let PC = math.op(math.italic("PC"))
#let basicPC = math.op(math.italic("basicPC"))
#let FoPCe = math.op(math.italic("FoPCe"))
#let basicFoPCe = math.op(math.italic("basicFoPCe"))
#let LC = math.op(math.italic("LC"))

#let hyp = math.op(math.italic("hyp"))
#let mon = math.op(math.italic("mon"))
#let cut = math.op(math.italic("cut"))
#let contr = math.op(math.italic("contr"))
#let goal = math.op(math.italic("goal"))

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
  [Referential transparency],
  [
    - *no* (mutable) variables
    - *no* assignments
    - *no* imperative control structures
    - all data structures are *immutable*
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

#deftbl(
  term: "Paradigm",
  [Imperative/Procedural],
  [Normie],
  [Object Oriented],
  [Corpochud],
  [Functional],
  [Gigachad],
  [Array],
  [
    ```uiua
    Xy ← °⍉˙⊞⊟÷⟜⇡
    F  ← ⍉◿1⊂⊃(+/÷|÷3+1∿×τ+)Xy
    ≡F100 ÷⟜⇡10
    ```
  ],
)

= Haskell

== Function definition

```haskell
funName :: (TypeBound a) => a -> b        -- type definition
funName x = fnRequiringTypeBound x        -- implementation
```

=== Curried functions

```haskell
add :: Int -> Int -> Int
add x y = x + y

add2 :: Int -> Int
add2 = add 2                              -- curried
```

=== Guarded Equations

```haskell
abs n
    | n >= 0 = n                          -- fancy if else
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
head (x : _) = x                          -- first elem
tail :: [a] -> [a]
tail (_ : xs) = xs                        -- rest of list
```

=== Lambda expressions

```haskell
-- \boundvar -> body
(\x -> x + x) 5
```

== Function application

```haskell
-- function argument
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
  `! # $ % & * + . / < = > ? @ ^ | - ~ :` (or any Unicode symbol or
  punctuation).
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

$
  & {x^2 | x in {1,2,...,5}} \
  & {x^2 | x in {1,2,...,12}, 12 mod x equiv 0} \
  & {(x,y) | x in {1,2}, y in {4,5}} \
  & {(x,y) | x in {1,2}, y in {x,...,2}} \
$

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
```hs
Prelude> :set -fprint-explicit-foralls
Prelude> :t Just
Just :: forall {a}. a -> Maybe a
```
- You may explicitly specify the universal quantification in polymorphic type
  signatures using the `ExplicitForAll` extension.


Maybe and Pair are called Type Constructors since they construct one type from
another. This behaviour is expressed using kinds, which is the type of a "type".
The type system for kinds is very simple:

```hs K ::= * | K -> K``` \
```hs *``` Kind of ordinary/proper/concrete/basic types \
```hs ->``` Kind of "type constructor" or "type operators"

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
- In the context of a type (e.g. ```hs id :: a -> a``` ), it denotes the type
  constructor for function types.
- In the context of a kind (e.g. ```hs List :: * -> *``` ), it denotes the kind
  constructor for type constructors.

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

```haskell
newtype ListOfBool = [Bool]
```

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

_Kleisi arrow (not in haskell)_

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
  Nothing  >>= _ = Nothing
  (Just x) >>= f = f x

instance Monad [] where
  xs >>= f = [y | x <- xs, y <- f x]
```

==== Comparison

#table(
  columns: 6,
  table-header(
    [],
    [Application\ operator],
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

- Perform an evaluation step only when it is necessary.
- Never perform the same step twice.

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

Created by Alonzo Church.

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
      & labs(ul(x), lapp(ul(x), z)) && \
    = & labs(ul(b), lapp(ul(b), z)) && because alpha \
    = & labs(n, lapp(n, z))         && because alpha \
  $,
)

=== $beta$ reduction

Replacing formal parameters (placeholders) with actual parameters (values)

$ lapp(plabs(x, M), N) = [x := N] M $

```haskell
betaReduce :: Term -> Maybe Term
betaReduce (App (Abs x m) n) = applySubst (x, n) m
betaReduce = id
```

#exbox(
  $
      & lapp(
          ul(
            plapp(
              plabs(x, plabs(y, y)),
              plapp(
                plabs(x, lapp(x, x)), plabs(
                  x,
                  x
                )
              )
            )
          ), plapp(plabs(x, x), z)
        )
        #h(2em) \
    = & ul(lapp(plabs(y, y), plapp(plabs(x, x), z))) && because beta \
    = & ul(lapp(plabs(x, x), z))                     && because beta \
    = & z                                            && because beta \
  $,
)

=== $delta$ reduction

Although not strictly necessary, it is very useful to introduce abbreviations
for $lambda$ terms to make them more readable. This can be done by introducing
definitions as equalities of the following form to a context within which a term
can be reduced.

$ x = M $

The substitution of a defined symbol with its definition is referred as $delta$
reduction

#exbox(
  $
    && lapp(lapp(ul(or), top), bot) & = top #h(2em) \
    <=> && lapp(ul(lapp(plabs(p, labs(q, lapp(lapp(p, p), q))), top)), bot) & = top && because delta \
    <=> && ul(lapp(plabs(q, lapp(lapp(top, top), q)), bot)) & = top && because beta \
    <=> && lapp(lapp(ul(top), top), bot) & = top && because beta \
    <=> && lapp(ul(lapp(plabs(x, labs(y, x)), top)), bot) & = top && because delta \
    <=> && ul(lapp(plabs(y, top), bot)) & = top && because beta \
    <=> && top & = top && because beta \
  $,
)

=== $eta$ contraction

For any $f$ that does not contain any free occurances of $x$ the following
equality holds:
```haskell
(\x -> f x) == f
\x -> f (g x) == f . g
```

$
            labs(x, lapp(f, x)) & <=> f \
  labs(x, lapp(f, plapp(g, x))) & <=> lapp(f, g)
$

=== As proof trees

#align(center, rule-set(
  prooftree(rule($Eta tack (lambda x . M) N = [x:=N] M$, name: $beta$)),
  prooftree(rule($Eta tack M = M$, name: $=goal$)),
  prooftree(rule(
    $Eta, M = N tack [x:=N]P$,
    $Eta, M = N tack [x:=M]P$,
    name: $=hyp$,
  )),
  prooftree(rule($Eta tack P$, $Eta, P tack Q$, $Eta tack Q$, name: $cut$)),
))

== Evaluation

/ Innermost Redex: Every redex not containing any other redex. A term can
  contain several innermost redexes
/ Outermost Redex: Every redex not contained in any other redex A term can
  contain several outermost redexes
/ Leftmost Innermost Redex: The leftmost redex not containing any other redex. A
  term can contain at most one leftmost innermost redex
/ Leftmost Outermost Redex: The leftmost redex not contained in any other redex.
  A term can contain at most one leftmost outermost redex
/ Leftmost Innermost Strategy: The leftmost innermost redex is reduced in each
  step
/ Leftmost Outermost Strategy: The leftmost outermost redex is reduced in each
  step

=== Relation to parameter passing

/ Call by value: Leftmost innermost reduction except that no reductions are
  performed within $lambda$ abstractions.
/ Call by name: leftmost outermost reduction except that no reductions are
  performed within $lambda$ abstractions.
/ Lazy evaluation: Used in order to make call by name more efficient. Terms that
  are duplicated during function application are shared such that they are
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

== Lambda cube

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
  $lambda ->$: Simply typed lambda calculus Terms may only depend on Terms
  Curry-Howard correspondence for $lambda ->$: Propositional calculus restricted
  to only use implication.
/ Going up (2):
  $lambda 2$: System F, second-order lambda calculus Terms may depend on Types
  (polymorphism, e.g. (Church-style)
  $lambda alpha : * . lambda x : alpha . x : fora(
    alpha,
    alpha -> alpha
  )$ , or (Curry-style) $lambda x . x : fora(alpha, alpha -> alpha)$)
  Curry-Howard correspondence for $lambda 2$: fragment of second-order
  intuitionistic logic that uses only universal quantification.
/ Going inwards ($omega$):
  Types may depend on Types (type operators, e.g. ```hs List a``` is a type,
  where List is a type operator with kind ```hs * -> *```) Not very interesting
  in isolation. Normally combined with $lambda 2$ (System F) to give
  $lambda omega$ (System F $omega$) (a variant of this (System FC) is used in
  Haskell) Curry-Howard correspondence for $lambda omega$ (System F$omega$):
  Higher-Order Logic.
/ Going rightwards ($Pi$, or P):
  Types may depend on values (dependent types, e.g. ```hs FloatList 3``` is a
  type denoting a list of floats with length 3, where
  ```hs Floatlist : Nat -> *``` ) $lambda Pi$ : also called $lambda$P, LF
  Curry-Howard correspondence for $lambda Pi$: A form of predicate calculus that
  only uses implication and universal quantification.
/ Richest calculus of all 8:
  $lambda Pi omega$ : Calculus of Constructions (CC, CoC, $lambda$C)

= Proofs

/ PAT: Propositions As Types / Proofs As Terms (using types to prove the
  correctness of your program)
/ Propositional logic: The simplest form of formal logic, dealing with
  statements (called propositions).
/ Proposition: Can be either true ($top$) or false ($bot$)
/ First-order logic/Predicate logic: Extension of propositional logic. It
  introduces variables, quantifiers, and predicates to express more nuanced
  statements about objects and their relationships.
/ Premise: Statement or assumption that you accept as true as the starting point
  for reasoning. Premises are the givens in a logical argument.
/ Sound reasoning: Logical argument is both valid and based on true premises

/ Propositional Calculus ($PC$): Formal proof system for propositional logic
/ First-order PC with equality ($FoPCe$): A (first-order) logic system whose
  language includes variables, predicate symbols, function symbols, quantifiers
  and equality
/ First-order: The logic's quantifiers range over individual objects in a
  domain, but it does not quantify over predicates/sets/properties as objects.

#{
  let nd = node.with(width: 8em)
  align(center, diagram(
    spacing: (2em, 2em),

    nd((0, 0), $FoPCe$, name: <f>),
    nd((0, 1), $basicFoPCe$, name: <bf>),
    node(enclose: (<f>, <bf>), shape: fletcher.shapes.brace.with(
      label: [First-Order Predicate\ Calculus with Equality],
      dir: left,
    )),

    nd((0, 2), $PC$, name: <p>),
    nd((0, 3), $basicPC$, name: <bp>),
    node(enclose: (<p>, <bp>), shape: fletcher.shapes.brace.with(
      label: [Propositional subset of\ the Propositional Calculus],
      dir: left,
    )),

    nd((1, 3), $LC$, name: <l>),
    node(enclose: (<l>,), shape: fletcher.shapes.brace.with(
      label: [Lambda Calculus],
      dir: right,
    )),

    node(enclose: ((0, 4), (1, 4)), [Sequent Calculus], name: <s>),

    edge(<f>, <bf>, "-|>"),
    edge(<bf>, <p>, "-|>"),
    edge(<p>, <bp>, "-|>"),
    edge(<bp>, <s>, "-|>"),
    edge(<l>, <s>, "-|>"),
  ))
}

== Notation

=== Symbols

#deftbl(
  $and$,
  [And],
  $or$,
  [Or],
  $not$,
  [Not],
  $->$,
  [Implies ($=>$)],
  $<->$,
  [Biconditional (iff/$<=>$/$equiv$)],
  $top$,
  [Tautology (always true)],
  $bot$,
  [Contradiction (always false)],
  $forall$,
  [Universal quantifier (for all)],
  $exists$,
  [Existential quantifier (exists)],
  $exists!$,
  [There exists exactly one],
  $exists.not$,
  [There does not exist],
  $tack.double$,
  [Logical consequence (entails)],
  $tack$,
  [Provability (can be proven from)],
)

=== Proof tree

#align(center, prooftree(rule(
  name: [Rule name],
  [Premise 1],
  [Premise 2],
  [...],
  [Premise n],
  [Conclusion],
)))

#exbox(
  title: $lambda ->$,
  align(center, rule-set(
    prooftree(rule(
      name: $"var"$,
      $Gamma, x : sigma tack.r x : sigma$,
    )),
    prooftree(rule(
      name: $"app"_"term"$,
      $Gamma tack.r M : sigma -> tau$,
      $Gamma tack.r N : sigma$,
      $Gamma tack.r M N : tau$,
    )),
    prooftree(rule(
      name: $"abs"_"term"$,
      $Gamma , x : sigma tack.r M : tau$,
      $Gamma tack.r lambda x . M : sigma -> tau$,
    )),
  )),
)

#exbox(
  title: "Type inference",
  align(center, prooftree(rule(
    ```hs f :: A -> B```,
    ```hs e :: A```,
    ```hs f e :: B```,
  ))),
)

=== Two-Column Proof

Format:
$
  "Statement" #h(2em) | "Justification"
$
#exbox(
  $
    & 1. P → Q #h(2em) && | "Premise" \
    & 2. P             && | "Premise" \
    & 3. Q             && | "From 1, 2 by Modus Ponens" \
  $,
)

=== Structured Proof

Format:
$
  & "Theorem: [Statement to prove]" \
  & "Proof:" \
  & "1. [First statement with justification]" \
  & "2. [Second statement with justification]" \
  & ... \
  & "n. [Final conclusion]" \
  & "QED (or" square ")" \
$
#exbox(
  $
    & "Theorem: If" P "and" P -> Q, "then" Q. \
    & "Proof:" \
    & "1. Assume" P "and" P -> Q "as premises." && "(Assumption)" \
    & "2. From" P -> Q "and" P ", we conclude" Q. #h(2em) && "(Modus Ponens)" \
    & && & square \
  $,
)

=== Sequent calculus

Format:
$
  Gamma tack Delta
$

Where:

- $Gamma$ = _antecedent_ = set of premises (assumptions)
- $tack$ = "proves" or "entails"
- $Delta$ = _succedent_ = conclusion(s)

#exbox(
  $
    P -> Q, P tack Q
  $,
)

== Formula

A formula is a symbolic expression built from logical operators, variables,
quantifiers, and predicates according to strict grammatical rules. It's the
written representation of a logical statement.

=== Components of a formula

#table(
  columns: (auto, 1fr, auto),
  table-header([Component], [Meaning], [Example]),
  [Propositional variables],
  [Simple true/false statements],

  $P, Q, R$, [Predicates], [Properties or relationships],
  $"Human"(x), "Loves"(x, y)$, [Quantifiers], [Universal or existential claims],
  $forall x, exists y$, [Logical operators], [Combine or modify statements],
  $and, or, not, ->, <->$, [Parentheses], [Clarify structure and precedence],
  $(P and Q) -> R$,
)

== Proof

A proof is a sequence of logical steps that demonstrates the truth of a
statement based on accepted premises and logical rules. Each step must follow
necessarily from previous steps or established axioms.

=== Components of a proof

#table(
  columns: (auto, 1fr, auto),
  table-header([Component], [Meaning], [Example]),
  [Axioms/Premises],
  [Starting assumptions accepted as true],

  [All humans are mortal],

  [Logical rules],
  [Valid inference methods (e.g., modus ponens)],
  [If $P -> Q$ and $P$ is true, then $Q$ is true],

  [Intermediate steps],
  [Conclusions derived from previous steps],
  [Socrates is human, so Socrates is mortal],

  [Final conclusion], [The statement being proven], [Socrates is mortal],
)

=== Common proof techniques

- Direct proof
- Proof by contradiction
- Proof by @induct

=== Logical rules

A _Rule of inference_ is a logical principle that allows you to derive a new
conclusion from one or more premises.

==== Modus ponens

#align(center, prooftree(rule(
  $P->Q$,
  $P$,
  $Q$,
)))

#exbox(align(center, prooftree(rule(
  [If FP is based, then Haskell is based],
  [FP is based],
  [Therefore, haskell is based],
))))

==== Modus tollens

#align(center, prooftree(rule(
  $P->Q$,
  $not Q$,
  $not P$,
)))

#exbox(align(center, prooftree(rule(
  [If Java is cool, then cool people write java],
  [Cool people don't write java],
  [Therefore, java isn't cool],
))))

==== Hypothetical syllogism

#align(center, prooftree(rule(
  $P->Q$,
  $Q->R$,
  $P->R$,
)))

#exbox(align(center, prooftree(rule(
  name: [Ragebait],
  [If you live with other people, you are part of a society],
  [If you are part of a society, you must abide by its rules],
  [Therefore, if you live with other people, you must abide by their rules],
))))

==== Disjunctive syllogism

#align(center, prooftree(rule(
  $P or Q$,
  $not P$,
  $Q$,
)))
#exbox(align(center, prooftree(rule(
  [I am alive or dead],
  [I am not dead :(],
  [Therefore, I am alive],
))))

==== Double negation elimination

#align(center, prooftree(rule(
  $not not P$,
  $P$,
)))

#exbox(align(center, prooftree(rule(
  [We were not unable to meet the deadline],
  [We were able to meet the deadline],
))))

== Sequent calculus

A proof system for logic where judgments are written as sequents of the form
$Gamma tack Delta$, in which $Gamma$ are the assumptions (antecedents) and
$Delta$ is the conclusion (consequent).

/ Sequent: A generic name for a statement that we want to prove
/ Proof rule: A device used to construct proofs of sequents. It consists of a
  list of antecedent sequents and a consequent sequent.
#exbox(
  title: [A Proof rule for the sequent named $r$, with antecedents $A, B$ and
    the consequent $C$],
  align(center, prooftree(rule($A$, $B$, $C$, name: $r$))),
)
/ Axiom: In case the list of antecedents is empty, a proof rule is said to be an
  _axiom_.
#exbox(
  title: [An axiom $r_a$],
  align(center, prooftree(rule($S$, name: $r_a$))),
)
/ Theory: A (possibly infinite) set of proof rules, also called _calculus_.
#exbox(
  title: [Theory $cal(T)$ with seven proof rules],
  align(center, {
    rule-set(
      prooftree(rule($S 2$, $S 3$, $S 4$, $S 1$, name: $r_1$)),
      prooftree(rule($S 5$, $S 6$, $S 2$, name: $r_2$)),
      prooftree(rule($S 7$, $S 3$, name: $r_3$)),
    )
    rule-set(
      prooftree(rule($S 4$, name: $r_4$)),
      prooftree(rule($S 5$, name: $r_5$)),
      prooftree(rule($S 6$, name: $r_6$)),
      prooftree(rule($S 7$, name: $r_7$)),
    )
  }),
)

=== Proofs and Validity

#defbox("Proof", [
  A proof of a sequent within a given theory is a finite tree whose nodes have
  the following properties:
  - Each node consists of a sequent and an optional proof rule of the theory.
  - The root node contains the sequent we want to prove.
  - A node with no proof rule has no child nodes.
  - In case a node contains a proof rule:
    - Its sequent is identical to the consequent of the proof rule.
    - It has a child node corresponding to each antecedent of the proof rule.
    - The sequent of each child node is identical to its corresponding
      antecedent.
])
#exbox(
  title: [Incomplete proof of the sequent $S 1$ using the theory $cal(T)$ just
    presented],
  [
    #align(center, prooftree(
      rule(
        rule(
          rule(
            $S 5$,
            name: $r_5$,
          ),
          rule(
            $S 6$,
            name: $r_6$,
          ),
          $S 2$,
          name: $r_2$,
        ),
        rule(
          $S 7$,
          $S 3$,
          name: $r_3$,
        ),
        rule(
          $S 4$,
          name: $r_4$,
        ),
        $S 1$,
        name: $r_1$,
      ),
    ))
    The sequent $S 7$ is said to be a _pending sub-goal_ of the above proof.
  ],
)
/ Pending Sub-goals of a proof: The leaf nodes of a proof that do not contain
  proof rules are said to be _pending nodes_. The sequents of such pending nodes
  are said to be the _pending sub-goals_ of a proof.
/ iff: If and only if
/ Complete proof: A proof is said to be _complete_ iff it has no pending
  sub-goals.
/ Incomplete proof: A proof is said to be _incomplete_ iff it has at least one
  pending sub-goal.
#exbox(
  title: [Complete proof],

  align(center, prooftree(
    rule(
      rule(
        rule(
          $S 5$,
          name: $r_5$,
        ),
        rule(
          $S 6$,
          name: $r_6$,
        ),
        $S 2$,
        name: $r_2$,
      ),
      rule(
        rule(
          $S 7$,
          name: $r_7$,
        ),
        $S 3$,
        name: $r_3$,
      ),
      rule(
        $S 4$,
        name: $r_4$,
      ),
      $S 1$,
      name: $r_1$,
    ),
  )),
)
/ Valid Sequent: A sequent $S$ is said to be valid with respect to a theory
  $cal(T)$ iff there exists a complete proof of $S$ within the theory $cal(T)$.

== Propositional calculus $(PC)$

/ Predicate: A formal statement expressing a certain property that we may
  assume, or a certain property that we wish to prove.

#exbox($ A and B => B and A $)

/ Syntax of $basicPC$: ```bnf <P> ::= ⊥ | ¬<P> | <P> ∧ <P> ``` with binding
  strength $and$, then $not$

=== Proof rule schemas

A theory is specified using a finite set of _proof rule schemas_. Each proof
rule schema represents an infinite number of proof rules *of the same form*. A
proof rule may be derived from its rule schema by instantiating its so-called
_meta variables_. For instance consider the rule schema:

#align(center, prooftree(
  rule(name: $c u t$, $Eta tack P$, $Eta, P tack Q$, $Eta tack Q$),
))

The letters $Eta$, $P$, and $Q$ are _meta variables_. The letter $Eta$ is a meta
variable standing for a finite set of predicates, whereas the letters $P$ and
$Q$ are meta variables standing for single predicates. Replacing these meta
variables by actual predicates gives us a proof rule. Here is an instance of the
above rule schema:

#align(center, prooftree(
  rule(name: $cut_"instantiated"$, $A tack B$, $A, B tack C$, $A tack C$),
))

=== Proof rules of $basicPC$

#align(center, rule-set(
  prooftree(rule($Eta, P tack P$, name: $hyp$)),
  prooftree(rule($Eta tack Q$, $Eta, P tack Q$, name: $mon$)),
  prooftree(rule($Eta tack P$, $Eta, P tack Q$, $Eta tack Q$, name: $cut$)),
  prooftree(rule($Eta, not P tack bot$, $Eta tack P$, name: $contr$)),
  prooftree(rule($Eta, bot tack P$, name: $bot hyp$)),
  prooftree(rule($Eta, P tack bot$, $Eta tack not P$, name: $not goal$)),
  prooftree(rule($Eta tack P$, $Eta, not P tack Q$, name: $not hyp$)),
  prooftree(rule(
    $Eta tack P$,
    $Eta tack Q$,
    $Eta tack P and Q$,
    name: $and goal$,
  )),
  prooftree(rule($Eta, P, Q tack R$, $Eta, P and Q tack R$, name: $and hyp$)),
))
/ hyp: The proof rule schema _hyp_, which is used to complete proofs, formally
  states the obvious fact that a sequent whose goal also occurs as a hypothesis
  is trivially valid.
The proof rule schemas _mon_ and _cut_ are so-called "structural" proof rule
schemas since they do not refer to any logical connectives, but operate on the
sequents directly to mimic meta-theoretic properties of the logic.
/ mon: The rule schema _mon_ (for "monotonicity") formally states that removing
  (superfluous) hypotheses is a valid proof step (i.e. it does not make an
  invalid sequent suddenly valid).
/ cut: The rule schema cut allows one to add an arbitrary predicate $P$
  (sometimes referred to as a "lemma") as an hypothesis in the current proof,
  provided one can prove it separately.
/ contr: The proof rule schema _contr_ starts a proof by contradiction: A valid
  way to prove something is assume that it does not hold, and from this arrive
  at a absurdity or contradiction.
The rest of the proof rule schemas aim to simplify individual logical operators
within the goal or hypotheses. Their names have been chosen accordingly

=== Derived Logical operators for /* FIXME: tanki bug $PC$ */ PC

$
      top eq.est & not bot                  && (scripts(eq.est)_top) \
          P or Q & not (not P and not Q)    && (scripts(eq.est)_or) \
   P => Q eq.est & not P or Q               && (scripts(eq.est)_(=>)) \
  P <=> Q eq.est & (P=>Q) and (Q => P) quad && (scripts(eq.est)_(<=>)) \
$

#todo[p.19+]

== First-order Predicate calculus $(FoPCe)$

/ Expression: An _expression_ is a formal statement denoting a mathematical
  object.
#exbox(
  $
    underbrace(f(x), "expression") quad underbrace(x, "expression") quad underbrace(g(x,f(x)), "expression")
  $,
)
An important distinction between expressions and predicates is that there is no
concept of proof for an expression, as there is for predicates. One cannot prove
an expression.
/ Variable: A _variable_ is an identifier that denotes an expression.
The identifier $x$ is a variable in the expression $f(x)$ and in the predicate
$x = f(x)$.

/ Syntax of $basicFoPCe$: ```bnf
  <P> ::= ... | ∀x.<P> | <E> = <E> | R(<E>)
  <E> ::= x | f(<E>)
  ```
  with binding strength $=$, then $forall$

=== Proof rules for /* FIXME: tanki bug $basicFoPCe$ */ basicFoPCe

#align(center, rule-set(
  prooftree(rule(
    $Eta tack P$,
    $Eta tack forall x . P$,
    name: $forall g o a l (x space accent("nfin", hat) space Eta)$,
  )),
  prooftree(rule(
    $Eta, forall x . P, [x := E] P tack Q$,
    $Eta, forall x . P tack Q$,
    name: $forall hyp$,
  )),
  prooftree(rule($Eta tack E = E$, name: $= goal$)),
  prooftree(rule(
    $Eta, E = F tack [x:=F] P$,
    $Eta, E = F tack [x:=E] P$,
    name: $=hyp$,
  )),
))
/ Substitution: The predicate $[x := E]P$ denotes the syntactic operator for
  _substitution_ $[x := E]$, applied to the predicate $P$.
/ Non-freeness: The side condition $(x space accent("nfin", hat) space Eta)$
  asserts that the variable $x$ is not free in any of the predicates contained
  in $H$: the "hat" over the $nfin$ operator denotes that it has been lifted
  from operating on single predicates to a set of predicates.

=== Derived logical operators for /* FIXME: tanki bug $FoPCe$ */ FoPCe

$
  exists x . P & eq.est not forall x . not P quad && (scripts(eq.est)_exists)
$

#todo[p.23+]

== Equational reasoning

In this course the '==' symbol is used instead of '=' to be more consistent with
the notation of equality used in Haskell.

#let subhs = (a, b, p: false) => {
  $#if p { raw(lang: "hs", "(") }#raw(lang: "hs", a) _#raw(lang: "hs", b)#if p { raw(lang: "hs", ")") }$
}

#exbox[
  $
    & #```hs ∀x. add Zero x == x``` && #```hs (addZero)``` \
    & #```hs ∀x. x == x``` && #subhs("(==)", "refl", p: true) \
    \
    & #```hs add Zero (add y z) == add (add Zero y) z``` \
    #```hs ==``` & #```hs { applying addZero }``` \
    & #```hs add y z == add (add Zero y) z``` \
    #```hs ==``` & #```hs { applying addZero }``` \
    & #```hs add y z == add y z``` \
    #```hs ==``` & #```hs { applying``` #subhs("(==)", "refl") #```}``` \
    & #```hs True```
  $
]

== Induction <induct>

$approx$ recursion

Structure:
- Proposition (Required to prove -- RTP)
- Proof
  + Base case
  + Induction step
- Conclusion

#exbox(
  title: ```hs length (xs ++ ys) == length xs + length ys```,
  [
    _Given properties_
    $
      & #```hs length [] == 0``` && #subhs("length", "[]", p: true) \
      & #```hs ∀x xs. length (x:xs) == 1 + length xs``` quad && #subhs("length", "(:)", p: true) \
      & #```hs ∀xs. [] ++ xs == xs``` && #subhs("(++)", "[]", p: true) \
      & #```hs ∀x xs ys. (x:xs) ++ ys == x:(xs++ys)``` && #subhs("(++)", "(:)", p: true) \
      & #```hs ∀n. 0 + n == n``` && #subhs("(+)", "0", p: true) \
      & #```hs ∀a b c. (a + b) + c == a + (b + c)``` && #subhs("(+)", "assoc", p: true) \
      & #```hs ∀x. (x == x) == True``` && #subhs("(==)", "refl", p: true) \
    $

    _Required to Prove (RTP)_

    ```hs ∀xs ys. (length (xs ++ ys) == length xs + length ys)```

    _Proof_

    Proceed by induction on ```hs xs```:

    Let ```hs P xs = ∀ys. (length (xs ++ ys) == length xs + length ys)``` and
    apply the induction rule for lists on ```hs P xs```.

    + Base Case. RTP: ```hs P []``` \
      $
        & #```hs P []``` \
        #```hs ==``` & #```hs {applying definiton of P, choosing a fixed but arbitrary ys}``` \
        & #```hs length ([] ++ ys) == length [] + length ys``` \
        #```hs ==``` & #```hs {applying``` #subhs("length", "[]") #`}` \
        & #```hs length ([] ++ ys) == 0 + length ys``` \
        #```hs ==``` & #```hs {applying``` #subhs("(++)", "[]") #`}` \
        & #```hs length ys == 0 + length ys``` \
        #```hs ==``` & #```hs {applying``` #subhs("(+)", "0") #`}` \
        & #```hs length ys == length ys``` \
        #```hs ==``` & #```hs {applying``` #subhs("(==)", "refl") #`}` \
        & #```hs True``` \
      $
    + Induction Step. RTP: ```hs ∀x xs.(P xs ⇒ P (x:xs))``` \
    Choose a fixed but arbitrary ```hs x``` and ```hs xs```, and assume that
    following the induction hypothesis ```hs P xs``` holds \
    $
      & #```hs ∀ys. (length (xs ++ ys) == length xs + length ys) (Induction Hypothesis) ``` \
      \
      & #```hs P (x:xs) ``` \
      #```hs ==``` & #```hs {applying definiton of P, choosing a fixed but arbitrary ys} ``` \
      & #```hs length ((x:xs) ++ ys) == length (x:xs) + length ys ``` \
      #```hs ==``` & #```hs {applying``` #subhs("length", "(:)") #`}` \
      & #```hs length ((x:xs) ++ ys) == (1 + length xs) + length ys ``` \
      #```hs ==``` & #```hs {applying``` #subhs("(++)", "(:)") #`}` \
      & #```hs length (x:(xs ++ ys)) == (1 + length xs) + length ys ``` \
      #```hs ==``` & #```hs {applying``` #subhs("length", "(:)") #`}` \
      & #```hs 1 + length (xs ++ ys) == (1 + length xs) + length ys ``` \
      #```hs ==``` & #```hs {applying Induction Hypothesis} ``` \
      & #```hs 1 + (length xs + length ys) == (1 + length xs) + length ys ``` \
      #```hs ==``` & #```hs {applying``` #subhs("(+)", "assoc") #`}` \
      & #```hs 1 + (length xs + length ys) == 1 + (length xs + length ys) ``` \
      #```hs ==``` & #```hs {applying``` #subhs("(==)", "refl") #`}` \
      & #```hs True ``` \
    $
    _Conclusion_

    Concatenating two lists results in a list of length equal to the sum of the
    concatenated lists
  ],
)

=== Logical inference

Logical inference rule / proof rule syntax:
$
  (["Base Case"] quad overbrace(
    (["Induction Hypothesis"]=>
      ["Induction Step"]), "Inductive Case"
  ))/(["Main goal to be proven"])
$

#exbox(
  title: $sum_(k=0)^n k = (k(k+1))/2$,
  [
    - Base case: $0 = (0(0+1))/2$
    - Induction step: Show that for every $k>=0$, if $P(k)$ holds, then $P(k+1)$
      also holds
      $
        (k(k+1))/2 + (k+1) = & (k(k+1)+2(k+1))/2 \
                           = & ((k+1)(k+2))/2 \
                           = & ((k+1)((k+1)+1))/2 = sum_(k=0)^n k + (k + 1) \
      $
    Logical inference rule:
    $
      (P 0 quad fora(n, P n => P (n + 1)))/(fora(n, P n)) \
      P n = (sum_(k=0)^n k = (k(k+1))/2)
    $
  ],
)

#exbox(
  title: ```haskell data [a] = [] | a:[a]```,
  $
    (P #`[]` quad fora(#`x xs`, P #`xs` => P (#`x:xs`)))/(fora(#`xs`, P #`xs`))
  $,
)

#todo[
  - Dependent typing
  - Mutable state + parallel programming
  - denotative language / semantics (central passages)
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

type ToLiteralTest = ToLiteral<Three>;     // 3
type AddTest = ToLiteral<Add<Three, Two>>; // 5
type SubTest = ToLiteral<Sub<Three, Two>>; // 1
```
