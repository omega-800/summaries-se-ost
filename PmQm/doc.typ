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

= Projekt oder Produkt

/ Produkt: ist etwas, das auf dem Markt verkauft werden kann
/ Projekt: eine Methode, die als Resultat ein Produkt hervorbringt

#table(
  columns: (50%, 50%),
  [Projekt], [Produkt],

  [Einmaliges Vorhaben], [Andauernde Entwicklung],

  [Grosser Initialaufwand bis zum ersten sichtbaren Ergebnis],
  [Mit MVP (Minimum Viable Product) sehr schnell ein erstes Ergebnis],

  [Kundennutzen oft erst am Ende], [Schneller und wachsender Kundennutzen],

  [Mit OTOBOS sehr gute Planbarkeit von Zeit, Budget und Scope],
  [Durch agile Entwicklungszyklen ständig ändernde Situation],
)

/ OTOBOS: On Time, On Budget, On Specification

== Das magische Dreieck

#diagram(
  node((1, 0), shape: fletcher.shapes.pill, [Kosten]),
  edge("<->"),
  node((0, 1), shape: fletcher.shapes.pill, [Scope]),
  edge("<->"),
  node((2, 1), shape: fletcher.shapes.pill, [Zeit]),
  edge((1, 0), "<->"),
)

= Innovation

Innovation ist der Prozess, bei dem eine Idee in ein Produkt umgewandelt wird, und einen Mehrwert für den Kunden schafft

/ Inkrementelle Innovation: bedeutet die allmähliche, aber kontinuierliche Verbesserung bestehender Technologien (Markt für Smartphones)
/ Disruptive Innovationen: führen zu neuen Technologien (Musik und Film-Streaming, digitale Fotographie)
/ Architektonische Innovationen: passen bestehende Komponenten eines Produkts einen neuen Markt und Zweck an (Smart Watch, EarPod als Hörgerät)
/ Radikale Innovation: ersetzt bestehende Angebote vollständig und erschliesst einen neuen Markt (Cloud Computing, AI)

= Qualität


#todo[rest of W1]
