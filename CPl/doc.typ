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

- Multi-paradigm language, now you have a thousand and one way to shoot yourself
  in your foot and obliterate your PC
- Being called stupid when you think that the `move` function actually moves
  things or if you confuse a const pointer with a pointer of const
- ISO standard: C++23. The higher the number the hotter the mess of poorly
  designed choices that have accumulated over decades into a chaotic pile of
  obsoleteness
- Good excuse for alcoholism
- Zero-cost abstractions (if you like learning the whole stdlib by heart and
  don't mind the cost of debugging template errors for hours on end)
- Headaches (if you're a masochist)
- It's a never ending journey. Even if you dedicate your whole life to learning
  C++, you'll never reach the day where you'll know all of the stdlib.
- "Undefined behavior" is defined (in the standard)
- Ever wanted to have 100 different ways to do the same thing? Now you can
- Has a pretty mascot @cpp-mascot #figure(image(width: 30%, "./img/mascot.jpg"))

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

== Compilation

3 Phases of compilation:

/ Preprocessor: Textual replacement of preprocessor directives (`#include`)
/ Compiler: Translation of C++ code into machine code (source file to object file)
/ Linker: Combination of object files and libraries into libraries and executables

== Declarations and definitions

All things with a name that you use in a C++ program must be declared before you can do so
- E.g. a function that you call (major difference from C)
- A type that you use for a variable (except some built-ins)
- A variable that you use

There can only be one definition of the same function (One Definition Rule), in
contrast to declaration, which can be done several times.

If a function has a non-void return type it must return a value on every path
(or throw an exception).

=== `#include` guards

`#include` guards ensure that a header file is only included once.

```cpp
#ifndef GUARD_HPP_
#define GUARD_HPP_
// ...
#endif /* GUARD_HPP_ */
```

=== Values and references

#todo[
  C++ allocates memory for variables on definition
  - No explicit heap memory needed
  - No indirection and space overhead
]

== Libraries

- catch2
- boost

#pagebreak()
#bibliography("./cit.bib")
