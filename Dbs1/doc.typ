#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "Dbs1",
  name: "Datenbanksysteme 1",
  semester: "HS25",
  language: lang
)
#let tbl =(..body)=> deftbl(lang,..body)

= UML

= Ansi-Modell

= Normalformen

= Relationale Algebra

= Queries

== Execution order

== Join

== Aggregate

== Window functions

== Views

= Funktionen

= User management
