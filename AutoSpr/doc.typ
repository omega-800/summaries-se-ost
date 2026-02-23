#import "../lib.typ": *
#import "@preview/finite:0.5.0" as finite: automaton

#show: project.with(
  module: "AutoSpr",
  name: "Automaten und Sprachen",
  semester: "FS26",
)

= Prädikate

Prädikate sind Aussagen über mathematische Objekte, die wahr oder falsch sein können. "Funktionen" mit booleschen Rückgabewerten: $P, Q(n), R(x,y,z)$. Siehe #link("../DMI/doc.pdf", "DMI").

== Normalformen

Normalformen (allgemein, _kanonische Formen_) helfen, das Vergleichsproblem zu lösen (ob zwei Aussagen dieselben sind).

$ P_1 and ... and P_n = forall i in {1,...,n}(P_i) = limits(or)_(i=1)^n P_i $
$ P_1 or ... or P_n = exists i in {1,...,n}(P_i) = limits(or)_(i=1)^n P_i $

== Negation

Nicht für alle = Es gibt einen Fall, für den nicht
$
  not forall i in {1,...,n}(P_i) <=> not (P_1 and ... and P_n) <=> not P_1 or ... or not P_n <=> exists i in {1,...,n}(not P_i)
$

= Mengen

== Konstruktion

Grundmenge $G$, Prädikat $P(x)$. Konstruierte Menge $A = {x in G | P(x)}$

== Operationen

#deftbl(
  [Vereinigung],
  [$A union B = {x | x in A or x in B}$],
  [Schnittmenge],
  [$A inter B = {x | x in A and x in B}$],
  [Komplement],
  [$overline(A) = {x | x in.not A}$],
  [Differenz],
  [$A without B = {x in A | x in.not B}$],
)

== Tupel

$A times B = {(a,b) | a in A and b n B}$ \
$limits(times)_(i=1)^n A_i = {(a_1, a_2,...,a_n)|a_i in A_i}$

= Beweise

Eine Folge von logischen Schlüssen, die zeigen, dass die Aussage aus den gegebenen Voraussetzungen folgt.

#deftbl(
  [Konstruktiver Beweis],
  [Liefert explizite "Lösung" / Algorithmus],
  [Widerspruchsbeweis],
  [Geeignet für Unmöglichkeitsaussagen. Z.B. $sqrt(2) in.not QQ$],
  [Vollständige Induktion],
  [Für Aussagen, die für alle $n in NN$ gelten.],
)

= Sprachen

#deftbl(
  [Alphabet],
  [Eine nichtleere endliche menge $Sigma$ heisst _Alphabet_. Die Elemente von $Sigma$ heissen _Zeichen_],
  [Wort],
  [Eine Zeichenkette der Länge $n$ ist ein $n$-Tupel in $Sigma^n = Sigma times ... times Sigma$. Ein Element von $Sigma^n$ heisst _Wort_ der Länge $n$],
  [Leeres Wort],
  [Die Zeichenkette $epsilon in Sigma^0 = {epsilon}$ der Länge 0 heisst das _leere Wort_.],
  [Menge aller Wörter],
  [
    Leeres Wort ist *immer* drin
    $
      Sigma^* = {epsilon} union Sigma union Sigma^2 union Sigma^3 union ... = limits(union)_(k=0)^oo Sigma^k
    $
  ],
  [Abgekürzte Schreibweisen von Wörtern],
  [$
    (A,u,t,o,S,p,r) = A u t o S p r \
    a^3b^5 = a a a b b b b b \
    b^5a^3 = b b b b b a a a \
  $],
  [Sprache],
  [Teilmenge $L subset Sigma^*$],
)

== Wortlänge

#deftbl(
  [Länge des Wortes $w$],
  [$w in Sigma^n => abs(w) = n$],
  [Anzahl Zeichen $a$ im Wort $w$],
  [$abs(w)_a, w in Sigma^n, a in Sigma$],
)

#exbox(grid(
  columns: (1fr, 1fr, 1fr),
  $
    abs(epsilon) = 0 \
    abs(01010)_0 = 3 \
  $,
  $
    abs(01010)_1 = 2 \
    abs(01010)_3 = 0 \
  $,
  $
    abs(a^3b^5) = 8 \
    abs((1291)^7) = 7 abs(1291) = 7 dot 4 = 28 \
  $,
))
$
  => abs(w^n) = n dot abs(w)
$

== Sprache

#exbox(
  $
    L = Sigma^* subset Sigma^* \
    L = emptyset subset Sigma^*, "die leere Sprache" \
    Sigma = {0,1}, "Sprache aller Binärstrings:" L = Sigma^* \
    Sigma = "Unicode", J = {w in Sigma^* | w "wird vom Java-Compiler akzeptiert"} \
    M "eine \"Maschine\"", L(M) = {w in Sigma^* | w "wird von" M "akzeptiert"} \
  $,
)

== Deterministische Endliche Automaten (DEA)

#todo("finish")

#exbox(title: "Skipiste", [
  #automaton(
    (v: (), e: ()),
    initial: "v",
    final: ("v",),
  )
  - Mögliche Aktionen: $T, D$
  - Zustände: $V, E$
  - Startzustand: $V$
  - Akzeptable Endzustände: ${V}$
  - Übergänge

  Wichtig:
  - Ein Pfeil für jedes Zeichen in jedem Zustand

  #todo("finish")
])

=== Definition

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

#grid(
  columns: (1fr, .5fr, 1.3fr),
  [Definition], [Tabellenform], [Zustandsdiagramm von $A$],

  [$ A = (#Q, #S, #d, #q, #F) $
    - Zustände: $#Q = {q_0, q_1, ... , q_n}$
    - Alphabet: #S
    - Übergangsfunktion: $#d : Q times Sigma -> Q$
    - Startzustand: $#q in Q$
    - Akzeptierzustände: $#F subset Q$
  ],

  [
    #table(
      columns: 2,
      inset: 0pt,
      [],
      box(
        fill: colors.blue.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          columns: (auto, auto),
          $0$, $1$,
        ),
      ),

      box(
        fill: colors.red.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          columns: 1,
          $q_0$,
          $q_1 \/ #F$,
          $q_2 \/ #F$,
        ),
      ),

      box(
        fill: colors.green.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          columns: (auto, auto),
          $q_2$, $q_1$,
          $q_0$, $q_1$,
          $q_1$, $q_2$,
        ),
      ),
    )],
  [
    #automaton(
      aut,
      final: ("q1", "q2"),
      layout: (q0: (0, 0), q1: (4, 0), q2: (2, -2)),
      style: (
        q1-q1: (anchor: right),
        q1-q0: (curve: -1),
        q2-q2: (anchor: bottom),
        transition: (
          stroke: colors.green,
          label: (fill: colors.blue),
          curve: 0,
        ),
        state: (stroke: colors.red, initial: (stroke: colors.fg)),
        q2: (stroke: colors.purple),
        q1: (stroke: colors.purple),
      ),
    )],
)

== Wörter einer regulären Sprache

#defbox(
  [Übergangsfunktionen für Wörter],
  [
    $
      delta: Q times Epsilon^* ->Q : (q, w = a_1, ..., a_n) |-> delta(... delta(delta(q, a_1), a_2), ..., a_n)
    $
    _Übergänge_ ausghend von $q$ für Zeichen $a_1, ..., a_n$ nacheinander anwenden.
  ],
)

#defbox(
  [Wort akzeptieren],
  [
    Der DEA $A = (Sigma, Q, q_0, delta, F)$ _akzeptiert_ das Wort $w in Sigma^*$, wenn er $A$ von Startzustand in einen Akzeptierzustand $delta(q_0, w) in F$ überführt.
  ],
)

#defbox(
  [Akzeptierte Sprache, reguläre Sprache],
  [
    Gegeben ein DEA $A = (Sigma, Q, q_0, delta, F)$. Die von $A$ _akzeptierte Sprache_ ist
    $
      L(A) = {w in Sigma^* mid(|) A "akzeptiert" w} = {w in Sigma^* mid(|) delta(q_0, w) in F}
    $
    Die Sprache $L subset Sigma^*$ heisst _regulär_, wenn es einen DEA $A$ gibt mit $L(A) = L$
  ],
)



#todo("")

#exbox(title: "DEA, der Ganzzahlen erkennt ohne führende Nullen", todo(""))

#todo("CPU")

#exbox(title: "DEA, der durch 3 teilbare Binärzahlen akzeptiert", todo(""))

#let aut = (
  g: (u: 1, g: (0, 2)),
  u: (u: (0, 2), g: 1),
)
#exbox(
  title: [DEA, der die Sprache $L = {w in Sigma^* mid(|) w "ist eine ungerade Zahl im Dreiersystem"}$ akzeptiert],
  grid(
    columns: (1fr, 1fr),
    automaton(
      aut,
      final: ("u",),
    ),

    finite.transition-table(aut),
  ),
)

== Myhill-Nerode

Für ein Wort $w in Sigma^*$ setze $L(w) = {w' in Sigma^* mid(|) w w' in L}$. Insbesondere $L(epsilon) = L$

#todo("Beispiel durch 3 teilbare Binärzahlen")

Gleicher Zustand $<=>$ gleiches $L(w)$ $ L(w) = {w' in Sigma^* mid(|) w w' in L} $

#grid(
  columns: (1fr, 2fr),
  [
    Myhill-Nerode Automat

    Gegeben: reguläre Sprache $L$ über $Sigma$. Rekonstruiere $A$ mit:
    - $Q = {L(w) mid(|) w in Sigma^*}$
    - $q_0 = L(sigma) = L$
    - $F = {L(w) in Q mid(|) epsilon in L(w)}$
    - $delta(L(w), a) = L(w a)$
  ],
  exbox(
    title: $Sigma = {0,1}, L = {w in Sigma^* mid(|) abs(w)_0 "gerade"}$,
    table(
      columns: (auto, 1fr, auto),
      $w$, $L(w)$, $Q$,
      $epsilon$, $L(epsilon) = L$, $q_0$,
      $0$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "ungerade"}$, $q_1$,
      $1$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "gerade"}$, $q_0$,
      $dots.v$, $dots.v$, $dots.v$,
    ),
  ),
)

#todo("Minimalautomat")
