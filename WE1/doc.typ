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

= HyperText Markup Lanugage (HTML)

= Cascading StyleSheets (CSS)

= JavaScript (JS)

#link(
  "https://www.destroyallsoftware.com/talks/the-birth-and-death-of-javascript",
  "why did you do this to us, brendan eich",
)

= SEO and Accessibility

== Semantic elements

https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements
