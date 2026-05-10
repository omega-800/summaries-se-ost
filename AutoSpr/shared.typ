#import "/lib.typ": *

#let cnode = node.with(
  shape: fletcher.shapes.circle,
  width: .5em,
  height: .5em,
)
#let tnode = node.with(
  shape: fletcher.shapes.triangle,
  width: .1em,
  height: .1em,
)
#let rc = cnode.with(stroke: colors.red, fill: colors-l.red)
#let dc = cnode.with(stroke: colors.darkblue, fill: colors-l.darkblue)
#let pc = cnode.with(stroke: colors.purple, fill: colors-l.purple)
#let gc = cnode.with(stroke: colors.green, fill: colors-l.green)

#let prod-aut = (s, e: ()) => {
  set text(size: 1em * s)
  grid(
    gutter: 3pt,
    columns: 2,
    align: left,
    [],
    grid.cell(fill: colors.red.transparentize(80%), inset: 1em * s, [$A_2$
      #automaton(
        (
          q0: (q0: 0, q1: 1),
          q1: (q0: 1, q2: 0),
          q2: (q2: 1, q1: 0),
        ),
        layout: (
          q0: (0, 0),
          q1: (3 * s, 0),
          q2: (6 * s, 0),
        ),
        final: ("q0",),
        style: (
          // TODO: arrow size
          transition: (curve: .5 * s, label: (dist: 0.33 * s)),
          q2-q2: (anchor: right),
          state: (radius: .6 * s, extrude: if s == 1 { .88 } else { .7 }),
        ),
      )]),

    grid.cell(
      fill: colors.darkblue.transparentize(80%),
      inset: 1em * s,
      [$A_1$#automaton(
          (
            q0: (q1: (0, 1)),
            q1: (q0: 1, q1: 0),
          ),
          layout: (
            q0: (0, 3 * s),
            q1: (0, 0),
          ),
          style: (
            q1-q1: (anchor: bottom),
            transition: (curve: .5 * s, label: (dist: 0.33 * s)),
            state: (radius: .6 * s, extrude: if s == 1 { .88 } else { .7 }),
          ),
        )],
    ),
    grid.cell(
      fill: colors.purple.transparentize(80%),
      inset: 1em * s,
      [$A_1 times A_2$ #automaton(
          (
            q00: (q10: 0, q11: 1),
            q01: (q10: 1, q12: 0),
            q02: (q11: 0, q12: 1),
            q10: (q10: 0, q01: 1),
            q11: (q00: 1, q12: 0),
            q12: (q11: 0, q02: 1),
          ),
          layout: (
            q00: (0, 3 * s),
            q01: (3 * s, 3 * s),
            q02: (6 * s, 3 * s),
            q10: (0, 0),
            q11: (3 * s, 0),
            q12: (6 * s, 0),
          ),
          style: (
            transition: (label: (dist: 0.33 * s)),
            q10-q10: (anchor: bottom),
            q02-q12: (curve: 1 * s),
            q11-q12: (curve: 0),
            q12-q11: (curve: 1 * s),
            q11-q00: (curve: .75 * s),
            q00-q11: (curve: .75 * s),
            q10-q01: (curve: .75 * s),
            q01-q10: (curve: .75 * s),
            q02-q11: (curve: .5 * s),
            q01-q12: (curve: .5 * s),
            state: (radius: .6 * s, extrude: if s == 1 { .88 } else { .7 }),
          ),
          final: e,
        )],
    ),
  )
}
#let ((x1, y1), (x2, y2), (x3, y3), (x4, y4), (x5, y5)) = (
  (0pt, 95pt),
  (182pt, 119pt),
  (96pt, 0pt),
  (71pt, 52pt),
  (112pt, 78pt),
  // (0pt, 8.5em),
  // (16.5em, 11em),
  // (8.5em, 0pt),
  // (6em, 4.5em),
  // (10em, 7em),
)

#let place-off = place.with(dx: 2.2em, dy: 2.5em)
#let poly = place-off(polygon(
  fill: colors.fg.transparentize(75%),
  (x1, y1),
  (x1, y2),
  (x2, y2),
  (x2, y1),
  (x3, y1),
  (x3, y3),
  (x4, y3),
  (x4, y1),
))

#let autospr-shared = (
  np-c-diag: {
    let n(p, t, ..args) = node(
      p,
      box(width: 10em, text(size: .75em, t)),
      stroke: none,
      width: 5.5em,
      ..args,
    )
    let gn = n.with(fill: colors-l.darkblue)
    let edge = edge.with(marks: "-|>")
    align(center, diagram(
      n((3, 0), [SAT], name: <sat>),

      n((2, 1), [k-CLIQUE], name: <k-clique>),
      n((3, 1), [BIP], name: <bip>),
      n((4, 1), [3SAT], name: <sat3>),

      n((1, 2), [VERTEX-COVER], name: <vertex-cover>),
      n((2.5, 2), [SET-PACKING], name: <set-packing>),
      n((5, 2), [VERTEX-COLORING], name: <vertex-coloring>),

      n((0, 3), [HAMPATH], name: <hampath>),
      n((1, 3), [SET-COVERING], name: <set-covering>),
      n((2, 3), [FEEDBACK-\ NODE-SET], name: <feedback-node-set>),
      n((3, 3), [FEEDBACK-\ ARC-SET], name: <feedback-arc-set>),
      n((4.5, 3), [EXACT-COVER], name: <exact-cover>),
      n((6, 3), [CLIQUE-COVER], name: <clique-cover>),

      n((0, 4), [UHAMPATH], name: <uhampath>),
      n((3, 4), [3D-MATCHING], name: <d-matching>),
      n((4, 4), [SUBSET-SUM], name: <subset-sum>),
      n((5, 4), [HITTING-SET], name: <hitting-set>),
      n((6, 4), [STEINER-TREE], name: <steiner-tree>),

      n((3.5, 5), [SEQUENCING], name: <sequencing>),
      n((4.5, 5), [PARTITION], name: <partition>),

      n((4.5, 6), [MAX-CUT], name: <max-cut>),

      edge(<sat>, <k-clique>),
      edge(<sat>, <bip>),
      edge(<sat>, <sat3>),

      edge(<k-clique>, <vertex-cover>),
      edge(<k-clique>, <set-packing>),

      edge(<sat3>, <vertex-coloring>),

      edge(<vertex-cover>, <feedback-node-set>),
      edge(<vertex-cover>, <feedback-arc-set>),
      edge(<vertex-cover>, <hampath>),
      edge(<vertex-cover>, <set-covering>),

      edge(<vertex-coloring>, <exact-cover>),
      edge(<vertex-coloring>, <clique-cover>),

      edge(<hampath>, <uhampath>),

      edge(<exact-cover>, <d-matching>),
      edge(<exact-cover>, <subset-sum>),
      edge(<exact-cover>, <hitting-set>),
      edge(<exact-cover>, <steiner-tree>),

      edge(<subset-sum>, <sequencing>),
      edge(<subset-sum>, <partition>),

      edge(<partition>, <max-cut>),
    ))
  },
  np-c-list: (
    "Graph-Überdeckungen": (
      desc: [
        Handeln davon, dass ein gegebener Graph von einer Menge beschränkter
        Größe mit einer besonderen Eigenschaft aus erreicht werden kann.
      ],
      "VERTEX-COLORING": (
        desc: [
          Gegeben ist ein Graph $G = (V, E)$ mit Knoten $V$ und Kanten $K$ und
          eine Zahl $k$. Ist es möglich, die Knoten des Graphen mit $k$ Farben
          so einzufärben, dass durch Kanten verbundene Knoten verschiedene
          Farben haben?
        ],
        lang: $
          {lrc(G, k) cases(
              delim: "|",
              "Es gibt eine Einfärbung der Knoten von" G, "mit" k "Farben derart,"
              "dass zwei verbundene", " Knoten verschiedene Farben haben"
            )}
        $,
        img: {
          diagram(
            spacing: (2em, 2em),
            node((0, -1.5), $k=4$, stroke: none),
            dc(name: <r1>, (0, -1)),
            pc(name: <r2>, (0, 0.5)),
            gc(name: <r3>, (-1, 0)),
            rc(name: <r4>, (-1, 1)),
            gc(name: <r5>, (1, 1)),
            rc(name: <r6>, (1, 0)),
            edge(<r1>, <r2>),
            edge(<r3>, <r2>),
            edge(<r4>, <r2>),
            edge(<r5>, <r2>),
            edge(<r1>, <r3>),
            edge(<r3>, <r4>),
            edge(<r6>, <r2>),
            edge(<r6>, <r5>),
            edge(<r6>, <r1>),
          )
        },
        ex: todo[],
      ),
      "CLIQUE-COVER": (
        desc: [
          Gibt es $k$ Cliquen so, dass jede Ecke in genau einer der Cliquen ist?
        ],
        lang: $
          {lrc(G, k) cases(
              delim: "|",
              "Es gibt" k "Cliquen" G_k =
              (V_k\, E_k)\, "die zusammen ", "alle Knoten von" G "abdecken, also" V = union.big_(i=1)^k
              V_i
            )}
        $,
        img: {
          diagram(
            spacing: (2em, 2em),
            node((0, -1.5), $k=3$, stroke: none),
            cnode(name: <r1>, (1, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r6>),
            edge(<r3>, <r2>),
            edge(<r4>, <r2>),
            edge(<r5>, <r2>),
            edge(<r6>, <r5>),
            edge(<r6>, <r1>),
            edge(<r4>, <r5>),

            node(
              enclose: (<r1>, <r6>),
              shape: fletcher.shapes.pill,
              stroke: colors.purple,
            ),
            node(
              enclose: (<r6>, <r3>),
              shape: fletcher.shapes.pill,
              stroke: colors.red,
            ),
            node(
              enclose: (<r5>, <r4>, <r2>),
              shape: fletcher.shapes.pill,
              stroke: colors.green,
              inset: 1em,
            ),
          )
        },
      ),
      "EXACT-CLIQUE-COVER": (
        desc: [
          Wie CLIQUE-COVER, nur müssen die Mengen disjunkt sein.
        ],
        lang: $
          {lrc(G, k) cases(
              delim: "|",
              "Es gibt" k "disjunkte Cliquen" G_k =
              (V_k\, E_k)\,, V_i inter V_j = emptyset "für" i != j\,
              "die zusammen alle", "Knoten von" G "abdecken, also" V = union.big_(i=1)^k
              V_i
            )}
        $,
        img: {
          diagram(
            spacing: (2em, 2em),
            node((0, -1.5), $k=2$, stroke: none),

            cnode(name: <r1>, (0, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r6>),
            edge(<r3>, <r2>),
            edge(<r4>, <r2>),
            edge(<r5>, <r2>),
            edge(<r1>, <r3>),
            edge(<r6>, <r5>),
            edge(<r6>, <r1>),
            edge(<r4>, <r5>),

            node(
              enclose: (<r6>, <r3>, <r1>),
              shape: fletcher.shapes.pill,
              inset: .75em,
              stroke: colors.red,
            ),
            node(
              enclose: (<r5>, <r4>, <r2>),
              shape: fletcher.shapes.pill,
              inset: .75em,
              stroke: colors.red,
            ),
          )
        },
      ),
      "K-CLIQUE": (
        desc: [
          Wie CLIQUE-COVER, nur ist $k$ bekannt.
        ],
        ex: todo[],
      ),
      "VERTEX-COVER": (
        desc: [Gibt es eine Menge $W$ von $k$ Knoten derart, dass jede Kante von
          $G$ einen Endpunkt in $W$ hat?],
        lang: $
          {lrc(G = (V,E), k) cases(
              delim: "|",
              "Es gibt eine" k"-elementige Teilmenge",
              W subset V "mit" W inter e != emptyset forall e in E
            )}
        $,
        img: diagram(
          spacing: (2em, 2em),
          node((0, -1.5), $k=2$, stroke: none),

          cnode(name: <r1>, (-1, -1)),
          cnode(name: <r2>, (1, -1)),
          cnode(name: <r3>, (-1, 0)),
          cnode(name: <r4>, (1, 0)),
          cnode(name: <r5>, (0, 1)),

          edge(<r3>, (-1, -.5), stroke: colors.red + 2pt),
          edge(<r4>, (1, -.5), stroke: colors.red + 2pt),
          edge(<r3>, (-.5, .5), stroke: colors.red + 2pt),
          edge(<r1>, <r3>),
          edge(<r2>, <r4>),
          edge(<r3>, <r4>, stroke: colors.red + 2pt),
          edge(<r3>, <r5>),

          node(
            enclose: (<r3>, <r4>),
            shape: fletcher.shapes.pill,
            stroke: colors.red,
          ),
        ),
        ex: todo[],
      ),
    ),
    "Mengen": (
      desc: [
        Handeln von einer Familie $(S_i)_(i in I)$ von nichtleeren endlichen
        Mengen. In diesen Problemen geht es um die existenz einer Teilfamilie
        mit bestimmten Eigenschaften.
      ],
      "SET-PACKING": (
        desc: [
          Wie viele der Mengen $S_i$ kann man in $U$ hineinpacken, ohne dass sie
          sich überlappen? Gibt es $k$ Teilmengen in $S$, welche disjunkt sind
          und die Menge $U$ abdecken?
        ],
        lang: $
          {lrc((S_i)_(i in I), k) cases(
              delim: "|",
              "Es gibt eine" k "-elementige Teilfamilie", J subset I\, abs(J) = k
              "von paarweise disjunkten", "Mengen" S_k inter S_l = emptyset forall k\,l in J
            )}
        $,
        img: diagram(
          spacing: (2em, 2em),
          node((0, -1.75), $k=5$, stroke: none),

          cnode((-1, -1)),
          cnode((0, -1)),
          cnode((1, -1)),

          cnode((-1, 0)),
          cnode((0, 0)),
          cnode((1, 0)),

          cnode((-1, 1)),
          cnode((0, 1)),
          cnode((1, 1)),

          node(
            stroke: colors.red + 2pt,
            enclose: ((-1, -1), (-1, 1)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(enclose: ((0, -1), (1, -1)), shape: fletcher.shapes.pill),
          node(
            enclose: ((-1, 1), (1, 0)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),

          node(
            stroke: colors.red + 2pt,
            enclose: ((0, 1),),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((1, 1),),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(enclose: ((-1, -1), (-1, 0)), shape: fletcher.shapes.pill),
          node(
            stroke: colors.red + 2pt,
            enclose: ((0, -1), (0, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((1, -1), (1, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(enclose: ((-1, 1), (1, 1)), shape: fletcher.shapes.pill),
        ),
        ex: todo[],
      ),
      "SET-COVERING": (
        desc: [
          Gibt es eine Unterfamilie bestehend aus $k$ Mengen, die die gleiche
          Vereinigung $U$ hat? Kann man $k$ Teilmengen bilden, welche die Menge
          $S$ komplett abdecken?
        ],
        lang: $
          {lrc((S_i)_(i in I), k) cases(
              delim: "|",
              "Es gibt eine" k "-elementige Teilfamilie",
              J subset I\, abs(J) = k "mit" union.big_(j in J) S_j = U
            )}
        $,
        img: diagram(
          spacing: (2em, 2em),
          node((0, -1.75), $k=3$, stroke: none),

          cnode((-1, -1)),
          cnode((0, -1)),
          cnode((1, -1)),

          cnode((-1, 0)),
          cnode((0, 0)),
          cnode((1, 0)),

          cnode((-1, 1)),
          cnode((0, 1)),
          cnode((1, 1)),

          node(enclose: ((0, 1),), shape: fletcher.shapes.pill, inset: 1em),
          node(enclose: ((1, 1),), shape: fletcher.shapes.pill, inset: 1em),
          node(
            enclose: ((-1, -1), (-1, 1)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((0, -1), (1, -1)),
            shape: fletcher.shapes.pill,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((-1, 1), (1, 0)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),

          node(
            stroke: colors.red + 2pt,
            enclose: ((-1, -1), (-1, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(enclose: ((0, -1), (0, 0)), shape: fletcher.shapes.pill),
          node(enclose: ((1, -1), (1, 0)), shape: fletcher.shapes.pill),
          node(enclose: ((-1, 1), (1, 1)), shape: fletcher.shapes.pill),
        ),
        ex: todo[],
      ),
      "EXACT-COVER": (
        desc: [
          Gibt es eine Unterfamilie von Mengen, die disjunkt sind, aber die
          gleiche Vereinigung haben? Jedes Element in $U$ soll genau in einer
          der Teilmengen der Familie $S$ vorkommen. Die gesuchte Menge bildet
          eine exakte Überdeckung.
        ],
        lang: $
          {lrc((S_i)_(i in I)) cases(
              delim: "|",
              "Es gibt eine Teilfamilie" J subset I "paarweise",
              "disjunkter Mengen mit der gleicher Vereinigung"
            )}
        $,
        img: diagram(
          spacing: (2em, 2em),

          node((0, -1.75), text(stroke: colors.bg, $k = 3$), stroke: none),

          cnode((-1, -1)),
          cnode((0, -1)),
          cnode((1, -1)),

          cnode((-1, 0)),
          cnode((0, 0)),
          cnode((1, 0)),

          cnode((-1, 1)),
          cnode((0, 1)),
          cnode((1, 1)),

          node(
            enclose: ((-1, -1), (-1, 1)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(enclose: ((0, -1), (1, -1)), shape: fletcher.shapes.pill),
          node(
            enclose: ((-1, 1), (1, 0)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),

          node(enclose: ((0, 1),), shape: fletcher.shapes.pill, inset: 1em),
          node(enclose: ((1, 1),), shape: fletcher.shapes.pill, inset: 1em),
          node(
            stroke: colors.red + 2pt,
            enclose: ((-1, -1), (-1, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((0, -1), (0, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((1, -1), (1, 0)),
            shape: fletcher.shapes.pill,
          ),
          node(
            stroke: colors.red + 2pt,
            enclose: ((-1, 1), (1, 1)),
            shape: fletcher.shapes.pill,
          ),
        ),
        ex: todo[],
      ),
      "HITTING-SET": (
        desc: [
          Sucht zu $U$ eine Menge von Punkten (Elemente), die jede Menge der
          Familie in genau einem Punkt treffen. Gibt es eine Menge $W subset U$
          derart, dass $W$ mit jeder Menge $S_i$ nur ein Element gemeinsam hat?
        ],
        lang: $
          {
            lrc((S_i)_(i in I)) cases(
              delim: "|",
              "Es gibt eine Teilfamilie" W subset U = union.big_(i in I) S_i,
              "derart, dass" abs(W inter S_i) = 1 forall i in I
            )
          }
        $,
        img: diagram(
          spacing: (2em, 2em),

          node((0, -1.75), text(stroke: colors.bg, $k = 3$), stroke: none),

          rc((-1, -1)),
          rc((0, -1)),
          cnode((1, -1)),

          cnode((-1, 0)),
          cnode((0, 0)),
          cnode((1, 0)),

          cnode((-1, 1)),
          cnode((0, 1)),
          rc((1, 1)),

          node(
            enclose: ((-1, -1), (-1, 1)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),
          node(enclose: ((0, -1), (1, -1)), shape: fletcher.shapes.pill),
          node(
            enclose: ((-1, 1), (1, 0)),
            shape: fletcher.shapes.pill,
            inset: 1em,
          ),

          node(enclose: ((1, 1),), shape: fletcher.shapes.pill, inset: 1em),
          node(enclose: ((-1, -1), (-1, 0)), shape: fletcher.shapes.pill),
          node(enclose: ((0, -1), (0, 0)), shape: fletcher.shapes.pill),
          node(enclose: ((-1, 1), (1, 1)), shape: fletcher.shapes.pill),
        ),
        ex: todo[],
      ),
    ),
    "Aufteilung in zwei Mengen": (
      "PARTITION": (
        desc: [
          Gibt es eine Unterteilung einer Liste $S$ von ganzen Zahlen in zwei
          disjunkte Listen mit gleicher Summe?
        ],
        lang: $
          {
            S = [s_1,...,s_n] cases(
              delim: "|",
              "Es gibt eine Teilliste" T subset S ", deren Elemente die gleiche",
              "Summe haben wie die Elemente der Liste" overline(T) = S without T
            )
          }
        $,
        ex: todo[],
      ),
      "MAX-CUT": (
        desc: [
          Gegeben ein Graph $G = (V, E)$ mit einer Gewichtsfunktion
          $phi: E -> ZZ$ der Kanten und einer ganzen Zahl $w in ZZ$, gibt es
          eine Aufteilung der Knotenmenge $V = V_1 union V_2$ in zwei disjunkte
          Teilmengen, so dass das Gewicht der Kanten, die $V_1$ und $V_2$
          verbinden, mindestens $w$ ist:
          $
            phi(V_1, V_2) = sum_(v_1 in V_1, v_2 in V_2, e = {v_1,v_2} in E) phi(e) >= w?
          $
        ],
        img: {
          diagram(
            spacing: (2em, 2em),
            node((0, -1.5), $w=10$, stroke: none),

            cnode(name: <r1>, (0, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r6>, label: $1$),
            edge(<r3>, <r2>, label: tr[$3$], stroke: colors.red),
            edge(<r4>, <r2>, label: $2$),
            edge(<r5>, <r2>, label: $0$),
            edge(<r1>, <r3>, label: $0$),
            edge(<r6>, <r5>, label: tr[$7$], stroke: colors.red),
            edge(<r6>, <r1>, label: $5$),
            edge(<r4>, <r5>, label: $4$),

            node(
              enclose: (<r6>, <r3>, <r1>),
              shape: fletcher.shapes.pill,
              inset: .75em,
            ),
            node(
              enclose: (<r5>, <r4>, <r2>),
              shape: fletcher.shapes.pill,
              inset: .75em,
            ),
          )
        },
        ex: todo[],
      ),
    ),
    "Kombinatirische Optimierung": (
      desc: [
        Handelt um das finden eines Maximums oder Minimums einer Zielfunktion.
      ],
      "STEINER-TREE": (
        desc: [
          Gibt es zu einem Graphen $G = (V, E)$ mit einer Gewichtsfunktion
          $w: E -> ZZ$, einer Teilmenge $R subset V$ der Knoten und einer Zahl
          $k$ einen Teilbaum $T = (V_1, E_1) subset G$ des Graphen, der alle
          Knoten von $R$ enthält und dessen Kantengewicht
          $sum_(e in E_1) w(e) <= k$
          ist?
        ],
        img: {
          diagram(
            spacing: (2em, 2em),
            node((0, -1.5), $k=8$, stroke: none),

            cnode(name: <r1>, (0, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r2>, label: tr[$3$], stroke: colors.red),
            edge(<r4>, <r2>, label: $2$),
            edge(<r5>, <r2>, label: $0$),
            edge(<r1>, <r3>, label: tr[$0$], stroke: colors.red),
            edge(<r6>, <r5>, label: $7$),
            edge(<r6>, <r1>, label: tr[$5$], stroke: colors.red),
            edge(<r4>, <r5>, label: $4$),

            node(
              enclose: (<r6>, <r3>, <r1>, <r2>),
              shape: fletcher.shapes.pill,
              inset: .75em,
            ),
          )
        },
        ex: todo[],
      ),
      "SEQUENCING": (
        desc: [
          Die Komponenten der drei Vektoren
          $
            "Laufzeiten:" & T = && (T_1 , ... , T_p) && in ZZ^p \
             "Deadlines:" & D = && (D_1 , ... , D_p) && in ZZ^p \
               "Strafen:" & P = && (P_1 , ... , P_p) && in ZZ^p
          $
          beschreiben je einen Job. Job $i$ hat Laufzeit $T_i$, sollte zur Zeit
          $D_i$ abgeschlossen sein und kostet die Strafe $P_i$, wenn er nicht
          rechtzeitig fertig ist. Die Jobs werden sequenziell ohne unterbruch
          abgearbeitet. Ist es möglich, die Reihenfolge der Ausführung der Jobs
          so zu planen, dass die entstehenden Strafen $<= k$ sind?
        ],
      ),
    ),
    "Pfade in Graphen": (
      desc: [
        Ein hamiltonscher Pfad in einem Graphen $G = (V, E)$ ist ein Pfad, der
        jeden Knoten des Graphen genau einmal besucht. Ein solcher Pfad
        definiert eine Reihenfolge $a_1, ... , a_n$ von Knoten, so dass jede
        Kante von $a_i$ nach $a_(i+1)$ in $E$ ist. Für einen gerichteten Graphen
        sind dies die Kanten $(a_i, a_(i+1)) in E$, für einen ungerichteten
        Graphen gilt ${a_i, a_(i+1)} in E$. Ein hamiltonscher Zyklus ist ein
        geschlossener hamiltonscher Pfad.
      ],
      "HAMPATH": (
        desc: [
          Gibt es einen gerichteten hamiltonschen Pfad im gerichteten Graphen
          $G$?
        ],
        lang: $
          {
            lrc(G) cases(
              delim: "|",
              "Im gerichteten Graphen" G "gibt es",
              "einen gerichteten hamiltonischen Pfad"
            )
          }
        $,
        img: {
          diagram(
            spacing: (2em, 2em),

            cnode(name: <r1>, (0, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r6>, "-|>"),
            edge(<r3>, <r2>, "-|>", stroke: colors.red),
            edge(<r4>, <r2>, "-|>"),
            edge(<r2>, <r6>, "-|>"),
            edge(<r5>, <r2>, "<|-", stroke: colors.red),
            edge(<r1>, <r3>, "-|>", stroke: colors.red),
            edge(<r6>, <r5>, "-|>"),
            edge(<r6>, <r1>, "-|>", stroke: colors.red),
            edge(<r4>, <r5>, "<|-", stroke: colors.red),
          )
        },
      ),
      "HAMCIRCUIT": (
        desc: [Wie HAMPATH, aber zusätzlich muss der Pfad geschlossen sein],
        ex: todo[],
      ),
      "UHAMPATH": (
        desc: [Wie HAMPATH, aber ungerichtet],
        lang: $
          {
            lrc(G) cases(
              delim: "|",
              "Im Graphen" G "gibt es einen",
              "hamiltonischen Pfad"
            )
          }
        $,
      ),
      "UHAMCIRCUIT": (
        desc: [Wie UHAMPATH, aber zusätzlich muss der Pfad geschlossen sein],
        img: {
          diagram(
            spacing: (2em, 2em),

            cnode(name: <r1>, (0, -1)),
            cnode(name: <r2>, (0, 1)),
            cnode(name: <r3>, (-1, 0)),
            cnode(name: <r4>, (-1, 2)),
            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (1, 0)),

            edge(<r3>, <r6>),
            edge(<r3>, <r2>, stroke: colors.red),
            edge(<r4>, <r2>, stroke: colors.red),
            edge(<r2>, <r6>),
            edge(<r5>, <r2>),
            edge(<r1>, <r3>, stroke: colors.red),
            edge(<r6>, <r5>, stroke: colors.red),
            edge(<r6>, <r1>, stroke: colors.red),
            edge(<r4>, <r5>, stroke: colors.red),
          )
        },
      ),
    ),
    "Gerichtete Graphen": (
      desc: [
        Es handelt sich um die Eigenschaften von Zyklen in gerichteten Graphen
        $G = (V,E)$. Die Kantenmenge $E$ besteht aus gerichteten Kanten $(a, e)$
        mit $a, e in V$. Ein gerichteter Zyklus in $G$ ist eine Folge von Knoten
        $a_0, ... , a_n = a_0$, die jeweils Enden von Kanten sind, also
        $(a_i, a_(i+1)) in E, i = 0, ... , n−1$
      ],
      "FEEDBACK-NODE-SET": (
        desc: [
          Gibt es zu einem gerichteten Graphen $G$ und einer Zahl $k$ eine Menge
          $W subset V$ von $k$ Knoten derart, dass jeder geschlossene Zyklus
          durch einen dieser Knoten geht?
        ],
        img: {
          diagram(
            spacing: (2em, 2em),

            node((2, -1), $k=2$, stroke: none),

            cnode(name: <r1>, (1, 0)),
            cnode(name: <r2>, (2, 0)),
            cnode(name: <r3>, (4, 0)),

            rc(name: <r4>, (3, 1)),

            cnode(name: <r5>, (1, 2)),
            rc(name: <r6>, (2, 2)),
            cnode(name: <r7>, (4, 2)),

            node(
              enclose: (<r1>, <r2>, <r5>, <r6>),
              shape: fletcher.shapes.pill,
              inset: 1.5em,
              stroke: colors.darkblue,
            ),
            node(
              enclose: (<r3>, <r4>, <r7>),
              shape: fletcher.shapes.pill,
              inset: 1em,
              stroke: colors.purple,
            ),
            node(
              enclose: (<r1>, <r2>, <r5>, <r6>, <r3>, <r4>, <r7>),
              shape: fletcher.shapes.pill,
              inset: 2em,
              stroke: colors.green,
            ),

            edge(<r1>, <r2>, "-|>", stroke: colors.darkblue),
            edge(<r2>, <r4>, "-|>", stroke: colors.green),
            edge(<r3>, <r7>, "-|>", stroke: colors.purple),
            edge(<r4>, <r3>, "-|>", stroke: colors.purple),
            edge(<r5>, <r1>, "-|>", stroke: colors.darkblue),
            edge(<r6>, <r5>, "-|>", stroke: colors.darkblue),
            edge(<r7>, <r4>, "-|>", stroke: colors.purple),
            edge(<r4>, <r6>, "-|>", stroke: colors.green),
            edge(<r2>, <r6>, "-|>", stroke: colors.darkblue),
          )
        },
        ex: todo[],
      ),
      "FEEDBACK-ARC-SET": (
        desc: [
          Gibt es zu einem gerichteten Graphen $G$ und einer Zahl $k$ eine Menge
          $F subset E$ von $k$ Kanten derart, dass jeder geschlossene Zyklus
          eine dieser Kanten enthält?
        ],
        img: {
          diagram(
            spacing: (2em, 2em),

            node((2, -1), $k=2$, stroke: none),

            cnode(name: <r1>, (1, 0)),
            cnode(name: <r2>, (2, 0)),
            cnode(name: <r3>, (4, 0)),

            cnode(name: <r4>, (3, 1)),

            cnode(name: <r5>, (1, 2)),
            cnode(name: <r6>, (2, 2)),
            cnode(name: <r7>, (4, 2)),

            node(
              enclose: (<r1>, <r2>, <r5>, <r6>),
              shape: fletcher.shapes.pill,
              inset: 1.5em,
              stroke: colors.darkblue,
            ),
            node(
              enclose: (<r3>, <r4>, <r7>),
              shape: fletcher.shapes.pill,
              inset: 1em,
              stroke: colors.purple,
            ),
            node(
              enclose: (<r1>, <r2>, <r5>, <r6>, <r3>, <r4>, <r7>),
              shape: fletcher.shapes.pill,
              inset: 2em,
              stroke: colors.green,
            ),

            edge(<r1>, <r2>, "-|>", stroke: colors.darkblue),
            edge(<r2>, <r4>, "-|>", stroke: colors.green),
            edge(<r3>, <r7>, "-|>", stroke: colors.purple),
            edge(<r4>, <r3>, "-|>", stroke: colors.red + 1.5pt),
            edge(<r5>, <r1>, "-|>", stroke: colors.darkblue),
            edge(<r6>, <r5>, "-|>", stroke: colors.red + 1.5pt),
            edge(<r7>, <r4>, "-|>", stroke: colors.purple),
            edge(<r4>, <r6>, "-|>", stroke: colors.green),
            edge(<r2>, <r6>, "-|>", stroke: colors.darkblue),
          )
        },
        ex: todo[],
      ),
    ),
    "Logik": (
      "SAT": (
        desc: [
          Gegeben einer aussagenlogischen Formel, gibt es eine Zusammensetzung
          der Variablenwerte, die die Aussage "Wahr" werden lassen?
        ],
        lang: $ {phi | phi "ist eine erfüllbare logische Formel"} $,
        ex: todo[
          Elektriker
          $ T =^? (x_1 or x_2 or x_3 or x_4) and (x_5 or x_6) $
        ],
      ),
      "3SAT": (
        desc: [
          Wie SAT, nur hat jede Klausel der Normalform maximal 3 Literale.
        ],
        ex: $
          T =^? (x_1 or x_2 or z_1) and (overline(z_1) or x_3 or x_4) and (x_5
            or x_6 or x_6)
        $,
      ),
    ),
    "Weitere": (
      "SUBSET-SUM": (
        desc: [
          Gegeben einer Liste $S$ von natürlichen Zahlen $s_i in NN$ und einer
          natürlichen Zahl $t in NN$ (Rucksack), ist es möglich eine teilliste
          $T subset S$ auszuwählen, sodass die Elemente von $T$ dies Summe
          $t = sum_(s in T) s$ haben?
        ],
        ex: todo[
          Rucksack-Problem
        ],
      ),
      "3D-MATCHING": (
        desc: [
          Gegeben sind drei endliche Mengen $X$, $Y$ und $Z$ mit gleich vielen
          $n = abs(X) = abs(Y) = abs(Z)$ Elementen und $T subset X times Y
          times Z$. Gibt es eine $n$-elementige Teilmenge $M subset T$ derart,
          dass keine zwei Tripel von $M$ in einer Koordinate übereinstimmen?
        ],
        img: {
          let edge = edge.with(stroke: colors.comment + .75em)
          diagram(
            spacing: (2em, 2em),

            node(height: 1em, (0, -1), tr[$X$], stroke: none),
            node(height: 1em, (1, -1), tg[$Y$], stroke: none),
            node(height: 1em, (2, -1), td[$Z$], stroke: none),

            rc(name: <r1>, (0, 0)),
            rc(name: <r2>, (0, 1)),
            rc(name: <r3>, (0, 2)),

            gc(name: <r4>, (1, 0)),
            gc(name: <r5>, (1, 1)),
            gc(name: <r6>, (1, 2)),

            dc(name: <r7>, (2, 0)),
            dc(name: <r8>, (2, 1)),
            dc(name: <r9>, (2, 2)),

            node(
              enclose: (<r1>, <r2>, <r3>),
              shape: fletcher.shapes.pill,
              stroke: colors.red,
            ),
            node(
              enclose: (<r4>, <r5>, <r6>),
              shape: fletcher.shapes.pill,
              stroke: colors.green,
            ),
            node(
              enclose: (<r7>, <r8>, <r9>),
              shape: fletcher.shapes.pill,
              stroke: colors.darkblue,
            ),

            edge(<r1>, <r5>),
            edge(<r5>, <r7>),

            edge(<r2>, <r6>),
            edge(<r6>, <r9>),

            edge(<r3>, <r4>),
            edge(<r4>, <r8>),
          )
        },
        ex: todo[],
      ),
      "BIP": (
        desc: "Binary Integer Programming",
        lang: $
          {lrc(C, d) cases(
              delim: "|", "Zu" C in M_(n times m) (ZZ) "und" d in ZZ^n "gibt es einen",
              "binären Vektor" x in {0,1}^m "derart, dass" C x = d
            )} \
        $,
      ),
    ),
  ),

  prodautbig: block(breakable: false, [
    $
      L = #block(inset: 5pt, fill: colors.darkblue.transparentize(80%), ${w in Sigma^* mid(|) abs(w)_1 "ungerade"}$) inter #block(inset: 5pt, fill: colors.red.transparentize(80%), ${w in Sigma^* mid(|) w "ist eine durch drei teilbare Binärzahl"}$)
    $
    #align(center, prod-aut(1))
  ]),

  prodautsets: (
    (
      [Schnittmenge $L(A_1) inter L(A_2)$],
      [#poly
        #place-off(polygon(
          stroke: colors.fg + 2pt,
          (x4, y1),
          (x4, y2),
          (x3, y2),
          (x3, y1),
        ))
        #prod-aut(.5, e: ("q10",))
      ],
    ),
    (
      [Vereinigungsmenge $L(A_1) union L(A_2)$],
      [#poly
        #place-off(polygon(
          stroke: colors.fg + 2pt,
          (x3, y1),
          (x3, y4),
          (x4, y4),
          (x4, y2),
          (x2, y2),
          (x2, y1),
        ))
        #prod-aut(.5, e: ("q00", "q10", "q11", "q12"))
      ],
    ),

    (
      [Differenzmenge $L(A_1) without L(A_2)$],
      [
        #place-off(polygon(
          fill: colors.fg.transparentize(75%),
          (x1, y4),
          (x1, y5),
          (x4, y5),
          (x4, y2),
          (x3, y2),
          (x3, y5),
          (x2, y5),
          (x2, y4),
          (x3, y4),
          (x3, y3),
          (x4, y3),
          (x4, y4),
        ))

        #place-off(polygon(
          stroke: colors.fg + 2pt,
          (x4, y4),
          (x4, y5),
          (x3, y5),
          (x3, y4),
        ))
        #prod-aut(.5, e: ("q00",))
      ],
    ),
    (
      [Symmetrische Differenz $L(A_1) triangle L(A_2)$],
      [
        #poly
        #place-off(polygon(
          stroke: colors.fg + 2pt,
          (x4, y4),
          (x4, y5),
          (x3, y5),
          (x3, y4),
        ))
        #place-off(polygon(
          stroke: colors.fg + 2pt,
          (x5, y1),
          (x5, y2),
          (x2, y2),
          (x2, y1),
        ))
        #prod-aut(.5, e: ("q00", "q11", "q12"))
      ],
    ),
  ),
)
