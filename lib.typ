#import "@preview/typ2anki:0.1.0": *

#let dateformat = "[day].[month].[year]"
#let colors = (
  red: rgb("#CD533B"),
  green: rgb("#84C082"),
  blue: rgb("#B0C4DE"),
  darkblue: rgb("#4874AD"),
  purple: rgb("#B222AD"),
  black: rgb("#090302"),
  white: rgb("#F5F5F5"),
  comment: rgb("#444444"),
)
#let corr(body) = {
  set text(fill: colors.red, weight: "bold")
  body
}
#let comment(body) = {
  set text(fill: colors.comment, style: "italic")
  body
}
#let code-font = "JetBrainsMono NF"
#let tp = body => {
  set text(fill: colors.purple)
  body
}
#let tr = body => {
  set text(fill: colors.red)
  body
}
#let tg = body => {
  set text(fill: colors.green.darken(20%))
  body
}
#let tb = body => {
  set text(fill: colors.blue.darken(50%))
  body
}
#let td = body => {
  set text(fill: colors.darkblue)
  body
}

#let ve = b => math.accent(b, math.arrow)
#let prod = math.circle.filled.small
#let num(p, n) = {
  set text(fill: colors.comment)
  "0"
  p
  set text(fill: colors.black, weight: "bold")
  n
}
#let hex(n) = {
  // TODO: pad & split
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, 16)
    res += if rem > 9 { str.from-unicode(55 + rem) } else { str(rem) }
    n = calc.floor(n / 16)
    i += 1
    if calc.rem(i, 2) == 0 and n > 0 {
      res += " "
    }
  }
  res += "0" * (calc.rem(i, 2))
  num("x", res.rev())
}
#let bin(n) = {
  // TODO: pad & split
  let res = ""
  let i = 0
  while n != 0 {
    let rem = calc.rem(n, 2)
    res += str(rem)
    n = calc.floor(n / 2)
    i += 1
    if calc.rem(i, 4) == 0 and n > 0 {
      res += " "
    }
  }
  if calc.rem(i, 4) > 0 {
    res += "0" * (4 - calc.rem(i, 4))
  }
  num("b", res.rev())
}
#let dec(n) = {
  let i = 0
  let res = ""
  for d in str(n).rev() {
    res += d
    i += 1
    if calc.rem(i, 3) == 0 and i != str(n).len() {
      res += "'"
    }
  }
  num("d", res.rev())
}

#let no-ligature(t) = {
  text(features: (calt: 0), t)
}
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

// FIXME: put into project
#let deftbl(language, module, ..body) = [
  #table(
    columns: (auto, 1fr),
    table.header(
      [#languages.at(language).term], [#languages.at(language).definition]
    ),
    ..body,
  )
  // FIXME: bruh typ2anki doesn't recognize this bc it only parse the file being compiled, searching for #card nodes
  // #box(place(hide(
  //   [
  //     #for i in (
  //       body
  //         .pos()
  //         .chunks(2)
  //         .enumerate(start: 1)
  //         .map(((i, (t, d))) => card(
  //           id: str(i),
  //           target-deck: module,
  //           q: t,
  //           a: d,
  //         ))
  //     ) [
  //       #i
  //     ]
  //   ],
  // )))
]
#let frame = (
  unit: "bit",
  with-tbl-unit: false,
  with-desc-unit: true,
  with-desc: true,
  ..body,
) => {
  let get-size = i => if type(i) == int { i } else { i.size }
  let get-unit = i => " (" + str(get-size(i)) + " " + unit + ")"
  let as-list = body.pos().map(r => r.pairs()).join()
  let defs = as-list.filter(((k, v)) => type(v) != int and "desc" in v)
  let size = body.pos().first().values().map(get-size).sum()
  [
    #{
      set text(font: code-font)
      set table(stroke: 0.07em)
      set table.cell(align: center)
      table(
        columns: range(0, size).map(_ => 1fr),
        // TODO: stretch
        table.header(table.cell(colspan: size, $<-- #(str(size)) #unit -->$)),
        ..as-list.map(
          ((k, v)) => table.cell(
            colspan: get-size(v),
            k +  if with-tbl-unit { get-unit(v) },
          ),
        )
      )
    }
    #if with-desc and defs.len() != 0 {
      // TODO: merge with deftbl
      table(
        columns: (auto, 1fr),
        table.header(
          [#languages.at("en").term], [#languages.at("en").definition]
        ),
        ..defs.map(((k, v)) => ([#k #{if with-desc-unit {get-unit(v)}}], [#v.desc])).flatten(),
      )
    }
  ]
}
/*
#let frame = (size, cols, ..body) => {
  set text(font: code-font)
  set table(stroke: 0.07em)
  set table.cell(align: center)
  table(
    columns: cols,
    table.cell(colspan: cols.len(), $<-- #size -->$),
    ..body
  )
}
*/

#let project(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columnsnr: 1,
  toc: (enabled: true, depth: 9, columnsnr: 1),
  language: "de",
  fsize: 11pt,
  appendix: (),
  cs: false,
  body,
) = {
  let author = "Georgiy Shevoroshkin"
  set document(author: author, title: name + " " + semester, date: date)

  let font = (
    font: "Arimo Nerd Font",
    lang: language,
    region: "ch",
    size: fsize,
    fill: colors.black,
  )

  let font2 = (font: code-font, weight: "bold", fill: colors.darkblue)

  set page(
    flipped: landscape,
    columns: columnsnr,
    margin: if (columnsnr < 2 and not cs) {
      (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
    } else {
      0.5cm
    },
    footer: context [
      #set text(font: font2.font, size: fsize - 1pt)
      #module | #semester
      #h(1fr)
      #languages.at(language).page #counter(page).display()
    ],
    header: context [
      #set text(font: font2.font, size: fsize - 1pt)
      #author
      #h(1fr)
      #datetime.today().display(dateformat)
    ],
  )

  set columns(columnsnr, gutter: if (columnsnr < 2) { 2em } else { 1em })
  set text(..font)
  show math.equation: set text(font: "Fira Math")
  set enum(numbering: "1.a)")
  set table.cell(breakable: false)

  show link: it => [
    #set text(weight: 500, fill: colors.darkblue)
    #underline(offset: 0.7mm, stroke: colors.blue, it)
  ]
  show ref: it => [
    #set text(weight: 500, fill: colors.darkblue)
    #underline(offset: 0.7mm, stroke: colors.blue, it)
  ]

  set heading(
    numbering: "1.1.1.1.1.1.",
    supplement: languages.at(language).chapter,
  )
  show heading: hd => block({
    if hd.numbering != none and hd.level <= 6 {
      context counter(heading).display()
      h(1.3em)
    }
    hd.body
  })

  show heading.where(level: 1): h => {
    set text(..font2, top-edge: 0.18em)
    set par(leading: 1.3em, hanging-indent: 2.5em)
    line(length: 100%, stroke: 0.18em + colors.blue)
    upper(h)
    v(0.45em)
  }

  show heading.where(level: 2): h => {
    set text(size: fsize - 1pt)
    upper(h)
  }

  show heading.where(level: 4): h => {
    v(-0.4em)
    h
  }

  set grid(gutter: 1em)
  set table(
    stroke: (x, y) => (left: if x > 0 { 0.07em }, top: if y > 0 { 0.07em }),
    inset: 0.5em,
  )

  show table.cell: set text(size: if cs { fsize - 1pt } else { fsize })
  show table.cell.where(y: 0): emph
  show list: set list(marker: "–", body-indent: 0.45em)
  show emph: set text(fill: font2.fill, weight: font2.weight)
  show raw: set text(font: font2.font, size: if cs { fsize - 1pt } else {
    fsize + 1pt
  })
  show raw.where(lang: "cisco"): it => [
    #show regex("(Router|Switch)(>|(\(config(-if)?\))?#)"): line => {
      show regex("(>|(\(config(-if)?\))?#)"): keyword => text(
        weight: "bold",
        fill: colors.darkblue,
        keyword,
      )
      show regex("(Router|Switch)"): keyword => text(weight: "bold", keyword)
      line
    }
    #it
  ]

  set quote(block: true, quotes: true)
  show quote: q => {
    set align(left)
    set text(style: "italic")
    q
  }

  show ref: ref => if ref.element.func() != heading {
    ref
  } else {
    let label = ref.target
    let header = ref.element
    link(
      label,
      ["#header.body" (#languages.at(language).page #header.location().page())],
    )
  }

  set outline(indent: 0em)

  show outline.entry.where(level: 1): entry => {
    v(1.1em, weak: true)
    strong(entry)
  }

  let subtitle(subt) = [
    #set text(..font2, size: fsize + 3pt)
    #pad(bottom: 1.3em, subt)
  ]

  if (not cs) {
    align(left)[
      #text(..font2, size: fsize + 5pt, name + " | " + module)
      #v(1em, weak: true)
      #subtitle[#languages.at(language).summary]
    ]
  }

  if (toc.enabled) {
    heading(outlined: false, numbering: none, languages.at(language).toc)
    columns(
      toc.at("columns", default: 1),
      outline(depth: toc.at("depth", default: none), title: none),
    )
    pagebreak()
  }

  set par(justify: true)
  body
}

#let cheatsheet(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: true,
  columnsnr: 5,
  toc: (enabled: false, depth: 9, columnsnr: 1),
  language: "de",
  fsize: 6pt,
  appendix: (),
  cs: true,
  body,
) = project(
  module: module,
  name: name,
  semester: semester,
  date: date,
  landscape: landscape,
  columnsnr: columnsnr,
  toc: toc,
  language: language,
  fsize: fsize,
  appendix: appendix,
  cs: cs,
  body,
)
