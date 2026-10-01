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

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="ost-favicon-32x32.png">
  <title>Hello World</title>
</head>
<body>
  <h1>Hello World</h1>
  <p>Ich bin eine Testseite</p>
</body>
</html>
```

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
      box(fill: colors.bg)[#v(-7em)Flow #v(7em)],
    ),
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

```html
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
```

=== section

General separation and grouping of content.

=== img

`alt` attribute's value should provide a clear and concise text replacement for
the image's content. It should not describe the presence of the image itself or
the file name of the image. The `alt` attribute *must be specified*.

#todo[bei dekorativen bildern `alt=""`]

#todo[https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements]
#todo[void elements]

= Cascading Style Sheets (CSS)

A simple mechanism for adding style (e.g., fonts, colors, spacing) to Web documents.

/ Inline: ```html <p style="color: red;">Text</p>``` #h(1fr) (Discouraged)
/ Inside of HTML: ```html <head><style> p { color: red; } </style></head>```
  #h(1fr) (For small documents)
/ External file: ```html <link rel="stylesheet" href="styles.css">``` #h(1fr)
  (Standard)

== Selectors

/ Class: ```css .classname``` reusable for multiple elements
/ ID: ```css #idname``` for unique, single element


=== Specificity

+ ```css !important```
+ ```html style=""``` Attribute
+ (1) ID-Selectors
+ (2) Class-Selectors, Pseudoclasses (eg. ```css :hover```) and Attributes (```css [...=...]```)
+ (3) Type-Selectors and Pseudoelements (eg. ```css ::first-line```)

#exbox(todo[])

#todo[cascading]

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

#align(center, outpad("margin", colors-l.orange, outpad(
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
)))

== Display

#todo(align(center, block(inset: 1em, grid(
  columns: (3em, 3em),
  rows: (3em, 3em),
  [], $ stretch(size: #6em, <->)^#{ `inline direction` } $,
  rotate(
    -90deg,
    reflow: true,
    $ stretch(size: #6em, <->)^#{ `block direction` } $,
  ),
  [...],
))))

#deftbl(
  [Block (```css p, h1, ul```)],
  [Vertical alignment, width fills parent, height from content],
  [Inline (```css a, strong```)],
  [Horizontal alignment, width and height from content,
    ```css left/right margin/padding``` allowed, not ```css top/bottom```],
  [Inline-Block],
  [Flows like inline, but
    ```css width/height margin/padding``` all allowed],
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

= SEO and Accessibility
