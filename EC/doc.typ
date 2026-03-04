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

== Chapter 1

#deftbl(
  [Commutativity],
  [],
  [Group],
  [],
  [Group extension],
  [],
  [Abelian group],
  [],
  [Abelian extension],
  [],
  [Homomorphism],
  [],
  [Isomorphism],
  [],
  [],
  [],
  [],
  [],
  [Subcategory],
  [],
  [Groupoid],
  [],
  [Fundamental groupoid],
  [],
  [Maximal groupoid],
  [],
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
    node((0, 0), $x$, name: <x>),
    edge("->", label: $f$),
    edge("<-", label: $f^(-1)$, bend: 40deg),
    node((2, 0), $y$, name: <y>),
    edge("->", label: $g$),
    edge("<-", label: $g^(-1)$),
    node((1, 2), $z$, name: <z>),
    node(enclose: (<x>, <y>, <z>), "C"),
    edge(<x>, <z>, label: $g compose f$),
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
    <=> & (g compose f) compose (g compose f)^(-1) = 1_z \
    // <=> &(g^(-1) compose f^(-1)) compose (g compose f) = 1_x \
    // <=> &g^(-1) (compose f^(-1) compose g) compose f = 1_x \
    // <=> &g^(-1) compose 1_y compose f = 1_x \
    // <=> &g^(-1) compose f = 1_x \
    // <=> &1_x = 1_x \
  $,
)

== Book club

=== 26.03.04

#pagebreak()

= Heapless Functional Programming - Ellis Kesterton, Edwin Brady

= SONiC / FRR

= Compilers: Principles, Techniques & Tools - Alfred V. Aho, Monica S. Lam, Ravi Sethi, Jeffrey D. Ullman
