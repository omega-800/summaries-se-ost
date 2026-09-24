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
  [Redundant returns that would be implicit], [ ],
  [```cpp using namespace```], [ ],
  [Not initializing a variable upon definition], [ ],
  [Not using ```cpp const``` enough],

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
- Automatic type conversion if values of different types are
  combined in an expression, *unless in braced initialization*
- Dividing integers by zero is *undefined behavior*

=== Assignment Operation

```cpp
// vvvvv lvalue
   myVar = 6 * 7;
//         ^^^^^ rvalue
```

=== Logic Operations

Logical operators and conditional statements are generous to accept numeric values as
statement of truth

#todo[```cpp
if (a < b < c);

// three-way-comparison
<=>
```]

=== Floating Point Numbers (IEEE754)

- Use `double` -- usually most efficient on current hardware and default for
  floating point literals.
- Use float only if memory consumption is utmost priority
  and precision and range can be traded (on 64bit often not beneficial).
- Remember there are legal double values that are not numbers:
  `NaN, +Inf, -Inf`.
- Comparing floating points for equality (`==`) is usually wrong
  - In Catch2 you have the option to specify a matcher that checks in a relative
    range to the expected value \
    ```cpp REQUIRE_THAT(actual, Catch::Matchers::WithinRel(expected, delta));```

=== Strings

```cpp std::string``` is C++'s type for representing sequences of char (which is
often only 8 bit). It is mutable and iterable with iterators.

```cpp
#include <string>

std::string statement{"Rust ftw"};
```

#todo[Unicode support?]

String literals like ```cpp "ab"``` are not of type ```cpp std::string```,
they're a null-terminated array of const characters (```cpp char const[3]```). \
But ```cpp "ab"s``` is an ```cpp std::string``` but requires ```cpp using namespace std::literals```.

=== Basic Streams

Streams aren't values, because they cannot be copied. So functions taking a
stream object must take it as a reference.

Pre-defined globals: ```cpp std::cin std::cout```, should only be used in
```cpp main()```. "shift" operators read into variables or write values and can
be chained:
```cpp
std::cin >> x;
std::cout << "the value is " << x << '\n';
```
#todo[
  Streams have a state that denotes if I/O was successful or not.
  - Only ```cpp .good()``` streams actually do I/O
  - You need to ```cpp .clear()``` the state in case of an error

  If a previous read already failed, subsequent reads fail as well

  Reading a std::string can not go wrong, unless the stream is already !good()
  - The content of the std::string is replaced
  - Maybe the std::string is empty after reading

    Reading an int:
  - No error recovery
  - One wrong input puts the stream into status fail
  - Characters remain in input
]

==== Boolean Conversion

```cpp
int age;
if (std::cin >> age) {
  return age;
}
```

Result of ```cpp std::cin >> age``` is the ```cpp istream``` object itself. The
stream object converts to ```cpp bool``` (in if and loop conditions):
- ```cpp true``` if the last reading operation has been successful
- ```cpp false``` if the last reading operation failed somehow (formatting, stream end or another problem)

==== States

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

#todo[
  - Formatted input on stream is must check for is.fail() and is.bad()
  - If failed, is.clear() the stream and consume invalid input characters before continue
]

#todo[slides 39, 40+]

#pagebreak()
#bibliography("./cit.bib")
