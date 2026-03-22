#import "./const.typ": *
#import "./functions.typ": merge-deep

// TODO: incorporate this everywhere
// WARN: wait for omega-800 to slightly refactor tanki api
// NOTE: oh wait that's me
// FIXME: slice and spread rest of fields
#let note = ta.add-note.with(anki-format: n => (
  ..n,
  fields: ([#n.fields.at(0) (#n.tags.join([, ]))], n.fields.at(1)),
))

// TODO: PR: only element functions can be used in set rules

#let deck = ta.deck.with(filename: "deck")
#let add-deck = ta.add-deck.with(filename: "deck")

#let diagram = fletcher.diagram.with(
  node-stroke: 1pt + colors.fg,
  edge-stroke: 1pt + colors.fg,
  mark-scale: 60%,
  spacing: (1em, 1em),
  node-shape: rect,
)
#let diagram3d = pt3d.diagram.with(
  width: 8.5cm,
  height: 6cm,
  cycle: color-cycle,
)
#let edge = fletcher.edge.with(label-side: center)
#let _par = chronos._par.with(color: colors-l.blue, show-bottom: false)
#let _seq = chronos._seq.with(
  slant: 5,
  comment-align: "center",
  color: colors.fg,
)

#let automaton = (..args) => {
  let transitions = (:)
  let states = (:)
  let nodes = args.pos().at(0)
  let n-no-style = ()
  let t-no-style = ()
  let seen = ()
  let style = args.named().at("style", default: (:))
  for (k, v) in nodes.pairs() {
    if not k in style or not "stroke" in style.at(k) { n-no-style.push(k) }
    if (
      v.len() == 0
        and (not k in style or not "stroke" in style.at(k))
        and nodes.pairs().all(((_, vv)) => not k in vv)
    ) {
      states.insert(k, (stroke: colors.comment))
    }
    if type(v) != dictionary { continue }

    for (to, _) in v.pairs() {
      let ft = k + "-" + to
      if not ft in style or not "stroke" in style.at(ft) { t-no-style.push(ft) }
      let tf = to + "-" + k
      if (
        not k in nodes.at(to)
          and (not ft in style or not "curve" in style.at(ft))
      ) {
        transitions.insert(ft, (curve: 0))
      }
      if (
        k in nodes.at(to)
          and not k in seen
          and (not tf in style or not "curve" in style.at(tf))
      ) {
        transitions.insert(tf, (curve: 0))
        // TODO:
        seen.push(to)
      }
      // TODO:
      // seen.push(to)
    }
  }
  finite.automaton(
    ..args.pos(),
    // ..args.named(),
    ..merge-deep(
      (
        state-format: label => {
          let m = label.match(regex(`^(s)?(_)?(\D+)((\d+,?)+)?$`.text))
          // panic("q1,2,3".match(regex(`^(s)?(_)?(\D+)((\d+,?)+)?$`.text)))
          if m != none {
            let is-set = m.captures.at(0) != none
            let is-neg = m.captures.at(1) != none
            let is-all = m.captures.at(2) == "Q"
            let is-eps = m.captures.at(2) == "e"
            let n = m.captures.at(3)
            let ns = (n,)
            if n != none and "," in n {
              ns = n.split(",")
            }

            let name = $#if is-eps { $epsilon$ } else if is-all { $Q$ } else {
              m.captures.at(2)
            }$
            let char = ns
              .map(d => if d == none { name } else { $#{ name } _#d$ })
              .join($,$)
            if is-set and not is-all {
              if is-eps { $emptyset$ } else {
                let s = [{#char}]
                if is-neg { $overline(#s)$ } else { s }
              }
            } else { char }
          } else {
            label
          }
        },
        input-format: inputs => {
          if type(inputs) != array { return inputs }
          inputs
            .map(i => if i == "\S" { $S$ } else if i == "\e" { $e$ } else if i
              == "S" { $Sigma$ } else if i == "e" { $epsilon$ } else {
              $#i$
            })
            .join($,$)
        },
        style: (
          transition: (
            label: (angle: 0deg, stroke: colors.fg),
            curve: .75,
          ),
          state: (stroke: colors.fg, label: (stroke: colors.fg)),
          ..merge-deep(
            (:..transitions, ..states),
            (..t-no-style, ..n-no-style)
              .map(k => (k, (stroke: colors.fg)))
              .to-dict(),
          ),
        ),
      ),
      args.named(),
    ),
  )
}
