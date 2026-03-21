#import "./const.typ": *
#import "./functions.typ": *
#import "./tmTheme.typ": tm-theme
#import "./ctx.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge
#import "@preview/lilaq:0.5.0" as lq

#let i18n-fonts = (language: "de", fsize: 11pt) => {
  let reg = (
    (lang: language) + (if language == "de" { (region: "ch") } else { (:) })
  )
  (
    font: (
      font: "Arimo Nerd Font",
      size: fsize,
      fill: colors.fg,
    )
      + reg,
    code-f: (font: code-font, weight: "bold", fill: colors.darkblue) + reg,
    math-f: (
      // font: "Fira Math",
      font: "Noto Sans Math",
      features: ("cv01",),
    )
      + reg,
  )
}

#let general(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columnsnr: 1,
  toc: (enabled: true, depth: 3, columnsnr: 1),
  language: "de",
  fsize: 11pt,
  show-title: true,
  body,
) = {
  fletcher.MARKS.update(m => {
    import fletcher.cetz.draw
    (
      m
        + (
          "composition": (
            draw: mark => {
              draw.ortho(
                draw.on-xz({
                  draw.rect((-10, -0), (0, 10))
                }),
              )
            },
          ),
          "aggregation": (
            // TODO: less hackiness
            tip-end: mark => -14,
            draw: mark => {
              draw.ortho(
                draw.on-xz({
                  draw.rect((-10, -0), (0, 10), fill: none)
                }),
              )
            },
          ),
          "inheritance": (
            tip-end: mark => -12,
            draw: mark => {
              draw.mark((0, 0), 0deg, symbol: ">", scale: 60, fill: none)
            },
          ),
        )
    )
  })
  defctr.update(1)
  exctr.update(1)
  obsctr.update(1)
  module-name.update(module)
  set document(author: author, title: name + " " + semester, date: date)

  let (font, code-f, math-f) = i18n-fonts(language: language, fsize: fsize)

  set page(
    flipped: landscape,
    columns: columnsnr,
    footer: context [
      #set text(font: code-f.font, size: fsize - 1pt)
      #module | #semester
      #h(1fr)
      #languages.at(language).page #counter(page).display()
    ],
    header: context [
      #set text(font: code-f.font, size: fsize - 1pt)
      #author
      #h(1fr)
      #datetime.today().display(dateformat)
    ],
    fill: colors.bg,
  )

  set columns(columnsnr, gutter: if (columnsnr < 2) { 2em } else { 1em })
  set text(..font)
  set enum(numbering: "1.a)")

  let lnkstyle = it => [
    #set text(weight: 500, fill: colors.darkblue)
    #underline(offset: 0.7mm, stroke: colors.blue, it)
  ]
  show link: lnkstyle
  show ref: lnkstyle

  // show heading.where(level: 5).or(heading.where(level: 6)): h => {
  //   set text(size: fsize - 1pt)
  //   h
  // }

  // FIXME: remove this and check all docs
  set grid(gutter: 1em)
  set table(
    stroke: (x, y) => (
      left: if x > 0 { 0.07em + colors.fg },
      top: if y > 0 { 0.07em + colors.fg },
    ),
    inset: 0.5em,
  )
  set table.cell(breakable: false)
  // FIXME: table-header
  show table.cell.where(y: 0): emph

  show list: set list(marker: "–", body-indent: 0.45em)
  show emph: set text(fill: code-f.fill, weight: code-f.weight)

  // FIXME: stretching arrows doesn't work
  // TODO: test features
  show math.equation: set text(..math-f)

  show: lq.theme.schoolbook
  show: lq.set-tick(inset: 2pt, outset: 2pt, pad: 0.4em)
  show: lq.set-diagram(
    cycle: color-cycle,
    // FIXME: remove this and check all docs
    width: 8.5cm,
    yaxis: (position: 0),
    xaxis: (position: 0),
  )
  set lq.style(
    stroke: 1.5pt, /*(paint: colors.darkblue/* , thickness: 1.5pt */)*/
  )
  show lq.selector(lq.diagram): set text(..math-f)

  show raw: set raw(theme: bytes(colors
    .pairs()
    .fold(tm-theme, (acc, (k, v)) => acc.replace(
      "{{" + k + "}}",
      "#"
        + v
          .components(alpha: false)
          .map(i => hex(int(255 * i / 100%), prefix: false))
          .join(),
    ))))
  // TODO: transfer to sublime syntax def
  show raw.where(lang: "cisco"): it => {
    show regex("(Router|Switch)(>|(\(config(-if|-router)?\))?#)"): line => {
      show regex("(>|(\(config(-if|-router)?\))?#)"): text.with(
        weight: "bold",
        fill: colors.darkblue,
      )
      show regex("(Router|Switch)"): text.with(weight: "bold")
      line
    }
    show regex("^#.*\n"): text.with(fill: colors.comment)
    it
  }
  let ebnf-syntax = it => {
    show regex("('|\").*?('|\")"): text.with(fill: colors.green.darken(20%))
    // TODO: include regex symbols for extended BNF syntax
    show regex("::?=|\[|\]|\{|\}|\||\(|\)"): text.with(weight: "bold")
    show regex("<[0-9a-zA-Z_-]+?>"): emph
    show regex("#.*\n"): text.with(
      fill: colors.comment,
      style: "normal",
      weight: "medium",
    )
    it
  }
  show raw.where(lang: "bnf").or(raw.where(lang: "ebnf")): ebnf-syntax

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

  set outline(indent: 1em)

  show outline.entry.where(level: 1): entry => {
    v(1.1em, weak: true)
    text(fill: colors.purple, strong(entry))
  }

  show outline.entry.where(level: 2): entry => {
    strong(entry)
  }

  if show-title {
    let subtitle(subt) = [
      #set text(..code-f, size: fsize + 3pt)
      #pad(bottom: 1.3em, subt)
    ]

    align(left)[
      #text(..code-f, size: fsize + 5pt, name + " | " + module)
      #v(1em, weak: true)
      #subtitle[#languages.at(language).summary]
    ]
  }

  if toc.enabled {
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

#let project(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: false,
  columnsnr: 1,
  toc: (enabled: true, depth: 3, columnsnr: 1),
  language: "de",
  fsize: 11pt,
  show-title: true,
  body,
) = {
  let (font, code-f) = i18n-fonts(language: language, fsize: fsize)

  set page(
    margin: if (columnsnr < 2) {
      (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
    } else {
      0.5cm
    },
  )
  show table.cell: set text(size: fsize)

  let raw-text = (
    font: code-f.font,
    size: fsize,
  )
  show raw: set text(..raw-text)
  show lq.selector(lq.tick-label): set text(size: raw-text.size - 4pt)

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
    set text(..code-f, top-edge: 0.18em, fill: colors.purple)
    set par(leading: 1.3em, hanging-indent: 2.5em)
    line(length: 100%, stroke: 0.18em + colors.purple)
    upper(h)
    v(0.45em)
  }

  show heading.where(level: 2): h => {
    set text(..code-f, top-edge: 0.18em)
    line(length: 100%, stroke: 0.1em + colors.darkblue)
    upper(h)
  }

  show heading.where(level: 3): h => {
    set text(..code-f)
    h
  }

  show heading.where(level: 4): h => {
    h
  }

  general(
    module: module,
    name: name,
    semester: semester,
    date: date,
    landscape: landscape,
    columnsnr: columnsnr,
    toc: toc,
    language: language,
    fsize: fsize,
    show-title: show-title,
    body,
  )
}

#let cheatsheet(
  module: "",
  name: "",
  semester: "",
  date: datetime.today(),
  landscape: true,
  columnsnr: 5,
  toc: (enabled: false, depth: 9, columnsnr: 1),
  show-title: false,
  language: "de",
  fsize: 6pt,
  body,
) = {
  let (font, code-f) = i18n-fonts(language: language, fsize: fsize)
  set page(
    margin: 0.5cm,
  )
  show table.cell: set text(size: fsize - 1pt)
  let raw-text = (
    font: code-f.font,
    size: fsize - 1pt,
  )
  show raw: set text(..raw-text)
  show lq.selector(lq.tick-label): set text(size: raw-text.size)

  show heading: hd => {
    if hd.level > 3 {
      text(
        fill: colors.darkblue,
        size: fsize - 1pt,
        style: "italic",
      )[#hd.body]
    } else {
      hd.body
    }
  }

  show heading.where(level: 1): h => {
    set text(..code-f, fill: colors.purple, size: fsize, style: "italic")
    upper(h)
    v(-.5em)
  }

  show heading.where(level: 2): h => {
    set text(..code-f, fill: colors.darkblue, size: fsize, style: "italic")
    upper(h)
    v(-.25em)
  }

  show heading.where(level: 3): h => {
    set text(
      ..code-f,
      fill: colors.darkblue,
      size: fsize - 1pt,
      style: "italic",
    )
    upper(h)
    v(-.25em)
  }

  show lq.selector(lq.legend): set grid(gutter: 0pt)

  general(
    module: module,
    name: name,
    semester: semester,
    date: date,
    landscape: landscape,
    columnsnr: columnsnr,
    toc: toc,
    language: language,
    fsize: fsize,
    show-title: show-title,
    body,
  )
}
