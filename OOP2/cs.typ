#import "../lib.typ": *

#show: cheatsheet.with(
  module: "OOP2",
  name: "Object-Oriented Programming 2",
  semester: "FS26",
  language: "en",
)

_Generics_ \
```java
// class
class Box<T> { }
// variable
Box<String> b = new Box<String>();
// method
public <T> void doStuff(T value) { }
```
_Java being stupid_ \
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
_Iterator_ \
```java
for (String s : stringList) { } // ==
for (Iterator<String> i = stringList.iterator();
    i.hasNext();) {
  String s = i.next();
}
```
_Iterable_ \
```java
interface Iterable<T> {
  Iterator<T> iterator();
}
interface Iterator<E> {
  boolean hasNext();
  E next();
}
```
_Comparable_ \
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
_Example_ \
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
_Bytecode_ \
#todo("")
_Type Erasure_ \
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
} // becomes
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
_Wildcards_ \
```java
public void printGs(List<Graphic> gs) { }
List<Graphic> gs1 = new ArrayList<>();
printGs(gs1);   // works
List<Circle> gs2 = new ArrayList<>();
printGs(gs2);   // error
/* solution */
public void printGs(List<? extends Graphic> gs) { }
```
_Generic variance_ \
#table(
  columns: (auto, 1fr, auto, auto, auto),
  [], [Type], [Compatible\ Type-Args], [R], [W],
  [Invariance], ```java C<T>```, ```java T```, cg, cg,
  [Covariance], ```java C<? extends T>```, [```java T``` and sub-types], cg, cr,
  [Contravariance],
  ```java C<? super T>```,
  [```java T``` and basis-types],
  cr,
  cg,

  [Bivariance], ```java C<?>```, [All], cr, cr,
)
_Invariance_ \
#todo("")
```java
```
_Covariance_ \
#todo("")
```java
```
_Contravariance_ \
#todo("")
```java
```
_Bivariance_ \
#todo("")
```java
```
_Misc_ \
```java
<T extends Comparable & Collection> // multiple type bounds
```
