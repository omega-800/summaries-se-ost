#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "../lib.typ": *
#let lang = "en"
#show: cheatsheet.with(
  module: "OOP1",
  name: "Objektorientiertes Programmieren 1",
  semester: "HS25",
  language: lang,
)
#let tbl = (..body) => deftbl(lang, "OOP1", ..body)
// FIXME: extrapolate
#let nwr = (height: 6pt, fill: colors.red.lighten(40%))
#let nwg = (height: 6pt, fill: colors.green.lighten(40%))
#let nt = t => box(inset: 1pt, baseline: -6pt, text(
  hyphenate: false,
  size: 5pt,
)[#t])
#let dd = (
  spacing: (2pt, 6pt),
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node-shape: rect,
  mark-scale: 40%,
)

#corr("TODO")
- `Function<T,V> Predicate<T> Stream<T> Collection<T>`

_Final (Attributes/Parameters)_ \
#table(
  columns: (1fr, 1fr, 1fr),
  [Variable], [Method], [Class],
  [Constant], [No overriding], [No inheritance],
)
_Initialisation_
+ Default-Values $arrow.b$
+ Attribute Assignments
+ Initialisation block
+ Constructor
_Default Values_
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  table.header([Type], [Default], [Type], [Default]),
  [boolean], [false], [char], ['\\u0000'],
  [byte], [0], [short], [0],
  [int], [0], [long], [0L],
  [float], [0.0f], [double], [0.0d],
)
_Types_
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [Type], [Size (bit)], [From], [To],
  [byte], [8], $-128$, $127$,
  [short], [16], $-32'768$, $32'767$,
  [char], [16], table.cell(colspan: 2, align: center, [all UTF-16 chars]),
  [int], [32], $-2^31$, $2^31 - 1$,
  [long], [64], $-2^63$, $2^63 - 1$,
  [float], [32], $plus.minus 1.4 dot 10^(-45)$, $plus.minus 3.4 dot 10^38$,
  [double], [64], $plus.minus 4.9 dot 10^(-324)$, $plus.minus 1.7 dot 10^308$,
)
```java
// short * int        => int
// float + int        => float
// int / double       => double
// int + long * float => float
// 1 / 0.0            => Infinity
// 0.0 / 0.f          => NaN

long l = 1L;      long ll = 0b1l;
float f = 0.0f;   double d = 0.0d;

12 == '.'; // implicit int/char conversion
0.1 + 0.1 != 0.2; // true
5/2 == 2;  // true, int div truncates to 0
NaN == NaN; // false
Integer.MAX_VALUE + 1 == Integer.MIN_VALUE;

String multiline = """
  Hello, "world"
""";
"a:b:c".split(":",2).length == 2; // true

var ints = new ArrayList<Integer>();
int[] jnts = new int[69];

if (obj instanceof ArrayList<Integer>)
  ((ArrayList<Integer>)obj).add(2);

public List<String> method(
  BiFunction<Integer, String, List<String>> fn){
  return fn.apply(5, "FooBar");
}
```
_Implicit casting_ \
#image("./img/konversionen.png")
No information loss `int->float`, to larger type `int->long` \
Sub->Super is implicit, Super->Sub ClassCastException \
_Misc_
```java
int[] intarr = new int[] {1, 2, 3, 4, 5};
int[] sub = Arrays.copyOfRange(intarr, 1, 3); // 2,3

var intlist = new ArrayList<Integer>();
intlist.add(1);
intarr.length; intlist.size();

// Multiply first to not lose precision
int percent = (int)((filled * 100) / capacity);

obj.clone();

Double.POSITIVE_INFINITY; // exists

Math.min(i,y); Math.max(i,y);
```
_Variable args_
```java
static int sum(int... numbers) {
  int sum  = 0;
  for (int i = 0; i < numbers.length; i++)
    sum += numbers[i];
  return sum;
}
```
_Equality_ \
```java
s.equals(sOther);           // Strings / Objects
Arrays.equals(a1, a2);      // arrays
Arrays.deepEquals(a1, a2);  // nested arrays

class Student extends Person {
  @Override
  public boolean equals(Object obj) {
    if (obj == null) return false;
    if (getClass() != obj.getClass()) return false;
    if (!super.equals(obj)) return false;
    Student other = (Student) obj;
    return getNumber() == other.getNumber();
  }
}
```
_Hashing_ \
Should be added to equals fn's for strict equality \
_String pooling_ \
```java
String first = "hello", second = "hello";
System.out.println(first == second);      // true

String third = new String("hello");
String fourth = new String("hello");
System.out.println(third == fourth);      // false
System.out.println(third.equals(fourth)); // true

String a = "A", b = "B", ab = "AB";
System.out.println(a + b == ab);          // false

final String d = "D", e = "E", de = "DE";
System.out.println(d + e == de);          // true
```
_Visibility_
#table(
  columns: (auto, 1fr),
  [public], [all classes],
  [protected], [package + sub-classes],
  [private], [only self],
  [(none)], [all classes in same package],
)
_Packages_ \
p1.sub won't be automatically imported in p1. \
Package name collisions: first gets imported. \
#grid(
  columns: (1fr, 1fr),
  box(
    stroke: 1pt,
    inset: 4pt,
    [
      ```java
      package p1;
      public class A { }
      ```
      #box(stroke: 1pt, inset: 4pt, ```java
      package p1.sub;
      public class E { }
      ```),
    ],
  ),
  box(
    stroke: 1pt,
    inset: 4pt,
    ```java
    package p2;
    import p1.sub.E;
    public class C {
      E e = new E();
    }
    ```,
  ),
)
```java
package p1; public class A { }
package p2; public class A { }
import p1.A; import p2.*; // OK
import p1.*; import p2.*; // reference to A is ambiguous
import static java.lang.Math.*; // sin, PI
```
_Enums_ \
```java
public enum Weekday {
  MONDAY(true), TUESDAY(true), WEDNESDAY(true),
  THURSDAY(true), FRIDAY(true),
  SATURDAY(false), SUNDAY(false);

  private boolean workDay;

  Weekday(boolean workDay) { // private constructor
    this.workDay = workDay;
  }
  public boolean isWorkDay() {
    return workDay;
  }
}
switch (wd) {
  case MONDAY:
  case TUESDAY:
    System.out.println("First two");
    break;
  default:
    System.out.println("Rest");
}
```
_Switch_
```java
switch (x) {
  case 'a':
    System.out.println("1");
    break;
  default:
    System.out.println("2");
}
int y = switch (x) {
  case 'a' -> 1;
  default -> 2;
}
```
_Overloading_ \
Methods with same names but different parameters \
Gets statically chosen by compiler \
#corr("TODO with class instances") \
```java
void print(int i, double j) { }    // 1
void print(double i, int j) { }    // 2
void print(double i, double j) { } // 3

print(1.0, 2.0);        // 3
print(1,2);// error: reference to print is ambiguous
print(1.0, 2);          // 2
print(2.0, (double) 2); // 3
```
_Overriding_ \
Methods with same names and signatures \
Dynamically chosen (Dynamic dispatch / Virtual call) \
Error: Cannot override the final method... \
Error: Cannot be subclass of final class... \
```java
class Fruit {
  void eat(Fruit f) { System.out.println("1"); }
}
class Apple extends Fruit {
  void eat(Fruit f) { System.out.println("2"); }
  void eat(Apple a) { System.out.println("3"); }
}

Apple a = new Apple();
Fruit fa = new Apple();
Fruit f = new Fruit();

a.eat(fa);            // 2
a.eat(a);             // 3
fa.eat(a);            // 2
fa.eat(fa);           // 2
f.eat(fa);            // 1
f.eat(a);             // 1
((Fruit) a).eat(fa);  // 3
((Apple) fa).eat(a);  // 2
((Apple) f).eat(a);   // ClassCastException
```
_Hiding_ \
```java
super.description == ((Vehicle)this).description
super.super // doesn't exist, use v
((SuperSuperClass)this).variable
```
_Abstract classes_ \
```java
public abstract class Vehicle {
  private int speed;
  public abstract void drive();
  public void accelerate(int acc) {
    this.speed += acc;
  }
}
public class Car extends Vehicle {
  @Override
  public void drive() { }
  @Override
  public void accelerate (int acc) { }
}
```
_Interfaces default methods_
```java
interface Vehicle {
  default void printModel() {
     System.out.println("Undefined vehicle model");
  }
}
```
_Interfaces_ \
Cannot have Attributes \
```java
interface RoadV {
  int MAX_SPEED = 120;
  void drive();
}
interface WaterV {
  int MAX_SPEED = 80;
  void drive();
}
class AmphibianMobile implements RoadV, WaterV {
  @Override // because ambiguous
  public void drive() {
    println(RoadV.MAX_SPEED); // MAX_SPEED ambiguous
  }
}

interface RoadV { String getModel(); }
interface WaterV { int getModel(); }
// Error, because of different return types
class AmphibianMobile implements RoadV, WaterV { }
```
_Anonymous Classes_
```java
var v = new RoadV() {
    @Override
    public void drive() {
      System.out.println("Anon");
    }
}
```
#corr("TODO: mby more interfaces stuff") \
_Inheritance_ \
```java
public class Vehicle {
   private int speed;
   public Vehicle(int speed) {
     this.speed = speed;
   }
}
public class Car extends Vehicle {
   private int doors;
   public Car(int speed, int doors) {
      super(speed);
      this.doors = doors;
   }
}
Car c     = new Car(); // Points to Car
Vehicle v = new Car(); // Points to Car
Object o  = new Car(); // Points to Car
// ^static      ^dynamic
Car c = (Car) new Vehicle(); // ClassCastException
```
_More Inheritance_ \
```java
public class Qwer {
  public void print() {
    System.out.println("1");
  }
}
public class Asdf extends Qwer {
  @Override
  public void print() {
    System.out.println("2");
  }
  public void dostuff () { }
}

var x = new Asdf();
x.print();            // 2
((Qwer) x).print();   // 2
((Qwer) x).dostuff(); // cannot find symbol
```
*Static Type*: According to var declaration at compiletime \
*Dynamic Type*: Type of the instance at runtime \
_Iterators_ \
```java
Iterator<String> it = stringList.iterator();
while (it.hasNext()) {
  String s = it.next();
  System.out.println(s);
}
```
Mutating Collection while iterating over it: ConcurrentModificationException \
_Exceptions_ \
#table(
  columns: (1fr, 1fr),
  [Error], [Exception],
  [Critical, don't handle], [Runtime, handleable],
  [OutOfMemoryError, StackOverflowError, AssertionError], [IOException],
)
#table(
  columns: (1fr, 1fr),
  [Checked], [Unchecked],
  [Must be handled (or throws-\ declaration)], [Not necessary],
  [Checked by compiler], [Compiler doesn't check],
  [Exception, not RuntimeException], [RuntimeException, Error],
)
Child Exception gets caught in catch clause with parent class
```java
void test() throws ExceptionA, ExceptionB {
  String c = clip("asdf");
  throw new ExceptionB("wack");
}
// finally ALWAYS executes, even on unhandled Exc.
try { test() } catch (ExceptionA | ExceptionB e) {
} finally { }

try { ... } catch(NullPointerException e) {
  throw e; // --leaves blocks-->
} catch (Exception e) {
  // above e won't get catched!
}

1 / 0; // ArithmeticException div by zero
```
#tr("Unchecked") #tg("Checked")
#diagram(
  ..dd,
  node(..nwg, (2, 1), nt("Throwable"), name: <throwable>),
  node(..nwr, (1, 2), nt("Error"), name: <error>),
  node(..nwg, (2, 2), nt("Exception"), name: <exception>),
  node(..nwr, (1, 3), nt("RuntimeException"), name: <runtime>),
  node(..nwg, (2, 3), nt("IllegalAccessE"), name: <illegal>),
  node(..nwg, (3, 3), nt("ClassNotFoundE"), name: <class>),
  node(..nwr, (1, 4), nt("NullPointerE"), name: <null>),
  node(..nwr, (2, 4), nt("IndexOutOfBoundsE"), name: <index>),
  node(..nwr, (3, 4), nt("IllegalArgumentE"), name: <arg>),
  node(..nwr, (2, 5), nt("ArrayIndexOutOfBoundsE"), name: <aindex>),
  edge(<error>, <throwable>, "-|>"),
  edge(<exception>, <throwable>, "-|>"),
  edge(<runtime>, <exception>, "-|>"),
  edge(<illegal>, <exception>, "-|>"),
  edge(<class>, <exception>, "-|>"),
  edge(<index>, <runtime>, "-|>"),
  edge(<null>, <runtime>, "-|>"),
  edge(<arg>, <runtime>, "-|>"),
  edge(<aindex>, <index>, "-|>"),
) \
_IO_ \
```java
try (var fr = new FileReader(path)) {
  int input = fr.read();
  while (input >= 0) {
    if (input == ';') { /* do something */ }
    input = fr.read();
  }
}
try {
  var input = new FileInputStream("text.txt");
  int i = input.read();
  while(i != -1) {
     System.out.print((char)i);
     i = input.read();
  }
  input.close();
} catch (Exception e) { e.printStackTrace(); }
```
_Try with_
```java
try (var output = new FileOutputStream("f.txt")) {
  output.write("Hello".getBytes());
} catch (IOException e) {
  System.out.println("Error writing file.");
}
```
_Serializing_ \
```java
class X implements Serializable { }
// Serializing
try (var stream = new ObjectOutputStream(
    new FileOutputStream("s.bin"))) {
  stream.writeObject(new X());
}
// Deserializing
try (var stream = new ObjectInputStream(
    new FileInputStream("s.bin"))) {
  X x = (X) stream.readObject();
}
```
_Collection_ \
```java
boolean add(E e);         boolean remove(Object o);
boolean equals(Object o); int hashCode();
int size();               boolean isEmpty();
boolean contains(Object o);

Set<String> noDup = new HashSet<>();
```
_Function_ \
```java
public interface Function<T, R> { 
  R apply(T t);
  static <T> Function<T, T> identity();
  <V> Function <T, V> andThen(
    Function<? super R, ? extends V> after);
  <V> Function <V, R> compose(
    Function<? super V, ? extends T> before);
}
```
_Comparable_ \
```java
public interface Comparable<T> {
    int compareTo(T obj);
}

var l = new ArrayList<Integer>(asList(3,2,4,5,1));
l.sort((a, b) -> a > b ? 1 : -1); // ==
l.sort((a, b) -> a - b);          // 1,2,3,4,5

class Person implements Comparable<Person> {
  private final String firstName, lastName;
  @Override
  public int compareTo(Person other) {
    int result = lastName.compareTo(other.lastName);
    if (result == 0)
      result = firstName.compareTo(other.firstName);
    return result;
  }

  static int compareByAge(Person a, Person b) {
    return Integer.compare(a.getAge(), b.getAge());
  }
}
List<Person> people = ...;
Collections.sort(people);
people.sort(Person::compareByAge);

class AgeComparator implements Comparator<Person> {
   @Override
   public int compare(Person a, Person b) {
     return Integer.compare(a.getAge(), b.getAge());
   }
}
Collections.sort(people, new AgeComparator());
people.sort(new AgeComparator());

people.sort(Comparator
  .comparing(Person::getAge)
  .thenComparing(Person::getFirstName)
  .reversed())
```
_Predicate_
```java
public interface Predicate<T> {
    boolean test(T t);
}

static void removeAll(Collection<Person> collection,
    Predicate criterion) {
  var it = collection.iterator();
  while (it.hasNext())
    if (criterion.test(it.next()))
      it.remove();
}
```
_Lambdas_
```java
String pattern = readFromConsole();
//     vvv not final -> Error
while (pattern.length() == 0)
  pattern = readFromConsole();
Utils.removeAll(people, p ->
    p.getLastName().contains(pattern));
// local variable ... referenced from a lambda expression must be final or effectively final

// Predicate      :: a -> boolean
Predicate<Integer> isLarge = (v) -> v > 69420;
// Function       :: a -> b
Function<Integer, String> str = (v) -> "" + v;
// Supplier       :: a 
Supplier<String> hello = () -> "Hello, World!";
// Consumer       :: a -> void
Consumer<Integer> consoomer = (v) -> log(v);
// UnaryOperator  :: a -> a
UnaryOperator<Integer> more = (v) -> v * v;
// BinaryOperator :: a -> a -> a
BinaryOperator<Integer> less = (a, b) -> a - b;
```
_Streams_
```java
import java.util.stream.*;

people
  .stream()
  .distinct()
  .filter(p -> p.getAge() >= 18)
  .skip(5)
  .limit(10)
  .map(p -> p.getLastName())
  .sorted()
  .forEach(System.out::println);

people
  .stream()
  .reduce(0, (acc,cur) -> acc + cur.getAge());

list.stream().mapToInt(Integer::intValue);
list.stream().mapToInt(Integer::parseInt);
```
*Terminal operations*: \
```java
min()                      max()
average()                  sum()
findAny()                  findFirst()
forEach(Consumer)          count()
forEachOrdered(Consumer)
```
