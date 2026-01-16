#let author = "Georgiy Shevoroshkin"
#let dateformat = "[day].[month].[year]"
#let colors = (
  red: rgb("#CD533B"),
  yellow: rgb("#f2d013"),
  green: rgb("#84C082"),
  blue: rgb("#B0C4DE"),
  darkblue: rgb("#4874AD"),
  purple: rgb("#B222AD"),
  black: rgb("#090302"),
  white: rgb("#F5F5F5"),
  comment: rgb("#444444"),
)
#let languages = (
  de: (
    page: "Seite",
    chapter: "Kapitel",
    toc: "Inhaltsverzeichnis",
    term: "Begriff",
    definition: "Bedeutung",
    summary: "Zusammenfassung",
  ),
  en: (
    page: "Page",
    chapter: "Chapter",
    toc: "Contents",
    term: "Term",
    definition: "Definition",
    summary: "Summary",
  ),
)
#let code-font = "JetBrainsMono NF"
#let prod = math.circle.filled.small
#let module-name = state("module", none)
