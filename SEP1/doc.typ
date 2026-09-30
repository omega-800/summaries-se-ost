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

"Responsibility-driven design"

+ Requirements analysis: What should the product do?
  - Software Requirements Specification (SRS)
+ Domain analysis: What is the problem domain?
  - Static View: Domain Model (UML notation: Class Diagram)
  - Dynamic View: Behavioural Models (UML notation: Interaction Diagram, State Machine Diagram, Activity Diagram, etc. depending on the domain)
#todo[diagrams oo slides 6]
#todo[oo slides in general]

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

// #{
//   let node = node.with(stroke: colors.black)
//   diagram(
//     width: 100%,
//     node((0, 0)),
//     node((1, 0)),
//   )
// }
//
UML Notation for Domain Models:
- Classes for sets of similar objects in the problem domain
- Attributes for properties of those objects
- Associations for relationships between those objects
- Generalisations in between classes with a "each X is a Y" relationship

= Unified Process (UP)

An iterative software development process for building object-oriented systems.

/ Software development process: describes an approach to building, deploying and
  possibly maintaining software.

= Iterative Development

= Domain Models

= Requirements

#diagram(
  node((1, 0), [General]),
  edge(),
  edge((2, 1)),
  node((0, 1), [Project\ Delivery dates, costs, ...]),
  node((2, 1), [Product\ Desired functions, reliability, scalability, ...]),
  edge(),
  edge((2, 2)),
  node((1, 2), [Functional\ What? $->$ Use Cases]),
  node((2, 2), [Non-Functional\ How well?]),
  edge(),
  edge((1.5, 3)),
  edge((2, 3)),
  edge((2.75, 3)),
  node((1, 3), [Performance]),
  node((1.5, 3), [Scalability]),
  node((2, 3), [Quality criteria]),
  node((2.75, 3), [Constraints]),
)
/ Discipline: a systematic approach to finding, documenting, organizing, and tracking the changing requirements of a system
/ Work Products: Software Requirement Specification (SRS) = Capabilities/Conditions that the software must fulfil

== Use Cases

"A set of use-case instances, where each instance is a sequence of actions a system
performs that yields an observable result of value to a particular actor."

#let (usecase, actor, actor-ext) = fletcher-usecase-diag-elems()

#grid(
  columns: 2,
  [
    - A textual process description with a concrete purpose
    - Documents a story of some actor using a system to meet goals
    - Places requirements within the context of a user with goals.
    - Simple & familiar for the average stakeholder

    A use case is typically composed of:
    - A main success scenario, and
    - Multiple extensions / alternative scenarios
  ],
  diagram(
    usecase((0, 0), [UseCaseName]),
  ),
)

=== Actors

#grid(
  columns: 2,
  [
    An actor is something with behaviour, such as a person
    (identified by a role), computer system, or organization.

    Actors are associated to roles, and not to physical entities
  ],
  diagram(
    actor((0, 0), [ActorName]),
    actor-ext((1, 0), [ExternalSystem\ Name]),
  ),
)

/ Primary Actors:
  Actors whose goals are fulfilled through using services of the SuD. \
  E.g., cashier in "Process Sale"
/ Supporting Actors:
  Provides a service to the SuD \
  E.g., Credit card billing system in "Process Sale" \
/ Offstage Actors:
  Has an interest in the behaviour of the use case, but is not primary or
  supporting. \
  E.g., Government tax agency in "Process Sale" \

=== Formats

/ Brief: Short, one-paragraph summary, usually of the main success scenario
/ Casual: Multiple paragraphs that cover various scenarios
/ Fully dressed: All scenarios, steps and variations written in detail, in a specific form, with supporting sections, such as preconditions and success guarantees.

#todo[W3 S12]

=== Elementary Business Processes (EBP)

Use Cases should be identified at the EBP level:

A task performed by one person in one place at one time, (single session)
in response to a business event,
which adds measurable business value (Boss Test) and
leaves the data in a consistent state

=== Finding Use Cases

+ Fix the system boundary: Software, HW/SW-System, Entire Organisation?
+ Identify primary actors and their goals: At the EBP level
+ Write down the use cases -- first in the brief Format

=== System boundary

#todo[W3 S19+]
