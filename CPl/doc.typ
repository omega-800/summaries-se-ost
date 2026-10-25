#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Why C++?
#{
  set grid(gutter: 0pt)
  wrap-content(
    columns: (2fr, 1fr),
    figure(image("./img/mascot.jpg")),
    [
      - Multi-paradigm language, now you have a thousand and one way to shoot
        yourself in your foot and obliterate your PC
      - Being called stupid when you think that the `move` function actually
        moves things or if you confuse a const pointer with a pointer of const
      - ISO standard: C++23. The higher the number the hotter the mess of poorly
        designed choices that have accumulated over decades into a chaotic pile
        of obsoleteness
      - Good excuse for alcoholism
      - Zero-cost abstractions (if you like learning the whole stdlib by heart
        and don't mind the cost of debugging template errors for hours on end)
      - Headaches (if you're a masochist)
      - It's a never ending journey. Even if you dedicate your whole life to
        learning C++, you'll never reach the day where you'll know all of the
        stdlib.
      - "Undefined behavior" is defined (in the standard)
      - Ever wanted to have 100 different ways to do the same thing? Now you can
      - Has a pretty mascot @cpp-mascot
    ],
    align: bottom + right,
  )
}

= Intro

- ```cpp main()``` implicitly returns 0
- Return types are written in front of the function name or as trailing
  return-types in declarations (because who needs consistency, amirite)
  #grid(
    columns: 4,
    align: center + horizon,
    [Nice and clean: ],
    ```cpp
    int main() { }
    ```,
    [Insanity: ],
    ```cpp
    auto main() -> int { }
    ```,
  )
- Header files can be either `*.hpp` or `*.h`
- Regarding include order: It is good practice to include own-headers (`""`)
  before system-headers (`<>`). The first is usually used for the header files
  belonging to the project itself, while the latter is used for includes of the
  standard library and external libraries. However, _this difference is only
  conventional, as any toolchain could just specify their own lookup rules for
  the two distinct kinds of includes_.

#table(
  columns: (auto, 1fr),
  table-header([Do's], [Don'ts]), [ ],
  [Using global variables], [ ],
  [Redundant returns in ```cpp main()``` that would be implicit], [ ],
  [```cpp using namespace```], [ ],
  [Not initializing a variable upon definition using `{}`], [ ],
  [Not using ```cpp const``` enough], [],
  [Using ```cpp sdt::cin``` and ```cpp sdt::cout```], [ ],
  [Not checking ```cpp stream.good()```], [ ],
  [Not removing stream fail flag with ```cpp stream.clear()```], [ ],
  [Not using ```cpp #include``` guards], [],
  [Using plain C-Arrays], [],
  [Using plain `for(int i; ...)` loops], [],
  [Returning from a function by const value (unnecessary and stupid)], [],
  [Returning reference to a local variable], [],
  [Throwing primitives. Don't ask why exactly should you be able to do this in
    the first place.],
  [],

  [Making class member variables ```cpp const```], [],
  [Adding member variables to communicate between member function calls], [],
  [Throwing an exception in a destructor], [],
  [Type-conversion constructors not being declared explicit],

  [ ], [#todo[make this column real big for the lulz]],
)

== Compilation

3 Phases of compilation:

/ Preprocessor: Textual replacement of preprocessor directives (`#include`)
/ Compiler: Translation of C++ code into machine code (source file to object
  file)
/ Linker: Combination of object files and libraries into libraries and
  executables

== Declarations and definitions

All things with a name that you use in a C++ program must be declared before you
can do so
- E.g. a function that you call (major difference from C)
- A type that you use for a variable (except some built-ins)
- A variable that you use

There can only be one definition of the same function (_One Definition
Rule_/ODR), in contrast to declaration, which can be done several times.

=== `#include` guards

```cpp #include``` guards ensure that a header file is only included once.
Necessary for functions and class type definitions, good practice either way.

```cpp
#ifndef GUARD_HPP_
#define GUARD_HPP_
// ...
#endif /* GUARD_HPP_ */
```

=== Functions

Declarations
```
auto          <function-name>(<parameters>) -> <return-type>;
<return-type> <function-name>(<parameters>);
```

Definitions
```
auto          <function-name>(<parameters>) -> <return-type> { /*body*/}
<return-type> <function-name>(<parameters>)                  { /*body*/}
```

If a function has a non-void return type it must return a value on every path
(or throw an exception).

=== Values and references

```cpp
struct Point {
  int x;
  int y;
};
```

Copying vs. Sharing:

```cpp
Point point{1, 20};

Point copiedPoint{point};
Point & sharedPoint{point};

auto copydPointParam(Point point) -> Point { }
auto referencePointParam(Point & point) -> Point { }
```

=== Alias Declarations

A type alias can help to abbreviate type names.

`using <alias-name> = <type>;`
#exbox(
  ```cpp
  using input = std::istream_iterator<std::string>;
  input eof{};
  input in{std::cin};
  ```,
)

== Libraries

- #link("https://github.com/catchorg/Catch2", "catch2")
- #link("http://www.boost.org/", "boost")
#todo[cmake]

= Values and Streams

== Variables

```
<type> <variable-name>{<initial-value>};
```

Using `=` or `{}` for initialization with a value supplied we can have the
compiler determine its type.

```cpp
auto const i = 5;
```

Initialization might be omitted but that is bad practice and potentially
dangerous.

```cpp
double x;
```

Adding the const keyword in front of the name makes the variable a
single-assignment variable, aka a constant which is immutable and must be
initialized. Some constants are required to be fixed at compile time
(```cpp constexpr```). The keyword ```cpp const``` also appears in other
contexts.

```cpp
int const theAnswer{42};
double constexpr pi{3.14};
```

You should use ```cpp const``` whenever possible for non-member variables.

== Literal Values

#table(
  columns: (2fr, 1fr, 1.5fr),
  [Literal Example], [Type], [Value],
  ```cpp 'a'```, [char], [Letter a, value: 97],
  ```cpp '\n'```, [char], [\<NL\> character, value: 10],
  ```cpp '\x0a'```, [char], [\<NL\> character, value: 10],
  ```cpp 1```, [int], [1],
  ```cpp 42L```, [long], [42],
  ```cpp 5LL```, [long long], [5],
  ```cpp int{} // (not really a literal)```, [int], [0 (default value)],
  ```cpp 1u```, [unsigned int], [1],
  ```cpp 42ul```, [unsigned long], [42],
  ```cpp 5ull```, [unsigned long long], [5],
  ```cpp 020```, [int], [16 (octal 20)],
  ```cpp 0x1f```, [int], [31 (hex 1F)],
  ```cpp 0XFULL```, [unsigned long long], [15 (hex F)],
  ```cpp 0.f```, [float], [0],
  ```cpp .33```, [double], [0.33],
  ```cpp 1e9```, [double], [1000000000 (109)],
  ```cpp 42.E-12L```, [long double], [0.00000000042 (42*10-12)],
  ```cpp .3l```, [long double], [0.3],
  ```cpp "hello"```, [char const [6]], [Array of 6 chars: h e l l o \<NUL\>],
  ```cpp "\012\n\\"```,
  [char const [4]],
  [Array of 4 chars: \<NL\> \<NL\> \ \<NUL\>],
)

== Expressions

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  table-header([], [Arithmetic], [Bit-operators], [Logic]),
  emph[Unary],
  ```cpp + - ++ --```,
  ```cpp ~```,

  ```cpp !```, emph[Binary], ```cpp + - * / %```, ```cpp & | ^ << >>```,
  ```cpp && || < > <= >= == !=```, emph[Tertiary], ```cpp ```, ```cpp ```,
  ```cpp ? :```,
)

- Fraction results of integer operations are always rounded down
- #link(
    "https://en.cppreference.com/cpp/language/operator_precedence",
    "Operator precedence",
  )

=== Type Conversion

- Integer to boolean conversion `0 -> false` / every other value `-> true`
- Automatic type conversion if values of different types are combined in an
  expression, *unless in braced initialization*
- Dividing integers by zero is *undefined behavior*

=== Assignment Operation

```cpp
// vvvvv lvalue
   myVar = 6 * 7;
//         ^^^^^ rvalue
```

=== Logic Operations

Logical operators and conditional statements are generous to accept numeric
values as statement of truth

```cpp
//    v returns boolean
if (a < b < c);
//        ^ coalesces to 0 if false, 1 if true
```

=== Floating Point Numbers (IEEE754)

- Use `double` -- usually most efficient on current hardware and default for
  floating point literals.
- Use float only if memory consumption is utmost priority and precision and
  range can be traded (on 64bit often not beneficial).
- Remember there are legal double values that are not numbers:
  `NaN, +Inf, -Inf`.
- Comparing floating points for equality (`==`) is usually wrong
  - In Catch2 you have the option to specify a matcher that checks in a relative
    range to the expected value \
    ```cpp REQUIRE_THAT(actual, Catch::Matchers::WithinRel(expected, delta));```

=== Strings

```cpp std::string``` is C++'s type for representing sequences of char (which is
often only 8 bit). For working with non-ASCII characters an external library is
advised. It is mutable and iterable with iterators.

```cpp
#include <string>
std::string statement{"Rust ftw"};
```

String literals like ```cpp "ab"``` are not of type ```cpp std::string```,
they're a null-terminated array of const characters (```cpp char const[3]```).
But ```cpp "ab"s``` is an ```cpp std::string``` but requires
```cpp using namespace std::literals```.

== Basic Streams

Streams aren't values, because they cannot be copied. So functions taking a
stream object must take it as a reference.

Pre-defined globals: ```cpp std::cin``` ```cpp std::cout```, should only be used
in ```cpp main()```. "shift" operators read into variables or write values and
can be chained:
```cpp
std::cin >> x;
std::cout << "the value is " << x << '\n';
```

Output can be formatted using #link(
  "https://en.cppreference.com/cpp/io/manip",
  [I/O manipulators],
).

#exbox(```cpp
#include <iostream>
#include <iomanip>
#include <ios>

auto main() -> int {
  std::cout << 42 << '\t'
    << std::oct << 42 << '\t'
    << std::hex << 42 << '\n';
  std::cout << 42 << '\t' // std::hex is sticky
    << std::dec << 42 << '\n';
  std::cout << std::setw(10) << 42
    << std::left << std::setw(5) << 43 << "*\n";
  std::cout << std::setw(10) << "hallo" << "*\n";
  double const pi{std::acos(0.5) * 3};
  std::cout << std::setprecision(4) << pi << '\n';
  std::cout << std::scientific << pi <<  '\n';
  std::cout << std::fixed << pi * 1e6 <<  '\n';
}
```)

=== Errors

Streams have a state that denotes if I/O was successful or not. If a previous
read already failed, subsequent reads fail as well.

#table(
  columns: (1fr, 1fr, 3fr),
  [State Bit Set], [Query], [Entered],
  ```cpp <none>```,
  ```cpp is.good()```,
  ```cpp initial
  is.clear()```,

  ```cpp failbit```, ```cpp is.fail()```, ``` formatted input failed```,
  ```cpp eofbit```, ```cpp is.eof()```, ``` trying to read at end of input```,
  ```cpp badbit```, ```cpp is.bad()```, ``` unrecoverable I/O error```,
)

- Formatted input on stream `is` must be checked for ```cpp is.fail()``` and
  ```cpp is.bad()```
- If failed, ```cpp is.clear()``` the stream and consume invalid input
  characters before continuing

=== `std::string`

Reading a ```cpp std::string``` can not go wrong, unless the stream is already
```cpp !good()```
- The content of the ```cpp std::string``` is replaced
- Maybe the ```cpp std::string``` is empty after reading

=== `int`

Reading an ```cpp int``` results in:
- No error recovery
- One wrong input puts the stream into status fail
- Characters remain in input

#exbox(
  title: [Robust way of reading an ```cpp int```],

  ```cpp
  auto readInt(std::istream & in) -> int {
    std::string line{};
    while (getline(in, line)) {
      std::istringstream is{line};
      int res{-1};
      if (is >> res)
        return res;
    }
    return -1;
  }
  ```,
)

#exbox(
  title: [Reading an ```cpp int``` and skipping invalid characters],

  ```cpp
  auto readInt(std::istream & in) -> int {
    while (in.good()) {
      int res{-1};
      if (in >> res)
        return res;
      in.clear();
      in.ignore();
      // alt: in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
      // ignores whole line
    }
    return -1;
  }
  ```,
)

=== Boolean Conversion

Result of ```cpp is >> res``` is the ```cpp std::istream``` object itself. The
stream object converts to ```cpp bool``` (in if and loop conditions):
- ```cpp true``` if the last reading operation has been successful
- ```cpp false``` if the last reading operation failed somehow (formatting,
  stream end or another problem)

```cpp good()``` for pre-checking "can I still read?" and ```cpp bool```
conversion for post-checking "did I read correctly?".

#let gcfalse = grid.cell(fill: colors-l.red, `false`)
#let gctrue = grid.cell(fill: colors-l.green, `true`)
#block(breakable: false, grid(
  stroke: colors.fg,
  columns: 9,
  gutter: 0pt,
  inset: .5em,
  grid.cell(colspan: 3, `ios_base::iostate flags`),

  grid.cell(colspan: 6, `basic_ios accessors`),
  ```cpp eofbit ```,
  ```cpp failbit ```,
  ```cpp badbit ```,
  ```cpp good() ```,
  ```cpp fail() ```,
  ```cpp bad() ```,
  ```cpp eof() ```,
  ```cpp operator bool ```,

  ```cpp operator
  !```,
  gcfalse,
  gcfalse,
  gcfalse,
  gctrue,
  gcfalse,
  gcfalse,

  gcfalse, gctrue, gcfalse, gcfalse, gcfalse, gctrue, gcfalse, gctrue, gctrue,
  gcfalse, gcfalse, gctrue, gcfalse, gctrue, gcfalse, gcfalse, gctrue, gcfalse,
  gcfalse, gcfalse, gctrue, gcfalse, gctrue, gctrue, gcfalse, gctrue, gctrue,
  gcfalse, gcfalse, gctrue, gctrue, gcfalse, gcfalse, gcfalse, gcfalse, gcfalse,
  gctrue, gctrue, gcfalse, gctrue, gcfalse, gctrue, gcfalse, gctrue, gctrue,
  gctrue, gcfalse, gctrue, gctrue, gctrue, gcfalse, gcfalse, gctrue, gcfalse,
  gctrue, gcfalse, gctrue, gctrue, gctrue, gctrue, gcfalse, gctrue, gctrue,
  gctrue, gcfalse, gctrue,
))

=== IO Headers

/ `iosfwd`: contains only the declarations for `std::ostream` and
  `std::istream`. \
  In header files (`.hpp`) this is usually sufficient when the streams are only
  used in function declarations
/ `istream` and `ostream`: contain the implementation of the corresponding
  stream and operators. \
  Usually, these are required in source files (`.cpp`) when the streams are
  actually used in functions
/ `iostream`: contains all of the above and additionally `std::cout`,
  `std::cin`, `std::cerr`. \
  This is only required in the source file containing the `main()` function,
  because only there the global standard IO variables shall be used

= Sequences and Iterators


#let (
  bnode,
  ibnode,
) = bn-abbrevs
#let bnode = bnode.with(width: 3em, height: 3em)
#let ibnode = ibnode.with(width: 3em, height: 3em)
#let enode = bnode.with(stroke: none)

== ```cpp std::array<T, N>```

```cpp
#include <array>

std::array<int, 6> emptyArray{};
```
Is a fixed-size Container
- `T` is a template type parameter (= placeholder for type)
- `N` is a positive integer, template non-type parameter (= placeholder for a
  value)

  It can be initialized with a list of elements

- The size of an array must be known at compile-time and cannot be changed
- Otherwise, it contains `N` default-constructed elements

The size is bound to the array object and can be queried using
```cpp .size()```

Element access using subscript operator ```cpp []``` or ```cpp .at()```
- ```cpp .at()``` throws ```cpp std::out_of_range exception``` on invalid index
  access
- ```cpp []``` has undefined behavior on invalid index access
#align(center, diagram(
  spacing: (0pt, 0pt),
  ibnode((1, 2), `[0]`),
  ibnode((2, 2), `[1]`),
  ibnode((3, 2), `[2]`),
  ibnode((4, 2), `[3]`),
  ibnode((5, 2), `[4]`),
  ibnode((6, 2), `[5]`),
  bnode((1, 3), $x_0$),
  bnode((2, 3), $x_1$),
  bnode((3, 3), $x_2$),
  bnode((4, 3), $x_3$),
  bnode((5, 3), $x_4$),
  bnode((6, 3), $x_5$),
  enode((0, 4)),
  enode((2, 1)),
  enode((0, 2)),
  enode((7, 2)),
  enode((1, 4.5), height: 2em, ```cpp front()```),
  edge((1, 3), "-O"),
  enode((6, 4.5), height: 2em, ```cpp back()```),
  edge((6, 3), "-O"),
  enode((6, .5), height: 2em, box(
    fill: colors.bg,
    width: 5em,
    ```cpp rbegin()```,
  )),
  edge("-|>", label: ```cpp ++```),
  edge((6, 2), "-|>"),
  enode((0, .5), height: 2em, ```cpp rend()```),
  edge((0, 2), "-|>"),
  enode((1, -1), box(fill: colors.bg, width: 4em, ```cpp begin()```)),
  edge("-|>", label: ```cpp ++```),
  edge((1, 2), "-|>"),
  enode((7, -1), ```cpp end()```),
  edge((7, 2), "-|>"),
))

== ```cpp std::vector<T>```

```cpp
#include <vector>

std::vector<int> numbers{1, 2, 3, 4, 5};
```

Is a Container = contains its elements of type `T` (no need to allocate them).
Works similar to an ```java java.util.ArrayList<T>``` in java, although it
doesn't store the Elements as references but as copies (use
```cpp std::vector<&T>``` for that purpose).

```cpp std::vector``` can be initialized with a list of elements
- The list can be empty: ```cpp std::vector<double> vd{}```;
- Other construction means might need parentheses (legacy)

When an initializer is given, the element type can be deduced!
```cpp std::vector{1, 2, 3, 4, 5};```

Parenthesis at definition allow providing initial size, when type of elements is
not numeric
```cpp std::vector<std::string> words{6}```

Index variable type is "unsigned" ```cpp std::size_t``` or
```cpp std::vector<T>::size_type```
#align(center, diagram(
  spacing: (0pt, 0pt),
  ibnode((1, 2), `[0]`),
  ibnode((2, 2), `[1]`),
  ibnode((3, 2), `[2]`),
  ibnode((4, 2), `[3]`),
  ibnode((5, 2), `[4]`),
  ibnode((6, 2), `[5]`),
  bnode((1, 3), $x_0$),
  bnode((2, 3), $x_1$),
  bnode((3, 3), $x_2$),
  bnode((4, 3), $x_3$),
  bnode((5, 3), $x_4$),
  bnode((6, 3), $x_5$),
  edge("..|>"),
  enode((8, 3), [Growth]),
  enode((0, 4)),
  enode((2, 1)),
  enode((0, 2)),
  enode((7, 2)),
  enode((1, 4.5), height: 2em, box(width: 6em, ```cpp front()```)),
  edge((1, 3), "-O"),
  enode((6, 4.5), height: 2em, box(width: 3em, ```cpp back()```)),
  edge((6, 3), "-O"),
  enode((6, .5), height: 2em, box(
    fill: colors.bg,
    width: 5em,
    ```cpp rbegin()```,
  )),
  edge("-|>", label: ```cpp ++```),
  edge((6, 2), "-|>"),
  enode((0, .5), height: 2em, ```cpp rend()```),
  edge((0, 2), "-|>"),
  enode((1, -1), box(fill: colors.bg, width: 4em, ```cpp begin()```)),
  edge("-|>", label: ```cpp ++```),
  edge((1, 2), "-|>"),
  enode((7, -1), ```cpp end()```),
  edge((7, 2), "-|>"),
  enode((6.5, 6), box(width: 8em, ```cpp push_back(x)```)),
  edge((6.5, 3.5), "-|>"),
  enode((2.5, 6), box(width: 14em, ```cpp insert(begin() + 3, x)```)),
  edge((2.5, 3.5), "-|>"),
))

== Iteration

#table(
  columns: (auto, 1fr, 1fr),
  table-header([], [const], [non-const]),
  emph[reference],
  ```cpp
  for (auto const & cref : v) { }
  ```,

  ```cpp
  for (auto & ref : v) { }
  ```,
  emph[copy],
  ```cpp
  for (auto const ccopy : v) { }
  ```,

  ```cpp
  for (auto copy : v) { }
  ```,
)

Only use this if the iterator is required in the loop:
```cpp
for (auto it = std::begin(v); it != std::end(v); ++it) {
  std::cout << (*it)++ << ", ";
}
```
Guarantee to just have read-only access: ```cpp std::cbegin()``` and
```cpp std::cend()```

=== Algorithms

```cpp
#include <algorithm>
```

Each algorithm takes iterator arguments: The range(s) of elements to apply an
algorithm to is specified by iterators.

```cpp
auto count_blanks(std::string s) -> size_t {
  return std::count(s.cbegin(), s.cend(), ' ');
}
```

#exbox(title: "Sum", ```cpp
#include <numeric>
std::vector<int> v{5, 4, 3, 2, 1};
std::cout << std::accumulate(std::cbegin(v), std::cend(v), 0)<< "=sum\n";
```)

#exbox(title: "Nr. of elements", ```cpp
#include <iterator>
void printDistanceAndLength(std::string s) {
  std::cout << "distance: "<< std::distance(s.begin(), s.end()) <<'\n';
  std::cout << "in a string of length: "<< s.size()<<'\n';
}
```)

#exbox(title: "Foreach", ```cpp
auto print(int x) -> void {
  std::cout << "print: "<< x << '\n';
}
auto printAll(std::vector<int> v) -> void {
  std::for_each(std::crbegin(v), std::crend(v), print);
}
```)

#exbox(title: "Foreach with lambdas", ```cpp
auto printAll(std::vector<int> v, std::ostream & out) -> void {
  std::for_each(std::cbegin(v), std::cend(v), [&out](auto x) {
    out << "print: "<< x << '\n';
  });
}
```)

=== Ranges

```cpp
auto printAll(std::vector<int> v, std::ostream & out) -> void {
  std::ranges::for_each(v, [&out](auto x) {
    out << "print: "<< x << '\n';
  });
}
```

=== Putting it all together

Iterators connect containers and algorithms.

#table(
  columns: (1fr, 1fr, 2fr),
  table-header([Containers], [Iterators], [Algorithms]),
  ```cpp
  std::vector<T>
  std::string
  std::set<T>
  std::map<K, V>
  ...
  ```,
  ```cpp
  std::begin()
  std::end()
  std::rbegin()
  std::rend()
  ...
  ```,

  ```cpp
  std::count(b, e, val)
  std::ranges::count(r, val)
  std::find(b, e, val)
  std::accumulate(b, e, start)
  std::copy(b, e, b_target)
  ...
  ```,
)

== Mutating

/ Append: ```cpp v.push_back(<value>);```
/ Insert anywhere: ```cpp v.insert(<iterator-position>, <value>);```

When using the ```cpp std::copy``` algorithm the target has to be an iterator
too
```
std::copy(<in-begin-iterator>, <in-end-iterator>, <out-begin-iterator>);
std::ranges::copy(<in-range>, <out-begin-iterator>);
```
To append elements to another list, use ```cpp std::back_inserter()```:
```cpp
std::vector<int> source{1, 2, 3}, target{};
std::copy(source.cbegin(), source.cend(), std::back_inserter(target));
std::ranges::copy(source, std::back_inserter(target));
```
=== Filling
Filling a vector with the same values can be done in multiple ways:
```cpp
// std::fill requires a vector with existing elements to be overwritten
std::vector<int> v{};
v.resize(10);
std::fill(std::begin(v), std::end(v), 2);
std::ranges::fill(v, 2)
// or
std::vector<int> v(10);
std::fill(std::begin(v), std::end(v), 2);
std::ranges::fill(v, 2)
// or
std::vector<int> v(10, 2);
```
Filling a vector with different values can also be done in multiple ways
(wowzers):

The algorithms ```cpp std::generate()``` and ```cpp std::generate_n()``` fill a
range with computed values. Either use ```cpp std::back_inserter``` or a
non-empty container respectively. The ```cpp std::iota()``` algorithm fills a
range with subsequent values.

== Finding and counting elements

```cpp std::(ranges::)find()``` and ```cpp std::(ranges::)find_if()``` return an
iterator to the first element that matches the value or condition. If no match
exists the end of the range is returned.

Similarly ```cpp std::(ranges::)count()``` and
```cpp std::(ranges::)count_if()``` return the number of matching elements in a
range.

== I/O

Streams cannot be used with algorithms directly.

#table(
  columns: (1fr, 2fr, 2fr),
  table-header([Containers], [Iterators], [Algorithms]),
  ```cpp
  std::ostream
  std::istream
  ```,
  ```cpp
  std::ostream_iterator()
  std::istream_iterator()
  ```,

  ```cpp
  std::count(b, e, val)
  std::ranges::count(r, val)
  std::copy(b, e, b_target)
  ...
  ```,
)

```cpp std::istream_iterator<T>``` reads values of type `T` from the given
```cpp std::istream```. End iterator is the default constructed
```cpp std::istream_iterator<T>{}```, it ends when the stream is no longer
```cpp good()```.

```cpp std::ranges::istream_view<T>``` combines `in` and `eof`.

```cpp std::istream_iterator<T>``` uses operator ```cpp >>``` for input, which
skips white space. For an exact copy, use
```cpp std::istreambuf_iterator<char>```, which uses
```cpp std::istream::get()``` to get every character. This only works with
char-like types. ```cpp std::noskipws``` stream manipulator can also be used for
this purpose.

#exbox(```cpp
using input = std::istreambuf_iterator<char>;
input eof{};
input in{std::cin};
std::ostream_iterator<char> out{std::cout, " "};
std::copy(in, eof, out);
```)

To fill a vector from a stream you can either use copy with
```cpp std::back_inserter(v)``` (It uses ```cpp v.push_back()``` internally)

```cpp
using input = std::ranges::istream_view<int>;
std::vector<int> v{};
std::ranges::copy(input{std::cin}, std::back_inserter(v));
```

or construct the ```cpp std::vector<T>``` directly from two iterators

```cpp
using input = std::istream_iterator<int>;
input eof{};
std::vector<int> const v{input{std::cin}, eof};
```

= Functions

== Basics

=== Arguments

#table(
  columns: (auto, 1.2fr, 1fr),
  table-header([], [const], [non-const]),
  emph[reference],
  ```cpp
  auto f(char const & c) -> void { }
  ```,

  ```cpp
  auto f(char & c) -> void { }
  ```,
  emph[copy],
  ```cpp
  auto f(char const c) -> void { }
  ```,

  ```cpp
  auto f(char c) -> void { }
  ```,
)

=== Return types

In function definitions the trailing return-type could be omitted. The actual
return type will be deduced from the return statements in the function's body.

#table(
  columns: (auto, 1.2fr, 1fr),
  table-header([], [const], [non-const]),
  emph[reference],
  ```cpp
  auto f() -> type const & { }
  ```,

  ```cpp
  auto f() -> type & { }
  ```,
  emph[value],
  ```cpp
  auto f() -> type const { }
  ```,

  ```cpp
  auto f() -> type { }
  ```,
)

#exbox(title: "Incorrect", ```cpp
#include <iostream>

// here the compiler can't deduce the return type!
auto maxValue(int f, int s, int t);

// this won't compile
int main() {
  std::cout << maxValue(1, 2, 3);
}
```)

==== Const reference

```cpp const &``` extends the life-time of the temporary object, until the end
of the block.

#exbox(
  title: [The POI will be copied into the returned ```cpp std::vector```
    object],
)[
  ```cpp
  auto createPOI(Coordinate) -> POI;
  auto allPOIs(Coordinate const location) -> std::vector<POI> {
    POI const & migros = createPOI(location);
    return std::vector{migros};
  }
  ```
]

=== Overloading

```cpp
auto incr(int & var) -> void;
auto incr(int & var, unsigned delta) -> void;
```

The same function name can be used for different functions if parameter number
or types differ
- Functions cannot be overloaded just by their return type
- If the parameter type is only different in reference/object there will be
  ambiguities
- If the parameter is only different in type, there might be ambiguities (e.g.
  passing a ```cpp long``` into ```cpp int``` vs. ```cpp double```)

Resolution of overloads happens at compile-time (Ad hoc polymorphism). That also
means that the internal name of a function also contains its parameter types as
significant information.

=== Default Arguments

```cpp
auto incr(int & var, unsigned delta = 1) -> void;
```

A function declaration can provide default arguments for its parameters from the
right. Definition doesn't need to/shouldn't repeat:
```cpp
auto incr(int & var, unsigned delta) -> void {
  var += delta;
}
```
If $n$ default arguments are provided, the behavior is, as if $n+1$ versions of
the function were declared.

=== Functions as Parameters

```cpp
auto applyAndPrint(double x, auto f(double) -> double) -> void {
  std::cout << "f(" << x << ") = " << f(x) << '\n';
}
```

Type signatures (legacy):
```cpp
auto f(double) -> int
int f(double)
auto (&ref)(double) -> int
int (&ref)(double)
```
Drawback: A function parameter declared in this way does not accept a lambda
with a capture. Use ```cpp std::function```.

==== `std::function`

```cpp
#include <functional>
```

Modern C++ approach: ```cpp std::function``` template, which also allows passing
lambdas (with capture)

```cpp
std::function<auto(double) -> int>
std::function<int(double)>
```

#exbox(```cpp
auto applyAndPrint(double x, std::function<auto(double) -> double> f) -> void {
  std::cout << "f(" << x << ") = " << f(x) << '\n';
}
auto main() -> int {
  double factor{3.0};
  auto const multiply = [factor](double value) {
    return factor * value;
  };
  applyAndPrint(1.5, multiply);
}
```)

=== Lambdas

```
[<capture>](<parameters>) -> <return-type> {
  <statements>
}
```
Capture names variables taken from the surrounding scope, or define new ones (=
copy, \& reference, rename possible, type deduced). The return type can be
omitted if ```cpp void``` or if inferrable for the compiler. Parameters can be
```cpp auto``` if inferrable from context.

```cpp
auto g = [](char c) -> char {
  return std::toupper(c);
};
g('a');
```
Captured local copies are immutable, unless lambda is declared mutable and lives
as long as the lambda lives.
```cpp
int x = 5;
auto l = [x]() mutable {
  std::cout << ++x;
};
```
Capturing a local variable by reference requires the referenced variable to live
at least as long as the lambda.

Capturing all (referenced) local variables by value:
```cpp
int x = 5;
auto l = [=]() mutable {
  std::cout << ++x;
};
```

Capturing all (referenced) local variables by reference:
```cpp
int x = 5;
auto const l = [&]() {
  std::cout << ++x;
};
```
Referenced variables will allow modification, unless it is originally declared
const

Capturing ```cpp this``` pointer allows accessing and modifying members of the
class
```cpp
struct S {
  auto foo() -> void {
    auto square = [this] {
      member *= 2;
    };
  }
private:
  int member{};
};
```

New local variable can be specified in capture
- New variable in capture has type ```cpp auto```
- Can be modified if lambda is mutable
```cpp
auto squares = [x = 1]() mutable {
  std::cout << (x *= 2);
};
```
In captures multiple variables can be combined and separated with commas (`,`)

Within a single expression, such as a function call, sequence of evaluation is
undefined! (except for the #link(
  "https://en.cppreference.com/cpp/language/operator_other",
  "comma operator",
) `,`)

== Failing

A function can fail if the _precondition_ is violated (e.g. negative index,
divisor is zero, ...) or if the _postcondition_ could not be satisfied (e.g.
resources not available, cannot open file, ...)

A function without preconditions has a so-called _wide contract_ as opposed to
_narrow contract_.

What should you do, if a function cannot fulfill its purpose?
+ Ignore the error and provide potentially *undefined behavior*
  - Relies on the caller to satisfy all preconditions
  - Viable only if not dependent on other resources
  - Most efficient implementation (no unnecessary checks)
  - Simpler for the implementer but harder for the caller
+ Return a *standard result* to cover the error
  - Reliefs the caller from the need to care if it can continue with the default
    value
  - Can hide underlying problems
  - Often better if caller can specify its own default value
+ Return an *error code* or error value
  - Only feasible if result domain is smaller than return type
  - Burden on the caller to check the result
  - `std::string::npos, std::expected`
  - ```cpp std::optional``` can be checked using ```cpp has_value()``` or
    boolean conversion
+ Provide an *error status* as a side-effect
  - Requires reference parameter or global variable (bad)
  - Example: ```cpp std::istream```'s state (```cpp good(), fail()```)
+ Throw an *exception*

=== Exceptions

```cpp
throw value;
```

Any (copyable) type can be thrown and there are no means to specify what could
be thrown. No meta-information is available as part of the exception. Exception
thrown while exception is propagated results in program abort.

#exbox[```cpp
throw std::invalid_argument{"reason"};
throw 15;
```]

Catching can be done using a try catch block, where the first match wins. Throw
by value, catch by const reference avoids unnecessary copying and allows dynamic
polymorphism for class types.

Caught exceptions can be rethrown with ```cpp throw;```

#exbox[```cpp
try {
  throwingCall();
} catch (type const & e) {
  //Handle type exception
} catch (type2 const & e) {
  //Handle type2 exception
} catch (...) {
  //Handle other exception types
}
```]

The Standard Library has some pre-defined exception types that you can also use
in ```cpp <stdexcept>```.

#diagram(
  node((1.5, 0), ```cpp std::exception```),
  edge("<|-"),
  edge((1, 1), "<|-"),
  node((2, 1), ```cpp std::runtime_error```),
  node((3, 1), `...`, stroke: none),
  node((1, 1), ```cpp std::logic_error```),
  edge("<|-"),
  edge((1, 2), "<|-"),
  edge((2, 2), "<|-"),
  node((0, 2), ```cpp std::out_of_range```),
  node((1, 2), ```cpp std::invalid_argument```),
  node((2, 2), ```cpp std::length_error```),
  node((3, 2), `...`, stroke: none),
)

```cpp std::exception``` is the base class and provides the ```cpp what()```
member function to obtain the "reason", which is passed as a construction
parameter.

Testing with Catch2 can be done as follows:

#exbox(
  title: [
    REQUIRE_THROWS(code) when an exception is expected
  ],
  ```cpp
  TEST_CASE("square_root of negative value throws") {
    REQUIRE_THROWS(square_root(-1.0));
  }
  ```,
)

#exbox(
  title: [
    REQUIRE_THROWS_AS(code, exception_type) when a specific type is expected to
    be thrown
  ],
  ```cpp
  TEST("at on empty vector throws std::out_of_range") {
    std::vector<int> empty_vector{};
    REQUIRE_THROWS_AS(empty_vector.at(0), std::out_of_range);
  }
  ```,
)

#exbox(
  title: [
    REQUIRE_THROWS_WITH(code, string or string-matcher) for exception content
  ],
  ```cpp
  TEST("parseInt of "one" throws with message") {
    REQUIRE_THROWS_WITH(parseInt("one"), "parse error – invalid digits in 'one'");
  }
  ```,
)

You can make your program terminate when an exception is thrown by using the
```cpp noexcept``` keyword after a function param definition.

```cpp
auto add(int lhs, int rhs) noexcept -> int {
  return lhs + rhs;
}
```

#todo[lifetime extension through const & can only be done for temporary
  lifetimes?
]

= Classes and Operators

A class defines a new type and is usually defined in a header file

```cpp
class <GoodClassName> {
  <member variables>
  <constructors>
  <member functions>
};
```

A good class:

- Does one thing well and is named after that
- Consists of member functions with only a few lines and no deep nesting
- Has a class invariant (Provides a guarantee about its state). Constructors
  establish that invariant
- Is easy to use without complicated protocol sequence requirements

== Declaration

#exbox(title: `Date.hpp`, ```cpp
#ifndef DATE_HPP_
#define DATE_HPP_
class Date {                                // class keyword
  int year, month, day;                     // member variables
public:                                     // access specifier
  Date();                                   // default constructor
  Date(Date const &);                       // copy constructor
  Date(Date &&);                            // move constructor
  explicit Date(int year,                   // type conversion
                int month = 1,              // constructor
                int day = 1);
  ~Date();                                  // destructor
  static auto isLeapYear(int year) -> bool; // public member function
private:                                    // access specifier
  auto isValidDate() const -> bool;         // private member function
};                                          // ends with semicolon ;
#endif
```)

Keywords for defining a class are ```cpp class``` and ```cpp struct```. Default
visibility for members of the class are
- `private` for ```cpp class```
- `public` for ```cpp struct```

=== Access specifiers

Access specifiers (followed by a colon `:`)
/ private: visible only inside the class (and friends); for hidden data members
/ protected: also visible in subclasses
/ public: visible from everywhere; for the interface of the class

All subsequent members have this visibility. Each visibility can reoccur
multiple times.

=== Member variables

Member variables have a type and a name `<type> <name>;` Don't make member
variables ```cpp const``` as it prevents copy assignment.

=== Constructor

A special member function with the name of the class and no return type. Can
have an initializer list for member initialization.
```
<class-name>(<parameters>)
  : <initializer-list>
{}
```

==== Default constructor

```cpp
Date d{};
```

It has no parameters, is implicitly available if there are no other declared
constructors and has to initialize member variables with default values. E.g.
```cpp Date();```

==== Copy constructor

```cpp
Date d2{d};
Date d3 = d;
```

It has one ```cpp Type const &``` parameter and is implicitly available unless
there is a move constructor or assignment operator. It copies all member
variables and is usually not needed to be implemented explicitly.

==== Move constructor

```cpp
Date d2{std::move(d)};
```
It has one ```cpp Type &&``` parameter and is implicitly available unless there
is a copy constructor or assignment operator. It moves all members and is
usually not needed to be implemented explicitly.

==== Type conversion constructor

```cpp
Date d{2001, 11, 9};
```

Constructors that are callable with a single argument of a different type are
called type-conversion constructors.

They have either a single parameter or multiple parameter, which have default
arguments for all parameters after the first.

Type-conversion constructors should be declared ```cpp explicit```, which avoids
unexpected implicit conversion (the compiler is allowed to make one implicit
conversion to resolve the parameters to a function).

==== Initializer list constructor

```cpp
Container box{item1, item2, item3};
```

Has one ```cpp std::initializer_list``` parameter and does not need to be
explicit, as implicit conversion is usually desired.
#todo[Initializer List constructors are preferred if a variable is initialized
  with {}]

#exbox[```cpp
struct Container {
  Container() = default;
  Container(std::initializer_list<Element> elements);
private:
  std::vector<Element> elements{};
};
```]

=== Destructor

Named like the default constructor but with a leading `~`. It must release all
resources and must not throw an exception. It is implicitly available and called
automatically at the end of the block for local instances.

== Inheritance

Base classes are specified after the name (multiple inheritance is possible)
```
class <name> : <base1>, ..., <baseN>
```

Inheritance can specify a visibility (public, protected, private), which limits
the maximum visibility of the inherited members. If no visibility is specified,
the default of the inheriting class is used (class $->$ private and struct $->$
public)

#exbox(grid(
  columns: 2,
  ```cpp
  class Base {
  private:
    int onlyInBase;
  protected:
    int baseAndInSubclasses;
  public:
    int everyoneCanFiddleWithMe
  };
  ```,
  ```cpp
  class Sub : public Base {
    // Can see baseAndInSubclasses
    // and everyoneCanFiddleWithMe
  };
  ```,
))

== Implementation

=== Constructors

#exbox[```cpp
#include "Date.hpp"

Date::Date(int year, int month, int day)
  : year{year}, month{month}, day{day} {
  if (!isValidDate()) {                         // only create valid
    throw std::out_of_range{"invalid date"};    // instances, throw if
  }                                             // invalid
}
Date::Date() : Date{1980, 1, 1} {               // default values
}
Date::Date(Date const & other)
  : Date{other.year, other.month, other.day} {
}
```]

One must initialize all members and enforce an invariant (properties for a value
of the type that are always true).

==== Default Initialization

```
class <classname> {
  <type> <membername>{<default-value>};
};
```

Member variables can have a default value assigned (NSDMI - Non-Static Data
Member Initializers). Such values are used if the member is not present in the
initializer list of the constructor. The initializer list still overrides those
values.

#exbox(title: "Default initialization for members")[
  ```cpp
  // Date.hpp
  class Date {
    int year{9999}, month{12}, day{31};
    Date();
    Date(int year, int month, int day);
  };

  // Date.cpp
  Date::Date() { }                           // Date = 31.12.9999
  Date::Date(int year, int month, int day)
    : year{year}, month{month}, day{day} { } // Date = day.month.year
  ```
]

==== Default constructors

Some special member functions are implicitly available in certain cases (e.g.
default constructor is implicitly available if no other explicit constructor is
declared).

(Re-)implementing the default behavior of the default constructor can be avoided
by defaulting it ```cpp <constructor>() = default;```

The implicit constructor are not always wanted. One can make them explicitly
private or delete them using ```cpp <constructor>() = delete;```

Possible for:
- Default constructor and destructor
- Copy/move constructor
- Copy/move assignment operator

==== Delegating constructors

Constructors can call other constructors. For that the constructor call has to
be in the member initializer list.

#exbox[
  ```cpp
  // Date.hpp
  class Date {
    Date(Year year, Month month, Day day);
    Date(int year, int month, int day);
  };

  // Date.cpp
  Date::Date(int year, int month, int day)
    : Date{Year(year), Month(month), Day(day)} { }
  ```
]

Similar are calls to constructors of base classes

```
Constructor(Parameters)
  : Base{Arguments} {
}
```

=== Member functions

An implicit ```cpp this``` object is available in the scope of a member
function. It's a pointer, so member variables can be accessed with an arrow:
`->`.

If a member function is ```cpp const``` then it must not modify members and can
only call ```cpp const``` member functions.

#exbox(
  ```cpp
  auto Date::isValidDate() const –> bool {
    if (day <= 0) // day is equivalent to this->day
      return false;
    switch (this->month) {
      case 1: case 3: case 5: case 7: case 8: case 10: case 12:
        return this->day <= 31;
      case 4: case 6: case 9: case 11:
        return this->day <= 30;
      case 2:
        return this->day <= (isLeapYear(this->year) ? 29 : 28);
      default:
        return false;
    }
  }
  ```,
)

==== Static member functions

Static member functions cannot be ```cpp const``` and have no ```cpp this```
object. No ```cpp static``` keyword is needed in implementation, only in
declaration. Call with `<classname>::<member>()`

#exbox[
  ```cpp
  class Date {
    static auto isLeapYear(int year) -> bool;
  };
  ```
]

=== Static member variables

No ```cpp static``` keyword is needed in implementation, only in declaration.
```cpp static const``` member can be initialized directly Access outside class
with name qualifier: `<classname>::<member>`

#exbox[
  ```cpp
  // Date.hpp
  class Date {
    static const Date myBirthday;
    static Date favoriteStudentsBirthday;
    static const Date today{2018, 10, 16};
  };

  // Date.cpp
  Date const Date::myBirthday{1964, 12, 24};
  Date Date::favoriteStudentsBirthday{1995, 5, 10};
  std::cout << Date::myBirthday;
  ```
]

== Operator overloading

Custom operators can be overloaded for user-defined types. They're declared like
a function, with a special name. Unary operators have one parameter, binary
operators have two (duh).

```cpp
auto operator op(<parameters>) -> <returntype>

<returntype> operator op(<parameters>)
```

Overloadable operators:
#grid(
  columns: 16,
  `+`,
  `-`,
  `*`,
  `/`,
  `%`,
  `^`,
  `&`,
  `|`,
  `~`,
  `!`,
  `,`,
  `=`,
  `<`,
  `>`,
  `<=`,
  `>=`,

  `++`,
  `--`,
  `<<`,
  `>>`,
  `==`,
  `!=`,
  `&&`,
  `||`,
  `+=`,
  `-=`,
  `/=`,
  `%=`,
  `^=`,
  `&=`,
  `|=`,
  `*=`,

  `<<=`,
  `>>=`,
  `[]`,
  `()`,
  `->`,
  `->*`,
  `new`,
  `new[]`,
  `delete`,
  `delete[]`,
  `<=>`,
)
Non-Overloadable operators:
#grid(
  columns: 16,
  `::`, `.*`, `.`, `?:`,
)
The three-way-comparison operator (also called spaceship operator, `<=>`) can be
implemented to provide all relational (`<, >, <=, >=`) comparisons at once.

#exbox[
  #todo[fix typst cpp starship parsing]

  ```cpp
  #include <compare>

  class Date {
    int year, month, day;
  public:
    auto operator<=>(Date const& right) const -> std::strong_ordering {
      if (year != right.year) {
        return year <=> right.year;
      }
      if (month != right.month) {
        return month <=> right.month;
      }
      return day <=> right.day;
    }
    auto operator==(Date const& right) const -> bool {
      return (*this <=> right) == std::strong_ordering::equal;
    } // Also allows != comparison
  };
  ```
]

=== Defaulting comparison Operators

The compiler can generate the three-way-comparison operator by defaulting it.
Three-way compares the members in declaration order and implicitly generates the
equality operator as well.
```cpp
class Date {
  int year, month, day;
public:
  auto operator<=>(Date const& right) const = default;
};
```
If you only want equality/inequality, that is possible as well.
```cpp
class Point {
  int x, y;
public:
  auto operator==(Point const& right) const = default;
};
```

=== Ordering

/ Strong order: Values that are equivalent/equal are indistinguishable. Either
  ```cpp a < b```, ```cpp a == b``` or ```cpp a > b``` must be ```cpp true``` \
  ```cpp std::strong_ordering::less``` #h(1fr) for ```cpp a < b``` \
  ```cpp std::strong_ordering::equivalent``` , #h(.5em)
  ```cpp std::strong_ordering::equal``` #h(1fr) for ```cpp a == b``` \
  ```cpp std::strong_ordering::greater``` #h(1fr) for ```cpp a > b``` \
/ Weak order: Values that are equivalent/equal _may be_ distinguishable. Either
  ```cpp a < b```, ```cpp a == b``` or ```cpp a > b``` must be ```cpp true```.
  E.g. ignoring letter case on strings. \
  ```cpp std::weak_ordering::less``` #h(1fr) for ```cpp a < b``` \
  ```cpp std::weak_ordering::equivalent``` #h(1fr) for ```cpp a == b``` \
  ```cpp std::weak_ordering::greater``` #h(1fr) for ```cpp a > b``` \
/ Partial order: Values that are equivalent/equal _may be_ distinguishable.
  Either ```cpp a < b```, ```cpp a == b``` or ```cpp a > b``` _can all be_
  ```cpp false```. E.g. ```cpp double``` as ```cpp NaN``` always compares
  ```cpp false``` even with itself! ```cpp std::isnan``` is required. \
  ```cpp std::partial_ordering::less``` #h(1fr) for ```cpp a < b``` \
  ```cpp std::partial_ordering::equivalent``` #h(1fr) for ```cpp a == b``` \
  ```cpp std::partial_ordering::greater``` #h(1fr) for ```cpp a > b``` \
  ```cpp std::partial_ordering::unordered``` #h(1fr) for none of the above \

=== ```cpp std::ostream``` ```cpp std::istream```

Output operator must be a free function.
- Parameters: ```cpp std::ostream&``` and ```cpp Type const&```
- Returns ```cpp std::ostream&``` for chaining output

#exbox[```cpp
#include <ostream>

class Date {
  int year, month, day;
public:
  auto print(std::ostream& os) const -> void {
    os << year << "/" << month << "/" << day;
  }
};

inline auto operator<<(std::ostream& os, Date const& date) -> std::ostream& {
  date.print(os);
  return os;
}
```]

Similar for ```cpp std::istream```: Input operator must be a free function.
- Parameters: ```cpp std::istream&``` and ```cpp Type &```
- Returns ```cpp std::istream&``` for chaining output

#todo[
  exceptions come with runtime overhead due to compiler generated scaffolding
  and runtime type information
]

= Namespaces

Namespaces are scopes for grouping and preventing name clashes. The global
namespace has the `::` prefix, it can be omitted if unique. E.g. `::std::cout`
is usually equal to `std::cout`. Namespaces can only be defined outside of
classes and functions.

#exbox[
  ```cpp
  namespace demo {
    auto foo() -> void;             // 1
    namespace subdemo {
      auto foo() -> void { }        // 2
    }
  }
  namespace demo {
    auto bar() -> void {
      foo();                        // 1
      subdemo::foo();               // 2
    }
  }
  auto demo::foo() -> void { }      // 1
  auto main() -> int {
    using demo::subdemo::foo;
    foo();                          // 2
    demo::foo();                    // 1
    demo::bar();
  }
  ```
]

Omitting a name after ```cpp namespace``` hides module internals, it should be
only used in source files (`*.cpp`). The compiler chooses a unique internal
identifier for the anonymous namespace.

== Name resolution

=== Using

- Import a name from a namespace into the current scope:
  ```cpp using std::string;```
- Alias: ```cpp using str = std::string;```
- Importing *all* namespaces: ```cpp using namespace std;```
  - use only in local scope to avoid pollution

=== Argument Dependent Lookup (ADL)

Argument Dependent Lookup is when the compiler encounters an unqualified
function or operator call with an argument of a user-defined type and looks into
the namespace in which that type is defined to resolve the function/operator.

E.g. it is not necessary to write ```cpp std::``` in front of ```cpp for_each```
when ```cpp std::vector::begin()``` is an argument of the function.

==== Operators

Unqualified operator calls don't allow explicit namespace qualification. E.g.
#{
  show "calendar::<<": underline.with(stroke: wave(stroke: colors.red + 1pt)) // "
  ```
  std::cout calendar::<< birthday;
  ```
}

Functions and operators are looked up in the namespace of the type of their
arguments first. E.g. namespaces `std` and `calendar` for
`std::cout << birthday;`

#exbox(
  title: "Cursed example of C++ implicitly doing shit nobody asked for",
  grid(
    columns: 2,
    ```cpp
    // Adl.hpp
    namespace one {
      struct type_one{};
      auto f(type_one) -> bool {}
    }
    namespace two {
      struct type_two{};
      auto f(type_two) -> void {}
      auto g(one::type_one) -> void {}
      auto h(one::type_one) -> void {}
    }
    auto g(two::type_two) -> void {}
    ```,

    ```cpp
    // Adl.cpp
    #include "Adl.hpp"
    int main() {
      one::type_one t1{};
      f(t1);              // one::f
      two::type_two t2{};
      f(t2);              // two::f
      h(t1);              // ???
      two::g(t1);         // two::g
      g(t1);      // (error) ::g
      g(t2);              // ::g
    }
    ```,
  ),
)

==== More ADL Issues

Generic code (Templates) might not pick up a global ```cpp operator<<``` in an
algorithm call using ```cpp ostream_iterator``` if the value output is from
namespace ```cpp std``` too. E.g. ```cpp std::vector<int>```

#todo[W6 S17,18]

= Enums

#grid(
  columns: (1fr, 1fr),
  ```
  enum <name> {
    <enumerators>
  };
  ```,
  ```
  enum class <name> {
    <enumerators>
  };
  ```,
)

== Defining

An enumeration creates a new type that can easily be converted to an integral
type (unscoped enumeration only). Conversion from an integral type to an
enumeration is not possible implicitly.

#exbox[```cpp
enum DayOfWeek {
  Mon, Tue, Wed, Thu, Fri, Sat, Sun
};
```]

The individual values (enumerators) are specified in the type. Unless specified
explicitly, the values start with 0 and increase by 1. With `=` values can be
specified for enumerators. Subsequent enumerators get the value incremented
`+1`. Different enumerators can have the same value (because why shouldn't
they).

#exbox[```cpp
enum Month {
  jan = 1, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec,
  january = jan, february, march, april, june, july, august,
  september, october, november, december, bestmonthoftheyear = 6
};
```]

== Scoped vs unscoped

Unscoped enumeration (without the ```cpp class``` keyword) converts implicitly
to ```cpp int```. Scoped enumeration on the other hand requires a
```cpp static_cast``` like so:
```cpp
int day = static_cast<int>(DayOfWeek::Sun);
```
Conversion from ```cpp int``` to ```cpp enum``` always requires a
```cpp static_cast```:
```cpp
DayOfWeek tuesday = static_cast<DayOfWeek>(1);
```

Unscoped enumerators leak into surrounding scope, scoped enumerators don't:

#exbox(grid(
  emph[Unscoped],
  ```cpp
  namespace calendar {
  enum DayOfWeek {
    Mon, Tue, Wed, Thu, Fri, Sat, Sun
  };
  //Enumerators are visible here
  }
  auto isWeekend(calendar::DayOfWeek day) -> bool {
    return day == calendar::Sat ||
    day == calendar::Sun;
  }
  ```,
  emph[Scoped],
  ```cpp
  namespace calendar {
  enum class DayOfWeek {
    Mon, Tue, Wed, Thu, Fri, Sat, Sun
  };
  }
  auto isWeekend(calendar::DayOfWeek day) -> bool {
    return day == calendar::DayOfWeek::Sat ||
    day == calendar::DayOfWeek::Sun;
  }
  ```,
))

== Implementing

Operators can be overloaded for enums just like with classes.

=== Specifying the underlying type

Enumerations can specify the underlying type by inheritance. The underlying type
can be any integral type. This allows forward-declaring enumerations or it can
be used to hide implementation details if defined as a class member.

#exbox[```cpp
enum class LaunchPolicy
  : unsigned char
{
  sync = 1,
  async = 2,
  gpu = 4,
  process = 8,
  none = 0,
}
```]

#todo[W6 S28,34(addable),35,36,39]

= User-Defined Literals

ngl, even though this makes C++ even more cursed, it is kinda cool:
User-defined literals allow to defined suffixes to constants to change their
type or value.

```
constexpr auto operator""<suffix>(<parameter>) -> <type>;
```

Caveats:

Must be put in a (separate) namespace
```cpp
namespace R5 {
constexpr auto operator""_r5(unsigned long long v) -> Ring5 {
  return Ring5{static_cast<unsigned>(v % 5)};
}
}
```
Requires using namespace directive

```cpp
using namespace R5;
static_assert(Ring5{2} == 7_r5, "UDL operator");
```

= STL Containers and Iterators

#{
  let node = node.with(width: 2em, height: 2em)
  table(
    columns: (1fr, 1fr, 1fr),
    [Sequence Containers],
    [Associative Containers],
    [Hashed Containers\ (Unordered Associative)],

    [
      Elements are accessible in order as they were inserted/created

      Find in linear time through the algorithm `std::find`
    ],
    [
      Elements are accessible in sorted order

      Find as member function in logarithmic time
    ],
    [
      Elements are accessible in unspecified order

      Find as member function in constant time
    ],

    align(center, diagram(
      node(enclose: (<a>, (3, 0), <c>, <d>)),
      node((0, 0), [A], name: <a>),
      node((1, 0), [C], name: <c>),
      node((2, 0), [D], name: <d>),
      node((2.5, 1), [B], name: <b>),
      edge(<n>, "-|>", bend: -30deg),
      node((3, 0), " ", name: <n>, stroke: colors.black),
    )),

    align(center, diagram(
      node(enclose: (<a>, <b>, <c>, <d>)),
      node((0, 0), [A], name: <a>),
      node((1.5, 1), [B], name: <n>),
      edge(<b>, "-|>", bend: 30deg),
      node((1, 0), [ ], name: <b>, stroke: colors.black),
      node((2, 0), [C], name: <c>),
      node((3, 0), [D], name: <d>),
    )),

    align(center, diagram(
      node(enclose: (<a>, <b>, <c>, <d>)),
      node((0, 0), [D#sub[\#1]], name: <a>),
      node((1, 0), sub[\#2], name: <b>, stroke: colors.black),
      node((1.5, 1), [Z#sub[\#3]], name: <n>),
      edge(<c>, "-|>", bend: -30deg),
      node((2, 0), sub[\#3], name: <c>, stroke: colors.black),
      node((3, 0), [A#sub[\#4]], name: <d>),
    )),
  )
}

All containers have the same/a similar basic interface

#table(
  columns: (1fr, 2fr),
  [Member Function], [Purpose],
  ```cpp begin()
  end()```,
  [Get iterators for algorithms and iteration in general],

  ```cpp erase(iter)
  ```,
  [Removes the element at position the iterator `iter` points to],

  ```cpp insert(iter, value)
  ```,
  [Inserts `value` at the position the iterator `iter` points to],

  ```cpp size()
  empty()```,
  [Check the size of the container],
)

#align(center, diagram(
  spacing: (0pt, 0pt),
  node(enclose: ((1, .5), (6.5, .5)), shape: fletcher.shapes.brace.with(
    dir: top,
    label: ```cpp size()```,
  )),
  ibnode((1, 2), `[0]`),
  ibnode((2, 2), `[1]`),
  ibnode((3, 2), `[2]`),
  ibnode((4, 2), `[3]`),
  ibnode((5, 2), `[4]`),
  ibnode((6, 2), `[5]`),
  bnode((1, 3), $x_0$),
  bnode((2, 3), $x_1$),
  bnode((3, 3), $x_2$),
  bnode((4, 3), $x_3$),
  bnode((5, 3), $x_4$),
  bnode((6, 3), $x_5$),
  enode((0, 4)),
  enode((2, 1)),
  enode((0, 2)),
  enode((7, 2)),
  enode((1, 4.5), height: 2em, box(
    fill: colors.bg,
    width: 9em,
    ```cpp erase(begin())```,
  )),
  edge((1, 3), "<|-<|"),
  enode((6.5, 4.5), height: 2em, box(
    fill: colors.bg,
    width: 10em,
    ```cpp insert(end(), x)```,
  )),
  edge((6.5, 3), "-|>"),
  enode((1, .5), box(fill: colors.bg, width: 5.5em, ```cpp begin()
  cbegin()```)),
  edge((1, 2), "-|>"),
  enode((7, .5), box(fill: colors.bg, width: 4.5em, ```cpp end()
  cend()```)),
  edge((7, 2), "-|>"),
))

Containers can be:
- default-constructed ```cpp std::vector<int> v{};```
- copy-constructed from another container of the same type
  ```cpp std::vector<int> vv{v};```
- equality compared if they are of the same type (or even lexicographically
  compared with relational operators) as long as their elements can be compared
  accordingly ```cpp v == vv```
- emptied with ```cpp v.clear();```

#todo[W7 S11]

#todo[diagrams for all containers]

== Containers

=== Sequence Containers

#todo[W7 S13, explain
  #h(1fr)
  ```cpp std::vector<T>``` #h(1em) ```cpp std::deque<T>``` #h(1em)
  ```cpp std::list<T>``` #h(1em) ```cpp std::array<T>``` #h(1fr)
]

==== `std::array`

```cpp
#include <array>

std::array values{1, 1, 3, 6, 9};
```
An array is a fixed-size "container" to which one cannot insert/append. It can
be initialized at compile-time. One should use std::array instead of C-style
arrays when defining arrays.

==== `std::deque<T>`

```cpp
#include <deque>

std::deque<int> q{begin(v), end(v)};
```
```cpp std::deque``` is like ```cpp std::vector``` but with additional,
efficient front insertion/removal ```cpp push_front()``` and
```cpp pop_front()```.
#todo[Special implementation for ```cpp bool```: ```cpp std::vector<bool>``` and
  ```cpp std::deque<bool>```]

==== `std::list<T>`

```cpp
#include <list>

std::list<int> l(5, 1);
```

It's basically a doubly-linked list. Efficient insertion in any position
```cpp insert(next(begin(), 3), x)```, but lower efficiency in bulk operations.
Requires member-function call for ```cpp sort()``` etc. Only bi-directional
iterators - no index access!

==== `std::forward_list<T>`

```cpp
#include <forward_list>

std::forward_list<int> l{1, 2, 3, 4, 5, 6};
```

It's basically a singly-linked list, meaning efficient insertion *after* any
position, but clumsy with iterator to get "before" position. It only has
forward-iterators and it's clumsy to search and remove. Use member-functions not
algorithms, or avoid completely, except when there is a specific need. Better
use ```cpp std::list``` or even better ```cpp std::vector```

=== Adapters

Adapters are no longer a container, due to the deliberate limitation.

==== `std::stack`

```cpp
#include <stack>

std::stack<int> s{};
s.push(42);
std::cout << s.top();
s.pop();                // does not return the popped element!
```

This LIFO adapter uses ```cpp std::deque``` (or ```cpp std::vector```,
```cpp std::list```) but limits its functionality to stack operations
(```cpp push_back()```, ```cpp back()``` and ```cpp pop_back()```). Iteration is
thus not possible.

==== `std::queue`

```cpp
#include <queue>

std::queue<int> q{};
q.push(42);
std::cout << q.front();
q.pop();
```

This FIFO adapter uses ```cpp std::deque``` (or ```cpp std::list```) and limits
its functionality to queue operations (```cpp push_back()``` and
```cpp pop_front()```). Iteration is thus not possible.

==== `std::priority_queue`

```cpp
#include <stack>

std::priority_queue<int> q{};
```

This adapter uses ```cpp std::deque``` (or ```cpp std::vector```) and limits its
functionality to stack operations but keeps elements partially sorted as
(binary) heap. ```cpp top()``` element is always the smallest (requires element
type to be comparable).

=== Associative Containers

Associative Containers, also called Sorted Tree Containers, allow searching by
content, not by sequence. So you can search by key, access key or key-value
pair.

#table(
  columns: (1fr, 1fr, 1fr),
  [], [Key Only], [Key-Value Pair],
  emph[Key Unique], ```cpp std::set<T>```, ```cpp std::map<K, V>```,
  emph[Multiple Equivalent Keys],
  ```cpp std::multiset<T>```,
  ```cpp std::multimap<K, V>```,
)

==== `std::set<T>`

```cpp
#include <set>

std::set<char> vowels{'a', 'e', 'o', 'u', 'i', 'y'}
```

The set stores elements in sorted order (ascending by default, but order can be
overwritten by the 2nd template parameter).
#todo[
  Iteration walks over the elements in order, keys cannot be modified through
  iterators. Use member functions for ```cpp .find()``` and ```cpp .count()```
  - Tree-search instead of sequential search
  - Result of ```cpp .count(element)``` is either 0 or 1
  - Since C++20 there is a ```cpp .contains(element)``` member
]


==== `std::map<K, V>`

```cpp
#include <map>

std::map<char, size_t> vowels{
  {'a', 3}, {'e', 8}, {'i', 5}, {'o', 4}, {'u', 2}, {'y', 1}
};
```

Map stores key-value pairs in sorted order (Sorted by key in ascending order,
order can be overwritten by the 3rd template parameter). Iterators access
```cpp std::pair<key, value>```. Use ```cpp .first``` for key and
```cpp .second``` for value.

The indexing operator ```cpp []``` inserts a new entry automatically if key is
not present! The key is the argument of the index operator, values is the
default value of the value type. It returns the value by reference, which allows
modification.

==== `std::multiset<T>` and `std::multimap<K, V>`

```cpp
#include <set>
#include <map>

std::multiset<char> letters{'a', 'a', 'c', 'c', 'c', 'f'};
std::multimap<int, char> cletters{
  {1, 'a'}, {1, 'c'}, {2, 'a'}, {2, 'c'}, {2, 'f'}
};
```

Multiple equivalent keys allowed, use ```cpp equal_range()``` or
```cpp lower_bound()``` / ```cpp upper_bound()``` member functions/algorithms to
find boundaries of equivalent keys.

#todo[W7 S31,32]

=== Hashed Containers

==== `std::unordered_set<T>`

```cpp
#include <unordered_set>

std::unordered_set<char> vowels{'a', 'e', 'i', 'o', 'u'};
```

C++11 introduced associative containers using hashing which have more efficient
lookup and no sorting. The standard lacks feature for creating your own hash
functions, but tere are ```cpp std::hash<T>``` functor for library types and
built-in types provided, esp. ```cpp std::string```. DIY programming of hash
functions is hard and prone to failure, i.e. it might produce too many
collisions $->$ stick to standard types, like ```cpp std::string``` for keys.

==== `std::unordered_map<K, V>`

```cpp
#include <unordered_map>

std::unordered_set<std::string, int> words{
  {"theanswer", 42}, {"h4x0r", 1337}, {"nice", 69}
};
```

Usage is almost equivalent to ```cpp std::map``` except for the lack of
ordering.

== Iterators

#grid(
  columns: 2,
  [
    Different containers support iterators of different capabilities. Categories
    are formed around increasing "power".
    - ```cpp std::input_iterator``` corresponds to ```cpp istream_iterator```'s
      capabilities
    - ```cpp std::ostream_iterator``` is an ```cpp output_iterator```
    - ```cpp std::vector<T>``` provides ```cpp random_access``` iterators
  ],
  diagram(
    spacing: (.5em, .5em),
    node((0, -.1), " ", stroke: none),
    node((2, 0), [Output Iterator]),
    node((0, 0), [Input Iterator]),
    node((0, 1), stroke: none, [Forward Iterator]),
    node((0, 2), stroke: none, [Bidirectional Iterator]),
    node((0, 3), stroke: none, [Random Access Iterator]),
    node(inset: 0pt, enclose: ((0, -1), (0, 1))),
    node(inset: 0pt, enclose: ((0, -2), (0, 0), (0, 2))),
    node(inset: 0pt, enclose: ((0, -3), (0, 0), (0, 3))),
  ),
)

=== Categories

Some algorithms only work with powerful iterators, e.g. ```cpp std::sort()```
requires a pair of random access iterators (it needs to jump forward and
backward). Some algorithms can be implemented better with more powerful
iterators E.g. ```cpp std::advance()``` or ```cpp std::distance()```.
#todo[Categories are enforcable with C++20 concepts]

#exbox(```cpp
template<class InputIt, class OutputIt>
auto copy(InputIt first, InputIt last, OutputIt result) -> OutputIt;

template<class RandomAccessIterator>
void sort(RandomAccessIterator first, RandomAccessIterator last);
```)

==== Input Iterator

#todo[
  #grid(
    columns: 2,
    [
      Supports reading the "current" element of type ```cpp Element```

      It allows for one-pass input algorithms, cannot step backwards.

      It models the ```cpp std::istream_iterator``` and ```cpp std::istream```

      It can be compared with ```cpp ==``` and ```cpp !=``` to other iterator
      objects of the same type: ```cpp It```

      It can be copied, after increment (calling ```cpp ++```) all other copies
      are invalid! ```cpp *it++``` is allowed explicitly (by the standard)
    ],
    ```cpp
    struct input_iterator_tag{};

    auto operator* () -> Element;
    auto operator++() -> It&;
    auto operator++(int) -> It;
    auto operator==(It const&) -> bool;
    auto operator!=(It const&) -> bool;
    auto operator= (It const&) -> It&;
    It(It const&); //copy ctor
    ```,
  )
]

==== Forward Iterator

#todo[
  #grid(
    columns: 2,
    [
      It can do whatever an input iterator can, plus changing the "current"
      element (of type ```cpp Element```), unless the container or its elements
      are ```cpp const```.

      It still allows only for one-pass input algorithms, cannot step backwards,
      but can keep iterator copy around for later reference.

      It models the ```cpp std::forward_list``` iterators.
    ],
    ```cpp
    struct forward_iterator_tag{};

    // all from input iterator
    ```,
  )
]

==== Bidirectional Iterator

#todo[
  #grid(
    columns: 2,
    [
      It can do whatever a forward iterator can, plus going backwards. It allows
      for forward-backward-pass algorithms and models the ```cpp std::set```
      iterators.
    ],
    ```cpp
    struct bidirectional_iterator_tag{};

    // all from forward iterator plus
    auto operator--() -> It&;
    auto operator--(int) -> It;
    ```,
  )
]

==== Random Access Iterator

#todo[
  #grid(
    columns: 2,
    [
      It can do whatever a bidrectional iterator can, plus:
      - Directly access element at index (offset to current position): distance
        can be positive or negative
      - Go $n$ steps forward or backward
      - "Subtract" two iterators to get the distance
      - Compare with relational operators (```cpp <, <=, >, >=```)
      It allows random access in algorithms and models the ```cpp std::vector```
      iterators.
    ],
    ```cpp
    struct random_access_iterator_tag{};

    // all from bidirectional iterator plus
    auto operator[](distance) -> Element&;
    auto operator+(distance) -> It;
    auto operator+=(distance) -> It&;
    auto operator-(distance) -> It;
    auto operator-=(distance) -> It&;
    auto operator-(It const &) -> distance;
    //relational operators, like <
    ```,
  )
]

==== Output Iterator

#todo[
  #grid(
    columns: 2,
    [
      It can write value to current element, but only once
      (```cpp *it = value```), then increment is required. Itys modeled after
      ```cpp std::ostream_iterator```. Most other iterators can also act as
      output iterators, unless the underlying container is const, except for
      associative containers, they allow only read-only iteration. No comparison
      and end to an out range is not queryable.
    ],
    ```cpp
    struct output_iterator_tag{};

    auto operator*() -> Element&;
    auto operator++() -> It&;
    auto operator++(int) -> It;
    ```,
  )
]

=== Functions

==== `std::distance`

```cpp
#include <iterator>;

std::distance(start, goal);
```

It counts the number of "hops" iterator start must make until it reaches goal.
Efficient for random access iterators, for other iterators the algorithm has to
hop to the element one-by-one. This implies that goal has to be "after" start.
I.e. reachable by an arbitrary number of ```cpp ++``` calls.

==== `std::advance`

```cpp
#include <iterator>;

std::advance(iter, n);
```

It lets ```cpp iter``` "hop" ```cpp n``` times. Efficient for random access
iterators, for other iterators, the algorithm has to loop. It also allows
negative ```cpp n``` for bidirectional iterators.

==== `std::next`

```cpp
#include <iterator>;

std::next(iter);
```

It has a default step of size 1, but can be specified. It makes a copy of the
argument, the argument can also be a temporary.

```cpp std::advance``` on the other hand requires a step, modifies the argument
iterator and returns void.

#exbox(```cpp
auto main() -> int {
  std::vector primes{2, 3, 5, 7, 11, 13};

  auto current = std::begin(primes);
  auto afterNext = std::next(current);
  std::cout << "cur: " << *current << " after: " << *afterNext << '\n';

  std::advance(current, 1);
  std::cout << "cur: " << *current << " after: " << *afterNext << '\n';
}
```)

=== A word on mutability

Declaring an iterator ```cpp const``` would not allow modifying the iterator object
(E.g. you cannot call ```cpp ++```).
```cpp cbegin()``` and ```cpp cend()``` return ```cpp const_iterators```:
This does not imply the iterator to be ```cpp const```,
the elements the iterator walks over are ```cpp const```.

#pagebreak()
#bibliography("./cit.bib")

// TODO:
// - summary W5 s23
// Is it possible to provide the overloads of `Date`'s constructors to allow writing `Date{1, Nov, 2012}` and `Date{Nov, 1, 2012}`?
// W5 S26 default initialization, when does what get called
//    struct Date { int year; }; (no constructor/with constructor)
//    class Date { int year; };
//    Date d{};
//    Date d;
#todo(table(
  columns: 4,
  [], ```cpp Date d;```, ```cpp Date d{};```, ```cpp Date d{1,2,3};```,
  ```cpp
  struct Date {
    int year, month, day;
  };
  ```,
  [],
  [],
  [],

  ```cpp
  class Date {
    int year, month, day;
  };
  ```,
  [],
  [],
  [],

  ```cpp
  class Date {
    int year{4}, month{5}, day{6};
  };
  ```,
  [],
  [],
  [],

  ```cpp
  class Date {
    int year{4}, month{5}, day{6};
  };
  Date(int year, int month, int day)
   : year{year},month{month},day{day} {
  };
  ```,
  [],
  [],
  [],
))
