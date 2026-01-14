#import "./const.typ": *

#let deftbl(..body) = context [
  #table(
    columns: (auto, 1fr),
    table.header(
      [#languages.at(text.lang).term], [#languages.at(text.lang).definition]
    ),
    ..body,
  )
  // FIXME: bruh typ2anki doesn't recognize this bc it only parse the file being compiled, searching for #card ast nodes
  // #box(place(hide(
  //   [
  //     #for i in (
  //       body
  //         .pos()
  //         .chunks(2)
  //         .enumerate(start: 1)
  //         .map(((i, (t, d))) => card(
  //           id: str(i),
  //           target-deck: mod.get(),
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
      deftbl(
        ..defs.map(((k, v)) => ([#k #{if with-desc-unit {get-unit(v)}}], [#v.desc])).flatten(),
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
