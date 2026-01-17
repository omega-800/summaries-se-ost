#import "./const.typ": *

#let deftbl(..body, term: context languages.at(text.lang).term, definition: context languages.at(text.lang).definition ) = [
  #table(
    columns: (auto, 1fr),
    table.header(
      [#term], [#definition]
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
  //           target-deck: module-name.get(),
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
  let get-size = v => if type(v) == int { v } else { v.size }
  let get-unit = v => " (" + str(get-size(v)) + " " + unit + ")"
  let get-name = (k, v) => if type(v) == int or not "name" in v { k } else { v.name }
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
            get-name(k, v) + if with-tbl-unit { get-unit(v) },
          ),
        )
      )
    }
    #if with-desc and defs.len() != 0 {
      deftbl(
        term: "Field",
        ..defs.map(((k, v)) => ([#get-name(k,v) #{if with-desc-unit {get-unit(v)}}], [#v.desc])).flatten(),
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
