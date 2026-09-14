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

= Kombinatorik

Mathematische Disziplin, die sich mit der Frage befasst, wie viele (und welche)
Möglichkeiten es gibt, eine bestimmte Anzahl von Dingen auszuwählen und
miteinander zu kombinieren.

== Zählregeln

/ Disjunkte Vereinigung: $abs(A union B) = abs(A) + abs(B)$
/ Schnittmenge: $abs(A union B) = abs(A) + abs(B) - abs(A inter B)$
/ Paare/Produkt: $abs(A times B) = abs(A) dot abs(B)$

#todo[merge with DigCod and MathFML]

/ Permutation: Auf wieviele Arten kann man $n$ Objekte anordnen? $ n! $
/ Kombination: Auf wieviele Arten kann man $k$ Objekte aus $n$ auswählen? $ binom(n, k) $
/ Variation: Auf wieviele Arten kann man $k$ mal unter $n$ verschiedenen Objekten auswählen? $ n^k $
