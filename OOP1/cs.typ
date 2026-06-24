#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)

= Final (Attributes/Parameters) \
#table(
  columns: (1fr, 1fr, 1fr),
  table-header([Variable], [Method], [Class]), [Constant], [No overriding],
  [No inheritance],
)
= Initialisation
+ Default-Values $arrow.b$
+ Attribute Assignments
+ Initialisation block
+ Constructor
== Default Values
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  table-header([Type], [Default], [Type], [Default]),
  [boolean],
  [false],
  [char],

  ['\\u0000'], [byte], [0], [short],
  [0], [int], [0], [long],
  [0L], [float], [0.0f], [double],
  [0.0d],
)
= Types
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  table-header([Type], [Size (bit)], [From], [To]),
  [byte], [8], $-128$, $127$,
  [short], [16], $-32'768$, $32'767$,
  [char], [16], table.cell(colspan: 2, align: center, [UTF-16 chars]),
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
// 0.0 / 0.f          => NaN

long l = 1L;
long ll = 0b1l;
float f = 0.0f;
double d = 0.0d;

12 == '.'; // implicit int/char conversion
0.1 + 0.1 != 0.2; // true
5/2 == 2;  // true, int div truncates to 0
NaN == NaN; // false
Integer.MAX_VALUE + 1 == Integer.MIN_VALUE;
1 / 0.0 == Double.POSITIVE_INFINITY; // true

var ints = new ArrayList<Integer>();
int[] jnts = new int[69];
int[][] matrix = new int[6][9];

if (obj instanceof ArrayList<Integer>)
  ((ArrayList<Integer>)obj).add(2);

public List<String> method(
  BiFunction<Integer, String, List<String>> fn) {
  return fn.apply(5, "FooBar");
}
```
== Implicit casting \
No information loss `int->float`, to larger type `int->long` \
Sub`->`Super is implicit, Super`->`Sub ClassCastException \
```java
// explicit casting
float f = (float) 1;
// type conversion
Integer.parseInt("2");
Float.parseFloat("2.0");
```
=== Widening primitive conversion
- If either operand is double, the other is converted to double
- Otherwise, if either is float, the other is converted to float
- Otherwise, if either is long, the other is converted to long
- Otherwise, both operands are converted to type int
#colbreak()
= Variable args
```java
static int sum(int... numbers) {
  int sum  = 0;
  for (int i = 0; i < numbers.length; i++)
    sum += numbers[i];
  return sum;
}
```
= Misc
```java
int[] intarr = new int[] {1, 2, 3, 4, 5};
int[] sub = Arrays.copyOfRange(intarr, 1, 3); // 2,3

var intlist = new ArrayList<Integer>();
intarr.length;
intlist.size();

// Multiply first to not lose precision
int percent = (int)((filled * 100) / capacity);

obj.clone();

Math.min(x, y);
Math.max(x, y);
```
#image("./img/konversionen.png")
= Equality \
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
= Strings \
```java
String multiline = """
  Hello, "world"
""";
"a:b:c".split(":",2).length == 2; // true
String str = Integer.toString(123456789);
str.length();                     // 9
str.charAt(1);                    // 2
str.toUpperCase();
str.toLowerCase();
str.trim();
str.substring(1, 3);              // 2,3
```
== String pooling \
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
#colbreak()
= Visibility
#table(
  columns: (auto, 1fr),
  table-header([public], [all classes]), [protected],
  [package + sub-classes], [private],
  [only self], [(none)],
  [all classes in same package],
)
== Packages \
p1.sub won't be automatically imported in p1. \
Package name collisions: first gets imported. \
#let pkg = c => box(
  stroke: 1pt,
  inset: 4pt,
  c,
)
#grid(
  columns: (1fr, 1fr),
  pkg(
    [
      ```java
      package p1;
      public class A { }
      ```
      #pkg(```java
      package p1.sub;
      public class E { }
      ```),
    ],
  ),
  pkg(
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
package p1; // public class A { }
package p2; // public class A { }

// OK
import p1.A;
import p2.*;

// reference to A is ambiguous
import p1.*;
import p2.*;

// sin, PI
import static java.lang.Math.*;
```
== Modules \
```java
// ./foo/module-info.java
module foo.bar.baz {
  exports com.my.package.foo;
}

// ./main/module-info.java
module main.module {
  requires com.my.package.foo;
}
```
= Enums \
```java
public enum Weekday {
  MONDAY(true),
  TUESDAY(true),
  WEDNESDAY(true),
  THURSDAY(true),
  FRIDAY(true),
  SATURDAY(false),
  SUNDAY(false);

  private boolean workDay;

  Weekday(boolean workDay) { // private constructor
    this.workDay = workDay;
  }
  public boolean isWorkDay() {
    return workDay;
  }
}

switch (wd) {
  case Weekday.MONDAY:
  case Weekday.TUESDAY:
    System.out.println("First two");
    break;
  default:
    System.out.println("Rest");
}

public enum Level {
  LOW,
  MEDIUM,
  HIGH
}
```
#colbreak()
= Switch
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
= Shadowing \
Variables with same names in same scope \
= Hiding \
Variables with same names in different classes \
Gets statically chosen by compiler \
```java
super.description == ((Vehicle)this).description
super.super // doesn't exist, use v
((SuperSuperClass)this).variable
// for multiple parent interfaces v
ParentInterface1.super.defaultMethod();
// ^ executes defaultMethod on ParentInterface1
ParentInterface2.super.defaultMethod();
```
= Overloading \
Methods with same names but different parameters \
Gets statically chosen by compiler \
```java
void print(int i, double j) { }    // 1
void print(double i, int j) { }    // 2
void print(double i, double j) { } // 3

print(1.0, 2.0);        // 3
print(1,2);// error: reference to print is ambiguous
print(1.0, 2);          // 2
print(2.0, (double) 2); // 3
```
= Overriding \
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
= Abstract classes \
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
#colbreak()
= Interfaces \
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
== Interfaces default methods
```java
interface Vehicle {
  default void printModel() {
     System.out.println("Undefined vehicle model");
  }
}
```
= Anonymous Classes
```java
var v = new RoadV() {
    @Override
    public void drive() {
      System.out.println("Anon");
    }
}
```
= Inheritance \
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
== More Inheritance \
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
#colbreak()
#shared.oopsndpage
