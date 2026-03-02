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

$ P_1 and ... and P_n = forall i in {1,...,n}(P_i) = limits(and)_(i=1)^n P_i $
$ P_1 or ... or P_n = exists i in {1,...,n}(P_i) = limits(or)_(i=1)^n P_i $

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
$ limits(times)_(i=1)^n A_i = {(a_1, a_2,...,a_n)|a_i in A_i} $

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
  [Länge des Wortes],
  [$w in Sigma^n => abs(w) = n$, $n$ ist _Länge des Wortes_ $w$],
  [Anzahl Zeichen],
  [Sei $w in Sigma^n, a in Sigma$. Dann ist $abs(w)_a$ die _Anzahl Zeichen_ $a$ im Wort $w$],
)

#exbox(title: "Wortlänge", grid(
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
        q1-q0: (curve: -1),
        q2-q2: (anchor: bottom),
        transition: (
          stroke: colors.green,
          label: (fill: colors.blue, angle: 0deg),
          curve: 0,
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

#exbox(title: "Skipiste", grid(
  columns: (1fr, 1fr),
  [
    - Mögliche Aktionen: $T, D$
    - Zustände: $V, E$
    - Startzustand: $V$
    - Akzeptable "Endzustände": ${V}$
    - Übergänge
  ],
  automaton(
    (V: (E: "T", V: "D"), E: (V: "D", E: "T")),
    initial: "V",
    final: ("V",),
  ),
  grid.cell(colspan: 2, [
    *Wichtig:*
    - Ein Pfeil für jedes Zeichen in jedem Zustand (deterministischer endlicher Automat / DEA)
  ]),
))

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
      $w$, $L(w)$, $Q$,
      $epsilon$, $L(epsilon) = L$, tg($q_0$),
      $0$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "ungerade"}$, tr($q_1$),
      $1$, $L(0) = {w in Sigma^* mid(|) abs(w)_0 "gerade"}$, tg($q_0$),
      $dots.v$, $dots.v$, $dots.v$,
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
        transition: (curve: .5, label: (angle: 0deg)),
        q0-q2: (curve: -.5),
        q2-q3: (curve: -.5),
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
      labels: ("q1,2": [q#sub[1], q#sub[2]]),
      style: (
        transition: (curve: .75, label: (angle: 0deg)),
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
    #todo("finish")
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
        box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$) $1$]),
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
        box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$) $1$]),
      ),
    )
  + Pumpen: nur die Anzahl der $1$ wird erhöhr, Anzahl $1$ bleibt
  - $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für $k != 1$, im Widerspruch zum Pumping Lemma
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
    Ein NEA $A$ akzeptiert das Wort $w in Sigma^*$, wenn es eine *Wahl* von Übergängen gibt, derart, dass das Wort $w$ den Automaten in einen Akzeptierzustand überführt.

    _Faustregeln_

    - Nur genau diejenigen Pfeile einzeichnen, die man zum Akzeptieren braucht.
    - Erlaube Alternativen
  ],
)

#exbox(todo(""))

=== Umgang mit mehrdeutigen Übergängen

#grid(
  columns: 2,
  automaton(
    (q0: (q1: "b"), q1: (q1: "a", q2: ("a", "b")), q2: (q0: "a")),
    layout: finite.layout.circular,
    final: ("q0",),
    style: (
      q1-q2: (stroke: colors.red),
      q1-q1: (stroke: colors.red, anchor: top + right),
    ),
    labels: (
      q1-q2: [#tr("a")#text(fill: colors.fg, ",b")],
    ),
  ),
  [
    #tr([a-Übergang von $q_1$ aus nicht eindeutig])

    Welchen Übergang soll man nehmen?

    - Beide Möglichkeiten probieren und akzeptieren, falls eine der Möglichkeiten auf einen Akzeptierzustand führt.
  ],
)

=== Thompson-NEA

#todo("Thompson-NEA")

==== Transformation NEA $->$ DEA

#todo("")

Gegeben $delta: Q times Sigma -> P(Q)$ eines NEA. Übergangsfunktion für Mengen $M subset Q$
$
  delta' : P(Q) times Sigma -> P(Q): (M, a) |-> delta' (M, a) = limits(union)_(q in M) delta (q,a)
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

#todo("")

$epsilon-$Übergang

== Mengenoperationen

#todo("")

Lassen reguläre Sprachen regulär sein.

=== Produkt

Verändert nur Endzustände

=== Schnittmenge

Beide Automaten akzeptieren.

=== Vereinigung

=== Differenz
