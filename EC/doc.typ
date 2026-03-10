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
\
$arrow.r.hook$ Inclusion ?\
$->>$ Surjective homomorphism ?\

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
  [A morphism $f: X -> Y$ for which there exists a morphism $g: Y->X$ so that $g f = 1_X and f g = 1_Y$],
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
  [A category in which every morphism is an isomorphism],
  [Fundamental groupoid],
  [For any space $X$, its fundamental groupoid $Pi_1 X$ is a category whose objects are the points of $X$ and whose morphisms are endpoint-preserving homotopy classes of paths],
  [Maximal groupoid],
  [The subcategory containing all of the objects and only those morphisms that are isomorphisms],
  [Comonoid],
  [],
)

=== Exercises

==== Let $f: x -> y$. Show that if $g,h:y arrows x$ so that $g f = 1_x$ and $f h = 1_y$ then $g = h$ and $f$ is an isomorphism.

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

==== Let $C$ be a category. Show that the collection of isomorphisms in $C$ defines a subcategory, the maximal groupoid inside $C$

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
  // TODO: for z
  $
    & (g compose f) compose (g compose f)^(-1) = 1_z \
    // <=> &(g^(-1) compose f^(-1)) compose (g compose f) = 1_x \
    // <=> &g^(-1) (compose f^(-1) compose g) compose f = 1_x \
    // <=> &g^(-1) compose 1_y compose f = 1_x \
    // <=> &g^(-1) compose f = 1_x \
    // <=> &1_x = 1_x \
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
  [Post-composition],
  [],
  [Pre-composition],
  [],
  [Supremum],
  [],
  [Infimum],
  [],
)






//
// = Heapless Functional Programming - Ellis Kesterton, Edwin Brady
//
// = SONiC / FRR
//
// = Compilers: Principles, Techniques & Tools - Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman
