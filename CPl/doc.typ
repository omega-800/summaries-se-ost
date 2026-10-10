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

- Implicitly returns 0
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

Output can be formatted using #link("https://en.cppreference.com/cpp/io/manip", [I/O manipulators]).

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
  enode((1, 4.5), height: 2em, ```cpp front()```),
  edge((1, 3), "-O"),
  enode((6, 4.5), height: 2em, ```cpp back() ```),
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
  enode((6.5, 6), ```cpp push_back(x)```),
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

#todo[
  Within a single expression, such as a function call, sequence of evaluation is
  undefined! (except for the comma operator , )
]

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

#pagebreak()
#bibliography("./cit.bib")
