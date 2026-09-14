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


= Object-Oriented Analysis and Design

- Responsibility-driven design

/ Analysis: Investigation of the objects in the problem domain
/ Design: Defining software objects and how they collaborate to fulfill the
  requirements

+ Define Use Cases
+ Define a Domain Model
+ Assign Object Responsibilities and Draw Interaction Diagrams
+ Define Design Class Diagrams
