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

=== Objects

```js
let obj = {
  key1: 69,
  key2: "nice",
};

let arr = [ obj, 1, "cursed" ];
```

=== Equality

#link(
  "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Equality_comparisons_and_sameness",
  "Equality in js",
) is weird. Double equals (`==`) will perform a type conversion when comparing
two things, and will handle ```js NaN```, ```js -0```, and ```js +0``` specially
to conform to IEEE 754 (so ```js NaN != NaN```, and ```js -0 == +0```). Triple
equals (`===`) will do the same comparison as double equals (including the
special handling for ```js NaN```, ```js -0```, and ```js +0```) but without
type conversion; if the types differ, ```js false``` is returned.

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
