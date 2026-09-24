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

A self-contained part of the document which is independently
placed or should be reused.

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

`alt` attribute's value should provide a clear and concise text replacement for the image's
content. It should not describe the presence of the image itself or the file name of the image.
The `alt` attribute *must be specified*.


#todo[https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements]

= Cascading StyleSheets (CSS)

= JavaScript (JS)

#link(
  "https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript",
  "why did you do this to us, brendan eich",
)

= SEO and Accessibility
