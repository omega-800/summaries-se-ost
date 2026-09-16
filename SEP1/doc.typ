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

= Unified Modeling Language (UML)

Visual language for specifying, constructing and documenting the artifacts of
systems.

Perspectives to apply UML (from abstract to specific): Conceptual, Specification, Implementation

#{
  let node = node.with(stroke: colors.black)
  diagram(
    width: 100%,
    node((0, 0)),
    node((1, 0)),
  )
}

= Unified Process (UP)

An iterative software development process for building object-oriented systems.

/ Software development process: describes an approach to building, deploying and
  possibly maintaining software.

= Iterative Development

= Domain Models


