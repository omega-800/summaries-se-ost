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

= HyperText Markup Language (HTML)

Structures the contents of a document, defines *what* is content and not *how*
it looks.

`<head>` contains metadata, `<body>` contains the content.

#exbox(```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="ost-favicon-32x32.png">
  <title>Hello World</title>
</head>
<body>
  <h1>Hello World</h1>
  <p>9/11 was an inside job</p>
</body>
</html>
```)

== Content categories

Most HTML elements are a member of one or more content categories. The content
categories are used to define the content model of elements, in other words,
what each element can take as descendants.

#{
  let node = node.with(inset: 1em)
  align(center, diagram(
    node(
      enclose: ((-1, 0), <h>, <s>, <p>, <e>, <i>),
      shape: fletcher.shapes.pill,
      name: <f>,
      inset: 2em,
    ),
    node((1, 1), stroke: none, box(fill: colors.bg)[Flow]),
    node((2, 2), shape: fletcher.shapes.pill, name: <h>, box(
      fill: colors.bg,
    )[Heading]),
    node((2, 3.5), shape: fletcher.shapes.pill, name: <s>, box(
      fill: colors.bg,
    )[Sectioning]),
    node(
      (0.5, 2),
      shape: fletcher.shapes.pill,
      name: <e>,
      box(fill: colors.bg)[Embedded],
      inset: 1.5em,
    ),
    node(
      enclose: (<e>, (-.5, 5), (1.25, 5)),
      shape: fletcher.shapes.pill,
      name: <p>,
      box(fill: colors.bg)[Phrasing],
    ),
    node((-.75, 4), width: 10em, shape: fletcher.shapes.pill, name: <m>, box(
      fill: colors.bg,
    )[Metadata]),
    node((-.25, 1.5), shape: fletcher.shapes.pill, name: <i>, inset: 1.5em, box(
      fill: colors.bg,
    )[Interactive]),
  ))
}
/ Metadata: Elements belonging to the metadata content category modify the
  presentation or the behavior of the rest of the document, set up links to
  other documents, or convey other out-of-band information.
/ Flow: Flow content is a broad category that encompasses most elements that can
  go inside the `<body>` element, including heading elements, sectioning
  elements, phrasing elements, embedding elements, interactive elements, and
  form-related elements.
/ Sectioning: Creates a section in the current outline defining the scope of
  `<header>` and `<footer>` elements.
/ Heading: Defines the title of a section.
/ Phrasing: Refers to the text and the markup within a document. Sequences of
  phrasing content make up paragraphs.
/ Embedded: Imports another resource or inserts content from another markup
  language or namespace into the document.
/ Interactive: Includes elements that are specifically designed for user
  interaction.

== Semantic elements

#{
  let (start, end, decide, desc, next, yes, no) = fletcher-state-diag-elems(
    height: 3em,
    width: 8em,
  )
  let decide = decide.with(height: 4em)
  align(center, diagram(
    spacing: (5em, 4em),
    start((1, 0), [Start]),
    next(),
    decide((1, 1), [Is it a major\ navigation block?]),
    yes((0, 1)),
    no(),
    decide((1, 2), [Does it make\ sense on its\ own?]),
    yes((0, 2)),
    no(),
    decide((1, 3), [Is it required to\ understand the\ curr. content?]),
    yes((0, 3)),
    no(bend: -20deg),
    decide((2, 3), [Could you\ move it to an\ appendix?]),
    yes((3, 3)),
    no(),
    decide((2, 2), [Is it logical to\ add a heading?]),
    yes((3, 2)),
    no(),
    decide((2, 1), [Does it have\ any semantics?]),
    yes((3, 1)),
    no((2, 0)),

    end((0, 1), [`<nav>`]),
    end((0, 2), [`<article>`]),
    end((0, 3), [`<aside>`]),
    end((3, 3), [`<figure>`]),
    end((3, 2), [`<section>`]),
    end((3, 1), [Appropriate\ element]),
    end((2, 0), [`<div>`]),
  ))
}

=== Webpage structure

#block(breakable: false, grid(
  columns: (3fr, 1fr),
  rows: (4em, 3em, 8em, 3em),
  align: center + horizon,
  gutter: 0pt,
  inset: 1em,
  grid.cell(colspan: 2, fill: colors-l.darkblue)[`<header>`],
  grid.cell(colspan: 2, fill: colors-l.purple)[`<nav>`],
  grid.cell(fill: colors-l.red)[`<main>`],
  grid.cell(fill: colors-l.green)[`<aside>`],
  grid.cell(colspan: 2, fill: colors-l.orange)[`<footer>`],
))

=== h\*

`<h1>` should only appear once on the website.

=== article

A self-contained part of the document which is independently placed or should be
reused.

#exbox(```html
<article>
  <section id="introduction">
    <p>JS was a mistake</p>
  </section>
  <section id="content">
    <!-- very long rant -->
  </section>
  <section id="summary">
    <p>JS was a mistake</p>
  </section>
</article>
```)

=== section

General separation and grouping of content.

=== img

`alt` attribute's value should provide a clear and concise text replacement for
the image's content. It should not describe the presence of the image itself or
the file name of the image. The `alt` attribute *must be specified*.

If the image is of decorative nature only, one must still set `alt`, although
empty: `alt=""`

== Void elements

A void element is an element in HTML that cannot have any child nodes (i.e.,
nested elements or text nodes). Void elements only have a start tag; end tags
must not be specified for void elements.

```html <area> <base> <br> <col> <embed> <hr> <img> <input> <link> <meta> <param> <source> <track> <wbr>```

#todo[https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements]

= Cascading Style Sheets (CSS)

A simple mechanism for adding style (e.g., fonts, colors, spacing) to Web
documents.

/ Inline: ```html <p style="color: red;">Text</p>``` #h(1fr) (Discouraged)
/ Inside of HTML: ```html <head><style> p { color: red; } </style></head>```
  #h(1fr) (For small documents)
/ External file: ```html <link rel="stylesheet" href="styles.css">``` #h(1fr)
  (Standard)

== Selectors

/ Class: ```css .classname``` reusable for multiple elements
/ ID: ```css #idname``` for unique, single element
/ Pseudo-class: Prefixed with a colon (`:`), allow the selection of elements
  based on state information that is not contained in the document tree.
/ Pseudo-element: Prefixed with two colons (`::`), represent entities that are
  not included in HTML. For example, the simple ```css ::marker``` selector
  selects list item bullets, and the compound selector ```css p::first-line```
  matches the first line of all ```html <p>``` elements.
/ Universal: The CSS universal selector (`*`) matches elements of any type.
/ Nesting: The CSS `&` nesting selector explicitly states the relationship
  between parent and child rules when using CSS nesting.
  ```css
  parentRule {
    & childRule { }
  }
  ```
/ Attribute: The CSS #link(
    "https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Selectors/Attribute_selectors#syntax",
    "attribute selector",
  ) matches elements based on the element having a given attribute explicitly
  set, with options for defining an attribute value or substring value match.
  ```css
  a[href*="example"] {
    font-size: 2em;
  }
  ```

=== Combinators

/ Descendant combinator: The descendant combinator, denoted with one or more
  spaces, selects nodes that are descendants of the first element.
/ Child combinator: The child combinator is more specific than the descendant
  combinator. Denoted with the greater than character (`>`), the child
  combinator selects nodes that are direct children of the first element.
/ Subsequent-sibling combinator: The subsequent-sibling combinator, denoted with
  a tilde (`~`), selects siblings. Given `A ~ B`, all elements matching `B` will
  be selected if they are preceded by `A`, provided both `A` and `B` share the
  same parent.
/ Next-sibling combinator: The next-sibling combinator, denoted by the plus
  symbol (`+`), is similar to the subsequent-sibling. However, given `A + B`, it
  only matches `B` if `B` is *immediately* preceded by `A`, with both sharing
  the same parent.
/ Column combinator: There is also a column combinator, denoted by two pipe
  characters (`||`), which, when supported, selects nodes that belong to a
  column.
/ Namespace separator: The namespace separator is another combinator that is
  generally used in conjunction with the `@namespace` at-rule. This combinator
  is denoted by a single pipe character (`|`). It enables limiting type
  selectors and the universal selector to a specific namespace.

=== Specificity

+ ```css !important```
+ ```html style=""``` Attribute
+ (1) ID-Selectors
+ (2) Class-Selectors, Pseudoclasses (eg. ```css :hover```) and Attributes
  (```css [...=...]```)
+ (3) Type-Selectors and Pseudoelements (eg. ```css ::first-line```)

#exbox([```css
  div.help > div#nested a:hover::before { }
  ```
  Specificity: 124 \
  1 id, 2 (pseudo-)classes, 4 (pseudo-)elements)
])

#exbox[
  ```html <div id="div-1" class="recent significant good-to-go">1</div>```
  ```css
  .recent // overrides others
  ```
]

== Box-Model

#let outpad(name, color, body) = {
  block(fill: color, inset: 1em, align(center + horizon, {
    raw(lang: "css", name + "-top")
    stack(
      dir: ltr,
      spacing: 1em,
      rotate(-90deg, reflow: true, raw(lang: "css", name + "-left")),
      body,
      rotate(-90deg, reflow: true, raw(lang: "css", name + "-right")),
    )
    raw(lang: "css", name + "-bottom")
  }))
}

#align(center, block(breakable: false, outpad("margin", colors-l.orange, outpad(
  "border",
  colors-l.black,
  outpad(
    "padding",
    colors-l.purple,
    {
      block(fill: colors-l.darkblue, inset: 1em, grid(
        columns: (4em, 4em),
        rows: (4em, 4em),
        grid.cell(
          colspan: 2,
          $ stretch(size: #11em, <->)^#{ ```css width``` } $,
        ),
        place(dx: 1.5em, dy: -2.5em, rotate(
          -90deg,
          reflow: true,
          $ stretch(size: #11em, <->)^#{ ```css height``` } $,
        )),

        [Content],
      ))
    },
  ),
))))

== Display

#deftbl(
  [Block (```css p, h1, ul```)],
  [Vertical alignment, width fills parent, height from content],
  [Inline (```css a, strong```)],
  [Horizontal alignment, width and height from content,
    ```css left/right margin/padding``` allowed, not ```css top/bottom```],
  [Inline-Block],
  [Flows like inline, but ```css width/height margin/padding``` all allowed],
)

```css display: none; ``` Element isn't visible and doesn't take any space
```css visibility: hidden; ``` Element isn't visible but does use space

=== Flexbox

#link("flexbox.help")

= JavaScript (JS)

#link(
  "https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript",
  "why did you do this to us, brendan eich",
)

== Atomic language constructs

=== Values and types

JS is dynamically typed (help) and doesn't have constant values. It only has
non-reassigneable namespaces when using ```js const```. Using ```js let``` you
declare a reassigneable variable and using ```js var``` is a crime against
humanity.

String interpolation:
```js
let answer = 42;
console.log(`The answer is ${answer}`);
```

=== Functions

Functions are hoisted to the top. A function wihout an explicit return returns
```js undefined```.

```js
function printName(name) {
  console.log(name);
}
```

Lambda functions
```js
((a, b) => console.log(a + b == 5))(2, 3)
```

Default parameters
```JavaScript
function formatAmount(amount, currency = "CHF") {
  return `${currency} ${(amount / 100).toFixed(2)}`;
}
```

=== Objects

```js
let obj = {
  key1: 69,
  key2: "nice",
};

let arr = [ obj, 1, "cursed" ];
```

=== this

The ```js this``` keyword refers to the context where a piece of code, such as a function's body,
is supposed to run. Most typically it refers to the object that the method is attached to.

The value of ```js this``` in JavaScript depends on how a function is invoked (runtime binding), not how it is defined.
which is why the same function can have different ```js this```
references in different objects. Arrow functions have no ```js this```.

=== ES Modules

A module is a file with its own scope. You can export functions and values to
other modules using ```js export``` and import them using ```js import```.

```js
// validation.js
export function validateInput(input) {
  // ...
}

// main.js
import { validateInput } from "./validation.js";
```

A module can be used in the browser using ```html type="module"```. The modules
referenced in that module will be recursively loaded as well. Modules behave the
same way as ```html defer```, being executed after the HTML.

```html
<head>
  <meta charset="UTF-8">
  <title>Modules</title>
  <script type="module" src="main.js"></script>
</head>
```

== The benefits of weak typing /s

js devs be seething rn

=== Equality

#link(
  "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Equality_comparisons_and_sameness",
  "Equality in js",
) is weird. Double equals (```js ==```) will perform a type conversion when comparing
two things, and will handle ```js NaN```, ```js -0```, and ```js +0``` specially
to conform to IEEE 754 (so ```js NaN != NaN```, and ```js -0 == +0```). It isn't
even transitive. Triple
equals (```js ===```) will do the same comparison as double equals (including the
special handling for ```js NaN```, ```js -0```, and ```js +0```) but without
type conversion; if the types differ, ```js false``` is returned.

=== Operators

If one operand of `+` is ```js typeof x === "string"``` then it will convert the other
operand into a string as well. Otherwise both operands will coalesce into
```js Number```.

Other operators  (`-, *, /, %`) will convert both operands into ```js Number```.

Evaluation happens in the order of PEMDAS and from left to right.

=== Numbers

#table(
  columns: (auto, auto, 1fr),
  [Expression], [Value], [Description],
  ```js Number("1.2ab")```, ```js NaN```, [The whole string must be a number],
  ```js Number("")```, ```js 0```, [Empty string is converted to `0`],
  ```js Number("1,5")```, ```js NaN```, [A comma is not a decimal point],
  ```js parseFloat("1.2ab")```,
  ```js 1.2```,
  [Float is read up until invalid input],

  ```js parseInt("1.2ab")```, ```js 1```, [Int is read up until invalid input],
)

==== Not a Number (NaN)

```js
const div0 = 0 / 0;
div0;                 // NaN
typeof div0;          // number
div0 === NaN;         // false
Number.isNaN(div0);   // true
const inf = 3 / 0;    // Infinity
typeof inf;           // number
```

==== Floating point

```js number``` is a 64-Bit IEEE 754 floating point number and thus has the
usual floating point shenanigans.

Comparing floats can be done in the following ways
```js
0.1 + 0.2;                                  // 0.30000000000000004
0.1 + 0.2 === 0.3;                          // false
0.3;                                        // 0.3
const sum = Math.round(0.1 * 100) + Math.round(0.2 * 100);
sum;                                        // 30
sum === Math.round(0.3 * 100)               // true
Math.abs(0.1 + 0.2 - 0.3) < Number.EPSILON  // true
```

=== Booleans

```js ""```, ```js NaN```, ```js null```, ```js undefined``` and ```js 0``` are all falsy. You shouldn't compare using implicit
boolean conversion or using weak equality (```js ==```). Truthy values are e.g. ```js "0"```, ```js "false"```, ```js []```, and ```js {}``` which might all lead to bugs. Use strict equality ```js ===```.

= Document Object Model (DOM)

The DOM (Document Object Model) is an API that represents an HTML document as a
tree structure, where each part (like elements and text) is a node.

== Lifecycle

DOMContentLoaded $->$ load $->$ beforeunload $->$ unload

The `DOMContentLoaded` event is fired when the HTML document has been fully
loaded and parsed, without waiting for stylesheets, images, and subframes to
finish loading.

The `load` event is fired when the whole page, including all dependent resources
such as stylesheets and images, has loaded.

The `beforeunload` event is fired when the window, the document, and its
resources are about to be unloaded.

The `unload` event on `window` triggers when the user is finally leaving, in the
handler we can only do simple things that do not involve delays or asking a
user. Because of that limitation, it’s rarely used.


== DOM-Tree

The HTML Document is represented as a tree in the DOM. It offers an API for HTML
Documents which provide functions to query the structure and its nodes, CRUD'ing
them, registering event-handlers etc.

=== Nodes

The DOM Node interface is an abstract base class upon which many other DOM API
objects are based, thus letting those object types be used similarly and often
interchangeably. All objects that implement Node functionality are based on one
of its subclasses. Most notable are `Document`, `Element`, and
`DocumentFragment`.

In addition, every kind of DOM node is represented by an interface based on
Node. These include Attr, CharacterData (which `Text`, `Comment`, `CDATASection`
and `ProcessingInstruction` are all based on), and `DocumentType`.

== Actions

=== Selection

```js
document.querySelector("h2");     // returns first matching element
document.querySelectorAll("h2");  // returns all matching elements
```

=== Navigation

```js
node.parentElement
node.childNodes
node.children
node.firstChild
node.firstElementChild
node.nextSibling
node.nextElementSibling
```

=== Manipulation

==== CSS classList

#exbox(```js
element.classList     // a DOMTokenList

// use the classList API to remove and add classes
element.classList.remove("foo");
element.classList.add("another-class");

// if visible is set remove it, otherwise add it
element.classList.toggle("visible");

// add/remove visible, depending on test conditional, i less than 10
element.classList.toggle("visible", i < 10);

// add or remove multiple classes
element.classList.add("foo", "bar", "baz");
element.classList.remove("foo", "bar", "baz");

// replace class "foo" with class "bar"
element.classList.replace("foo", "bar");
```)

==== Contents

`innerHTML`, `innerText`, and `textContent` are properties of the DOM Nodes.
They allow you to read and update the content of HTML elements.

/ innerHTML: reads both the HTML markup and the text content of the element.
  This means when you use it to set the content of elements, you can include
  HTML tags, and the browser will render them correctly.
/ innerText: returns the text as it appears on screen. It ignores HTML tags
/ textContent: also ignores all HTML tags and returns only the text. While
  `innerText` reads text as it is rendered on screen, textContent reads text as
  it is in the markup. It also returns all text, whether it's rendered on screen
  or not

=== Creation

/ createElement(): This method of the Document interface creates a new
  `HTMLElement` that has the specified `localName` (type of node). If
  `localName` isn't recognized, the method creates an `HTMLUnknownElement`.
/ createTextNode(): Creates a new Text node. This method can be used to escape
  HTML characters.
/ createDocumentFragment(): Creates a new empty `DocumentFragment` into which
  DOM nodes can be added to build an offscreen DOM tree.

#exbox(```js
const element = document.getElementById("elem");
const fragment = document.createDocumentFragment();
const browsers = ["Firefox", "Chrome", "Opera", "Safari"];

browsers.forEach((browser) => {
  const li = document.createElement("li");
  li.textContent = browser;
  fragment.appendChild(li);
});

element.appendChild(fragment);
```)

==== insertAdjacentHTML

Use this method if you want to provide XSS attack surface.

#exbox(```js
let container = document.querySelector("#container");
let newHTMLCode = "<p>igrok</p>";
container.insertAdjacentHTML("beforeend", newHTMLCode);
```)

`position` can be one of the following:
/ beforebegin: Before the element. Only valid if the element is in the DOM tree
  and has a parent element.
/ afterbegin: Just inside the element, before its first child.
/ beforeend: Just inside the element, after its last child.
/ afterend: After the element. Only valid if the element is in the DOM tree and
  has a parent element.

== Events

Objects that can fire events have an `addEventListener()` method.

#exbox(```js
let handleClick = e => console.log(`Clicked on ${e.target}`)
element.addEventListener("click", handleClick);
element.removeEventListener("click", handleClick);
```)

/ e.preventDefault(): prevents the browser from executing the default behavior of
  the selected element
/ e.stopPropagation(): prevent the parent element from accessing the event (stop
  bubbling)

=== Event-Bubbling

What happens when you add an event listener to a parent element, and the user
clicks the child element.

/ e.target: refers to the element on which the event was initially fired
/ e.currentTarget: refers to the element to which this event handler has been
  attached
#grid(
  columns: 2,
  [

    Events have 3 stages

    + Capture-Phase
      - Event walks DOM-tree from root to leaf
      - Each element can respond (but doesn't have to)
    + Target-Phase
      - Event reaches target element
      - All event listeners attached to the target element fire here
    + Bubbling-Phase
      - Event walks DOM-tree from leaf to root
      - Each element can respond (but doesn't have to)
      - Not all events do the bubbling phase
  ],
  diagram(
    // node-stroke: none,
    node((1, 0), ```html document```),
    edge("-|>"),
    edge("-|>", shift: -.2, stroke: 2pt + colors.red),
    edge("<|-", shift: .2, stroke: 2pt + colors.green),
    node((1, 1), ```html <html>```),
    edge("-|>"),
    edge("-|>", shift: -.2, stroke: 2pt + colors.red),
    edge("<|-", shift: .2, stroke: 2pt + colors.green),
    node((1, 2), ```html <body>```),
    edge("-|>"),
    edge("-|>", shift: -.2, stroke: 2pt + colors.red),
    edge("<|-", shift: .2, stroke: 2pt + colors.green),
    edge((0, 3), "-|>"),
    node((2, 3), ```html <div>```),
    edge("-|>"),
    edge("-|>", shift: -.5, stroke: 2pt + colors.red),
    edge("<|-", shift: .5, stroke: 2pt + colors.green),
    node((2, 4), ```html <p>```, fill: colors.darkblue),
    node((0, 3), ```html <div>```),
    edge("-|>"),
    node((0, 4), ```html <p>```),
    node((1, 4), td[target\ phase (2)], stroke: none),
    node((0, 1), tr[capture\ phase (1)], stroke: none),
    node((2, 2), tg[bubbling\ phase (3)], stroke: none),
  ),
)

#todo[`data-` attributes]

= Clean Code

Intuitively understandable: Can be correctly understood with little effort and in a short time.

== Naming

Basic rule: What is my motivation to create this?

+ Names should be short, intuitive, and meaningful
+ Names should be pronounceable

- camelCase
- Constants: ALL_CAPS
- Boolean values: is...
- Arrays: Plural
- Familiar and specific words (```js erase -> delete```)
- Consistency
- Do not repeat context (```js todoService.addTodo -> todoService.add```)

#tp[`verb`]#tg[`Attribute`]#td[`Object`]: #tp[`remove`]#tg[`Every2nd`]#td[`ChildElement`]`(...)`

== Code Quality

Building blocks of software quality
#table(
  columns: (1fr, 1fr),
  [Customer-oriented], [Manufacturer-oriented],
  [Functionality], [Portability],
  [Reliability], [Modifiability],
  [Efficiency], [Testability],
  [Usability], [Transparency],
)

/ DRY: Don't Repeat Yourself
/ DIY: Do It Yourself
/ DIE: Release me from my misery

== js Styleguide (AirBnB)

/ no-var: do not use ```js var```
/ prefer-const: use ```js let``` only for variables with dynamic assignment
/ quotes: always use single quotes for strings
/ no-param-reassign: do not modify parameters inside a function
/ operator-linebreak: No line break directly before or after an assignment (```js =```)
/ eqeqeq: use ```js ===``` and ```js !==``` (not ```js ==, !=```)
/ space-infix-ops: spaces around infix operators (e.g. not ```js const x=y+5```)
/ eol-last: A return at the end of the file
/ no-multiple-empty-lines: only one blank line
/ semi: end lines with a semicolon

Variable interpolation in strings should be done with ```js `${}` ```,
variables should preferably be written as individual statements on new lines
instead of being comma-separated.

== MVC

#{
  let node = node.with(width: 10em)
  align(center, diagram(
    node((2, 0), stroke: colors.darkblue, [*Controller*\ connection code]),
    edge(),
    edge((1, 1)),
    node((0, 0), stroke: colors.green, [*View*\ presentation]),
    edge(),
    node((1, 1), stroke: colors.purple, [*Model*\ logic]),
  ))
}

/ Model: Manages and changes state
  - Data model
  - App state
  - Logic
  - *No view refs*
/ View: Displays elements in the DOM
/ Controller: Connects View & Model
  - User input
  - View changes (routing)

= HyperText Transfer Protocol (HTTP)

#grid(
  columns: 2,
  [
    HTTP is stateless - client and server "forget" each other after every
    transaction. Each request and response contains all data.

    Any kind of data can be transmitted over HTTP.
  ],

  {
    let node = node.with(height: 4em, width: 4em)
    align(center, diagram(
      node((0, 0), shape: monitor.with(label: "Client")),
      edge((2, 0), "-|>", label: "Request", shift: .7),
      edge((2, 0), "<|-", label: "Response", shift: -.7),
      node((1, 0), shape: cloud, width: 8em),
      node((2, 0), shape: server.with(label: "Server")),
    ))
  },
)

== URL Scheme

#{
  show "https": td
  show "unterricht.ost.ch": tp
  show "443": tr
  show "stundenplan": to
  show "org=I&sem=HS30": ty
  show "08:00": tg
  `https://unterricht.ost.ch:443/stundenplan?org=I&sem=HS30#08:00`
  [\ ]
  show "protocol": td
  show "host": tp
  show "port": tr
  show "path": to
  show "query": ty
  show "anchor": tg
  `protocol://host:port/path?query#anchor`
  // "
}

URL encoding turns any other character into a safe code the URL can carry. Each
such character becomes a `%` sign followed by two hexadecimal digits. A space,
for example, becomes `%20`. Special Characters must be encoded:

```js
encodeURI("what's up? #gfeller ")         // "what's%20up?%20#gfeller%20"
encodeURIComponent("what's up? #gfeller") // "what's%20up%3F%20%23gfeller"
```

== Request

#todo[W9A S12]

#highlight(fill: colors-l.red.lighten(50%))[Method]
#highlight(fill: colors-l.darkblue.lighten(50%))[Address]
#highlight(fill: colors-l.yellow.lighten(50%))[Version]
#highlight(fill: colors-l.purple.lighten(50%))[Headers]
#highlight(fill: colors-l.orange.lighten(50%))[Header/body separator]
#highlight(fill: colors-l.green.lighten(50%))[Request body]
#code(
  ```http
  GET /index.php HTTP/3<crlf>
  Host: www.html-world.de<crlf>
  User-Agent: Mozilla/4.0<crlf>
  Accept: image/gif, image/jpeg, */*<crlf>
  Connection: close
  <crlf>
  <crlf>
  ...
  ```,
  highlights: (
    (line: 1, start: 0, end: 3, fill: colors-l.red),
    (line: 1, start: 5, end: 14, fill: colors-l.darkblue),
    (line: 1, start: 16, end: 30, fill: colors-l.yellow),
    (line: 2, start: 0, end: 50, fill: colors-l.purple),
    (line: 3, start: 0, end: 50, fill: colors-l.purple),
    (line: 4, start: 0, end: 50, fill: colors-l.purple),
    (line: 5, start: 0, end: 50, fill: colors-l.purple),
    (line: 6, start: 0, end: 50, fill: colors-l.orange),
    (line: 7, start: 0, end: 50, fill: colors-l.orange),
    (line: 8, start: 0, end: 50, fill: colors-l.green),
  ),
)

#table(
  columns: 2,
  [Method], [Description],
  [GET],
  [The GET method is used to retrieve information from the given server using a given URI. Requests using GET should only retrieve data and should have no other effect on the data.],

  [HEAD], [Same as GET, but transfers the status line and header section only.],
  [POST],
  [A POST request is used to send data to the server, for example, new customer information, file upload, etc. using HTML forms.],

  [PUT],
  [Replaces all current representations of the target resource with the uploaded content.],

  [DELETE],
  [Removes all current representations of the target resource given by a URI.],

  [CONNECT], [Establishes a tunnel to the server identified by a given URI.],
  [OPTION], [Describes the communication options for the target resource.],
  [TRACE],
  [Performs a message loop-back test along the path to the target resource.],
)

GET data is placed into the URL (as query string), whereas POST data is placed
into the request body.

== Response

#highlight(fill: colors-l.yellow.lighten(50%))[Version]
#highlight(fill: colors-l.red.lighten(50%))[Status code]
#highlight(fill: colors-l.purple.lighten(50%))[Headers]
#highlight(fill: colors-l.orange.lighten(50%))[Header/body separator]
#highlight(fill: colors-l.green.lighten(50%))[Request body]
#code(
  ```http
  HTTP/2 200 OK <crlf>
  Transfer-Encoding: chunked<crlf>
  Date: Sat, 28 Nov 2030 04:36:25 GMT<crlf>
  Pragma: public<crlf>
  Etag: "pub1259380237;gz"<crlf>
  Cache-Control: max-age=3600, public<crlf>
  Content-Type: text/html; charset=UTF-8<crlf>
  Last-Modified: Sat, 28 Nov 2030 03:50:37 GMT
  <crlf>
  <crlf>
  <title>Title of page</title>
  <!-- ... rest of the html ... -->
  ```,
  highlights: (
    (line: 1, start: 0, end: 6, fill: colors-l.yellow),
    (line: 1, start: 8, end: 13, fill: colors-l.red),
    (line: 2, start: 0, end: 50, fill: colors-l.purple),
    (line: 3, start: 0, end: 50, fill: colors-l.purple),
    (line: 4, start: 0, end: 50, fill: colors-l.purple),
    (line: 5, start: 0, end: 50, fill: colors-l.purple),
    (line: 6, start: 0, end: 50, fill: colors-l.purple),
    (line: 7, start: 0, end: 50, fill: colors-l.purple),
    (line: 8, start: 0, end: 50, fill: colors-l.purple),
    (line: 9, start: 0, end: 50, fill: colors-l.orange),
    (line: 10, start: 0, end: 50, fill: colors-l.orange),
    (line: 11, start: 0, end: 50, fill: colors-l.green),
    (line: 12, start: 0, end: 50, fill: colors-l.green),
  ),
)

=== Status codes

#table(
  columns: (auto, 1fr, 2fr),
  [Code], [Description], [Examples],
  [1xx], [Informational], [100 Continue],
  [2xx], [Successful], [200 OK\ 201 Created\ 204 No Content],
  [3xx], [Redirection], [301 Moved Permanently\ 304 Not Modified],
  [4xx],
  [Client Error],
  [400 Bad Request\ 401 Unauthorized\ 403 Forbidden\ 404 Not Found\
    418 I'm a teapot],

  [5xx],
  [Server Error],
  [500 Internal Server Error\ 505 HTTP Version Not Supported],

  [9xx], [Non-Standard Codes],
)

=== Content-Type

Declares the parsing / interpreting format for the
Client/Server. The Content-Type is declared in MIME-Type format

#table(
  columns: 3,
  [Type], [Description], [Examples],
  [text],
  [Represents any document that contains text and is theoretically human readable],
  [text/plain\ text/html\ text/css\ text/typst],

  [image],
  [Represents any kind of images. Videos are not included, though animated images (like animated gif) are described with an image type.],
  [image/gif\ image/png\ image/jpeg\ image/bmp\ image/webp],

  [audio],
  [Represents any kind of audio files],
  [audio/midi\ audio/webm\ audio/ogg\ audio/wav],

  [video], [Represents any kind of video files], [video/webm\ video/ogg],
  [application],
  [Represents any kind of binary data.],
  [application/javascript\ application/octet-stream\ application/pkcs12\ application/json\ application/xml\ application/pdf],
)

=== Host

#todo[W9A S23..]

= Asynchronous JavaScript And XML (AJAX)

With AJAX, web applications can send data to and retrieve from a server asynchronously
without interfering with the display and behavior of the existing page.

== Async js

/ Callback: A function passed into another function as an argument, which is then invoked
  inside the outer function to complete some kind of routine or action. (HOF)
/ Promise: A js object that represents the eventual completion (or failure) of an
  asynchronous operation. It can be in one of three states: pending, fulfilled
  (```js resolve```), or rejected (```js reject```).
/ Synchronous: Main thread is blocked while waiting for response
/ Asynchronous: Main thread isn't blocked, no "waiting" happens per se.
  Callbacks in promises or async/await can be used to write async js.

#exbox(title: "Promises", ```js
function createTimer(time) {
  const startTime = performance.now()
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const timePassed = performance.now() - startTime;
      const inTime = Math.abs(time - timePassed) < 100;
      if (inTime) resolve();
      else reject("call to late");
    }, time)
  });
}

createTimer(1000)
  .then(snooze)
  .then(snooze)
  .then(snooze)
  .catch(console.error)
  .then(wakeUpCall)
  .finally(() => console.log("finished"))
```)

Using ```js await``` the function is paused, until the promise completes. The
function must be marked ```js async```.
#exbox(grid(
  columns: (1fr, auto, 1fr),
  ```js
  try {
    await createTimer(1000)
    wakeUpCall();
  } catch(e) {
    console.error(e);
  }
  ```,
  align(horizon, $ <=> $),
  ```js
  createTimer(1000)
    .then(wakeUpCall)
    .catch(console.error)
  ```,
))

== Fetch

The Fetch API provides a JavaScript interface for making HTTP requests and processing the responses.

#exbox(```js
try {
  const res = await fetch('/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: 'admin@admin.ch’, pwd: '123456' })
  });
  console.log(res);   // { ..., ok: true, status: 200 }
  const data = await res.json();
  console.log(data);  // { ... }
} catch (err) {
  console.error(err); // { ..., ok: false, status: 400 }
}
```)

The Response interface provides a number of methods to retrieve the entire body contents in a variety of different formats:

```js
Response.json()
Response.arrayBuffer()
Response.blob()
Response.formData()
Response.text()
```
