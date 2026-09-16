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
/ Geordnete Multimaps: Geordnet, ```java first(), last(), successors(k), predecessors(k)```
/ Binäre Suche: Bei einer Multimap, realisiert als array-basierte
  Sequenz, sortiert nach Key, bei ```java find(k)```: bei jedem Schritt wird die
  Anzahl der Kandidaten halbiert, terminiert nach $O(log n)$ Schritten
/ Suchtabelle: Multimap, welche mithilfe einer sortierten Sequenz implementiert
  wird.
  - `find`: $O(log n)$
  - `insert`: $O(n)$
  - `remove`: $O(n)$

== Binärer Suchbaum

Ein binärer Baum, welcher Keys (oder Key- Value-Entries) in seinen internen
Knoten speichert und folgende Bedingungen erfüllt: \
Gegeben sind die drei Knoten $u$, $v$, und $w$. $u$ ist im linken Teilbaum von
$v$ und $w$ ist im rechten Teilbaum von $v$. So gilt: $"key"(u) <= "key"(v) <= "key"(w)$

#todo[u links, v oben, w rechts]

#todo[OOP2 inorder etc traversing]

=== Suche

#todo[OOP2, slides 8]

=== Einfügen

#todo[OOP2, slides 9]

=== Löschen

#todo[OOP2, slides 11]

=== Performance

Betrachte eine Map mit $n$ Entries, welcher mit einem binären Suchbaum
implementiert ist mit der Höhe $h$
- nötiger Speicher ist $O(n)$
- Methoden `find`, `insert` und `remove` benötigen $O(h)$
- Die Höhe $h$ ist $O(n)$ im schlechtesten Fall und $O(log n)$ im besten Fall

=== Arithmetische Progression

Der Worst-Case tritt z.B. ein, wenn man aufsteigend sortierte Werte in
einen binäreren Such-Baum einfügt. Laut der _Gaussschen Summenformel_ $(n(n+1))/2$ ist die
Worst-Case Laufzeit somit $O(n^2)$.

#todo[implementation?]

= Sorting

= Text Processing

= Graphs
