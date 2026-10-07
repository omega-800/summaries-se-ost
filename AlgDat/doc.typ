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
  columns: (1fr, 1.25fr),
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
  exbox(
    title: ```java search(4)```,

    align(center, diagram(
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
    )),
  ),
)

#block(breakable: false)[
  === Einfügen

  #grid(
    columns: (1fr, 1.25fr),
    [
      Annahme: der Baum ist eine Multimap und $k$ ist schon im Baum vorhanden:
      Im jeweils linken Teilbaum von $k$ wird weitergesucht bis man auf ein
      Blattknoten $w$ stösst
    ],
    exbox(
      title: ```java insert(2)```,

      align(center, diagram(
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
      )),
    ),
  )
]

=== Löschen

#grid(
  columns: (1fr, 1.25fr),
  [
    - finde den internen Knoten $w$ (4), welchem $v$ (6) in der
      Inorder-Traversierung folgt
    - kopiere $"key"(w)$ in den Knoten $v$
    - lösche den Knoten $w$ und sein rechtes Kind $z$ (welches ein Blatt sein
      muss)
  ],
  exbox(
    title: ```java delete(6)```,

    align(center, diagram(
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
    )),
  ),
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

=== Rotieren

```java
BinaryNode rotateWithLeftChild(BinaryNode k2) {
  BinaryNode k1 = k2.left;
  k2.left = k1.right;
  k1.right = k2;
  return k1;
}

BinaryNode doubleRotateWithLeftChild(BinaryNode k3) {
  k3.left = rotateWithRightChild(k3.left);
  return rotateWithLeftChild(k3);
}
```

Im Beispiel unten wird diese Rotation mit `k3` = $z$, `k2` = $y$ und `k1` = $x$
durchgeführt.

#exbox(title: ```java doubleRotateWithLeftChild(z);```, grid(
  columns: (1fr, auto, 1fr, auto, 1fr),
  align: center + horizon,
  diagram(
    spacing: (0pt, 1em),
    bnode((1, 0), $z$),
    edge(),
    edge((0, 1)),
    obn((2, 1), $T_3$),
    bnode((0, 1), $x$),
    edge(),
    edge((1, 2)),
    rbn((-1, 2), $T_0$),
    bnode((1, 2), $y$),
    edge(),
    edge((2, 3)),
    pbn((0, 3), $T_1$),
    bbn((2, 3), $T_2$),
  ),
  text(size: 2em, $arrow.ccw_x$),
  diagram(
    spacing: (0pt, 1em),
    bnode((1, 0), $z$),
    edge(),
    edge((0, 1)),
    obn((2, 1), $T_3$),
    bnode((0, 1), $y$),
    edge(),
    edge((-1, 2)),
    bbn((1, 2), $T_2$),
    bnode((-1, 2), $x$),
    edge(),
    edge((0, 3)),
    rbn((-2, 3), $T_0$),
    pbn((0, 3), $T_1$),
  ),
  text(size: 2em, $arrow.cw_z$),
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
))

=== Trinode Umstrukturierungs-Algorithmus

Sei $x, y, z$ die (Inorder) geordnete Liste der Knoten. Man führe
die nötigen Rotationen durch, damit $b$ zum obersten Knoten des Baumes wird.

#exbox(
  title: ```java doubleRotateWithRightChild(x); ```,

  grid(
    columns: (1fr, auto, 1fr),
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
    [Doppel-Rotation\ #text(size: 2em, $arrow.cw_z quad arrow.ccw_x$)],
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
      bnode((4, 1), $y$),
      edge(),
      edge((5, 2)),
      bbn((3, 2), $T_2$),
      obn((5, 2), $T_3$),
    ),
  ),
)

#exbox(
  title: ```java rotateWithRightChild(x); ```,

  grid(
    columns: (1fr, auto, 1fr),
    align: center + horizon,

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
      edge((4, 3)),
      bbn((2, 3), $T_2$),
      obn((4, 3), $T_3$),
    ),
    [Einzel-Rotation\ #text(size: 2em, $arrow.ccw_x$)],
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
  ),
)

Weitere Fälle sind symmetrisch.

=== Cut/Link Restrukturierungs-Algorithmus

Sei $x, y, z$ die (Inorder) geordnete Liste der Knoten, und sei
$(T_0, T_1, T_2, T_3)$ die Liste der vier Unterbäume von $x, y, z$.

+ Ersetze den Unterbaum mit Root $x$ durch den Unterbaum mit Root $y$.
+ Setze $x$ als linkes Kind von $y$ und $T_0, T_1$ als den linken resp. rechten
  Unterbaum von $x$.
+ Setze $z$ als rechtes Kind von $y$ und $T_2, T_3$ als den linken resp. rechten
  Unterbaum von $z$.

#grid(
  columns: (1fr, auto, 1fr),
  align: center + horizon,
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
  text(size: 2em, $arrow$),
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

== Splay Baum

Ein Splay Baum ist ein binärer Such-Baum, bei welchem nach einem Zugriff auf
einen Knoten dieser zur Root bewegt wird (jede Operation, auch Suche). Diese
neue Operation heisst `splay`. Bewegt einen Knoten zum Root unter Benutzung von
Rotationen.

Welcher Knoten wird "splayed" nach jeder Operation?

#table(
  columns: (auto, 1fr),
  table-header([Methode], [Splay Knoten]), ```java find(k)```,
  [
    Wenn Key gefunden, benutze diesen Knoten \
    Wenn Key nicht gefunden, benutze den Eltern-Knoten des externen Knoten am
    Ende
  ],
  ```java insert(k, v)```,

  [
    Benutze den neuen Knoten bei welchem der Entry eingefügt/ersetzt wurde
  ],
  ```java remove(k)```,

  [
    Benutze den Eltern-Knoten des internen Knotens welcher gelöscht wurde
  ],
)

"$x$ ist das links-rechts Grosskind": $x$ ist das linke Kind von seinem
Eltern-Knoten, welcher selber ein rechtes Kind ist von seinem Eltern-Knoten. $y$
ist $x$'s Eltern-Knoten; $z$ ist $y$'s Eltern-Knoten


#let (start, end, decide, desc, next, yes, no) = fletcher-state-diag-elems(
  height: 3em,
  width: 8em,
)

#align(center, diagram(
  spacing: (6em, 4em),
  start((0, -1), [Starte mit\ Node $x$]),
  next(),
  decide((0, 0), [Ist $x$ Root?], name: <ixr>),
  yes(),
  no(<kvr>, bend: -20deg),
  end((1, -1), [Stop]),
  decide((1, 0), [Ist $x$ Kind\ von Root?], name: <kvr>),
  yes(bend: -20deg),
  no(<llg>),
  decide((2, 0), [Ist $x$ linkes\ Kind von Root?]),
  yes(label: tg[JA (zig)]),
  no(<lur>, label: tr[NEIN (zag)]),
  end((2, 1), [Rechtsrotation um Root]),
  end((2, -1), [Linksrotation um Root], name: <lur>),

  decide((1, 1), [$x$ links-links\ Grosskind?], name: <llg>),
  yes(label: tg[JA (zig-zig)]),
  no(<rrg>),
  desc((-.5, 1), [Rechts um $z$,\ Rechts um $y$]),
  next((-1, 1), marks: ()),

  decide((1, 2), [$x$ rechts-rechts\ Grosskind?], name: <rrg>),
  yes(label: tg[JA (zag-zag)]),
  no(<rlg>),
  desc((-.5, 2), [Links um $z$,\ Links um $y$]),
  next((-1, 2), marks: ()),

  decide((1, 3), [$x$ rechts-links\ Grosskind?], name: <rlg>),
  yes(label: tg[JA (zag-zig)]),
  no(<lrg>),
  desc((-.5, 3), [Rechts um $z$,\ Links um $y$]),
  next((-1, 3), marks: ()),

  decide((1, 4), [$x$ links-rechts\ Grosskind?], name: <lrg>),
  yes(label: tg[JA (zig-zag)]),
  desc((-.5, 4), [Links um $z$,\ Rechts um $y$]),
  next((-.5, 4), (-1, 4), (-1, 0), <ixr>),
))

=== Performance

- `splay` ist $O(h)$
  - Durchschnittlich: $O(log n)$, Für oft besuchte Knoten wesentlich schneller
  - Worst-Case: $O(h)$ Rotationen, jede mit $O(1)$


= Sorting

== Merge Sort

Merge-sort ist ein Sortier-Algorithmus basierend auf dem Divide-and-Conquer
Paradigma.

/ Divide: Input-Daten $S$ in zwei getrennte Teilmengen $S_1$ und $S_2$ aufteilen
/ Recur (Wiederhole): Die Teilprobleme mit $S_1$ and $S_2$ rekursiv lösen
/ Conquer: Mischen der Lösungen von $S_1$ und $S_2$ in die Lösung von $S$

=== Conquer

Mischen zweier sortierter Sequenzen von je $n/2$ Elemente mit double-linked
Listen: $O(n)$ Laufzeit

```java
void merge(int[] s1, int[] s2, int[] result) {
  int i = 0, j = 0, k = 0;
  while (i < s1.length && j < s2.length) {
    if (s1[i] <= s2[j])
      result[k++] = s1[i++];
    else
      result[k++] = s2[j++];
  }
  while (i < s1.length)
    result[k++] = s1[i++];
  while (j < s2.length)
    result[k++] = s2[j++];
}
```

=== Merge-Sort Baum

Die Ausführung eines Merge-Sort kann als binärer Baum dargestellt werden:
- Jeder Knoten representiert einen rekursiven Aufruf des Merge-Sort und enthält
  - unsortierte Sequenz vor der Ausführung und der Aufteilung
  - sortierte Sequenz nach dem Ende der Ausführung
- die Wurzel entspricht dem initialen Aufruf
- die Blätter sind Aufrufe auf Teilsequenzen der Grösse 0 oder 1

#align(center, diagram(
  node((1.5, 0), [7294 $->$ 2479]),
  edge(),
  edge((2.5, 1)),
  node((0.5, 1), [72 $->$ 27]),
  edge(),
  edge((1, 2)),
  node((0, 2), [7 $->$ 7]),
  node((1, 2), [2 $->$ 2]),
  node((2.5, 1), [94 $->$ 49]),
  edge(),
  edge((3, 2)),
  node((2, 2), [9 $->$ 9]),
  node((3, 2), [4 $->$ 4]),
))

=== Performance

- Die Höhe $h$ des Merge-Sort Baumes ist $O(log n)$
  - bei jedem rekursiven Aufruf: Aufteilung in zwei Hälften
- Der Gesamt-Aufwand aller Knoten einer Tiefe $i$ ist $O(n)$:
  - Aufteilung und Mischen von $2^i$ Sequenzen der Grösse $n/2^i$
  - $2^i+1$ rekursive Aufrufe
- Somit: totale Laufzeit des Merge-Sort ist $O(n log n)$

#todo[W4 S18 non-recursive merge-sort]

== Zusammenfassung

#table(
  columns: (1fr, 1fr, 2fr),
  table-header([Algorithmus], [Zeitverhalten], [Bemerkungen]),
  [selection-sort],
  $O(n^2)$,

  [
    - langsam
    - in-place
    - für kleine Data Sets ($< 1K$)
  ],
  [insertion-sort],
  $O(n^2)$,

  [
    - langsam
    - in-place
    - für kleine Data Sets ($< 1K$)
  ],
  [heap-sort],
  $O(n log n)$,

  [
    - schnell
    - in-place
    - für grosse Data Sets ($1K - 1M$)
  ],
  [merge-sort],
  $O(n log n)$,

  [
    - schnell
    - sequentieller Datenzugriff
    - für riesige Data Sets ($> 1M$)
  ],
)
