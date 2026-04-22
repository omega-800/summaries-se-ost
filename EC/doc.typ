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

#grid(
  columns: 2,
  diagram(
    node-stroke: none,
    spacing: (6em, 6em),
    node((1, 0.5), $C$, name: <C>),
    node((0.5, 1), tp($C(c,x)$)),
    node((1.5, 1), td($C(c,y)$)),
    node((1, 1), $c$, name: <c>),
    node((0, 2), $x$, name: <x>),
    edge(<x>, <y>, "->", label: $f$),
    edge(<y>, <x>, "->", label: $g$, bend: 20deg),
    node((2, 2), $y$, name: <y>),
    node(
      enclose: (<c>, <x>, (2, 1)),
      shape: fletcher.shapes.pill,
      stroke: 1pt,
      inset: 4em,
    ),
    edge(
      <c>,
      (0.5, 0.5),
      (-0.5, 2),
      (0, 2.5),
      (1.5, 2.5),
      <y>,
      "->",
      label: $f compose h$,
      corner-radius: 30pt,
      label-pos: 75%,
    ),
    edge(<c>, <x>, "->", stroke: colors.purple, label: $h$, bend: -20deg),
    edge(<c>, <x>, "->", stroke: colors.purple),
    edge(<c>, <x>, "->", stroke: colors.purple, bend: 20deg),
    edge(<c>, <y>, "->", stroke: colors.darkblue, bend: -20deg),
    edge(<c>, <y>, "->", stroke: colors.darkblue),
    edge(<c>, <y>, "->", stroke: colors.darkblue, label: $k$, bend: 20deg),
    node((1, 1.45), $f_*$, shape: (..) => cntopo.arrow(
      (0, 0),
      (1.5, 1),
      stroke: 1pt + gradient.linear(colors.purple, colors.darkblue),
      ratio-width: 1 / 2,
    )),
    node((1, 1.75), $g_*$, shape: (..) => cntopo.arrow(
      (0, 0),
      (3, 1),
      stroke: 1pt + gradient.linear(colors.purple, colors.darkblue),
      ratio-width: 1 / 2,
      ratio-len: 8 / 10,
      dir: rtl,
    )),
  ),
  $
    & (i) =>^! (i i) \
    & (1) space cases(f_*(h) &:= f compose h, f_* : h &|-> f compose h) \
    & (2) space cases(g_*(k) &:= g compose k, g_* : k &|-> g compose k) \
    & cases(
        reverse: #true,
        g_* (f_* (h)) =^((1)) &g_* (g compose h) =^((2)) &underbrace(g compose f, (i) => 1_x) compose h =^((i)) h,
        f_* (g_* (k)) =^((2)) &f_* (g compose k) =^((1)) &underbrace(f compose g, (i) => 1_y) compose k =^((i)) k
      ) g_* = (f_*)^(-1) \
  $,
)

#grid(
  columns: 2,
  todo[],
  $
    & (i i) =>^! (i) \
    & g_* = f_*^(-1)
  $,
)

===== Split morphisms

#let grd = gradient.linear(colors.purple, colors.darkblue, angle: 90deg)
#grid(
  columns: 3,
  align: center + horizon,
  diagram(
    node-stroke: none,
    spacing: (8em, 1em),
    node((0, 0), $x$, name: <x>),
    node((1, 0), $y$, name: <y>),
    edge(
      <x>,
      <x>,
      "-|>",
      label: text(fill: grd)[$r compose s = 1_x$],
      bend: 145deg,
      loop-angle: 0deg,
      label-side: left,
      stroke: grd,
    ),
    edge(
      <x>,
      <y>,
      "-|>",
      label: tp[$s$],
      bend: 75deg,
      label-side: right,
      stroke: colors.purple,
    ),
    edge(
      <y>,
      <x>,
      "-|>",
      label: td[$r$],
      bend: 75deg,
      label-side: right,
      stroke: colors.darkblue,
    ),
  ),
  {
    let ndot = node.with(
      width: .5em,
      height: .5em,
      shape: fletcher.shapes.circle,
      fill: colors.fg,
    )
    diagram(
      spacing: (4em, 2em),
      node((0, .5), $x$, stroke: none),
      node((2, 0), $y$, stroke: none),
      node((.75, 0.5), tp[$s$], stroke: none),
      node((1.25, 3.5), td[$r$], stroke: none),

      ndot((0, 1.5), " ", name: <x1>),
      ndot((0, 2.5), " ", name: <x2>),

      ndot((2, 1), " ", name: <y1>),
      ndot((2, 2), " ", name: <y2>),
      ndot((2, 3), " ", name: <y3>),

      edge(<x1>, <y1>, "-|>", bend: 20deg, stroke: colors.purple),
      edge(<y1>, <x1>, "-|>", bend: 20deg, stroke: colors.darkblue),
      edge(<x2>, <y2>, "-|>", bend: 20deg, stroke: colors.purple),
      edge(<y2>, <x2>, "-|>", bend: 20deg, stroke: colors.darkblue),
      edge(<y3>, <x2>, "-|>", bend: 20deg, stroke: colors.darkblue),

      node(enclose: (<x1>, <x2>), shape: fletcher.shapes.pill, inset: 2em),
      node(
        enclose: (<y1>, <y2>, <y3>),
        shape: fletcher.shapes.pill,
        inset: 2em,
      ),
      node(
        enclose: ((.75, 0.5), (.75, 2.25)),
        shape: fletcher.shapes.pill,
        stroke: colors.purple,
        inset: 0pt,
      ),
      node(
        enclose: ((1.25, 1), (1.25, 3.5)),
        shape: fletcher.shapes.pill,
        stroke: colors.darkblue,
        inset: 0pt,
      ),
    )
  },
  [
    $
         & x tp(->^s) y td(->^r) x and td(r) compose tp(s) = 1_x \
      => & tp(s) "is split monomorphism" \
         & "(section/right inverse to" td(r) ")" \
      => & td(r) "is split epimorphism" \
         & "(retraction/left inverse to" tp(s) ")" \
    $

    NOTE: that doesn't mean that $s compose r = 1_y$. If so, then they would be isomorph.
  ],
)

===== Exercises

1.2.i.

Goals:
$
  (1) space &C\/c tilde.equiv (c\/(C^op))^op \
  (2) space &exists underbrace(c\/C, C "under" c) => exists underbrace(C\/c, C "over" c) \
$

1.2.ii

$
  (i) space & "monic" f : x >-> y and g : y >-> z => g f : x >-> z \
  & f : x -> y => h,k : w arrows x, underline(f compose h = h compose k =>^! h = k) \
  & (g compose f) compose h = (g compose f) compose k =>^! h = k \
  <=>& g compose (f compose h) = g compose (f compose k) => h = k\
  <=>& cancel(g compose) (f compose h) = cancel(g compose) (f compose k) => h = k && g "monic"\
  <=>& cancel(f compose) h = cancel(f compose) k => h = k && f "monic"\
  <=>& h = k => k = k \
  (i ') space & "(dually)" \
  (i i) space & "monic" g compose f, f \
  &f compose h = f compose k =>^! h = k \
  <=>&g compose (f compose h) = g compose (f compose k) => h = k \
  <=>&cancel((g compose f)) compose h = cancel((g compose f)) compose k => h = k && g compose f "monic"\
  <=>&h = k => h = k \
  (i i ') space & "(dually)" \
  // &h compose f = k compose g => h = k
$

==== Book club (01.04.26)

1.2.iii

Fields are sets $F$ with Operations $+,-,times,div$

https://abuseofnotation.github.io/category-theory-illustrated/02_category/

==== Book club (15.04.26)

1.2.vi

#diagram(
  node-stroke: none,
  spacing: (8em, 4em),

  node((0, 0), $y$, name: <y>),
  node((1, 0), $x$, name: <x>),
  node((2, 0), $z$, name: <z>),

  edge(<x>, <x>, label: $r s = 1_x$),
  edge(<y>, <x>, label: $r$),
  edge(<x>, <y>, label: $s$),
  edge(<x>, <z>, label: $h$),
  edge(<x>, <z>, label: $k$),
)

$
  overbrace(r s = 1_x, "Premisse") =>^?
  &overbrace(forall h"," k (h r = k r => h = k), "To be shown") \
  &forall h,k (h r = k r => h r s = k r s => h 1_x = k 1_x => h = k)
$

Dual:

$$

==== Bool club (22.04.26)

1.2.v

(i)

(ii) Let $f^*: C(y,c) -> C(x,c)$ be surjective $forall c in C$. Show that only then
$f:x->y$ is a split monomorphism in the category $C$.

$
  k = h compose f \
$

#diagram(
  node-stroke: none,
  spacing: (4em, 6em),
  node((1, 0), $c$, name: <c>),
  node((2, 1), $x$, name: <x>),
  node((0, 1), $y$, name: <y>),

  edge(<x>, <c>, "->", stroke: colors.darkblue),
  edge(<x>, <c>, "->", stroke: colors.darkblue, bend: -20deg, label: $k$),

  edge(<y>, <c>, "->", stroke: colors.purple),
  edge(<y>, <c>, "->", stroke: colors.purple, bend: 20deg),
  edge(<y>, <c>, "->", stroke: colors.purple, bend: 40deg, label: $h$),

  edge(<x>, <y>, "->", label: $f$, label-side: left, bend: -40deg),
  edge(<y>, <x>, "->", label: $g$, label-side: right, bend: -40deg),
  edge(
    <x>,
    <x>,
    "<-",
    label: $g compose f$,
    bend: 130deg,
    label-side: left,
    loop-angle: 180deg,
  ),

  node((1, .35), $f^*$, shape: (..) => cntopo.arrow(
    (0, 0),
    (1.5, 1),
    stroke: 1pt + gradient.linear(colors.purple, colors.darkblue),
    ratio-width: 1 / 2,
  )),
)

#pagebreak()

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

= OSDEV

useful links & cool projects

#link("https://osdev.wiki/wiki/Expanded_Main_Page", "OSDev wiki"),
#link("http://www.osdever.net/tutorials/", "osdever.net"),
#link("https://youtu.be/oH41gGBVpkE", "it's good to be king"),
#link("http://9front.org/", "9front (Plan 9)"),
#link("https://mirage.io/", "mirageOS"),
#link("https://100r.co/site/uxn.html", "Uxn"),
#link("https://sel4.systems/", "seL4"),

== Kernel

=== Memory

/ Paging: Memory gets subdivided into fixed-size blocks called *pages*.
/ Segmentation: Memory gets subdivided into variable-sized segments based on logical units such as functions, arrays, or data structures
/ Virtual memory: Exposing a virtual continuous block of memory to user-level applications which gets is to the underlying separate physical parts
/ DMA: Direct Memory Access

=== Processes

==== Inter Process Communication (IPC)

/ Shared memory: Processes can use shared memory for extracting information as a record from another process as well as for delivering any specific information to other processes
/ Message passing: Processes communicate by sending and receiving messages to exchange data. Message Passing can be achieved through different methods like Sockets, Message Queues or Pipes

/ Gates:
/ IPC ports:

===== Multithreading/Synchronization

/ Synchronization: Maintaining the consistency of shared data even when multiple processes/threads are executed simultaneously.
/ Critical region: A region of memory shared by 2 or more processes
/ Lock: A variable whose value allows or denies the entrance to a critical region
/ Semaphore: A technique used to manage concurrent processes accessing a critical region by using a lock
/ Counting Semaphore (Semaphore): Allows access of a critical region to a group of processes
/ Binary Semaphore (Mutex): Allows access of a critical region to one process
/ Busy waiting: Continuously testing of a variable until some value appears
/ Spinlock: A lock which uses busy waiting

===== Multitasking

/ Round Robin: Processes are put inito a circular queue and executed sequentially
/ Priority scheduling algorithm: Each process is allocated a priority and the process with the highest priority is executed first

=== Syscalls

=== CPU

/ Interrupts: Signals that prompt the processor to temporarily halt its current tasks to address an event
/ IRQ: Interrupt Request
/ ISR: Interrupt Service Routine

==== x86

/ GDT: Global Descriptor Table
/ IDT: Interrupt Descriptor Table

=== Filesystem

=== Hardware

==== Device drivers
