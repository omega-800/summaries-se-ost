#import "./const.typ": *
#import "./functions.typ": *
#import "./overrides.typ": ta

#let deftbl(
  ..body,
  term: context languages.at(text.lang).term,
  definition: context languages.at(text.lang).definition,
  did: none,
  tags: (),
) = [
  #table(
    columns: (auto, 1fr),
    table-header([#term], [#definition]),
    ..body,
  )
  #if did != none {
    body
      .pos()
      .chunks(2)
      .map(((t, d)) => ta.add-note(deck: did, t, d, format: none, tags: tags))
      .join()
  }
]

#let contentbox(
  color: colors.black,
  // stfu i *am* good at naming things, it's your opinion that's wrong
  title: none,
  titlesub: none,
  // *cries*
  titlesubsub: none,
  bodysub: none,
  body,
) = {
  let header = ()
  if titlesub != none or titlesubsub != none {
    header.push(align(horizon, [#if titlesub != none {
        text(fill: color, style: "italic", weight: "bold")[#titlesub]
      }
      #if titlesubsub != none {
        text(fill: color, style: "italic")[#titlesubsub]
      }
      #if title != none { text(fill: color, weight: "bold")[:] }
    ]))
  }
  if title != none {
    header.push(text(weight: "bold")[#title])
  }
  let content = ()
  if bodysub != none {
    content.push(text(fill: color, style: "italic")[#bodysub :])
  }
  content.push(body)
  pad(x: 1em, block(
    stroke: color + 1.25pt,
    fill: color.lighten(95%),
    inset: 1em,
    width: 100%,
    radius: 3pt,
    [
      #if header.len() > 0 {
        grid(columns: header.len(), ..header)
        align(center, line(length: 100%, stroke: color))
      }
      #grid(
        columns: if content.len() > 1 { (auto, 1fr) } else { (1fr,) },
        ..content
      )
    ],
  ))
}

#let defctr = counter("definitions")
#let defbox(
  term: context languages.at(text.lang).term,
  definition: context languages.at(text.lang).definition,
  did: none,
  tags: (),
  title,
  body,
) = context {
  defctr.update(n => n + 1)
  contentbox(
    color: colors.purple,
    title: title,
    titlesub: term,
    titlesubsub: defctr.display(),
    // bodysub: definition,
    body,
  )
  if did != none {
    ta.add-note(deck: did, title, body, format: none, tags: tags)
  }
}

#let exctr = counter("examples")
#let exbox(
  example: context languages.at(text.lang).example,
  title: none,
  did: none,
  tags: (),
  body,
) = context {
  exctr.update(n => n + 1)
  contentbox(
    color: colors.blue,
    title: title,
    titlesub: example,
    titlesubsub: exctr.display(),
    body,
  )
  if did != none and title != none {
    ta.add-note(deck: did, title, body, format: none, tags: tags)
  }
}

#let obsctr = counter("observations")
#let obsbox(
  observations: context languages.at(text.lang).observations,
  title: none,
  ..body,
) = context {
  obsctr.update(n => n + 1)
  let n = obsctr.display()
  contentbox(
    color: colors.green,
    title: title,
    titlesub: observations,
    titlesubsub: n,
    grid(columns: (auto, 1fr), ..body
        .pos()
        .enumerate(start: 1)
        .map(((i, b)) => (
          [#n.#i.],
          b,
        ))
        .join()),
  )
}

#let frame = (
  unit: "bit",
  with-tbl-unit: false,
  with-desc-unit: true,
  with-desc: true,
  ..body,
) => {
  let get-size = v => if type(v) == int { v } else { v.size }
  let get-unit = v => " (" + str(get-size(v)) + " " + unit + ")"
  let get-name = (k, v) => if type(v) == int or not "name" in v { k } else {
    v.name
  }
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
        table-header(table.cell(colspan: size, $<-- #(str(size)) #unit -->$)),
        ..as-list.map(
          ((k, v)) => table.cell(
            colspan: get-size(v),
            get-name(k, v) + if with-tbl-unit { get-unit(v) },
          ),
        )
      )
    }
    #if with-desc and defs.len() != 0 {
      deftbl(
        term: "Field",
        ..defs
          .map(((k, v)) => (
            [#get-name(k, v) #{ if with-desc-unit { get-unit(v) } }],
            [#v.desc],
          ))
          .flatten(),
      )
    }
  ]
}
#let custom-frame = (..body) => {
  set text(font: code-font)
  set table(stroke: 0.07em)
  set table.cell(align: center)
  table(..body)
}

#let tanki-utils = did => (
  add-note: ta.add-note.with(deck: did),
  add-answer-note: ta.add-note.with(deck: did, format: note-answer),
  add-hd-note: (q, a, n: 2, ..args) => ta.add-note(
    deck: did,
    q,
    a,
    format: note => [
      #heading(level: n, note.fields.at(0))

      #note.fields.at(1)
    ],
    ..args,
  ),
  deftbl: deftbl.with(did: did),
  defbox: defbox.with(did: did),
  exbox: exbox.with(did: did),
)
