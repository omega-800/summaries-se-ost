#import "../lib.typ": *

#show: project.with(
  module: "EC",
  name: "Extracurriculars",
  semester: "HS25-HS26",
  language: "en",
)
// TODO: only exercises
#set enum(numbering: "(i)")
// TODO: header numbering exercises

= Category Theory in Context - Emily Rie

Notation:

$->$ Morphism \
$arrows$ Parallel pair of morphisms \
$arrows.rl$ Opposing pair of morphisms \
$|->$ "maps to" \
$~>$ "yields" / "leads to" \
$arrow.r.dashed$ Implied existece of another morphism \
$=$ Genuine equality \
$:=$ Definitional equality \
$tilde.equiv$ Isomorphism \
$tilde.eq$ Weaker equivalence \
$->>$ Epimorphism \
$arrow.r.hook$ Inclusion/Embedding/"beinhaltet"/$subset$  ? \

== Chapter 1

=== Abstract and concrete categories

#deftbl(
  [Commutative],
  [The order of the elements in an operation does not affect the result],
  [Commutative diagram],
  [Diagram where all directed paths with the same starting and ending points yield the same result],
  [Natural],
  [],
  [Functor],
  [],
)
Groups
#deftbl(
  [Group],
  [A non-empty set with a binary operation satisfying associativity, identity and inverse $<=>$ A groupoid with one object],
  [Subgroup],
  [],
  [Group extension],
  [],
  [Abelian group],
  [A Group equipped with an operation that satisfies the commutative property],
  [Abelian extension],
  [],
  [Ring],
  [],
  [Quiver],
  [A directed graph defined by objects and morphisms in a category],
)
Morphisms
#deftbl(
  [Morphism],
  [A structure-preserving map between two objects within a category],
  [Homomorphism],
  [A morphism mapping between two algebraic structures while preserving their operations],
  [Isomorphism],
  [
    A morphism $f: X -> Y$ for which there exists a morphism $g: Y->X$ so that $g f = 1_X and f g = 1_Y$

    A morphism which is both a monomorphism and an epimorphism. \*
  ],
  [Endomorphism],
  [A morphism whose domain equals its codomain],
  [Automorphism],
  [An isomorphic endomorphism],
)
Categories
#deftbl(
  [Category],
  [
    Consists of objects $X,Y,Z,...$ and morphisms $f,g,h,...$, such that:
    - Each morphism has a specified domain and codomain among the collection of objects
    - Each object has a designated identity morphism
    - For any composable pair of morphisms $g,f$ there exists a composite morphism $g f$ whose domain is equal to the domain of $f$ and whose codomain is equal to the codomain of $g$
  ],
  [Subcategory],
  [Subcollection of objects and morphisms of a category, such that it contains the domain and codomain of any morphism, the identity morphism of any object and the composite of any composable pair of morphisms in the subcategory],
  [Small category],
  [A category is small if it has only a set's worth of arrows],
  [Locally small category],
  [A category is locally small if between any pair of objects there is only a set's worth of morphisms],
  [Hom-set],
  [Set of arrows between a pair of fixed objects in a locally small category],
  [Discrete Category],
  [Every morphism is an identity],
  [Slice category],
  [],
)
Groupoids
#deftbl(
  [Groupoid],
  [A category in which every morphism is an isomorphism $=>$ has itself as its opposite category. Example: Discrete Category],
  [Fundamental groupoid],
  [For any space $X$, its fundamental groupoid $Pi_1 X$ is a category whose objects are the points of $X$ and whose morphisms are endpoint-preserving homotopy classes of paths],
  [Maximal groupoid],
  [The subcategory containing all of the objects and only those morphisms that are isomorphisms],
  [Comonoid],
  [],
)

==== Book club (04.03.26)

#table(
  columns: (1fr, 1fr),
  [Not commutative], [Commutative],
  diagram(
    node-stroke: none,
    spacing: (6em, 2em),
    node((0, 0), [Person], name: <p>),
    edge("->", label: [has a father]),
    node((2, 0), [Person], name: <f>),
    edge("->", label: [lives in]),
    node((2, 2), [City], name: <c>),
    edge(<p>, <c>, "->", label: [lives in]),
    edge(
      <p>,
      <c>,
      "->",
      label: align(center)[#h(5em)$!=$\ lives in $compose$ has a father],
      bend: -30deg,
      label-pos: 40%,
    ),
  ),

  diagram(
    node-stroke: none,
    spacing: (6em, 2em),
    node((0, 0), [Person], name: <p>),
    edge("->", label: align(center)[has biological\ parents]),
    node((2, 0), [Pair\ $(w,m)$], name: <f>),
    edge("->", label: [pick $w$]),
    node((2, 2), [Person], name: <c>),
    edge(
      <p>,
      <c>,
      "->",
      label: align(center)[has biological\ mother],
      bend: -20deg,
    ),
  ),
)

===== Let $f: x -> y$. Show that if $g,h:y arrows x$ so that $g f = 1_x$ and $f h = 1_y$ then $g = h$ and $f$ is an isomorphism.

+ #grid(
    columns: (1fr, 1fr),
    align: center,
    $
      a) f compose h & = 1_y \
      b) g compose f & = 1_x \
                   g & =^! h \
    $,
    $
      g & = g compose 1_y           && | a) \
        & = g compose (f compose h) \
        & = (g compose f) compose h && | b) \
        & = 1_x compose h \
        & = h \
    $,
  )
+

===== Let $C$ be a category. Show that the collection of isomorphisms in $C$ defines a subcategory, the maximal groupoid inside $C$

There should exist a Category $D$, such that:

- Elements in $D$: The same as in $C$
- Morphisms in $D$: The isomorphisms in $C$

All identity morphisms can be taken into $D$

Given isomorphisms $f : x -> y, g : y -> z$, show that $g compose f$ is isomorph.

// TODO diagram
#grid(
  columns: (1fr, 1fr, 1fr),
  diagram(
    node-shape: fletcher.shapes.circle,
    spacing: (2em, 2em),
    node((1, -1), $C$, name: <C>, stroke: none),
    node((0, 0), $x$, name: <x>),
    edge(<x>, <y>, "->", label: $f$),
    edge(<x>, <y>, "<-", label: $f^(-1)$, bend: 40deg),
    node((2, 0), $y$, name: <y>),
    edge(<y>, <z>, "->", label: $g$),
    edge(<y>, <z>, "<-", label: $g^(-1)$, bend: 40deg),
    node((1, 2), $z$, name: <z>),
    node(enclose: (<x>, <y>, <z>, <C>), shape: fletcher.shapes.pill),
    edge(<x>, <z>, "->", label: $g compose f$),
  ),

  $
        & (g compose f)^(-1) = f^(-1) compose g^(-1) \
    <=> & (g compose f)^(-1) compose (g compose f) = 1_x \
    <=> & (g^(-1) compose f^(-1)) compose (g compose f) = 1_x \
    <=> & g^(-1) (compose f^(-1) compose g) compose f = 1_x \
    <=> & g^(-1) compose 1_y compose f = 1_x \
    <=> & g^(-1) compose f = 1_x \
    <=> & 1_x = 1_x \
  $,
  $
        & (g compose f) compose (g compose f)^(-1) = 1_z \
    <=> & g compose f compose f^(-1) compose g^(-1) = 1_z \
    <=> & g compose 1_y compose g^(-1) = 1_z \
    <=> & g compose g^(-1) = 1_z \
    <=> & 1_z = 1_z \
  $,
)

=== Duality

#deftbl(
  [Duality],
  [],
  [Opposite Category],
  [An opposite category of $C$, called $C^op$, has the same objects as $C$ and a morphism $f^op$ for each morphism $f$ in $C$ so that the domain of $f^op$ is defined to be the codomain of $f$ and the codomain of $f^op$ is defined to be the domain of $f$
  ],
  [Composable],
  [],
  [Postcomposition],
  [$f_* : C(c,x) -> C(c,y), c in C$],
  [Precomposition],
  [$f^* : underbrace(C(y,c), "Set of morphisms /"\ "\"higher order morphisms\"") -> C(x,c), c in C$],
  [Monomorphism],
  [],
  [Epimorphism],
  [],
  [Supremum],
  [],
  [Infimum],
  [],
  [section/right inverse],
  [],
  [retraction/left inverse],
  [],
  [retract],
  [],
  [split morphism],
  [],
)

==== Book club (11.03.26)

===== Ex 1

#grid(
  columns: 4,
  diagram(
    node-shape: fletcher.shapes.circle,
    node((0, 0), $1$, name: <x>),
    edge(label: $"take" 1$, "-|>", bend: 20deg),
    edge(label: $1_({1,2})$, "-|>", bend: -20deg),
    node((5, 0), ${1,2}$, name: <y>),
    edge(label: $+1$, bend: 20deg, "-|>"),
    edge(label: $times 2$, bend: -20deg, "-|>"),
    node((8, 0), $NN$, name: <z>),
  ),
  $
    +1 compose "take" 1 = 2 \
    times 1 compose "take" 1 = 2 \
    => "not an Epimorphism!"
  $,
)

#grid(
  columns: 2,
  diagram(
    node-shape: fletcher.shapes.circle,
    node((0, 0), $x$, name: <x>),
    edge(label: $f$, "-|>"),
    node((3, 0), $y$, name: <y>),
    edge(label: $h$, bend: 20deg, "-|>"),
    edge(label: $g$, bend: -20deg, "-|>"),
    node((6, 0), $z$, name: <z>),
  ),
  [
    $f$ is an epimorphism if $forall h,g . h compose f = g compose f => h = g$
  ],
)

===== Ex 2

#grid(
  columns: 2,
  diagram(
    node-shape: fletcher.shapes.circle,
    node((0, 0), $x$, name: <x>),
    edge(label: $h$, bend: 20deg, "-|>"),
    edge(label: $g$, bend: -20deg, "-|>"),
    node((3, 0), $y$, name: <y>),
    edge(label: $f$, "-|>"),
    node((6, 0), $z$, name: <z>),
  ),
  [
    $f$ is a monomoprhism if $forall h,g . f compose h = f compose g => h = g$
  ],
)

==== Book club (18.03.26)

===== Lemma 1.2.3

$#tp($C(c,x)$) #td($C(c,y)$)$
#diagram(
  node-stroke: none,
  spacing: (6em, 6em),
  node((0, 0), $C$, name: <C>),
  node((1, 1), $c$, name: <c>),
  node((0, 2), $x$, name: <x>),
  edge(<x>, <y>, "->", label: $f$),
  edge(<y>, <x>, "->", label: $g$, bend: 20deg),
  node((2, 2), $y$, name: <y>),
  node(
    enclose: (<c>, <x>, <y>),
    shape: fletcher.shapes.pill,
    stroke: 1pt,
    inset: 2em,
  ),
  edge(<c>, <x>, "->", stroke: colors.purple, label: $h$, bend: -20deg),
  edge(<c>, <x>, "->", stroke: colors.purple),
  edge(<c>, <x>, "->", stroke: colors.purple, bend: 20deg),
  edge(<c>, <y>, "->", stroke: colors.darkblue, label: $k$, bend: -20deg),
  edge(<c>, <y>, "->", stroke: colors.darkblue),
  edge(<c>, <y>, "->", stroke: colors.darkblue, bend: 20deg),
  edge((0.5, 1.5), (1.5, 1.5), "->", label: $f_*$),
  edge((0.5, 1.75), (1.5, 1.75), "<-", label: $g_*$),
)

$
  (i) => (i i) \
  (1) cases(f_*(h) := f compose h, f_* : h |-> f compose h) \
  (2) cases(g_*(k) := g compose k, g_* : k |-> g compose k) \
  cases(
    reverse: #true,
    g_* (f_* (h)) =^((1)) g_* (g compose h) =^((2)) underbrace(g compose f, (i) => 1_x) compose h =^((i)) h,
    f_* (g_* (k)) =^((2)) f_* (g compose k) =^((1)) underbrace(f compose g, (i) => 1_y) compose k =^((i)) k
  ) g_* = (f_*)^(-1)\
$

===== Split morphisms

#diagram()

// ===== Ex 3 / Proof
//
// #grid(
//   columns: 2,
//   diagram(
//     node-shape: fletcher.shapes.circle,
//     node((0, 0), $x$, name: <x>),
//     edge(label: $h$, bend: 20deg, "-|>"),
//     edge(label: $g$, bend: -20deg, "-|>"),
//     node((3, 0), $y$, name: <y>),
//     edge(label: $f$, "-|>", bend: 20deg),
//     edge(label: $f'$, "<|-", bend: -20deg),
//     node((6, 0), $z$, name: <z>),
//     edge(label: $j$, bend: 20deg, "-|>"),
//     edge(label: $k$, bend: -20deg, "-|>"),
//     node((9, 0), $a$, name: <y>),
//   ),
//   [
//   ],
// )
// If $f$ is an epimorphism as well as a monomorphism, show that it need not be an isomorphism.
// $
//   1) & forall h,g . f compose h = f compose g => h = g \
//   2) & forall h,g . j compose f = k compose f => j = k \
//      & f compose f' =^! 1_z and f' compose f =^! 1_y
// $
// Example:
//
// #grid(
//   columns: 2,
//   diagram(
//     node-shape: fletcher.shapes.circle,
//     node((0, 0), $X$, name: <x>),
//     edge(label: $h$, bend: 20deg, "-|>"),
//     edge(label: $g$, bend: -20deg, "-|>"),
//     node((3, 0), $ZZ_2$, name: <y>),
//     edge(label: $f$, "-|>", bend: 20deg),
//     edge(label: $f'$, "<|-", bend: -20deg),
//     node((6, 0), $ZZ_3$, name: <z>),
//     edge(label: $j$, bend: 20deg, "-|>"),
//     edge(label: $k$, bend: -20deg, "-|>"),
//     node((9, 0), $ZZ_4$, name: <y>),
//   ),
//   [
//   ],
// )
// $
//       & ZZ_3 arrow.r.hook^f ZZ_2 \
//       & f : cases(ZZ_3 &-> ZZ_2, 0 &|-> 0, 1&|-> 1, 2&|-> 0) \
//       & forall h,g . f compose h = f compose g => h = g \
//   <=> & forall h,g . h != g => f compose h != f compose g \
//       & h = g => forall w in X . h(w) = g(w) \
//       & f compose h = f compose g => forall w in X . (f compose h)(w) = (f compose g)(w) \
// $


//
// = Heapless Functional Programming - Ellis Kesterton, Edwin Brady
//
// = SONiC / FRR
//
// = Compilers: Principles, Techniques & Tools - Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman
