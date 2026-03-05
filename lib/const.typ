#let author = "Georgiy Shevoroshkin"
#let dateformat = "[day].[month].[year]"
// https://github.com/catppuccin/catppuccin
#let colors-catppuccin-latte = (
  darkblue: rgb("#1e66f5"),
  purple: rgb("#8839ef"),
  pink: rgb("#ea76cb"),
  green: rgb("#40a02b"),
  red: rgb("#e64553"),
  yellow: rgb("#df8e1d"),
  comment: rgb("#8c8fa1"),
  black: rgb("#5c5f77"),
  orange: rgb("#fe640b"),
  blue: rgb("#7287fd"),
  white: rgb("#e6e9ef"),
  bg: rgb("#eff1f5"),
  fg: rgb("#4c4f69"),
)
// https://github.com/morhetz/gruvbox
#let colors-gruvbox-dark = (
  darkblue: rgb("#83a598"),
  purple: rgb("#d3869b"),
  green: rgb("#b8bb26"),
  red: rgb("#fb4934"),
  yellow: rgb("#fabd2f"),
  black: rgb("#fbf1c7"),
  orange: rgb("#fe8019"),
  blue: rgb("#8ec07c"),
  white: rgb("#1d2021"),
  comment: rgb("#a89984"),
  bg: rgb("#282828"),
  fg: rgb("#ebdbb2"),
)
#let colors-gruvbox-light = (
  darkblue: rgb("#076678"),
  purple: rgb("#8f3f71"),
  green: rgb("#79740e"),
  red: rgb("#9d0006"),
  yellow: rgb("#b57614"),
  comment: rgb("#7c6f64"),
  black: rgb("#282828"),
  orange: rgb("#af3a03"),
  blue: rgb("#427b58"),
  white: rgb("#f9f5d7"),
  bg: rgb("#fbf1c7"),
  fg: rgb("#3c3836"),
)
// https://github.com/chriskempson/tomorrow-theme/tree/master
#let colors-tomorrow = (
  darkblue: rgb("#4271ae"),
  purple: rgb("#8959a8"),
  green: rgb("#718c00"),
  red: rgb("#c82829"),
  yellow: rgb("#eab700"),
  comment: rgb("#d6d6d6"),
  black: rgb("#8e908c"),
  orange: rgb("#f5871f"),
  blue: rgb("#3e999f"),
  white: rgb("#efefef"),
  bg: rgb("#ffffff"),
  fg: rgb("#4d4d4c"),
)
#let colors = colors-tomorrow
#let colors-l = colors.pairs().map(((k, v)) => (k, v.lighten(50%))).to-dict()
// #let colors = (
//   colors-catppuccin-latte
//     + (
//       bg: rgb("#FFFFFF"),
//       fg: rgb("#090302"),
//     )
// )
#let colors-prev = (
  darkblue: rgb("#4874AD"),
  purple: rgb("#B222AD"),
  green: rgb("#84C082"),
  red: rgb("#CD533B"),
  yellow: rgb("#f2d013"),
  comment: rgb("#444444"),
  black: rgb("#090302"),
  orange: rgb("#fe8019"),
  blue: rgb("#B0C4DE"),
  white: rgb("#F5F5F5"),
  bg: rgb("#FFFFFF"),
  fg: rgb("#090302"),
)
#let color-cycle = (
  colors.darkblue,
  colors.purple,
  colors.green,
  colors.red,
  colors.yellow,
  colors.comment,
  colors.black,
)
#let languages = (
  de: (
    page: "Seite",
    chapter: "Kapitel",
    toc: "Inhaltsverzeichnis",
    term: "Begriff",
    definition: "Bedeutung",
    summary: "Zusammenfassung",
    example: "Beispiel",
    observations: "Beobachtungen",
  ),
  en: (
    page: "Page",
    chapter: "Chapter",
    toc: "Contents",
    term: "Term",
    definition: "Definition",
    summary: "Summary",
    example: "Example",
    observations: "Observations",
  ),
)
#let code-font = "JetBrainsMono NF"
#let prod = math.circle.filled.small
#let module-name = state("module", none)

#let undefined = math.op("undefined")
#let sig = math.op("sig")
#let domain = math.op("domain")
#let graph = math.op("graph")
#let nullity = math.op("nullity")
#let nul = math.op("nul")
#let rank = math.op("rank")
#let span = math.op("span")
#let colsp = math.op("colsp")
#let rowsp = math.op("rowsp")
#let ggT = math.op("ggT")
#let kgV = math.op("kgV")
#let Bild = math.op("Bild")
#let Rang = math.op("Rang")
#let undefiniert = math.op("undefiniert")
