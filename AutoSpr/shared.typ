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

#let Q = tr($Q$)
#let S = td($Sigma$)
#let d = tg($delta$)
#let q = $q_0$
#let F = tp($F$)
#let aut = (
  "q0": ("q1": 1, "q2": 0),
  "q1": ("q1": 1, "q0": 0),
  "q2": ("q2": 1, "q1": 0),
)

#let a = tr[$a$]
#let b = td[$b$]
#let L = tg[$L$]
#let R = tg[$R$]
#let p = ty[$p$]
#let q = ty[$q$]

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
        k: 4,
        img: {
          diagram(
            spacing: (2em, 2em),
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
        ex: (
          [
            Stundenplan: Planung der Fächer $f in F$ auf $k$ Zeitfenster, damit
            keine Anmeldungen ${f_1,f_2} in A$ in gleichen Zeitfenstern liegen
          ],
          [
            *Knoten $V$ =* Fach, *Kanten $E$ =* Anmeldungen, *Farben =*
            Zeitfenster
          ],
        ),
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
        k: 3,
        img: {
          diagram(
            spacing: (2em, 2em),
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
        k: 2,
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
        ex: (
          [
            Bilden von $k$ Gruppen von Leuten, die sich kennen. Alle Leute
            sollen eingeteilt sein.
          ],
          [
            *Knoten $V$ =* Teilnehmer, *Kanten $E$ =* Kennen sich, *$k$ =*
            Anzahl Gruppen, *Clique $G_k$ =* Gruppe
          ],
        ),
      ),
      "K-CLIQUE": (
        desc: [
          Wie CLIQUE-COVER, nur ist $k$ bekannt.
        ],
        k: 0,
        ex: (
          [Job-Parallelisierbarkeit: Menge von $n$ Jobs, die jeweils exklusiv
            auf $m$ Ressourcen zugreifen, Jobs dürfen nicht gleichzeitig laufen.
            Ziel: Entscheiden, ob zu irgendeinem Zeitpunkt mehr als $k$
            Prozessoren ausgelastet werden können],
          [
            *Graph $G$ =* Job-Parallelisierbarkeit, *Knoten $V$ =* $n$ Job,
            *Kanten $E$ =* $m$ gleiche Ressourcen, *$k$-Clique $G_k$ = * Auswahl
            Knoten ohne Verbindung, *$k$ =* Auslastbare Anzahl Prozessoren
          ],
        ),
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
        k: 2,
        img: diagram(
          spacing: (2em, 2em),

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
        ex: (
          [
            Kontrolle des Verkehrsnetzes: Mitarbeiter haben ihre Basis an
            einzelnen Knotenpunkten. Ziel: An welchen Stationen muss man
            Kontrolleure stationieren, damit jede Strecke bei einem Kontrolleur
            endet?
          ],
          [
            *Knoten $V$ =* Stationen, *Kanten $E$ =* Strecke, *$k$ =* Anzahl
            Kontrolleure, *$W subset V$ =* Knoten mit Kontrolleur
          ],
        ),
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
        k: 5,
        img: diagram(
          spacing: (2em, 2em),

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
        ex: (
          [Medizinische Studie: 17 Allergene wählen, sodass jeder Proband
            maximal auf eines davon reagiert.],
          [
            *$I =$* Allergene, *$S_i =$* auf Allegien $i$ allergische Probanden,
            *$J =$* Ausgewählte Allergene, *$S_i inter S_j = emptyset ->$*
            Ausschlussbedingung zwischen Allergenen
          ],
        ),
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
        k: 3,
        img: diagram(
          spacing: (2em, 2em),

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
        ex: (
          [
            Ein Tourist möchte mit dem Besuch von nur $k$ Aussichtspunkten alles
            sehen, was man an Sehenswürdigkeiten von allen Aussichtspunkten aus
            sehen könnte.
          ],
          [
            *$U$ =* Alle Sehenswürdigkeiten, *$i in I$ =* Aussichtspunkt $i$,
            *$S_i$ =* Sichtbare Sehenswürdigkeiten von $i$ aus, *$J subset I$ =*
            Ausgewählte Aussichtspunkte, *$union.big_(j in J) S_j
            = U$ =
            * Bedingung, alles sehen zu können
          ],
        ),
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
        ex: (
          [
            Es stehen binäre Eigenschaften von Kunden zur Verfügung, z.B. ob sie
            ein bestimmtes Produkt gekauft haben oder volljährig sind. Ziel:
            Eine Teilmenge von Kriterien finden, dass jeder Kunde genau eine der
            Eigenschaften hat.
          ],
          [
            *$I$ =* Eigenschaften, *$(S_i)_(i in I)$ =* Kunden, auf die die
            Eigenschaft zutrifft , *$J subset I$ =* Teilmenge
          ],
        ),
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
        ex: (
          [
            Finden eines Einzelnen Vertreters für Gruppen von Menschen.
          ],
          [
            *$i in I =$* Gruppierungskriterien, *$S_i =$* Menschen in Gruppe
            $i$, *$W subset union.big_(i in l) S_i =$* Teilmenge von Vertretern,
            *$abs(
              W inter
              S_i
            ) = 1 forall i ->$* $H$ hat mit jeder der Mengen $S_i$ genau einen
            Vertreter gemeinsam
          ],
        ),
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
              "Es gibt eine Teilliste" T subset S ", deren ",
              "Elemente die gleiche Summe haben ",
              "wie die Elemente der Liste" overline(T) = S without T
            )
          }
        $,
        img: $\[underbrace(
          1\,2\,4\,5, T\ ->\
          12
        ),underbrace(6\,8, overline(T)\ ->\ 12)\]$,
        ex: (
          [
            Unterteilung der Prominenten + Entourage auf zwei Säle des
            Film-Festivals.
          ],
          [
            *$i in I =$* Promi, *$c_i =$* Anz. Mitglieder seiner Entourage, *$A
            =$* Stars samt Entourage für Saal A, *$B =$* für Saal B,
            *$I= A union B, sum_(i in A) c_i = sum_(i in B) c_i$*
          ],
        ),
      ),
      "MAX-CUT": (
        desc: [
          Gegeben ein Graph $G = (V, E)$ mit einer Gewichtsfunktion
          $phi: E -> ZZ$ der Kanten und einer ganzen Zahl $k in ZZ$, gibt es
          eine Aufteilung der Knotenmenge $V = V_1 union V_2$ in zwei disjunkte
          Teilmengen, so dass das Gewicht der Kanten, die $V_1$ und $V_2$
          verbinden, mindestens $w$ ist:
          $
            phi(V_1, V_2) = sum_(v_1 in V_1, v_2 in V_2, e = {v_1,v_2} in E) phi(e) >= k?
          $
        ],
        k: 10,
        img: {
          diagram(
            spacing: (2em, 2em),
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
        ex: (
          [
            Feindliche Übernahme einer Firma, mit resultierender Aufteilung der
            Abteilung, sodass diese möglichst ineffizient miteinander
            kommunizieren können.
          ],
          [
            *$V$ =* Abteilung, *$E$ =* Kommunikationsbeziehung, *$phi$ =*
            Kommunikationsvolumen
          ],
        ),
      ),
    ),
    "Kombinatirische Optimierung": (
      desc: [
        Handelt um das finden eines Maximums oder Minimums einer Zielfunktion.
      ],
      "STEINER-TREE": (
        desc: [
          Gibt es zu einem Graphen $G = (V, E)$ mit einer Gewichtsfunktion
          $phi: E -> ZZ$, einer Teilmenge $R subset V$ der Knoten und einer Zahl
          $k$ einen Teilbaum $T = (V_1, E_1) subset G$ des Graphen, der alle
          Knoten von $R$ enthält und dessen Kantengewicht
          $sum_(e in E_1) phi(e) <= k$
          ist?
        ],
        k: 8,
        img: {
          diagram(
            spacing: (2em, 2em),
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
        ex: (
          [Stromnetzausbau zwischen Ortschaften gegeben eines Budgets.],
          [
            *STEINER-TREE =* Stromnetz, *Knoten $V$ =* Ortschaften, *Knoten
            $R subset V$ =* zu erschliessende Ortschaften, *Gewicht $phi$ =*
            Baukosten einer Verbindung, *Max. Gewicht $k$ =* Budget
          ],
        ),
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
        k: 0,
        ex: (
          [
            Eine Firma hat eine bestimmte Anzahl laufende Verträge. Es ist nicht
            möglich, alle Verträge in einer bestimmten Zeit abzuarbeiten. Sie
            versucht also möglichst viele Verträge in der verbleibenden Zeit
            abzuarbeiten, die eine hohe Entlöhnung haben.
          ],
          [
            *$T$ =* Zeitaufwände für Vertragserfüllung, *$P$ =* Entlöhnung der
            Verträge, *$D$ =* Deadlines der Verträge
          ],
        ),
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
        ex: (
          [Ganze Schweiz bereisen, ohne eine Stadt mehrmals zu besuchen],
          [
            *$G$ = * Liniennetz, *$V$ =* Stadt, *$E$ =* ÖV-Verbindung,
            *Hamiltonscher Pfad =* Reise
          ],
        ),
      ),
      "HAMCIRCUIT": (
        desc: [Wie HAMPATH, aber zusätzlich muss der Pfad geschlossen sein],
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
        k: 2,
        img: {
          diagram(
            spacing: (2em, 2em),

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
        ex: (
          [
            Es gibt mehrere Buslinien. Wo muss das Putzpersonal platziert
            werden, damit alle Linien geputzt werden können? Man möchte
            möglichst wenig Personal einsetzen.
          ],
          [
            *$V$ =* Stationen, *$W subset V$ =* Stationen, von denen aus alle
            Linien erreicht werden
          ],
        ),
      ),
      "FEEDBACK-ARC-SET": (
        desc: [
          Gibt es zu einem gerichteten Graphen $G$ und einer Zahl $k$ eine Menge
          $F subset E$ von $k$ Kanten derart, dass jeder geschlossene Zyklus
          eine dieser Kanten enthält?
        ],
        k: 2,
        img: {
          diagram(
            spacing: (2em, 2em),

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
      ),
    ),
    "Logik": (
      "SAT": (
        desc: [
          Gegeben einer aussagenlogischen Formel, gibt es eine Zusammensetzung
          der Variablenwerte, die die Aussage "Wahr" werden lassen?
        ],
        lang: $ {phi | phi "ist eine erfüllbare logische Formel"} $,
        ex: (
          [
            Elektriker: Konfiguration der Schalter zweier Stromkreise, die in
            allen Räumen Licht brennen lassen sollten
          ],
          [
            *$x_i =$* Schalter, *$T or F =$* Stromkreise (werte der Variable
            $x_i$, Lampen des ersten Kreises leuchten, wenn $x_i = T$),
            *$x_i_1 or ... or x_i_(k)
            =$* ob Licht im Raum der mit $x_i$ verbundenen Schalter brennt
          ],
        ),
      ),
      "3SAT": (
        desc: [
          Wie SAT, nur hat jede Klausel der Normalform maximal 3 Literale.
        ],
        ex: (
          [SAT $->$ 3SAT],
          $
               & (x_1 or x_2 or x_3 or x_4) and (x_5 or x_6) \
            -> & (x_1 or x_2 or z_1) and (overline(z_1) or x_3 or x_4) and (x_5
                   or x_6 or x_6)
          $,
        ),
      ),
    ),
    "Weitere": (
      "SUBSET-SUM": (
        desc: [
          Gegeben einer Liste $S$ von natürlichen Zahlen $s_i in NN$ und einer
          natürlichen Zahl $t in NN$, ist es möglich eine teilliste $T subset S$
          auszuwählen, sodass die Elemente von $T$ dies Summe
          $t = sum_(s in T) s$ haben?
        ],
        ex: (
          [
            Rucksack-Problem (Ziel: Rucksack füllen)
          ],
          [
            *$S =$* Grössen der Gegenstände, *$t =$* Max. Platz im Rucksack,
            *$T subset S =$* Grössen der Gegenstände, die in den Rucksack passen
          ],
        ),
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
        ex: (
          [Ein Koch hat $n$ Rezepte für Vorspeisen, Hauptspeisen und Desserts.
            Nicht alle Vorspeisen lassen sich mit jeder Hauptspeise kombinieren,
            dasselbe gilt auch für Desserts. Er möchte $n$ Menus
            zusammenstellen, sodass jedes Rezept in genau einem der Menus
            vorkommt.
          ],
          [
            *$X$ =* Vorspeisen, *$Y$ =* Hauptspeisen, *$Z$ =* Desserts,
            *$T subset X times Y times Z$ =* Menge aller Menus, *$M subset T$ =*
            Menge der zusammengestellter Menus
          ],
        ),
      ),
      "BIP": (
        desc: [
          BIP = Binary Integer Programming

          Zu einer ganzzahligen Matrix $C$ und einem ganzzahligen Vektor $d$,
          ist ein binärer Vektor $x$ zu finden mit $C dot x = d$
        ],
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
  setsets: (
    ("intersection", $inter$),
    ("union", $union$),
    ("difference", $without$),
    ("xor", $triangle$),
  ).map(((op, m)) => canvas(length: 4em, {
    import cetz.draw: *
    circle((0, 0), name: "a")
    circle((1, 0), name: "b")
    boolean("a", "b", op: op, fill: colors.darkblue)
    content((0.5, 1.5), $A_1 #m A_2$)
    circle((0, 0))
    circle((1, 0))
  })),
  dea: (
    def: [
      $ A = (#Q, #S, #d, #q, #F) $
      - Zustände: $#Q = {q_0, q_1, ... , q_n}$
      - Alphabet: #S
      - Übergangsfunktion: $#d : Q times Sigma -> Q$
      - Startzustand: $#q in Q$
      - Akzeptierzustände: $#F subset Q$
    ],
    aut: context [
      #let lt = if is-cs.get() {
        (q0: (0, 0), q1: (2, 0), q2: (1, -1))
      } else {
        (q0: (0, 0), q1: (3, 0), q2: (1.5, -1.5))
      }
      #automaton(
        aut,
        final: ("q1", "q2"),
        layout: lt,

        style: (
          q1-q1: (anchor: right),
          q2-q2: (anchor: bottom),
          transition: (
            stroke: colors.green,
            label: (fill: colors.blue),
          ),
          state: (
            stroke: colors.red,
            initial: (stroke: colors.fg),
          ),
          q2: (stroke: colors.purple),
          q1: (stroke: colors.purple),
        ),
      )],
    tbl: [
      #let gcb = grid.cell.with(fill: colors-l.blue)
      #let gcr = grid.cell.with(fill: colors-l.red)
      #let gcg = grid.cell.with(fill: colors-l.green)
      #grid(
        gutter: 0pt,
        stroke: (x, y) => if x == 2 and y == 1 {
          (left: colors.fg, top: colors.fg)
        } else if x == 2 { (left: colors.fg) } else if y == 1
          and x > 0
          and x < 4 { (top: colors.fg) },
        columns: (1fr, 1fr, 1fr, 1fr, 1fr),
        inset: 0.5em,
        [], [], gcb($0$), gcb($1$), S,
        Q, gcr($q_0$), gcg($q_2$), gcg($q_1$), [],
        F, gcr[*$tp(q_1)$*], gcg($q_0$), gcg($q_1$), d,
        [], gcr[*$tp(q_2)$*], gcg($q_1$), gcg($q_2$),
      )],
  ),
  pl: [
    + Annahme: $L$ ist regulär
    + Gemäss Pumping Lemma gibt es die Pumping Length $N$
      - Es darf keine Annahme über die konkrete Grösse von $N$ gemacht werden!
    + Wähle ein Wort $w in L$ mit $abs(w) >= N$
      - Die Definition *muss* $N$ verwenden!
    + Aufteilung des Wortes gemäss Pumping Lemma
      - $w = #tg($x$)#tr($y$)#td($z$), abs(#tg($x$)#tr($y$)) <= N, abs(#tr($y$)) > 0$
    + Auswirkung des Pumpens
      - $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für mindestens ein $k in NN$ (mit
        Begründung!)
    + Widerspruch und Schlussfolgerung, dass die Annahme nicht zutreffen kann
  ],
  nea: [
    $ A = (#Q, #S, #d, #q, #F) $
    - Endliche Menge von Zuständen: $#Q$
    - Alphabet: #S
    - Übergangsfunktion: $#d : Q times Sigma -> #ty($P(#Q)$)$
    - Startzustand: $#q in Q$
    - Akzeptierzustände: $#F subset Q$
  ],
  cfg: [
    $ G = (V, Sigma, R, S) $

    - $V$: Variablen
    - $Sigma$: Terminalsymbole (Alphabet)
    - $R$: Regeln der Form $A -> x_1 x_2 ... x_n$ mit
      $A in V, x_i in V union Sigma$
    - $S$: Startvariable
  ],
  pda: (
    def: [
      $ P = (Q, Sigma, Gamma, delta, q_0, F) $

      + $Q$: Zustände
      + $Sigma$: Eingabe-Alphabet
      + $Gamma$: Stack-Alphabet
      + $delta$:
        $Q times Sigma_epsilon times Gamma_epsilon -> P(Q times Gamma_epsilon)$
      + $q_0 in Q$: Startzustand
      + $F subset Q$: Akzeptierzustände
    ],
    diag: [

      #diagram(
        node((0, 0), $p$, shape: fletcher.shapes.circle),
        edge(label: $#tr($a$), #tg($b$) -> #td($c$)$, label-side: left, "-|>"),
        node((6, 0), $q$, shape: fletcher.shapes.circle),
      )

      #tr($a$) vom Input

      #tg($b$) vom Stack entfernen (Bedingung)

      #td($c$) auf den Stack
    ],
  ),
  tm: (
    def: [
      (deterministische) Turing-Maschine\ $M = (Q, Sigma, Gamma, delta, q_0,
        q_"accept", q_"reject")$

      - $Q$: #ty[Zustände]
      - $Sigma$: Alphabet
      - $Gamma$: Bandalphabet, $bracket.b in Gamma without Sigma$
      - $delta$: $Q times Gamma -> Q times Gamma times {#L,#R}$
      - $q_0 in Q$: Startzustand
      - $q_"accept" in Q$: Akzeptierzustand
      - $q_"reject" in Q$: Ablehnzustand, $q_"accept" != q_"reject"$
    ],
    diag: align(horizon, stack(
      spacing: .5em,
      dir: ltr,
      $delta(#p, #a) = (#q, #b, #L):$,
      automaton(
        (
          p: (q: "a"),
          q: (),
        ),
        final: (),
        initial: (),
        style: (
          p: (stroke: colors.yellow),
          q: (stroke: colors.yellow),
          p-q: (label: $#a -> #b, #L$),
        ),
        layout: (
          p: (0, 0),
          q: (3, 0),
        ),
      ),
    )),
    trans: [
      - Übergang möglich, wenn #a unter dem Schreib- / Lese-Kopf
      - Aktuelles Feld auf dem Band wird mit #b überschrieben
      - Kopfbewegung: #L links, #R rechts
    ],
  ),
)
