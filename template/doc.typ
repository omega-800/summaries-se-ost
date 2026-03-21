#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let did = gen-id(info.module)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(did)

#add-deck(id: did, info.module, info.name)
