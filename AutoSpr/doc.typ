#import "../lib.typ": *
#import "@preview/cetz:0.3.4"

#show: project.with(
  module: "AutoSpr",
  name: "Automaten und Sprachen",
  semester: "FS26",
)

= Prädikate

Prädikate sind Aussagen über mathematische Objekte, die wahr oder falsch sein können. "Funktionen" mit booleschen Rückgabewerten: $P, Q(n), R(x,y,z)$. Siehe #link("../DMI/doc.pdf", "DMI").

== Normalformen

Normalformen (allgemein, _kanonische Formen_) helfen, das Vergleichsproblem zu lösen (ob zwei Aussagen dieselben sind).

$
  P_1 and ... and P_n = forall i in {1,...,n}(P_i) = limits(and.big)_(i=1)^n P_i
$
$ P_1 or ... or P_n = exists i in {1,...,n}(P_i) = limits(or.big)_(i=1)^n P_i $

== Negation

#tr("Nicht") #tg("für alle") = #tg("Es gibt") einen Fall, für den #tr("nicht")
$
  #tr($not$) #tg($forall$) i in {1,...,n}(P_i) <=> not (P_1 and ... and P_n) <=> not P_1 or ... or not P_n <=> #tg($exists$) i in {1,...,n}(#tr($not$) P_i)
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

$ A times B = {(a,b) | a in A and b n B} $
$n$-Tupel:
$ limits(times.big)_(i=1)^n A_i = {(a_1, a_2,...,a_n)|a_i in A_i} $

= Beweise

Eine Folge von logischen Schlüssen, die zeigen, dass die Aussage aus den gegebenen Voraussetzungen folgt.

#deftbl(
  term: "Beweistechnik",
  definition: "Anwendungsfall",
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
  [Eine nichtleere endliche menge $Sigma$ heisst _Alphabet_. Die Elemente von $Sigma$ heissen _Zeichen_.],
  [Wort],
  [Eine Zeichenkette der Länge $n$ ist ein $n$-Tupel in $Sigma^n = Sigma times ... times Sigma$. Ein Element von $Sigma^n$ heisst _Wort_ der Länge $n$. Wörter haben immer endliche Länge.],
  [Leeres Wort],
  [Die Zeichenkette $epsilon in Sigma^0 = {epsilon}$ der Länge $0$ heisst das _leere Wort_.],
  [Menge aller Wörter],
  [
    Leeres Wort ist *immer* drin
    $
      Sigma^* = {epsilon} union Sigma union Sigma^2 union Sigma^3 union ... = limits(union.big)_(k=0)^oo Sigma^k
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
  [Länge des Wortes],
  [$w in Sigma^n => abs(w) = n$, $n$ ist _Länge des Wortes_ $w$],
  [Anzahl Zeichen],
  [Sei $w in Sigma^n, a in Sigma$. Dann ist $abs(w)_a$ die _Anzahl Zeichen_ $a$ im Wort $w$],
)

#exbox(title: "Wortlänge", grid(
  columns: (1fr, 1fr, 2fr),
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

#exbox(
  title: "Sprache",
  $
    L = Sigma^* subset Sigma^* \
    L = emptyset subset Sigma^*, "die leere Sprache" \
    Sigma = {0,1}, "Sprache aller Binärstrings:" L = Sigma^* \
    Sigma = "Unicode", J = {w in Sigma^* | w "wird vom Java-Compiler akzeptiert"} \
    M "eine \"Maschine\"", L(M) = {w in Sigma^* | w "wird von" M "akzeptiert"} \
  $,
)

#obsbox(
  $abs(w^n) = n dot abs(w)$,
  [Zu jeder Maschine $M$ gibt es eine Sprache $L(M)$],
)

== Deterministische Endliche Automaten (DEA)

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
  columns: (1fr, .5fr, 1fr),
  [_Definition_], [_Tabellenform_], [_Zustandsdiagramm von $A$_],

  [$ A = (#Q, #S, #d, #q, #F) $
    - Zustände: $#Q = {q_0, q_1, ... , q_n}$
    - Alphabet: #S
    - Übergangsfunktion: $#d : Q times Sigma -> Q$
    - Startzustand: $#q in Q$
    - Akzeptierzustände: $#F subset Q$
  ],

  [
    // oh god this is so hacky
    #place(dx: 0em, dy: 3em, Q)
    #place(dx: 0em, dy: 4.5em, F)
    #place(dx: 8em, dy: 4em, d)
    #place(dx: 8em, dy: .5em, S)
    #align(center, box(width: 70%, table(
      columns: (1fr, 2fr),
      inset: 0pt,
      [],
      box(
        fill: colors.blue.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          gutter: .25em,
          align: center,
          columns: (50% - .125em, 50% - .125em),
          $0$, $1$,
        ),
      ),

      box(
        fill: colors.red.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          gutter: .25em,
          align: center,
          columns: (100%,),
          $q_0$,
          tp($q_1$),
          tp($q_2$),
        ),
      ),

      box(
        fill: colors.green.transparentize(60%),
        width: 100%,
        inset: .25em,
        grid(
          inset: .25em,
          gutter: .25em,
          align: center,
          columns: (50% - .125em, 50% - .125em),
          $q_2$, $q_1$,
          $q_0$, $q_1$,
          $q_1$, $q_2$,
        ),
      ),
    )))],
  [
    #automaton(
      aut,
      final: ("q1", "q2"),
      layout: (q0: (0, 0), q1: (3, 0), q2: (1.5, -1.5)),

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
          radius: 1.25em,
        ),
        q2: (stroke: colors.purple),
        q1: (stroke: colors.purple),
      ),
    )],
)
*Wichtig:*
- Ein Pfeil für jedes Zeichen in jedem Zustand (deterministischer endlicher Automat / DEA)

== Wörter einer regulären Sprache

=== Übergangsfunktionen für Wörter

$
  delta: Q times Epsilon^* ->Q : (q, w = a_1, ..., a_n) |-> delta(... delta(delta(q, a_1), a_2), ..., a_n)
$
_Übergänge_ ausghend von $q$ für Zeichen $a_1, ..., a_n$ nacheinander anwenden.

=== Wort akzeptieren

Der DEA $A = (Sigma, Q, q_0, delta, F)$ _akzeptiert_ das Wort $w in Sigma^*$, wenn er $A$ von Startzustand in einen Akzeptierzustand $delta(q_0, w) in F$ überführt.

=== Akzeptierte Sprache, reguläre Sprache

Gegeben ein DEA $A = (Sigma, Q, q_0, delta, F)$. Die von $A$ _akzeptierte Sprache_ ist
$
  L(A) = {w in Sigma^* mid(|) A "akzeptiert" w} = {w in Sigma^* mid(|) delta(q_0, w) in F}
$
Die Sprache $L subset Sigma^*$ heisst _regulär_, wenn es einen DEA $A$ gibt mit $L(A) = L$

#let aut = (
  g: (u: 1, g: (0, 2)),
  u: (u: (0, 2), g: 1),
)
#exbox(
  title: [DEA, der die Sprache $L = {w in Sigma^* mid(|) w "ist eine ungerade Zahl im Dreiersystem"}$ akzeptiert],
  grid(
    columns: (1fr, 1fr),
    align: center,
    automaton(
      aut,
      final: ("u",),
    ),

    finite.transition-table(aut),
  ),
)

== Myhill-Nerode Automat

Für ein Wort $w in Sigma^*$ setze $L(w) = {w' in Sigma^* mid(|) w w' in L}$. Insbesondere $L(epsilon) = L$

Gegeben: reguläre Sprache $L$ über $Sigma$. Rekonstruiere $A$ mit:
- $Q = {L(w) mid(|) w in Sigma^*}$
- $q_0 = L(sigma) = L$
- $F = {L(w) in Q mid(|) epsilon in L(w)}$
- $delta(L(w), a) = L(w a)$

Gleicher Zustand $<=>$ gleiches $L(w)$

#exbox(
  title: $Sigma = {0,1}, L = {w in Sigma^* mid(|) abs(w)_0 "gerade"}$,
  grid(
    columns: (1fr, 2fr),
    automaton(
      (
        q0: (q1: "0", q0: "1"),
        q1: (q1: "1", q0: "0"),
      ),
      final: ("q0",),
      style: (
        q0: (stroke: colors.green),
        q1: (stroke: colors.red),
      ),
    ),
    table(
      columns: (auto, 1fr, auto),
      table-header($w$, $L(w)$, $Q$), $epsilon$, $L(epsilon) = L$,
      tg($q_0$), $0$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "ungerade"}$,
      tr($q_1$), $1$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "gerade"}$,
      tg($q_0$), $dots.v$, $dots.v$,
      $dots.v$,
    ),
  ),
)

== Minimalautomat

*Ziel:* Nicht unterscheidbare Zustände zusammenlegen

*Vorgehen:*
+ Akzeptierzustand $!=$ Nichtakzeptierzustand
+ Iteration: alle unterscheidbaren Paare suchen
+ Verbleibende Paare sind ununterscheidbar $->$ zusammenlegen

#exbox(grid(
  columns: (1fr, 1fr),
  [
    #automaton(
      (
        q0: (q1: 0, q2: 1),
        q1: (q2: 0, q3: 1),
        q2: (q1: 0, q3: 1),
        q3: (q3: (0, 1)),
      ),
      layout: (
        q0: (0, 0),
        q1: (2, 2),
        q2: (2, -2),
        q3: (4, 0),
      ),
      style: (
        q0-q1: (curve: .1),
        q1-q3: (curve: .1),
        q3-q3: (anchor: right),
        q1: (fill: colors.yellow.transparentize(60%)),
        q2: (fill: colors.yellow.transparentize(60%)),
      ),
    )
    #automaton(
      (
        q0: ("q1,2": (0, 1)),
        "q1,2": ("q1,2": 0, q3: 1),
        q3: (q3: (0, 1)),
      ),
      layout: (
        q0: (0, 0),
        "q1,2": (2, 0),
        q3: (4, 0),
      ),
      style: (
        q3-q3: (anchor: right),
        "q1,2": (fill: colors.yellow.transparentize(60%)),
      ),
    )
  ],
  [
    #align(center, grid(
      columns: (auto, auto, auto, auto, auto),
      gutter: 0pt,
      inset: .75em,
      stroke: 1pt,
      $$, $q_0$, $q_1$, $q_2$, $q_3$,
      $q_0$, $equiv$, td[$times$], td[$times$], tr[$times$],
      $q_1$, td[$times$], $equiv$, tg[$equiv$], tr[$times$],
      $q_2$, td[$times$], tg[$equiv$], $equiv$, tr[$times$],
      $q_3$, tr[$times$], tr[$times$], tr[$times$], $equiv$,
    ))
    _Algorithmus_

    + #tr[$q in F, q' in.not F$]
    + #td[Unterscheidbar nach Übergang]
    + #tg[Iteration bis keine Änderung mehr]
    $=>$ #ty[$q_1$ und $q_2$ sind nicht unterscheidbar]
  ],
))

== Pumping Lemma

#grid(
  columns: (1fr, 1fr),
  grid.cell(
    colspan: 2,
    [Ist $L$ eine reguläre Sprache, dann gibt es $N in NN$, die pumping length so, dass jedes Wort $w in L$ mit $abs(w) >= N$ in drei Teile $w = #tg($x$)#tr($y$)#td($z$)$ zerlegt werden kann mit:
    ],
  ),
  [
    + $abs(#tg($x$)#tr($y$)) <= N$
    + $abs(#tr($y$)) > 0$
    + $#tg($x$)#tr($y$)^k#td($z$) in L forall k in NN$

    Oder: genügend lange Wörter ($abs(w) >= N$) einer regulären Sprache ($w in L$) können alle in einem Anfangsstück der Länge N ($abs(#tg($x$)#tr($y$)) <= N$) aufgepumpt werden ($#tg($x$)#tr($y$)^k#td($z$) in L$).
  ],

  automaton(
    (
      q0: (q1: "x"),
      q1: (q1: "y", q2: "z"),
      q2: (),
    ),
    style: (
      q0-q1: (stroke: colors.green),
      q1-q1: (stroke: colors.red),
      q1-q2: (stroke: colors.darkblue),
    ),
  ),
)

Was zeichnet reguläre Sprachen aus?

- Reguläre Ausdrücke
- Lange Wörter: \* kommt im regulären Ausdruck vor
- Blöcke mit \* können beliebig oft wiederholt werden
- $=>$ Wörter können "aufgepumpt" werden

=== Beweis

Behauptung: Die Sprache $L subset Sigma^*$ ist nicht regulär.

Beweis (Widerspruch):

+ Annahme: $L$ ist regulär
+ Gemäss Pumping Lemma gibt es die Pumping Length $N$
  - Es darf keine Annahme über die konkrete Grösse von $N$ gemacht werden!
+ Wähle ein Wort $w in L$ mit $abs(w) >= N$
  - Die Definition *muss* $N$ verwenden!
+ Aufteilung des Wortes gemäss Pumping Lemma
  - $w = #tg($x$)#tr($y$)#td($z$), abs(#tg($x$)#tr($y$)) <= N, abs(#tr($y$)) > 0$
+ Auswirkung des Pumpens
  - $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für mindestens ein $k in NN$ (mit Begründung!)
+ Widerspruch und Schlussfolgerung, dass die Annahme nicht zutreffen kann

#exbox(title: [$L = {0^n 1^n mid(|) n >= 0}$ ist nicht regulär], [
  + Annahme: $L$ ist regulär
  + $exists N in NN$, Pumping Length
  + $w = 0^N 1^N$
  + Unterteilung $w = #tg($x$)#tr($y$)#td($z$)$
    #todo("reduce confusion")
    #block(
      width: 100% * 5 / 6,
      stroke: colors.black,
      fill: colors.white,
      inset: 4pt,
      grid(
        columns: (1fr, 1fr, 3fr),
        align: center,
        gutter: 4pt,
        box(width: 100%, inset: 4pt, stroke: colors.green, [#tg($x$)]),
        box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
        [
          #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$) $1$])
          #place(dx: 10% + 0.75em, dy: -2.75em, [$N$])
          #place(dx: 10%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
          #place(dx: 100%, dy: -2.75em, [$2N$])
        ],
      ),
    )
    #block(
      width: 100%,
      stroke: colors.black,
      fill: colors.white,
      inset: 4pt,
      grid(
        columns: (1fr, 1fr, 1fr, 3fr),
        align: center,
        gutter: 4pt,
        box(width: 100%, inset: 4pt, stroke: colors.green, [#tg($x$)]),
        box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
        box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
        [
          #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$) $1$])
          #place(dx: 10% - 0.25em, dy: -2.75em, [$N + abs(#tr($y$))$])
          #place(dx: 10%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
          #place(dx: 100% - 3.25em, dy: -2.75em, [$2N + abs(#tr($y$))$])
        ],
      ),
    )
  + Pumpen: nur die Anzahl der $1$ wird erhöhr, Anzahl $1$ bleibt
  + $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für $k != 1$, im Widerspruch zum Pumping Lemma
])

== Nichtdeterministische endliche Automaten (NEA)

#grid(
  columns: (1fr, 1.5fr),
  [_Definition_], [_Akzeptieren_],

  [
    $ A = (#Q, #S, #d, #q, #F) $
    - Endliche Menge von Zuständen: $#Q$
    - Alphabet: #S
    - Übergangsfunktion: $#d : Q times Sigma -> #ty($P(#Q)$)$
    - Startzustand: $#q in Q$
    - Akzeptierzustände: $#F subset Q$
  ],
  [
    Ein NEA $A$ _akzeptiert_ das Wort $w in Sigma^*$, wenn es eine *Wahl* von Übergängen gibt, derart, dass das Wort $w$ den Automaten in einen Akzeptierzustand überführt.

    _Faustregeln_

    - Nur genau diejenigen Pfeile einzeichnen, die man zum Akzeptieren braucht.
    - Erlaube Alternativen
  ],
)

#exbox(title: $L = {w in Sigma^* mid(|) w "endet mit zwei" 0}$, grid(
  columns: (1fr, 1fr),
  [_DEA-Lösung_], [_NEA-Lösung_],
  automaton(
    (
      q0: (q0: 1, q1: 0),
      q1: (q0: 1, q2: 0),
      q2: (q0: 1, q2: 0),
    ),
    style: (q2-q0: (curve: 1), q1-q0: (curve: 0), q0-q1: (curve: .75)),
  ),
  automaton((
    q0: (q0: (0, 1), q1: 1),
    q1: (q2: 1),
    q2: (),
  )),
))

=== Umgang mit mehrdeutigen Übergängen

#grid(
  columns: 2,
  [
    #tr([a-Übergang von $q_1$ aus nicht eindeutig])

    Welchen Übergang soll man nehmen?

    - Beide Möglichkeiten probieren und akzeptieren, falls eine der Möglichkeiten auf einen Akzeptierzustand führt.
    - Zufallsgenerator (probabilistischer endlicher automat, PEA)
  ],
  automaton(
    (q0: (q1: "b"), q1: (q1: "a", q2: ("a", "b")), q2: (q0: "a")),
    layout: finite.layout.circular,
    final: ("q0",),
    style: (
      q1-q2: (stroke: colors.red, curve: .1),
      q1-q1: (stroke: colors.red, anchor: top + right),
      q0-q1: (curve: .1),
      q2-q0: (curve: .1),
    ),
    labels: (
      q1-q2: $space a#text(fill: colors.fg, $,b$)$,
    ),
  ),
)

#place(dx: 75%, rotate(90deg, line(length: 4em)))
#place(dx: 75% + 12.5pt, dy: 18pt, rotate(45deg, line(length: 1em)))
#place(dx: 75% + 20.5pt, dy: 18pt, rotate(135deg, line(length: 1em)))

=== Thompson-NEA
#grid(
  columns: (1fr, 2fr),
  [
    - Zustand = *Menge* der möglichen Zustände
    - Akzeptieren = Ob NEA im\ Zustand sein *könnte*
  ],
  automaton(
    (
      "sq0": (se: "a", sq1: "b"),
      "sq1": (s_q0: "a", sq2: "b"),
      "sq2": (se: "b", sq0: "a"),
      "se": (se: ("a", "b")),
      "s_q0": (sQ: "a", sq2: "b"),
      "s_q1": (),
      "s_q2": (),
      "sQ": (s_q0: "b", sQ: "a"),
    ),
    layout: (
      "sq0": (3, 4),
      "sq1": (3, 2),
      "sq2": (3, 0),
      "se": (0, 2),
      "s_q0": (6, 4),
      "s_q1": (6, 2),
      "s_q2": (6, 0),
      "sQ": (9, 2),
    ),
    final: ("sq0", "sQ", "s_q1", "s_q2"),
    style: (
      sq2-sq0: (curve: 1.5),
      sq0-se: (curve: -.5),
      sq2-se: (curve: .5),
      sq1-s_q0: (curve: .5),
      s_q0-sQ: (curve: .5),
      sQ-s_q0: (curve: .5),
    ),
  ),
)

==== Transformation NEA $->$ DEA

Gegeben $delta: Q times Sigma -> P(Q)$ eines NEA. Übergangsfunktion für Mengen $M subset Q$
$
  delta' : P(Q) times Sigma -> P(Q): (M, a) |-> delta' (M, a) = limits(union.big)_(q in M) delta (q,a)
$

#grid(
  columns: (1fr, 1fr),
  [_Satz_], [_Implementation_],
  [
    Ein NEA $A$ kann in einen DEA $A′$ umgewandelt werden mit
    - $Q′ = P(Q)$
    - $Sigma′ = Sigma$
    - $delta′$ wie oben definiert
    - $q′_0 = {q_0}$
    - $F′ = {M in P(Q) | F inter M != emptyset}$
  ],
  [
    Thompson-NEA:
    - Zustand $M subset Q$ realisiert durch Markierung der Zustände in $M$
    - $delta'$ realisiert durch Verschieben von Markierungen
    - Akzeptieren: mindestens ein Akzeptierzustand markiert
  ],
)

=== $"NEA"_epsilon$

#deftbl(
  [$epsilon$-Übergang],
  [
    Kann ohne Verarbeitung eines Zeichens genommen werden.
    $ delta:Q times (Sigma union {epsilon}) -> P(Q) $
  ],
  [$"NEA"_epsilon$],
  [NEA mit $epsilon$-Übergängen],
)

#grid(
  columns: 2,
  [Einen $"NEA"_epsilon$ kann man immer in einen NEA umwandeln. Beweis:

    + $E(q) =$ Menge der von $q$ aus mit $epsilon$-Übergängen erreichbaren Zustände
    + $E(M) = union.big_(q in M) E(q)$
    + $delta$ ersetzen durch $delta: Q times (Sigma inter {epsilon}) -> P(Q) : (q,a) |-> E(delta(q, a))$
  ],

  [$ L={0^k 1^l mid(|) k,l >=0} $ #automaton(
      (
        q0: (q0: 0, q1: "e"),
        q1: (q1: 1),
      ),
    )],
)

== Mengenoperationen

Lassen reguläre Sprachen regulär sein.

Produktautomat: $L_i = L(A_i)$

$
  L = #block(inset: 5pt, fill: colors.darkblue.transparentize(80%), ${w in Sigma^* mid(|) abs(w)_1 "ungerade"}$) inter #block(inset: 5pt, fill: colors.red.transparentize(80%), ${w in Sigma^* mid(|) w "ist eine durch drei teilbare Binärzahl"}$)
$

#let prod-aut = (s, e: ()) => {
  set text(size: 1em * s)
  grid(
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
#align(center, prod-aut(1))
// TODO: remove
#pagebreak()
#let place-off = place.with(dx: 25pt, dy: 29pt)
#let poly = place-off(polygon(
  fill: colors.fg.transparentize(75%),
  (0pt, 96pt),
  (0pt, 125pt),
  (187pt, 125pt),
  (187pt, 96pt),
  (102pt, 96pt),
  (102pt, 0pt),
  (72pt, 0pt),
  (72pt, 96pt),
))
#grid(
  columns: 2,
  align: center,
  [
    Schnittmenge $L(A_1) inter L(A_2)$
    #poly
    #place-off(polygon(
      stroke: colors.fg + 2pt,
      (72pt, 96pt),
      (72pt, 125pt),
      (102pt, 125pt),
      (102pt, 96pt),
    ))
    #prod-aut(.5, e: ("q10",))
  ],
  [
    Vereinigungsmenge $L(A_1) union L(A_2)$
    #poly
    #place-off(polygon(
      stroke: colors.fg + 2pt,
      (102pt, 96pt),
      (102pt, 54pt),
      (72pt, 54pt),
      (72pt, 125pt),
      (187pt, 125pt),
      (187pt, 96pt),
    ))
    #prod-aut(.5, e: ("q00", "q10", "q11", "q12"))
  ],

  [
    Differenzmenge $L(A_1) without L(A_2)$
    #place-off(polygon(
      fill: colors.fg.transparentize(75%),
      (0pt, 54pt),
      (0pt, 83pt),
      (72pt, 83pt),
      (72pt, 125pt),
      (102pt, 125pt),
      (102pt, 83pt),
      (187pt, 83pt),
      (187pt, 54pt),
      (102pt, 54pt),
      (102pt, 0pt),
      (72pt, 0pt),
      (72pt, 54pt),
    ))

    #place-off(polygon(
      stroke: colors.fg + 2pt,
      (72pt, 54pt),
      (72pt, 83pt),
      (102pt, 83pt),
      (102pt, 54pt),
    ))
    #prod-aut(.5, e: ("q00",))
  ],
  [
    Symmetrische Differenz $L(A_1) triangle L(A_2)$
    #poly
    #place-off(polygon(
      stroke: colors.fg + 2pt,
      (72pt, 54pt),
      (72pt, 83pt),
      (102pt, 83pt),
      (102pt, 54pt),
    ))
    #place-off(polygon(
      stroke: colors.fg + 2pt,
      (115pt, 96pt),
      (115pt, 125pt),
      (187pt, 125pt),
      (187pt, 96pt),
    ))
    #prod-aut(.5, e: ("q00", "q11", "q12"))
  ],
)

Operationen verändern nur Endzustände:

#deftbl(
  [Schnittmenge $L_1 inter L_2$],
  $F = F_1 times F_2$,
  [Vereinigung $L_1 union L_2$],
  $F = F_1 times Q_2 union Q_1 times F_2$,
  [Differenz $L_1 without L_2$],
  $F = F_1 times (Q_2 without F_2)$,
)

== Reguläre Operationen

WICHTIG: $epsilon$-Übergänge immer hinzufügen

#let crc = (pos, ..args) => cetz.draw.circle(
  pos,
  radius: .25,
  ..args.pos(),
  ..args.named(),
)
#let autsqr = (pos, name: none, final: true, mirror: false) => {
  import cetz.draw: *
  group({
    set-origin(pos)
    let crcf = pos => {
      crc(pos)
      circle(pos, radius: .18, stroke: if final { colors.fg } else {
        colors-l.fg
      })
    }

    if not mirror {
      rotate(y: 180deg)
    }

    rect((-.5, -.5), (4.2, 2))
    crcf((.6, 0))
    crcf((0, .7))
    crcf((.2, 1.4))

    crc((1.4, .1))
    crc((1, .7))
    crc((1, 1.5))

    crc((1.8, 1))

    crc((2.3, .2))
    crc((2.9, .7))
    crc((2.4, 1.5))

    crc((3.6, 1.2))

    if name != none {
      content((3.6, 0), name)
    }
  })
}
#let mrk = cetz.draw.mark.with(
  symbol: ">",
  fill: colors.red,
  stroke: colors.red,
)

=== Alternative

#grid(
  columns: (auto, 1fr),
  align: center + horizon,
  $
    L & = L_1 union L_2 \
      & = L(A_1) union L(A_2) \
      & = L(A_1) | L(A_2)
  $,
  cetz.canvas({
    import cetz.draw: *
    autsqr((0, 0), final: true, name: $A_1$, mirror: true)

    content((5.5, 1.5), text(fill: colors.red)[$epsilon$])
    content((4.5, 1.5), text(fill: colors.red)[$epsilon$])
    line((5, 2), (5, 1.2), stroke: colors.red)
    line((5, 1.2), (6.15, 1.2), stroke: colors.red)
    line((5, 1.2), (3.85, 1.2), stroke: colors.red)
    crc((5, 1.2), stroke: colors.red, fill: colors.bg)
    mrk((6.15, 1.2), (10, 1.2))
    mrk((3.85, 1.2), (0, 1.2))
    mrk((5, 1.45), (5, 1.2))

    autsqr((10, 0), name: $A_2$)
  }),
)

=== Verkettung

#grid(
  columns: (auto, 1fr),
  align: center + horizon,
  $
    L & = L_1 L_2 \
      & = L(A_1) L(A_2) \
      & = {w_1 w_2 mid(|) w_i in L_i}
  $,
  cetz.canvas({
    import cetz.draw: *
    autsqr((0, 0), final: false, name: $A_1$)

    line((-5, 1.2), (-4, 1.2))
    mrk((-3.85, 1.2), (-3, 1.2), stroke: colors.fg, fill: colors.fg)

    content((1.15, 1.6), text(fill: colors.red)[$epsilon$])
    line((0.05, 1.4), (1.9, 1.19), stroke: colors.red)
    line((0.25, .75), (1.9, 1.18), stroke: colors.red)
    line((-.35, .05), (1.9, 1.16), stroke: colors.red)
    mrk((2.15, 1.185), (2.25, 1.19))

    autsqr((6, 0), name: $A_2$)
  }),
)

=== \*-Operation

#grid(
  columns: (auto, 1fr),
  align: center + horizon,
  $
    L^* & = {epsilon} union L union L^2 union ... \
        & = union.big_(k=0)^oo L^k
  $,

  cetz.canvas({
    import cetz.draw: *
    autsqr((0, 0), final: false, name: $A$)

    content((-4.75, 1.5), text(fill: colors.red)[$epsilon$])
    line((-5.5, 1.2), (-3.85, 1.2), stroke: colors.red)
    mrk((-3.85, 1.2), (-3, 1.2))

    line((-6.85, 1.2), (-5.5, 1.2), stroke: colors.red)
    mrk((-5.73, 1.2), (-3, 1.2))

    catmull(
      (.05, 1.4),
      (.5, 1.9),
      (0, 2.4),
      (-4.5, 2.4),
      (-5.45, 1.6),
      stroke: colors.red,
      tension: .5,
    )
    catmull(
      (.2, .85),
      (.8, 1.8),
      (0, 2.5),
      (-4.6, 2.5),
      (-5.45, 1.6),
      stroke: colors.red,
    )
    catmull(
      (-.35, 0),
      (.5, .5),
      (1.1, 1.8),
      (0, 2.6),
      (-4.7, 2.6),
      (-5.45, 1.6),
      stroke: colors.red,
    )

    content((.35, 1.4), text(fill: colors.red)[$epsilon$])
    content((.65, 1.1), text(fill: colors.red)[$epsilon$])
    content((.95, 0.8), text(fill: colors.red)[$epsilon$])

    mrk((-5.45, 1.45), (-5.5, 1.2))

    crc((-5.5, 1.2), fill: colors.bg)
    circle((-5.5, 1.2), radius: .18, stroke: colors.red, fill: colors.bg)
  }),
)

$=>$ die Klasse der regulären Sprachen ist abgeschlossen unter regulären Operationen

== Reguläre Ausdrücke

Formeln, die Zeichenketten beschreiben.

+ Buchstaben stehen für sich selbst, mit Ausnahme der Metazeichen $( ) [ ] \* ? | . \\$ (escape character)
+ Verkettung: Zeichen und Formeln hintereinanderschreiben
+ $.$ = ein beliebiges Zeichen, $Sigma$
+ $|$: Alternative, $a|A$ = a oder A
+ $\*$: Wiederholung, beliebige viele
+ $( )$: Gruppierung
+ $[ ]$ Zeichenklassen: $[a b c] = a|b|c$, $[\^ a b c]$ = nicht [abc]

Erweiterungen / Dialekte

+ ${n,m}$: zwischen $n$ un $m$ Wiederholungen
+ $+$: mindestens eines, ${1,}$
+ $?$: optional, ${0,1}$
+ Symbole für Zeichenklassen: $\\ d$ Ziffern, $\\ s$ whitespace, $[:s p a c e:]$, $[:l o w e r:]$

=== VNEA

#deftbl(
  [Regulärer Ausdruck],
  [Zeichenkette $r$ zur Beschreibung einer regulären Sprache $L = L(r)$],
  [Reguläre Operationen],
  $
    L(r_1) union L(r_2) = L(r_1 | r_2) \
    L(r_1) L(r_2) = L(r_1 r_2) \
    L(r_1)\* = L(r_1 \*)
  $,
  [Verallgemeinerter NEA],
  [$"NEA"_epsilon$, dessen Übergänge mit regulären Ausdrücken beschriftet sind],
  [Primitive reguläre Ausdrücke],
  [
    Reguläre Ausdrücke für Wörter mit Länge $<= 1$
    #let saut = (..args) => automaton(..args.pos(), ..args.named(), style: (
      state: (stroke: colors.fg, radius: .3, extrude: .7),
      "": (stroke: colors.fg),
      "q": (label: (text: "")),
    ))
    #table(
      columns: 3,
      table-header($L = L(r)$, $r$, $"NEA"$), $emptyset$, $emptyset$,
      saut(("": ()), final: ()), ${epsilon}$, ${epsilon}$,
      saut(("": ())), ${a}$, $a$,
      saut(("": (q: "a"), "q": ())), ${o,s,t}$, $[o s t]$,
      saut(("": (q: ("o", "s", "t")), q: ())), ${a,b,...,s}$, $[a-s]$,
      saut(("": (q: "[a-s]"), q: ())), $Sigma$, $.$,
      saut(("": (q: "S"), "q": ())),
    )
  ],
)
$=>$ zu jedem regulären Ausdruck gibt es einen DEA

==== VNEA $A$ umwandeln in Regex $r$

_Keine Übergänge nach $q_0$ und nur ein Akzeptierzustand_

#align(center, cetz.canvas({
  import cetz.draw: *
  autsqr((0, 0), name: $A$)
  autsqr((8, 0), final: false, name: $A$)

  line((-5, 1.2), (-4, 1.2))
  mrk((-3.85, 1.2), (-3, 1.2), stroke: colors.fg, fill: colors.fg)

  content((1.2, 0.8), text(size: 2em)[$~~>$])

  content((9.15, 1.6), text(fill: colors.red)[$epsilon$])
  line((8.05, 1.4), (9.9, 1.19), stroke: colors.red)
  line((8.25, .75), (9.9, 1.18), stroke: colors.red)
  line((7.65, .05), (9.9, 1.16), stroke: colors.red)
  mrk((10.15, 1.185), (10.25, 1.19))

  content((3.55, 1.5), text(fill: colors.red)[$epsilon$])
  line((2.5, 1.2), (3.95, 1.2), stroke: colors.red)
  mrk((4.15, 1.2), (6, 1.2))

  line((1.85, 1.2), (2.5, 1.2), stroke: colors.red)
  mrk((2.73, 1.2), (4.5, 1.2))

  crc((3, 1.2), fill: colors.bg, stroke: colors.red)

  crc((10.35, 1.2), fill: colors.bg, stroke: colors.red)
  circle((10.35, 1.2), radius: .18, stroke: colors.red, fill: colors.bg)
}))

_Reduktion_

#align(center, grid(
  columns: 3,
  align: center + horizon,
  automaton(
    (
      q1: (q2: "r1", qrip: "r2"),
      q2: (),
      qrip: (qrip: "r3", q2: "r4"),
    ),
    layout: (
      q1: (0, 0),
      q2: (4, 0),
      qrip: (2, -1.5),
    ),
    style: (qrip: (label: (text: $q_"rip"$)), qrip-qrip: (anchor: bottom)),
    final: (),
  ),
  text(size: 2em)[$~~>$],
  automaton(
    (
      q1: (q2: "asdf"),
      q2: (),
    ),
    final: (),
    style: (
      q1-q2: (label: (text: $r_1|r_2 r_3*r_4$)),
    ),
    layout: (q1: (0, 0), q2: (4, 0)),
  ),
))

_Regulärer Ausdruck_

Nach Entfernen aller Zwischenzustände $q_"rip" in Q$ bleibt ein regulärer Ausdruch $r$ von $A$

#align(center, automaton(
  (
    S: (E: "r"),
    E: (),
  ),
))

$=>$ jede reguläre Sprache lässt sich mit einem regulären Ausdruck beschreiben ${L(A) | A "ein DEA"} = {L(r)|r "ein regulärer Ausdruck"}$

Interessantes projekt (DEA Lexer DSL): #link("https://www.colm.net/open-source/ragel/", "Ragel")

=== Teststrategie

#table(
  columns: (1fr, 1fr),
  table-header([Messung], [Folgerung]),
  [
    Für $n = 1,2,3,...$

    - Regulären Ausdruck erzeugen \
      $r = underbrace(a?a?a?a?...a?, n dot a ?)underbrace(a a a a ... a, n dot a)$
    - Laufzeit für Akzeptieren von $a^n$ durch $r$ messen
  ],

  [
    - Laufzeit $O(2^n)$: NEA-Implementation
    - Laufzeit $O(n)$: DEA-Implementation
  ],
)
