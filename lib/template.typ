#import "./const.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge
#import "@preview/lilaq:0.5.0" as lq

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
  appendix: (),
  cs: false,
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
  module-name.update(module)
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
  set text(..font, lang: language)
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

  let math-text = (font: "Fira Math")
  show math.equation: set text(..math-text)

  let raw-text = (
    font: font2.font,
    size: if cs { fsize - 1pt } else {
      fsize + 1pt
    },
  )

  show: lq.theme.schoolbook
  show: lq.set-tick(inset: 2pt, outset: 2pt, pad: 0.4em)
  show lq.selector(lq.tick-label): set text(size: raw-text.size - 4pt)
  show: lq.set-diagram(
    cycle: (colors.darkblue, colors.purple, colors.green, colors.red),
    width: 8.5cm,
    yaxis: (position: 0),
    xaxis: (position: 0),
  )
  set lq.style(
    stroke: 1.5pt, /*(paint: colors.darkblue/* , thickness: 1.5pt */)*/
  )
  show lq.selector(lq.diagram): set text(..math-text)

  show raw: set text(..raw-text)
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
  show raw.where(lang: "bnf"): it => [
    #show regex("::?="): line => {
      text(weight: "bold", line)
    }
    #show regex("'.*?'"): line => {
      text(fill: colors.green.darken(20%), line)
    }
    #show regex("\*|\.\.\.|,"): line => {
      text(fill: colors.red, line)
    }
    // #show regex("\{|\}|\[|\]|\|"): line => {
    //   text(fill: colors.red, line)
    // }
    #show regex("<\w*>"): line => {
      emph(line)
    }
    #show regex("#.*\n"): line => {
      text(fill: colors.comment, style: "normal", weight: "medium", line)
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
