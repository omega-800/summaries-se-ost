#import "/lib.typ": *

#let cnode = node.with(
  shape: fletcher.shapes.circle,
  width: .5em,
  height: .5em,
)
#let rc = cnode.with(stroke: colors.red, fill: colors-l.red)
#let dc = cnode.with(stroke: colors.darkblue, fill: colors-l.darkblue)
#let pc = cnode.with(stroke: colors.purple, fill: colors-l.purple)
#let gc = cnode.with(stroke: colors.green, fill: colors-l.green)

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
          node((0, -1.5), $k=5$, stroke: none),

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
          node((0, -1.5), $k=3$, stroke: none),

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

            cnode(name: <r1>, (0, 0)),
            cnode(name: <r2>, (2, 0)),
            cnode(name: <r3>, (4, 0)),

            rc(name: <r4>, (3, 1)),

            cnode(name: <r5>, (0, 2)),
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

            cnode(name: <r1>, (0, 0)),
            cnode(name: <r2>, (2, 0)),
            cnode(name: <r3>, (4, 0)),

            cnode(name: <r4>, (3, 1)),

            cnode(name: <r5>, (0, 2)),
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
    "Weitere": (
      "SAT": (
        desc: [Gegeben einer aussagenlogischen Formel, gibt es eine
          Zusammensetzung der Variablenwerte, die die Aussage "Wahr" werden
          lassen?],
        lang: $ {phi | phi "ist eine erfüllbare logische Formel"} $,
      ),
      "3SAT": (
        desc: [Wie SAT, nur hat jede Klausel der Normalform maximal 3
          Literale.],
      ),
      "SUBSET-SUM": (
        desc: [
          Gegeben einer Liste $S$ von natürlichen Zahlen $s_i in NN$ und einer
          natürlichen Zahl $t in NN$ (Rucksack), ist es möglich eine teilliste
          $T subset S$ auszuwählen, sodass die Elemente von $T$ dies Summe
          $t = sum_(s in T) s$ haben?
        ],
      ),
      "3D-MATCHING": (
        desc: [
          Gegeben sind drei endliche Mengen $X$, $Y$ und $Z$ mit gleich vielen
          $n = abs(X) = abs(Y) = abs(Z)$ Elementen und $T subset X times Y
          times Z$. Gibt es eine $n$-elementige Teilmenge $M subset T$ derart,
          dass keine zwei Tripel von $M$ in einer Koordinate übereinstimmen?
        ],
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
)
