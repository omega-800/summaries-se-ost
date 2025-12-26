#import "../lib.typ": *
#let lang = "en"
#show: cheatsheet.with(
  module: "OOP1",
  name: "Objektorientiertes Programmieren 1",
  semester: "HS25",
  language: lang,
)
#let tbl =(..body)=> deftbl(lang, "OOP1",..body)

- signatures
- ByteArray
- Stream.sort() which direction it gets sorted
- stream functions, :
- `Function<T,V> Predicate<T> Stream<T> Collection<T>`
- HashCode-methods
- cannot override final methods
- cannot be subclass of final class

_Final (Attributes/Parameters)_ \
#corr("TODO") \
_Static (Attributes/Methods)_ \
#corr("TODO") \
_Private (Attributes/Methods)_ \
#corr("TODO") \
_Types_
```java
long l = 1L; long ll = 0b1l;
float f = 0.0f; long d = 0.0d;
String multiline = """
  Hello, "world"
""";
var ints = new ArrayList<Integer>();
boolean isTrue = 0.1 + 0.1 != 0.2;
```
_Variable args_
```java
long l = 1L; long ll = 0b1l;
static int sum(int... numbers) {
  int sum  = 0;
  for (int i = 0; i < numbers.length; i++) sum += numbers[i];
  return sum;
}
```
_Implicit casting_ \
#image("./img/konversionen.png")
No information loss `int->float`, to larger type `int->long` \
Sub->Super is implicit, Super->Sub ClassCastException \
_Try with_
```java
try (FileOutputStream output = new FileOutputStream("filename.txt")) {
  output.write("Hello".getBytes());
} catch (IOException e) {
  System.out.println("Error writing file.");
}
```
_Static vs Dynamic types_ \
#corr("TODO") \
_Dynamic dispatch_ \
#corr("TODO") \
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
_String pooling_ \
#corr("TODO") \
_Hashing_
#corr("TODO") \
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
_Visibility_
#table(
  columns: (auto, 1fr),
  [public], [all classes],
  [protected], [package + sub-classes],
  [private], [only self],
  [(none)], [all classes in same package],
)
_Packages_
#corr("TODO") \
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
_IO_ \
#corr("TODO") \
_Stream API_ \
#corr("TODO") \
```java
people
  .stream()
  .filter(p -> p.getAge() >= 18)
  .map(p -> p.getLastName())
  .sorted()
  .forEach(System.out::println);
```
_Lambdas_ \
#corr("TODO") \
```java
people.sort(Comparator
  .comparing(Person::getLastName)
  .thenComparing(Person::getFirstName)
  .reversed();
```
_Enums_ \
#corr("TODO") \
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
```
_Interfaces default methods_ 
```java
interface Vehicle {
  default void printModel() { 
     System.out.println("Undefined vehicle model");
  }
}
```
_Interfaces_
```java
interface Iterator<T> {
  boolean hasNext();
  T next();
}
class Person implements Comparable<Person> {
  private int age;
  @Override
  public int compareTo(Person other) {
    if (age < other.age) return -1;
    if (age > other.age) return 1;
    return 0;
    // return Integer.compare(age, other.age);
  }
  static int compareByAge(Person p1, Person p2) {
    return Integer.compare(p1.getAge(), p2.getAge());
  }
}
people.sort(Person::compareByAge);
```
_Inheritance_ \
_Serializable_ \
_Compiler Quirks_ \
-> 05_Vererbung_1.pdf ...
