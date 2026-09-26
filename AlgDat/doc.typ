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

#let (
  bx,
  bnode,
  rb,
  gb,
  ob,
  pb,
  bb,
  rbn,
  gbn,
  obn,
  pbn,
  bbn,
  A,
  B,
  C,
  D,
  E,
) = bn-abbrevs

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
    - finde den internen Knoten $w$ (4), welchem $v$ (6) in der
      Inorder-Traversierung folgt
    - kopiere $"key"(w)$ in den Knoten $v$
    - lösche den Knoten $w$ und sein rechtes Kind $z$ (welches ein Blatt sein
      muss)
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
      edge(),
      bbn((5, 2), [ ]),
      bnode((6, 2), [#math.arrow.t 4], stroke: none),
      bnode((4, 3), [ ], stroke: none),
      rbn((7, 0), [4]),
      bnode((8, 0), [$tr(cancel(6))$], stroke: none),
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

== AVL Baum

Ein AVL Baum ist ein binärer Such-Baum, bei dem für jeden internen Knoten $v$
von $T$ gilt: die Höhe der Kinder von $v$ unterscheiden sich höchstens um $1$.
AVL Bäume sind balanciert.

Die Höhe eines AVL Baumes $T$, der $n$ Keys speichert, ist $O(log(n))$. Die
*minimale* Anzahl Knoten können wir als Funktion der Höhe $h$ definieren:
$
  n(1) = & 1 \
  n(2) = & 2 \
  n(h) = & 1 + n(h-1) + n(h-2) \
$
Dabei gilt
$
     n(h-1) > & n(h-2) \
       n(h) > & 2n(h-2) \
       n(h) > & 2^(h/2 - 1) \
          h < & 2 log(n(h)) + 2 \
  => "Höhe" ~ & O(log(n))
$

Balance

$
  b(k) = & "Höhe"("links") - "Höhe"("rechts") \
  b(k) in {-1, 0, 1} \
  -2 <= b(k) <= 2 & & "Nach dem Einfügen eines neuen Knotens"
$

=== Einfügen

Wie beim binären Such-Baum. Verletzungen des AVL-Merkmals können beispielsweise
auftreten beim:
#grid(
  columns: (1fr, 1fr),
  [
    1. Einfügen eines Knotens in den linken Teilbaum des linken Sohnes \
    #diagram(
      spacing: (0pt, 1em),
      bnode((2, 0), [ ]),
      edge(),
      bnode((1, 1), [ ]),
      edge(),
      rbn((0, 2), [ ]),
      bnode((3, 1), [ ], stroke: none),
      edge((3, 0), (3, 2), "<->", [Höhenunterschied 2], label-side: left),
    )
  ],
  [
    2. Einfügen eines Knotens in den rechten Teilbaum des linken Sohnes \
      #diagram(
        spacing: (0pt, 1em),
        bnode((2, 0), [ ]),
        edge(),
        bnode((1, 1), [ ]),
        edge(),
        rbn((2, 2), [ ]),
        bnode((3, 1), [ ], stroke: none),
        edge((3, 0), (3, 2), "<->", [Höhenunterschied 2], label-side: left),
      )
  ],

  [
    3. Einfügen eines Knotens in den rechten Teilbaum des rechten Sohnes \
    #diagram(
      spacing: (0pt, 1em),
      bnode((0, 0), [ ]),
      edge(),
      bnode((1, 1), [ ]),
      edge(),
      rbn((2, 2), [ ]),
      bnode((3, 1), [ ], stroke: none),
      edge((3, 0), (3, 2), "<->", [Höhenunterschied 2], label-side: left),
    )
  ],
  [
    4. Einfügen eines Knotens in den linken Teilbaum des rechten Sohnes \
      #diagram(
        spacing: (0pt, 1em),
        bnode((1, 0), [ ]),
        edge(),
        bnode((2, 1), [ ]),
        edge(),
        rbn((1, 2), [ ]),
        bnode((3, 1), [ ], stroke: none),
        edge((3, 0), (3, 2), "<->", [Höhenunterschied 2], label-side: left),
      )
  ],
)

Nach dem Einfügen wandern wir vom neuen Knoten aus aufwärts, bis wir den ersten
Knoten $x$ finden, dessen Grosseltern $z$ ein unbalancierter Knoten ist und
balancieren den Baum aus.

==== Rotieren

```java
BinaryNode rotateWithLeftChild (BinaryNode k2) {
  BinaryNode k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  return k1;
}
```

Im Beispiel unten wird diese Rotation mit `k2` = $z$ und `k1` = $y$
durchgeführt.

==== Cut/Link Restrukturierungs-Algorithmus

Sei $(a, b, c)$ die (Inorder) geordnete Liste der Knoten $x, y, z$, und sei
$(T_0, T_1, T_2, T_3)$ die Liste der vier Unterbäume von $x, y, z$.

#grid(
  columns: (1fr, auto, 1fr, auto, 1fr),
  align: center + horizon,
  diagram(
    spacing: (0pt, 1em),
    bnode((1, 0), $x$),
    edge(),
    edge((2, 1)),
    rbn((0, 1), $T_0$),
    bnode((2, 1), $z$),
    edge(),
    edge((1, 2)),
    obn((3, 2), $T_3$),
    bnode((1, 2), $y$),
    edge(),
    edge((2, 3)),
    pbn((0, 3), $T_1$),
    bbn((2, 3), $T_2$),
  ),
  text(size: 2em, $arrow.cw_z$),
  diagram(
    spacing: (0pt, 1em),
    bnode((1, 0), $x$),
    edge(),
    edge((2, 1)),
    rbn((0, 1), $T_0$),
    bnode((2, 1), $y$),
    edge(),
    edge((3, 2)),
    pbn((1, 2), $T_1$),
    bnode((3, 2), $z$),
    edge(),
    edge((2, 3)),
    obn((4, 3), $T_3$),
    bbn((2, 3), $T_2$),
  ),
  text(size: 2em, $arrow.ccw_x$),
  diagram(
    spacing: (0pt, 1em),
    bnode((2, 0), $y$),
    edge(),
    edge((4, 1)),
    bnode((0, 1), $x$),
    edge(),
    edge((1, 2)),
    rbn((-1, 2), $T_0$),
    pbn((1, 2), $T_1$),
    bnode((4, 1), $z$),
    edge(),
    edge((5, 2)),
    bbn((3, 2), $T_2$),
    obn((5, 2), $T_3$),
  ),
)

Ab Zustand 2:

+ Ersetze den Unterbaum mit Root $x$ durch den Unterbaum mit Root $y$.
+ Setze $x$ als linkes Kind von $y$ und $T_0, T_1$ als den linken resp. rechten
  Unterbaum von $x$.
+ Setze $z$ als rechtes Kind von $y$ und $T_2, T_3$ als den linken resp. rechten
  Unterbaum von $z$.

Alternativ:

+ Kreiere ein Array mit 7 Elementen und befülle es In-Order mit den Knoten und
  den Unterbäumen: #stack(dir: ltr, rb[$T_0$], bx[$x$], pb[$T_1$], bx[$y$], bb[$T_2$], bx[$z$], ob[$T_3$])
+ Baue den Baum schrittweise wieder auf (beginnend bei $y$)

=== Löschen

Das Löschen eines Knotens $w$ beginnt wie im binären Suchbaum. Sein
Eltern-Knoten kann jetzt die Balance aus dem Gleichgewicht bringen, somit muss
eine Umstrukturierung stattfinden. Die Umstrukturierung kann eine neue Unbalance
hervorrufen bei Knoten höher im Baum. Somit muss die Balance weiter geprüft
werden bis die Wurzel von $T$ erreicht ist.

=== Performance

- Umstrukturierung ist $O(1)$
- `find` ist $O(log n)$ (= Höhe des Baumes)
- `insert` ist $O(log n)$ (`find` zu Beginn ist $O(log n)$, eventuelle
  Restrukturierungen $O(1)$)
- `delete` ist $O(log n)$ (`find` zu Beginn sowie eventuelle Restrukturierungen
  sind $O(log n)$)

= Sorting

= Text Processing

= Graphs
