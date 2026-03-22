#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)

#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))
