#import "../lib.typ": *
#import "./info.typ": info
#import "./content.typ": content

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Vorwort

Diese Zusammenfassung basiert auf dem Buch "Automaten und Sprachen" @autospr,
geschrieben von Prof. Dr. Andreas Müller.

#content(false)

#pagebreak()
#bibliography("cit.bib")
