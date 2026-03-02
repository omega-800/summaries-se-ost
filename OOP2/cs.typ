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
_Wildcards_ \
```java
void printGs(List<Graphic> gs) { }
List<Graphic> gs1 = new ArrayList<>();
printGs(gs1);   // ok
List<Circle> gs2 = new ArrayList<>();
printGs(gs2);   // error
/* solution */
void printGs(List<? extends Graphic> gs) { }
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
_Covariance_ \
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
_Contravariance_ \
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
_Bivariance_ \
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
_Producer / Consumer_ \
#todo("") \
_Misc_ \
```java
<T extends Comparable & Collection> // multiple type bounds
```

_Generics stream_ \
#todo("slides 7")
_Profiler_ \
#todo("slides 10")
_Annotations_ \
#todo("slides 10")
_Defining_ \
_Validation_ \
_Reflection_ \
