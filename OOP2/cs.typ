#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

// TODO: add to overrides
#let plot = lq.plot.with(mark: none)

= Generics
```java
// class
class Box<T> { }
// variable
Box<String> b = new Box<String>();
// method
public <T> void doStuff(T value) { }
```
== Java being stupid
```java
T obj = new T();          // error
obj instanceof T;         // error
T heh = (T) "asdf";       // no typechecking
var s = Stack<int>();     // no primitive types
private static T x;       // static no workey
Node<Number> s = new Node<Integer>; // error
class IThrowAnErrorBecauseWhyNot {
  void m(List<String> list) { }
  void m(List<Integer> list) { }
} // error because of type erasure & identifiability
```
== Iterator
```java
for (String s : stringList) { } // ==
for (Iterator<String> i = stringList.iterator();
    i.hasNext();) {
  String s = i.next();
}
```
=== Iterable
```java
interface Iterable<T> {
  Iterator<T> iterator();
}
interface Iterator<E> {
  boolean hasNext();
  E next();
}
```
== Comparable
#todo("Type signature?")
```java
static <T extends Comparable> T doStuff(T a, T b) {
  // compareTo is possible with all types
  return a.compareTo("b") > 0 ? a : b;
}
static <T extends Comparable<T>> T doStuff(T a, T b) {
  // compareTo is possible only with T
  return a.compareTo(b) > 0 ? a : b;
}
```
== Example
```java
class Graphic {
  public void draw() { }
}
class Rectangle extends Graphic { }
class Circle extends Graphic { }
class GraphicStack<T extends Graphic>
    extends Stack<T> {
  public void drawAll() {
    for (T item : this) item.draw();
  }
}
```
== Bytecode
#todo("")
== Type Erasure
- Introduced because of "bAcKwArDs CoMpAtAbIlItY"
- No type information at runtime (Non-Reifiable Type)
```java
class MyStack<T> {
  Entry<T> top;
  int push(T value) { }
}
// becomes
class MyStack {
  Entry top;
  int push(Object value) { }
}
/* with bounds */
class MyStack<T extends Comparable<T>> {
  Entry<T> top;
  int push(T value) { }
}
// becomes
class MyStack {
  Entry top;
  int push(Comparable value) { }
}
/* what happens at/before runtime */
MyStack<String> s = new MyStack<String>();
s.push("Eh");
String x = s.pop();
// becomes
MyStack s = new MyStack();
s.push("Eh");
String x = (String) s.pop();
```
== Wildcards
```java
void printGs(List<Graphic> gs) { }
List<Graphic> gs1 = new ArrayList<>();
printGs(gs1);   // ok
List<Circle> gs2 = new ArrayList<>();
printGs(gs2);   // error
/* solution */
void printGs(List<? extends Graphic> gs) { }
```
== Generic variance
#table(
  columns: (auto, 1fr, auto, auto, auto),
  table-header([], [Type], [Compatible\ Type-Args], [R], [W]),
  [Invariance],
  ```java C<T>```,
  ```java T```,
  cg,

  cg, [Covariance], ```java C<? extends T>```, [```java T``` and sub-types], cg,
  cr,
  [Contravariance],
  ```java C<? super T>```,
  [```java T``` and basis-types],
  cr,

  cg,

  [Bivariance], ```java C<?>```, [All], cr, cr,
)
=== Invariance
```java
static <T> void move(Stack<T>, from, Stack<T> to) {
  while(!from.isEmpty()) to.push(from.pop());
}
var rectS = new Stack<Rectangle>();
var graphS = new Stack<Graphic>();
graphS.push(new Rectangle());         // ok
move(rectS, graphS);                  // error
Stack<Object> objS = graphS;          // error
/* anotherone */
String[] strA = new String[10];
Object[] objA = strA;                 // ok
objA[0] = Integer.valueOf(2);         // runtime err
```
#todo(```java
// compiles?
List<Graphic> list = new ArrayList<Rectangle>();
// compiles?
Rectangle[] rectangleStack = new Rectangle[10];
Graphic[] graphicStack = new Graphic[10];
graphicStack = rectangleStack;
// compiles?
Stack<Rectangle> rectangleStack = new Stack<>();
Stack<Graphic> graphicStack = new Stack<>();
graphicStack = rectangleStack;
// compiles?
Stack<Rectangle> rectangleStack = new Stack<>();
Stack<Graphic> graphicStack = new Stack<>();
for (Rectangle r : rectangleStack) {
  graphicStack.push(r);
}
```)
=== Covariance
```java
public class Stack<E> {
  public void pushAll(Iterable<? extends E> src) { }
}
Stack<? extends Graphic> graphS;
graphS = new Stack<Rectangle>();    // ok
graphS = new Stack<Circle>();       // ok
graphS = new Stack<Object>();       // error (duh)
/* read only */
Stack<? extends Graphic> stack = new
  Stack<Rectangle>();
stack.push(new Graphic());          // error
stack.push(new Rectangle());        // error
stack.push(new Triangle());         // error
```
=== Contravariance
```java
static <T> void addToC(List<? super T> list, T e) {
    list.add(e);
}
addToC(new ArrayList<Number>(), 3); // ok
addToC(new ArrayList<Object>(), 3); // ok
/* shenanigans */
Stack<? super Graphic> s = new Stack<Object>();
s.add(new Graphic());               // ok
s.add(new Rectangle());             // ok
Graphic g = s.pop();                // error
Object g = s.pop();                 // ok
```
=== Bivariance
```java
static void printList(List<?> list) {
  for (Object elem : list)
    System.out.print(elem + " ");
}
/* more shenanigans */
static void appendNewObject(List<?> list) {
  list.add(new Object());           // error
}
```
= Producer / Consumer
#todo("")
= Misc
```java
<T extends Comparable & Collection> // multiple type bounds
```

= Generics stream tomfoolery
```java
List<? extends Media> mediaList;
public <S extends T> List<S>
  filterBySubtype(Class<S> subtype) {
    return mediaList.stream()
            .filter(subtype::isInstance)
            .map(subtype::cast)
            .collect(Collectors.toList());
}
```
= Annotations
- Metadata
- Not actually part of the code
#todo("slides 10")
- \@Override
- \@Test
- \@Json...
== Defining
```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Author {
  String name();
  String date() default "N/A";
}

@Author(name = "UwU", date = "idon'tvalidateinput")
public class WeeOoo { }
```
== Reflection

- Information of Class (private and public): Methods, Attributes, Parent class, Implemented interfaces
- Calling methods possible
- Usages: Debugger, Serialization, Frameworks, Remote Procedure Call, ORM
```java
// all of these `throws SecurityException`
public Field[] getDeclaredFields()
public Method[] getDeclaredMethods()
public Constructor<?>[] getDeclaredConstructors()

System.out.println(dump(new Student("a", "b"), 0));
// {
//   firstName = a
//   lastName = b
// }
Class c = "s".getClass(); // java.lang.String
```
#todo("Diagram (slides 26)")
== Method
```java
// @Target(ElementType.METHOD)

public String getName()
public boolean isAnnotationPresent(
  Class<? extends Annotation> annotationClass)
public Object invoke(Object obj, Object... args)
  throws IllegalAccessException,
         IllegalArgumentException,
         InvocationTargetException

public class Profiler {
  public static void main(String[] args) {
    var testFunctions = new ProfileFunctions();
    int[] array = {5, 2, 8, 1, 93, 3, 33, 1, 333};
    var methods = ProfileFunctions.class
                    .getDeclaredMethods();
    for (var m : methods) {
      if(m.isAnnotationPresent(Profile.class)) {
        m.setAccessible(true); // best practice or sth, idk, i write code in actually good languages
        Profiler.profileMethod(testFunctions, m,
          new Object[] {array});
      }
    }
  }
}
```
== Class
#todo("")
```java
// @Target(ElementType.TYPE)

getDeclaredConstructor().newInstance()
...
```
== Attribute
#todo("")
```java
// @Target(ElementType.FIELD)

...
```
== Validation
```java
@Min(value = 18, message = "Age must be >= 18")
@Max(value = 99, message = "Age must be <= 99")
private int age;
@NotNull(message = "Name cannot be null")
private String name;
```
= Algorithms

- Brute-force
- Greedy
  - Take best option each step (optimize locally)
  - Fast
- Backtracking
  - Trial and error
  - Best overall option
  - Higher compute costs
- Divide and conquer
  - Binary search
- Dynamic programming
  - Recursion optimization?
  - Tabulation

== Backtracking

#todo[slides 87]

== Big O Notation
- Worst case scenario
- Atomic operations = constant time
- Runtime measured as sum of primitive operations
#let n = text(fill: colors.yellow)[$n$]
#let n0 = text(fill: colors.green)[$n_0$]
#let c = text(fill: colors.red)[$c$]
#let g = text(fill: colors.purple)[$g$]
#let f = text(fill: colors.darkblue)[$f$]
Notation
$
  overbrace(#f, "Algorithm")(underbrace(#n, "Size of problem")) = "Number of steps"
$
$#g =$ complexity class
#todo([diagram $f <= c g$])
#let xs = lq.linspace(0, 10).slice(1)
#diagram2d(
  width: 100%,
  legend: (position: center + top),
  lq.line((4.5, 20), (4.5, 0), stroke: (paint: colors.green, dash: "dashed")),
  lq.place(4.5, -5, align(center + horizon, n0)),
  plot(xs, xs.map(x => x * x / 2 + 10), label: $#f (#n)$),
  plot(xs, xs.map(x => x * x), label: $#c #g (#n)$),
)
$
  #f (#n) "is" O(#g (#n)) "if" #c > 0 and #n0 >= 1 \
  #f (#n) <= #c #g (#n) "for" #n >= #n0
$
#f in order #g:
$
  "Let" #f,#g:NN->NN \
  #n0, #c in NN and forall #n >= #n0: #f (#n) <= #c dot #g (#n)\ => #f in O(#g)
  <=> #f = O(#g)
$
Big $O$
$
  overbrace(O, "Big O")(underbrace(#n, "Size of problem")) = "Complexity class"
$
=== Rules
If $#f (#n)$ is polynomial of degree $d$, then $#f (#n) in O(#n^d)$
- ignore lower powers
- ignore constants
Use most optimal function (lowest power)
- $2 #n$ is $O(#n)$ better than $2#n$ is $O(#n^2)$
Simplify as far as possible
- $3 #n + 5$ is $O(#n)$ instead of $3#n + 5$ is $O(3#n)$
=== Complexity classes
#table(
  columns: (auto, auto, 1fr),
  table-header([Name], [Class], [Example]), emph[Constant], $1$,
  [Array read], emph[Logarithmic], $log n$,
  [Binary search], emph[Linear], $n$,
  [Linear search], emph[Log-linear], $n log n$,
  [Merge+Quick sort], emph[Quadratic], $n^2$,
  [Bubble+Insertion sort], emph[Cubic], $n^3$,
  [Solve equation], emph[Polynomial], $n^k$,
  [Various algorithms], emph[Exponential], $2^n$,
  [Calculate all subsets], emph[Factorial], $n!$,
  [Calculate all permutations],
)
#let xs = lq.linspace(0, 20).slice(1)
#diagram2d(
  width: 100%,
  ylim: (0, 100),
  legend: (position: right + top, inset: 0pt, pad: 0pt),
  plot(xs, xs.map(_ => 1), label: $O(1)$),
  plot(xs, xs.map(calc.log), label: $O(log n)$),
  plot(xs, xs, label: $O(n)$),
  plot(xs, xs.map(x => x * calc.log(x)), label: $O(n log n)$),
  plot(xs, xs.map(x => calc.pow(x, 2)), label: $O(n^2)$),
  plot(xs, xs.map(x => calc.pow(x, 3)), label: $O(n^3)$),
  plot(xs, xs.map(x => calc.pow(2, x)), label: $O(2^n)$),
  // plot(xs, xs.map(x => calc.pow(x, 2)/2 + 2 * x + 5), label: $f(n) = 0.5n^2 + 2n + 5$),
)
#todo("Counting primitive operations (slides 55)")

== Sorting algorithms

=== Selection sort

- Search for smallest elem in unsorted part and move in front
- Less mutations in array
- Same performance even if list almost sorted

```java
public static void selectionSort(int[] a) {
    int n = a.length;
    for (int i = 0; i < n - 1; i++) {
        int minimum = i;
        for (int j = i + 1; j < n; j++)
            if (a[j] < a[minimum])
                minimum = j;
        swap(a, i, minimum);
    }
}
```

$
  (n-1)+(n-2)+...+1 = sum_(i=1)^(n-1) i = (n(n-1))/2 = (n^2 - n)/2 ~ O(n^2)
$

=== Insertion sort

- Take elem and put into correct place in sorted part
- Good for already partially sorted arrays

```java
public static void insertionSort(int[] a) {
  int n = a.length;
  for (int i = 1; i < n; i++)
    for (int j = i; j > 0 && a[j] < a[j - 1]; j--)
      swap(a, j, j - 1);
}
```

$
  1 + ... + (n - 1) + n = sum_(i=1)^n i = (n(n+1))/2 = (n^2 + n)/2 ~ O(n^2)
$

=== Bubble sort

- Compare neighboring elems and swap if needed

```java
public static void bubbleSort(int[] a) {
  for (n = a.length; n > 1; n--)
    for (i = 0; i < n - 1; i++)
      if (a[i] > a[i + 1])
        swap(a, i, i + 1);
}
```

$
  (n - 1) + (n - 2) + ... + 1 = sum_(i=1)^(n-1) i = (n(n - 1))/2 = (n^2 - n)/2 ~ O(n^2)
$

=== Counting sort

```java
public static void countingSort(int[] a) {
  int k = Arrays.stream(arr).max().getAsInt();
  int[] c = new int[k + 1];
  for (int i : a) c[i] += 1;
  int pos = 0;
  for (int i = 0; i < k; i++)
    for (int j = 0; j < c[i]; j++) {
      a[pos] = i;
      pos++;
    }
}
```

$ n + n + k + n = 3n + k ~ O(n + k) $

=== Shell sort

- Sort pairs of far away elems
- Sort the partially sorted array through insertion sort

```java
public static void shellSort(int[] a) {
  int n = a.length;
  int h = 1;
  while (h < n/3) h = 3 * h + 1;
  while (h >= 1) {
    for (int i = h; i < n; i++)
      for (int j = i; j >= h && a[j] < a[j - h];
            j = j - h) swap(a, j, j - h);
    h /= 3;
  }
}
```
== Binary search

```java
public static <T extends Comparable<T>> boolean bs(
    List<T> data, T target, int low, int high) {
  if (low > high) return false;
  int pivot = low + ((high - low) / 2);
  if (target.equals(data.get(pivot)))
    return true;
  else if (target.compareTo(data.get(pivot)) < 0)
    return searchBinary(data, target, low,
                        pivot - 1);
  else
    return searchBinary(data, target, pivot + 1,
                        high);
}
```

$ O(log n) $

= Recursion

When a function calls itself

== Linear recursion

Recursive call starts _at most one_ further recursive call

#todo[recursive $->$ iterative (slides 61)]

== Tail recursion

Linear recursion where the recursive call is _last_

#todo[recursive $->$ iterative (slides 69 -- nice)]

== Binary recursion

All non-terminal calls have _two_ recursive calls

#todo[example (slides 76,77,78)]

#todo[$O(n)$ (slides 84)]

= Data structures

/ ADT: Abstract Data Type (e.g. Interface) #todo[diagram]

== Array

#let bnode = node.with(
  shape: fletcher.shapes.rect,
  width: 1.5em,
  height: 1.5em,
  inset: 2pt,
)
#let bedge = edge.with(marks: "-|>", stroke: .75pt)
#align(center, diagram(
  spacing: (0pt, 0pt),
  bnode((0, 0), `1`),
  bnode((1, 0), `2`),
  bnode((2, 0), `3`),
  bnode((3, 0), `4`),
))

== Linked List

#align(center, diagram(
  spacing: (2em, 0pt),
  bnode((0, 0), `1`),
  bedge(),
  bnode((1, 0), `2`),
  bedge(),
  bnode((2, 0), `3`),
  bedge(),
  bnode((3, 0), `4`),
))

== Doubly linked list

#align(center, diagram(
  spacing: (2em, .375em),
  bnode((0, 0), `1`),
  bedge(shift: 1),
  bedge(marks: "<|-", shift: -1),
  bnode((1, 0), `2`),
  bedge(shift: 1),
  bedge(marks: "<|-", shift: -1),
  bnode((2, 0), `3`),
  bedge(shift: 1),
  bedge(marks: "<|-", shift: -1),
  bnode((3, 0), `4`),
))

== Stack

- LIFO

#align(center, diagram(
  spacing: (0pt, .375em),
  bnode((0, 0), `1`),
  bnode((1, 0), `2`),
  bnode((2, 0), `3`),
  bnode((3, 0), `4`, name: <s>),
  bnode(stroke: none, (6, 0)),
  bnode(stroke: none, (5, 0)),
  bedge(<s>, (6, 0), shift: 1),
  bedge(<s>, (6, 0), marks: "<|-", shift: -1),
))

== Queue

- FIFO

#align(center, diagram(
  spacing: (0pt, 0pt),
  bnode(stroke: none, (-3, 0)),
  bnode(stroke: none, (-2, 0)),
  bedge((-3, 0), <s>, marks: "<|-"),
  bnode((0, 0), `1`, name: <s>),
  bnode((1, 0), `2`),
  bnode((2, 0), `3`),
  bnode((3, 0), `4`, name: <l>),
  bnode(stroke: none, (6, 0)),
  bnode(stroke: none, (5, 0)),
  bedge(<l>, (6, 0), marks: "<|-"),
))

== Tree

#align(center, diagram(
  spacing: (2em, 0pt),
  bnode((2, 0), `1`, name: <n1>),
  bnode((1, 1), `2`, name: <n2>),
  bnode((3, 1), `3`, name: <n3>),
  bnode((0, 2), `4`, name: <n4>),
  bnode((2, 2), `5`, name: <n5>),

  bedge(<n1>, <n2>),
  bedge(<n1>, <n3>),
  bedge(<n2>, <n4>),
  bedge(<n2>, <n5>),
))

== Ring buffer

#align(center, diagram(
  spacing: (0pt, 1em),
  node(
    (1.5, -1.25),
    width: 0em,
    block(width: 16em, $underbrace(("front" + "elems") % "cap")$),
    stroke: none,
    name: <a>,
  ),
  bnode((0, 0), `5`, name: <f>),
  bnode((1, 0), `6`),
  bnode((2, 0), `1`),
  bnode((3, 0), `2`),
  bnode((4, 0), `3`),
  bnode((5, 0), `4`, name: <l>),
  bedge(<l>, (5, 1), (0, 1), <f>),
))

== Priority Queue

#table(
  columns: (1fr, 1fr, 1fr),
  table-header([Method], [Unsorted List], [Sorted List]), `insert`, $O(1)$,
  $O(n)$, `min`, $O(n)$,
  $O(1)$, `removeMin`, $O(n)$,
  $O(1)$,
)

== Heap

- Binary tree
- Layers $0, ..., h-1$ fully populated, layer $h$ filled from left
- Operations always lowest RHS so that tree stays consistent
/ Min-Heap: Keys of nodes are *smaller* or equal than children's
/ Max-Heap: Keys of nodes are *larger* or equal than children's

#let bx = box.with(stroke: colors.fg, width: 1.5em, height: 1.5em, inset: 2pt)
#let rb = bx.with(fill: colors-l.red)
#let gb = bx.with(fill: colors-l.green)
#let ob = bx.with(fill: colors-l.orange)
#let pb = bx.with(fill: colors-l.purple)
#let bb = bx.with(fill: colors-l.darkblue)
#let pbn = bnode.with(fill: colors-l.purple)
#let gbn = bnode.with(fill: colors-l.green)
#let rbn = bnode.with(fill: colors-l.red)
#let obn = bnode.with(fill: colors-l.orange)
#let bbn = bnode.with(fill: colors-l.darkblue)
#let dbn = bnode.with(fill: colors-l.darkblue, stroke: colors.yellow)
#let ibnode = bnode.with(fill: colors-l.comment, stroke: none)
#align(center, diagram(
  spacing: (1em, 0em),
  ibnode((3, 1), `[0]`, name: <i1>),
  pbn((3, 0), [1], name: <n1>),

  ibnode((1, 3), `[1]`, name: <i3>),
  ibnode((5, 3), `[2]`, name: <i4>),
  gbn((1, 2), [3], name: <n3>),
  gbn((5, 2), [4], name: <n4>),

  ibnode((0, 5), `[3]`, name: <i5>),
  ibnode((2, 5), `[4]`, name: <i9>),
  ibnode((4, 5), `[5]`, name: <i8>),
  rbn((0, 4), [5], name: <n5>),
  rbn((2, 4), [9], name: <n9>),
  rbn((4, 4), [8], name: <n8>),

  bedge(<n1>, <n3>),
  bedge(<n1>, <n4>),

  bedge(<n3>, <n5>),
  bedge(<n3>, <n9>),
  bedge(<n4>, <n8>),

  bedge(
    <i3>,
    (-1.5, 3),
    (-1.5, 5),
    <i5>,
    label-side: right,
    label: text(
      fill: colors.purple,
      $(2 dot i) + 1$,
    ),
    stroke: colors.purple + .75pt,
  ),
  bedge(
    <i8>,
    (6, 5),
    (6, 3),
    <i4>,
    label-side: right,
    label: text(
      fill: colors.purple,
      $(i-1) div 2$,
    ),
    stroke: colors.purple + .75pt,
  ),
))

#align(center, diagram(
  spacing: (0em, 0em),

  ibnode((0, 1), `[0]`),
  ibnode((1, 1), `[1]`),
  ibnode((2, 1), `[2]`),
  ibnode((3, 1), `[3]`),
  ibnode((4, 1), `[4]`),
  ibnode((5, 1), `[5]`),

  pbn((0, 0), [1]),
  gbn((1, 0), [3]),
  gbn((2, 0), [4]),
  rbn((3, 0), [5]),
  rbn((4, 0), [9]),
  rbn((5, 0), [8]),
))

=== Enqueue

#grid(
  columns: (1fr, 1fr),
  align: center,
  diagram(
    spacing: (1em, 1em),
    pbn((1.5, 0), [1], name: <n1>),

    gbn((.5, 1), [3], name: <n3>),
    gbn((2.5, 1), [4], name: <n4>),

    rbn((0, 2), [5], name: <n5>),
    rbn((1, 2), [9], name: <n9>),
    rbn((2, 2), [8], name: <n8>),
    dbn((3, 2), [2], name: <n2>),

    bedge(<n1>, <n3>),
    bedge(<n1>, <n4>),

    bedge(<n3>, <n5>),
    bedge(<n3>, <n9>),
    bedge(<n4>, <n8>),
    bedge(<n4>, <n2>),

    bedge(
      <n2>,
      <n4>,
      label: td[$< checkmark$],
      label-side: right,
      bend: -50deg,
      stroke: .75pt + colors.darkblue,
      marks: "<|-|>",
    ),

    bedge((5, 2), <n2>, stroke: .75pt + colors.darkblue, marks: "-|>"),
  ),
  diagram(
    spacing: (1em, 1em),
    pbn((1.5, 0), [1], name: <n1>),

    gbn((.5, 1), [3], name: <n3>),
    dbn((2.5, 1), [2], name: <n4>),

    rbn((0, 2), [5], name: <n5>),
    rbn((1, 2), [9], name: <n9>),
    rbn((2, 2), [8], name: <n8>),
    rbn((3, 2), [4], name: <n2>),

    bedge(<n1>, <n3>),
    bedge(<n1>, <n4>),

    bedge(<n3>, <n5>),
    bedge(<n3>, <n9>),
    bedge(<n4>, <n8>),
    bedge(<n4>, <n2>),

    bedge(
      <n4>,
      <n1>,
      label: td[$>= crossmark$],
      label-side: right,
      bend: -50deg,
      stroke: .75pt + colors.darkblue,
      marks: "<|-|>",
    ),
  ),
)

=== Dequeue

#grid(
  columns: (1.5fr, 1fr, 1fr),
  align: center + horizon,
  diagram(
    spacing: (1em, 1em),
    bnode((1.5, 0), [ ], name: <n1>),

    gbn((.5, 1), [3], name: <n3>),
    gbn((2.5, 1), [2], name: <n4>),

    rbn((0, 2), [5], name: <n5>),
    rbn((1, 2), [9], name: <n9>),
    rbn((2, 2), [8], name: <n8>),
    rbn((3, 2), [4], name: <n2>),

    bedge(<n1>, <n3>),
    bedge(<n1>, <n4>),

    bedge(<n3>, <n5>),
    bedge(<n3>, <n9>),
    bedge(<n4>, <n8>),
    bedge(<n4>, <n2>),

    bedge(
      <n2>,
      <n1>,
      label-side: right,
      bend: -50deg,
      stroke: .75pt + colors.darkblue,
      marks: "-|>",
    ),
    bedge(
      <n1>,
      (0, 0),
      label: tp[*1*],
      label-side: center,
      stroke: .75pt + colors.darkblue,
      marks: "-|>",
    ),
  ),
  diagram(
    spacing: (1em, 1em),
    pbn((1.5, 0), [4], name: <n1>),

    gbn((.5, 1), [3], name: <n3>),
    gbn((2.5, 1), [2], name: <n4>),

    rbn((0, 2), [5], name: <n5>),
    rbn((1, 2), [9], name: <n9>),
    rbn((2, 2), [8], name: <n8>),

    bedge(<n1>, <n3>),
    bedge(<n1>, <n4>),

    bedge(<n3>, <n5>),
    bedge(<n3>, <n9>),
    bedge(<n4>, <n8>),

    bedge(
      <n4>,
      <n1>,
      label-side: right,
      label-pos: 30%,
      bend: -50deg,
      stroke: .75pt + colors.darkblue,
      label: td[$> checkmark$],
      marks: "<|-|>",
    ),
  ),
  diagram(
    spacing: (1em, 1em),
    pbn((1.5, 0), [2], name: <n1>),

    gbn((.5, 1), [3], name: <n3>),
    gbn((2.5, 1), [4], name: <n4>),

    rbn((0, 2), [5], name: <n5>),
    rbn((1, 2), [9], name: <n9>),
    rbn((2, 2), [8], name: <n8>),

    bedge(<n1>, <n3>),
    bedge(<n1>, <n4>),

    bedge(<n3>, <n5>),
    bedge(<n3>, <n9>),
    bedge(<n4>, <n8>),

    bedge(
      <n4>,
      <n8>,
      label-side: right,
      label-sep: 0pt,
      bend: -50deg,
      stroke: .75pt + colors.darkblue,
      label: td[$<= crossmark$],
      marks: "<|-|>",
    ),
  ),
)

=== Heap sort

Dequeue elems from head into list, resorting tree on each iter

#todo[]

== Binary search tree (BST)

- All subnodes of *left* subtree are *smaller* than root
- All subnodes of *right* subtree are *larger* than root

=== Traversing

#let D = rb(align(horizon + center, [D]))
#let B = gb(align(horizon + center, [B]))
#let E = ob(align(horizon + center, [E]))
#let A = pb(align(horizon + center, [A]))
#let C = bb(align(horizon + center, [C]))

#grid(
  columns: 3,
  align: horizon,
  grid.cell(rowspan: 5, {
    let node = node.with(stroke: none, width: 1em, height: 1em)
    diagram(
      rbn((2, 0), [D], name: <d>),
      gbn((1, 1), [B], name: <b>),
      obn((3, 1), [E], name: <e>),
      pbn((0, 2), [A], name: <a>),
      bbn((2, 2), [C], name: <c>),

      edge(<d>, <b>),
      edge(<d>, <e>),
      edge(<b>, <a>),
      edge(<b>, <c>),
    )
  }),
  [Preorder (W-L-R)], stack(dir: ltr, D, B, A, C, E), [Postorder (L-R-W)],
  stack(dir: ltr, A, C, B, E, D),
  [Breadth-First/\ Level-Order],
  stack(dir: ltr, D, B, E, A, C),

  [Inorder (L-W-R)], stack(dir: ltr, A, B, C, D, E),
)
#todo[]
