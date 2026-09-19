#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Suchbäume

/ Multimaps: Ungeordnet, ```java find(k), findAll(k), insert(k,o), remove(e)```
/ Geordnete Multimaps: Geordnet,
  ```java first(), last(), successors(k), predecessors(k)```
/ Binäre Suche: Bei einer Multimap, realisiert als array-basierte Sequenz,
  sortiert nach Key, bei ```java find(k)```: bei jedem Schritt wird die Anzahl
  der Kandidaten halbiert, terminiert nach $O(log n)$ Schritten
/ Suchtabelle: Multimap, welche mithilfe einer sortierten Sequenz implementiert
  wird.
  - `find`: $O(log n)$
  - `insert`: $O(n)$
  - `remove`: $O(n)$

== Binärer Suchbaum

#let (bx, bnode, rbn, gbn, obn, pbn, bbn, A, B, C, D, E) = bn-abbrevs

#grid(
  columns: 2,
  [
    Ein binärer Baum, welcher Keys (oder Key- Value-Entries) in seinen internen
    Knoten speichert und folgende Bedingungen erfüllt: \
    Gegeben sind die drei Knoten $u$, $v$, und $w$. $u$ ist im linken Teilbaum
    von $v$ und $w$ ist im rechten Teilbaum von $v$. So gilt:
    $"key"(u) <= "key"(v) <= "key"(w)$
  ],
  diagram(
    node-shape: fletcher.shapes.circle,
    bnode((1, 0), $v$),
    edge((1, 0), (0, 1)),
    edge((1, 0), (2, 1)),
    bnode((0, 1), $u$),
    bnode((2, 1), $w$),
  ),
)

=== Traversierung

#shared.bsttraversal

=== Suche

#grid(
  columns: (1fr, auto),
  ```java
  V search(K k, Node<V> n) {
    if (n.isExternal)
      return null;
    else if (k < n.key)
      return search(k, n.left);
    else if (k > n.key)
      return search(k, n.right);
    else
      return n.value;
  }
  ```,
  [
    ```java search(4)```

    #diagram(
      spacing: (0pt, 1em),
      bbn((0, 3), [ ]),
      edge(),
      bnode((1, 2), [1]),
      edge(),
      bbn((2, 3), [ ]),
      bnode((3, 1), [2]),
      bbn((4, 3), [ ]),
      edge(),
      rbn((5, 2), [4]),
      edge(),
      bbn((6, 3), [ ]),
      bnode((7, 0), [6]),
      bbn((8, 3), [ ]),
      edge(),
      bnode((9, 2), [8]),
      edge(),
      bbn((10, 3), [ ]),
      bnode((11, 1), [9]),
      bnode((12, 2), [ ], stroke: none),
      bbn((13, 2), [ ]),
      edge((3, 1), (1, 2)),
      edge((3, 1), (5, 2), stroke: colors.red, $tr(>)$),
      edge((7, 0), (3, 1), stroke: colors.red, $tr(<)$),
      edge((7, 0), (11, 1)),
      edge((11, 1), (9, 2)),
      edge((11, 1), (13, 2)),
    )],
)

#block(breakable: false)[
  === Einfügen

  #grid(
    columns: (1fr, auto),
    [
      Annahme: der Baum ist eine Multimap und $k$ ist schon im Baum vorhanden:
      Im jeweils linken Teilbaum von $k$ wird weitergesucht bis man auf ein
      Blattknoten $w$ stösst
    ],
    [
      ```java insert(2)```

      #diagram(
        spacing: (0pt, 1em),
        bbn((0, 3), [ ]),
        edge(),
        bnode((1, 2), [1]),
        edge((2, 3), stroke: colors.red, $tr(>)$),
        bbn((1.25, 4), [ ]),
        edge(),
        rbn((2, 3), [2]),
        edge(),
        bbn((2.75, 4), [ ]),
        bnode((3, 1), [2]),
        bbn((4, 3), [ ]),
        edge(),
        bnode((5, 2), [4]),
        edge(),
        bbn((6, 3), [ ]),
        bnode((7, 0), [6]),
        bbn((8, 3), [ ]),
        edge(),
        bnode((9, 2), [8]),
        edge(),
        bbn((10, 3), [ ]),
        bnode((11, 1), [9]),
        bnode((12, 2), [ ], stroke: none),
        bbn((13, 2), [ ]),
        edge((3, 1), (1, 2), stroke: colors.red, $tr(=)$),
        edge((3, 1), (5, 2)),
        edge((7, 0), (3, 1), stroke: colors.red, $tr(<)$),
        edge((7, 0), (11, 1)),
        edge((11, 1), (9, 2)),
        edge((11, 1), (13, 2)),
      )],
  )
]

=== Löschen

#grid(
  columns: (1fr, auto),
  [
    - finde den internen Knoten $w$, welcher $v$ in der Inorder-Traversierung
      folgt
    - kopiere $"key"(w)$ in den Knoten $v$
    - lösche den Knoten $w$ und sein linkes Kind z (welches ein Blatt sein muss)
  ],
  [
    ```java delete(6)```

    #diagram(
      spacing: (0pt, 1em),
      bbn((0, 3), [ ]),
      edge(),
      bnode((1, 2), [1]),
      edge(),
      bbn((2, 3), [ ]),
      bnode((3, 1), [2]),
      bnode((4, 3), [ ], stroke: none),
      bnode((5, 2), [ ], stroke: none),
      bnode((6, 3), [ ], stroke: none),
      rbn((7, 0), [4]),
      bbn((8, 3), [ ]),
      edge(),
      bnode((9, 2), [8]),
      edge(),
      bbn((10, 3), [ ]),
      bnode((11, 1), [9]),
      bnode((12, 2), [ ], stroke: none),
      bbn((13, 2), [ ]),
      edge((3, 1), (1, 2)),
      edge((7, 0), (3, 1)),
      edge((7, 0), (11, 1)),
      edge((11, 1), (9, 2)),
      edge((11, 1), (13, 2)),
    )],
)

=== Performance

Betrachte eine Map mit $n$ Entries, welcher mit einem binären Suchbaum
implementiert ist mit der Höhe $h$
- nötiger Speicher ist $O(n)$
- Methoden `find`, `insert` und `remove` benötigen $O(h)$
- Die Höhe $h$ ist $O(n)$ im schlechtesten Fall und $O(log n)$ im besten Fall

=== Arithmetische Progression

Der Worst-Case tritt z.B. ein, wenn man aufsteigend sortierte Werte in einen
binäreren Such-Baum einfügt. Laut der _Gaussschen Summenformel_ $(n(n+1))/2$ ist
die Worst-Case Laufzeit somit $O(n^2)$.

#todo[implementation?]

= Sorting

= Text Processing

= Graphs
