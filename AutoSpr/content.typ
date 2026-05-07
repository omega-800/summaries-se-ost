#import "../lib.typ": *

#let content(cs) = [

  #let cnode = node.with(
    width: 1.5em,
    height: 1.5em,
    shape: fletcher.shapes.circle,
  )

  = Prädikate

  Prädikate sind Aussagen über mathematische Objekte, die wahr oder falsch sein
  können. "Funktionen" mit booleschen Rückgabewerten: $P, Q(n), R(x,y,z)$.

  #context shared.pred-rules
  #context shared.pred-rules-tbl

  == Normalformen

  Normalformen (allgemein, _kanonische Formen_) helfen, das Vergleichsproblem zu
  lösen (ob zwei Aussagen dieselben sind).

  $
    P_1 and ... and P_n = forall i in {1,...,n}(P_i) = limits(and.big)_(i=1)^n P_i
  $
  $
    P_1 or ... or P_n = exists i in {1,...,n}(P_i) = limits(or.big)_(i=1)^n P_i
  $

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

  Eine Folge von logischen Schlüssen, die zeigen, dass die Aussage aus den
  gegebenen Voraussetzungen folgt.

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

  #align(center, diagram(
    node-stroke: none,
    node((0, 1), [*Regulär*]),
    node((0, 2), tp[DEA\ NEA\ Regex]),
    node((1, 1), [*Kontextfrei*]),
    node((1, 2), tp[CFG\ PDA\ Palindrome\ #td[${0^n 1^n | n >= 0}$]]),
    node((2, 1), [*Turing-erkennbar*]),
    node((2, 2), tp[Primzahlen\ #td[${a^n b^n c^n | n >= 0}$]]),
    node((3.5, 1), [*Alle Sprachen $P(Sigma^*)$*]),
    node((3.5, 2), td[Überabzählbar unendlich]),
    node(
      enclose: ((0, 1), (0, 2)),
      stroke: black,
      corner-radius: 1em,
    ),
    node(
      enclose: ((0, 1), (0, 2), (1, 1), (1, 2)),
      stroke: black,
      corner-radius: 1em,
      inset: 1em,
    ),
    node(
      enclose: ((0, 1), (0, 2), (1, 1), (1, 2), (2, 1), (2, 2)),
      stroke: black,
      corner-radius: 1em,
      inset: 1.5em,
    ),
    node(
      enclose: (
        (0, 1),
        (0, 2),
        (1, 1),
        (1, 2),
        (2, 1),
        (2, 2),
        (3.5, 1),
        (3.5, 2),
      ),
      stroke: black,
      corner-radius: 1em,
      inset: 2em,
    ),
  ))

  #deftbl(
    [Alphabet],
    [Eine nichtleere endliche menge $Sigma$ heisst _Alphabet_. Die Elemente von
      $Sigma$ heissen _Zeichen_.],
    [Wort],
    [Eine Zeichenkette der Länge $n$ ist ein $n$-Tupel in
      $Sigma^n = Sigma times ... times Sigma$. Ein Element von $Sigma^n$ heisst
      _Wort_ der Länge $n$. Wörter haben immer endliche Länge.],
    [Leeres Wort],
    [Die Zeichenkette $epsilon in Sigma^0 = {epsilon}$ der Länge $0$ heisst das
      _leere Wort_.],
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
    [Sei $w in Sigma^n, a in Sigma$. Dann ist $abs(w)_a$ die _Anzahl Zeichen_
      $a$ im Wort $w$],
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
          ),
          q2: (stroke: colors.purple),
          q1: (stroke: colors.purple),
        ),
      )],
  )
  *Wichtig:*
  Ein Pfeil für jedes Zeichen in jedem Zustand für validen DEA

  == Wörter einer regulären Sprache

  === Übergangsfunktionen für Wörter

  $
    delta: Q times Sigma^* ->Q : (q, w = a_1, ..., a_n) |-> delta(... delta(delta(q, a_1), a_2), ..., a_n)
  $
  _Übergänge_ ausghend von $q$ für Zeichen $a_1, ..., a_n$ nacheinander
  anwenden.

  === Wort akzeptieren

  Der DEA $A = (Sigma, Q, q_0, delta, F)$ _akzeptiert_ das Wort $w in Sigma^*$,
  wenn er $A$ von Startzustand in einen Akzeptierzustand $delta(q_0, w) in F$
  überführt.

  === Akzeptierte Sprache, reguläre Sprache

  Gegeben ein DEA $A = (Sigma, Q, q_0, delta, F)$. Die von $A$ _akzeptierte
  Sprache_ ist
  $
    L(A) = {w in Sigma^* mid(|) A "akzeptiert" w} = {w in Sigma^* mid(|) delta(q_0, w) in F}
  $
  Die Sprache $L subset Sigma^*$ heisst _regulär_, wenn es einen DEA $A$ gibt
  mit
  $L(A) = L$

  #let aut = (
    g: (u: 1, g: (0, 2)),
    u: (u: (0, 2), g: 1),
  )
  #exbox(
    title: [DEA, der die Sprache
      $L = {w in Sigma^* mid(|) w "ist eine ungerade Zahl im Dreiersystem"}$
      akzeptiert],
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

  Für ein Wort $w in Sigma^*$ setze $L(w) = {w' in Sigma^* mid(|) w w'}$
  // $underbrace(
  //   L(w) = {w' in Sigma^* mid(|) w w'
  //     in L}, "Alle wörter" w' in L ", die nach einem Wort" w in L
  //   "folgen und ein neues Wort" w w' in L "formen"
  // )$.
  Insbesondere $L(epsilon) = L$

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
      [Ist $L$ eine reguläre Sprache, dann gibt es $N in NN$, die pumping length
        so, dass jedes Wort $w in L$ mit $abs(w) >= N$ in drei Teile
        $w = #tg($x$)#tr($y$)#td($z$)$ zerlegt werden kann mit:
      ],
    ),
    [
      + $abs(#tg($x$)#tr($y$)) <= N$
      + $abs(#tr($y$)) > 0$
      + $#tg($x$)#tr($y$)^k#td($z$) in L forall k in NN$

      Oder: genügend lange Wörter ($abs(w) >= N$) einer regulären Sprache
      ($w in L$) können alle in einem Anfangsstück der Länge N
      ($abs(#tg($x$)#tr($y$)) <= N$) aufgepumpt werden
      ($#tg($x$)#tr($y$)^k#td($z$) in L$).
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
    - $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für mindestens ein $k in NN$ (mit
      Begründung!)
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
            #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$)
              $1$])
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
            #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$)
              $1$])
            #place(dx: 10% - 0.25em, dy: -2.75em, [$N + abs(#tr($y$))$])
            #place(dx: 10%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
            #place(dx: 100% - 3.25em, dy: -2.75em, [$2N + abs(#tr($y$))$])
          ],
        ),
      )
    + Pumpen: nur die Anzahl der $1$ wird erhöht, Anzahl $1$ bleibt
    + $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für $k != 1$, im Widerspruch zum
      Pumping Lemma
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
      Ein NEA $A$ _akzeptiert_ das Wort $w in Sigma^*$, wenn es eine *Wahl* von
      Übergängen gibt, derart, dass das Wort $w$ den Automaten in einen
      Akzeptierzustand überführt.

      _Faustregeln_

      - Nur genau diejenigen Pfeile einzeichnen, die man zum Akzeptieren
        braucht.
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

      - Beide Möglichkeiten probieren und akzeptieren, falls eine der
        Möglichkeiten auf einen Akzeptierzustand führt.
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

  Gegeben $delta: Q times Sigma -> P(Q)$ eines NEA. Übergangsfunktion für Mengen
  $M subset Q$
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

  // FIXME: PR shiroa template-link.typ:10
  // yet another converter bug
  // === $"NEA"_epsilon$
  === $N E A_epsilon$

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

      + $E(q) =$ Menge der von $q$ aus mit $epsilon$-Übergängen erreichbaren
        Zustände
      + $E(M) = union.big_(q in M) E(q)$
      + $delta$ ersetzen durch
        $delta: Q times (Sigma inter {epsilon}) -> P(Q) : (q,a) |-> E(delta(q, a))$
    ],

    [$ L={0^k 1^l mid(|) k,l >=0} $
      #automaton(
        (
          q0: (q0: 0, q1: "e"),
          q1: (q1: 1),
        ),
      )],
  )

  == Mengenoperationen

  Lassen reguläre Sprachen regulär sein.

  Produktautomat: $L_i = L(A_i)$

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
  )

  #block(breakable: false, [
    $
      L = #block(inset: 5pt, fill: colors.darkblue.transparentize(80%), ${w in Sigma^* mid(|) abs(w)_1 "ungerade"}$) inter #block(inset: 5pt, fill: colors.red.transparentize(80%), ${w in Sigma^* mid(|) w "ist eine durch drei teilbare Binärzahl"}$)
    $
    #align(center, prod-aut(1))
  ])
  #let place-off = place.with(dx: 25pt, dy: 29pt)
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
  #grid(
    columns: 2,
    align: center,
    block(breakable: false)[
      Schnittmenge $L(A_1) inter L(A_2)$
      #poly
      #place-off(polygon(
        stroke: colors.fg + 2pt,
        (x4, y1),
        (x4, y2),
        (x3, y2),
        (x3, y1),
      ))
      #prod-aut(.5, e: ("q10",))
    ],
    block(breakable: false)[
      Vereinigungsmenge $L(A_1) union L(A_2)$
      #poly
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

    block(breakable: false)[
      Differenzmenge $L(A_1) without L(A_2)$
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
    block(breakable: false)[
      Symmetrische Differenz $L(A_1) triangle L(A_2)$
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
    canvas({
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

    canvas({
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

  $=>$ die Klasse der regulären Sprachen ist abgeschlossen unter regulären
  Operationen

  == Reguläre Ausdrücke

  Formeln, die Zeichenketten beschreiben.

  + Buchstaben stehen für sich selbst, mit Ausnahme der Metazeichen
    $( ) [ ] \* ? | . \\$ (escape character)
  + Verkettung: Zeichen und Formeln hintereinanderschreiben
  + $.$ = ein beliebiges Zeichen, $Sigma$
  + $|$: Alternative, $a|A$ = a oder A
  + $\*$: Wiederholung, beliebige viele
  + $( )$: Gruppierung
  + $[ ]$ Zeichenklassen: $[a b c] = a|b|c$, $[\^ a b c]$ = alles ausser a, b,
    oder c

  Erweiterungen / Dialekte

  + ${n,m}$: zwischen $n$ un $m$ Wiederholungen
  + $+$: mindestens eines, ${1,}$
  + $?$: optional, ${0,1}$
  + Symbole für Zeichenklassen: $\\ d$ Ziffern, $\\ s$ whitespace,
    $[:s p a c e:]$, $[:l o w e r:]$

  === Verallgemeinerter NEA (VNEA)

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
    [$"NEA"_epsilon$, dessen Übergänge mit regulären Ausdrücken beschriftet
      sind],
    [Primitive reguläre Ausdrücke],
    [
      Reguläre Ausdrücke für Wörter mit Länge $<= 1$
      #let saut = (..args) => automaton(..args.pos(), ..args.named(), style: (
        state: (stroke: colors.fg, radius: .3, extrude: .8),
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

  #align(center, canvas({
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

  Nach Entfernen aller Zwischenzustände $q_"rip" in Q$ bleibt ein regulärer
  Ausdruch $r$ von $A$

  #align(center, automaton(
    (
      S: (E: "r"),
      E: (),
    ),
  ))

  $=>$ jede reguläre Sprache lässt sich mit einem regulären Ausdruck beschreiben
  ${L(A) | A "ein DEA"} = {L(r)|r "ein regulärer Ausdruck"}$

  Interessantes projekt (DEA Lexer DSL): #link(
    "https://www.colm.net/open-source/ragel/",
    "Ragel",
  )

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

  == Kontextfreie Sprachen

  #deftbl(
    [CFL],
    [Context Free Language],
    [CFG],
    [Context Free Grammar],
    [PDA],
    [Pushdown Automata],
  )

  === Kontextfreie Grammatik und Sprache

  #grid(
    columns: 2,
    [_Kontextfreie Grammatik: $G = (V, Sigma, R, S)$_

      - $V$: Variablen
      - $Sigma$: Terminalsymbole (Alphabet)
      - $R$: Regeln der Form $A -> x_1 x_2 ... x_n$ mit
        $A in V, x_i in V union Sigma$
      - $S$: Startvariable

      _Ableitung und erzeugte Sprache_

      - Regel $A -> w$ erzeugt aus $u A v$ das Wort $u w v: u A v => u w v$
      - $v$ aus $u$ ableiten: $u => u_1 => u_2 => ... => u_n => v$ oder
        $u=>^* v$
      - $L(G) = {w in Sigma^* | S =>^* w}$ von $G$ erzeugte kontextfreie Sprache

      / Erzeugte Sprache: Die Menge der Wörter, die von einer kontextfreien
        Grammatik $G$ aus der Startvariablen abgeleitet werden können, wird mit
        $L(G)$ bezeichnet und heißt die von $G$ erzeugte Sprache.
      / Kontextfreie Sprache: Eine Sprache $L$ heißt kontextfrei, wenn es eine
        kontextfreie Grammatik gibt, die die Sprache $L = L(G)$ erzeugt.
    ],
    [
      _Parse Tree_

      $ L = {w in {0,1}^* | abs(w)_0 = abs(w)_1} $
      mit der Grammatik
      $ S -> 0 S 1 | 1 S 0 | S S | epsilon $

      #align(center, diagram(
        node-stroke: none,
        node((0, 4), $1$),
        node((1, 4), $0$),
        node((2, 4), $0$),
        node((3, 4), $1$),
        node((4, 4), $in L$),
        node(enclose: ((0, 4), (3, 4)), fill: colors-l.darkblue, inset: 0em),
        node((1.5, 0), $S$),
        edge("-|>"),
        edge((2.5, 1), "-|>"),
        node((0.5, 1), $S$),
        edge("-|>"),
        node((0.5, 2), $S$),
        edge("-|>"),
        node((0.5, 3), $epsilon$),
        node((2.5, 1), $S$),
        edge("-|>"),
        node((2.5, 2), $S$),
        edge("-|>"),
        node((2.5, 3), $epsilon$),

        edge((0.5, 1), (0, 4), "-|>", bend: -20deg),
        edge((0.5, 1), (1, 4), "-|>", bend: 20deg),
        edge((2.5, 1), (2, 4), "-|>", bend: -20deg),
        edge((2.5, 1), (3, 4), "-|>", bend: 20deg),
      ))
    ],
  )

  #exbox(title: $L = {0^n 1^n | n >= 0}$, grid(
    columns: (1fr, 1fr),
    [
      Grammatik $L = {0^n 1^n | n >= 0}$
      + Variablen: $V = {S}$
      + Terminalsymbole: $Sigma = {0,1}$
      + Regeln: $R = {S-> epsilon|#td($0$) S #tp($1$)}$
      + Startvariable: $S$
    ],
    [
      Wörter, die erzeugt werden müssen
      $
        epsilon \
        0 1 = #td($0$) epsilon #tp($1$) \
        0 0 1 1 = #td($0$) 0 1 #tp($1$)
      $
    ],
  ))

  Es ist nicht garantiert, dass es für die Ableitung eines Wortes nur einen
  einzigen Syntaxbaum gibt. Man sagt, die Grammatik ist _nicht eindeutig_, wenn
  sie mehrere Syntaxbäume für die gleichen Wörter erlaubt.

  === Reguläre Operationen

  Die Klasse der kontextfreien Sprachen ist abgeschlossen unter regulären
  Operationen.

  *Reguläre Sprachen sind kontextfrei*.

  ==== Grammatik für reguläre Operationen

  Seien $L_1$ und $L_2$ kontextfreie Sprachen mit Grammatiken
  $G_i = (V_i, Sigma,
    R_i, S_i)$. Wir nehmen an, dass die Variablen- und Regelmengen disjunkt
  sind, also $V_1 inter V_2 = emptyset and R_1 inter R_2 = emptyset$. Zudem sei
  $S_0$ eine Variable, die nicht in $V_1 union V_2$ enthalten ist. Dann gilt:

  _Alternative $L_1 | L_2$ ist kontextfrei mit der Grammatik_
  $
    G = (V_1 union V_2 union {S_0}, Sigma, R = R_1 union R_2 union {#tp($S_0 ->
        S_1 | S_2$)},S_0)
  $

  _Verkettung $L_1 L_2$ ist kontextfrei mit der Grammatik_
  $
    G = (V_1 union V_2 union {S_0}, Sigma, R = R_1 union R_2 union {#tp($S_0 -> S_1 S_2$)},S_0)
  $

  _\*-Operation $L^*_1$ ist kontextfrei mit der Grammatik_
  $
    G = (V_1 union {S_0}, Sigma, R= R_1 union {#tp($S_0 -> S_0 S_1$), #tp($S_0 -> epsilon$)},S_0)
  $

  === Kontextfrei

  ==== Regeln ohne Kontext

  #grid(
    columns: (2fr, 1fr),
    [Es spielt keine Rolle, in welchem Kontext das Zeichen $A$ vorkommt, die
      Regel kann immer angewendet werden
      $
        S -> a A b -> a a b
      $
    ],
    $
      S -> & A | C \
      A -> & a \
      A -> & a A b \
      C -> & b A \
    $,
  )

  ==== Regeln mit Kontext

  #grid(
    columns: (2fr, 1fr),
    [Je nach #tr[Kontext] kann eine Regel nicht unbedingt angewendet werden
      $
        S & -> a C && -> && A \
        S & -> b C && -> && B \
        S & -> C   && -> && #tr($?$)
      $
    ],
    $
               S -> & C | a C | b C \
      #tr($a$) C -> & A \
      #tr($b$) C -> & B \
    $,
  )

  === Chomsky-Normalform (CNF)

  Eine CFG ist in _Chomsky-Normalform_, wenn $S$ auf der rechten Seite nicht
  vorkommt und jede Regel von der Form $A -> B C$ oder $A -> a$ ist, zusätzlich
  ist die Regel $S -> epsilon$ erlaubt.

  ==== Umwandlung

  + Neue Startvariable $S_0 -> S$ (wenn nötig)
  + $epsilon$-Regeln: $cases(reverse: #true, A -> epsilon, B -> A C) => A$ kann
    weggelassen werden $=> cases(B &-> A C, &-> #comment($A$) C)$
  + Unit-Rules: $cases(reverse: #true, A -> B, B -> C D) =>$ aus $A$ kann man
    wie aus $B$ auch $C D$ machen $=> cases(A -> C D, B -> C D)$
  + Verkettungen: $A -> u_1 u_2 ... u_n$ ersetzen durch
    $A -> u_1 A_1, A_1 -> u_2 A_2, ..., A_(n-2) -> u_(n-1) u_n$ und falls $u_i$
    ein Terminalsymbol ist: $A_(i-1) -> U_i A_i, U_i -> u_i$.

  ==== Folgerungen

  + Ableitung eines Wortes $w in L(G)$ ist immer in $2 abs(w) - 1$
    Regelanwendungen möglich. Beweis:
    - $abs(w) - 1$ Regeln der Form $A -> B C$ um aus $S$ ein Wort aus $abs(w)$
      Variablen zu erzeugen
    - $abs(w)$ Regeln der Form $A -> a$ um das Wort $w$ zu erzeugen
    - $=>$ insgesamt $2 abs(w) - 1$ Regelanwendungen
  + Deterministischer Parse-Algorithmus mit Laufzeit $O(abs(w)^3)$

  #exbox(
    title: $
      S -> & A S A | a B \
      A -> & B | S \
      B -> & b | epsilon
    $,
    [
      + Startvariable
        $
          #tr($S_0 -> & S$) \
                       S -> & A S A | a B \
                       A -> & B | S \
                       B -> & b | epsilon
        $
      + $epsilon$-Regel #grid(
          align: center + horizon,
          columns: (1fr, auto, 1fr),
          $ S_0 -> & S \
            S -> & A S A | a B | #tr($a$) \
            A -> & B | #tr($epsilon$) | S \
            B -> & b $,
          $~>$,
          $ S_0 -> & S \
            S -> & A S A | #tr($S A$) | #tr($A S$) | a B | a \
            A -> & B | S \
            B -> & b $,
        )
      + Unit-Regel #grid(
          align: center + horizon,
          columns: (1fr, auto, 1fr),
          $ S_0 -> & #tr($A S A$) | #tr($S A$) | #tr($A S$) | #tr($a B$) | #tr($a$) \
            S -> & A S A | S A | A S | a B | a \
            A -> & B | #tr($A S A$) | #tr($S A$) | #tr($A S$) | #tr($a B$) | #tr($a$) \
            B -> & b $,
          $~>$,
          $ S_0 -> & A S A | S A | A S | a B | a \
            S -> & A S A | S A | A S | a B | a \
            A -> & #tr($b$) | A S A | S A | A S | a B | a \
            B -> & b $,
        )
      + Komplexe Regeln
        $
                       S_0 -> & #tr($A A_1$) | S A | A S | #tr($U B$) | a \
                         S -> & #tr($A A_1$) | S A | A S | #tr($U B$) | a \
                         A -> & b | #tr($A A_1$) | S A | A S | #tr($U B$) | a \
          #tr($A_1 -> & S A$) \
              #tr($U -> & a$) \
                         B -> & b
        $
    ],
  )

  = Parsing

  == Cocke-Younger-Kasami Algorithmus (CYK)

  _Gegeben_

  + Grammatik G = $(V, Sigma, R, S)$
  + Variable $A in V$
  + Wort $w in Sigma^*$

  _Frage_

  Ist $w$ ableitbar? Formell geschrieben: $A =>^* w$
  - Spezialfall #h(1fr)
    $w = epsilon: #h(1em) A =>^* epsilon #h(1em) <=> #h(1em) A -> epsilon in R$
    #h(1em) (Epsilonregel, $A = S$) #h(15em)
  - Spezialfall #h(1fr)
    $abs(w) = 1: #h(1em) A =>^* w #h(1em) <=> #h(1em) A -> w in R$ #h(1em)
    (Terminalsymbolregel) #h(14em)
  - Fall $abs(w) > 1:$
    $
      A =>^* w #h(1em) => #h(1em) exists cases(A -> B C &in R, w = w_1 w_2 #h(1em) &w_i in Sigma^*) #h(1em) "mit" #h(1em) cases(B =>^* w_1, C=>^* w_2)
    $

  === Ableitungsdreieck

  #grid(
    columns: (1fr, 1fr),
    [
      _Ideen_

      - Parse Tree aus #tr($A -> B C$) und #tp($T -> t$)
      - Variablen in Tabelle füllen

      _Prinzip_

      - Einem Teilwort entspricht ein Feld der Tabelle (rot hinterlegt)
      - Das Feld wird mit den Variablen gefüllt, aus denen das Teilwort
        abgeleitet werden kann.

      _Beispiel_

      Parsen des Wortes `()[()]`
      #grid(
        columns: (1fr, 1fr),
        $
          S & -> && #tr($A B$) | #tr($C D$) | #tr($C U$) | #tr($S S$) \
          U & -> && #tr($S D$) \
          A & -> && #tp($($) \
        $,
        $
          B & -> && #tp($)$) \
          C & -> && #tp($[$) \
          D & -> && #tp($]$) \
        $,
      )

      _Definitionen_

      Die Felder $(k, l_1)$ und $(k + l_1, l −l_1)$ heissen _korrespondierende
      Felder_ im Ableitungsdreieck des Feldes $(k, l)$.
    ],
    {
      let node = node.with(width: 3em, height: 3em, stroke: none)
      let nd = node.with(width: 1em, height: 1em)
      let sq = nd
      let sqo = node.with(stroke: colors.fg)
      let sqg = node.with(stroke: colors.fg, fill: colors.comment, layer: -1)
      align(center, diagram(
        spacing: (0pt, 0pt),
        sq((0, 0), "S", name: <s1>),
        sqo((0, 0)),

        sqg((0, 1), " "),
        sqg((1, 1), " "),

        sqg((0, 2), " "),
        sqg((1, 2), " "),
        sq((2, 2), "S", name: <s2>),
        sqo((2, 2)),

        sqg((0, 3), " "),
        sqg((1, 3), " "),
        sqg((2, 3), " "),
        sq((3, 3), "U", name: <u>),
        sqo((3, 3)),

        sq((0, 4), "S", name: <s3>),
        sqo((0, 4)),
        sqg((1, 4), " "),
        sqg((2, 4), " "),
        sq((3, 4), "S", name: <s4>),
        sqo((3, 4)),
        sqg((4, 4), " "),

        edge(<s1>, <s2>, "->", stroke: colors.red),
        edge(<s1>, <s3>, "->", stroke: colors.red),

        edge(<s2>, <c>, "->", stroke: colors.red),
        edge(<s2>, <u>, "->", stroke: colors.red),

        edge(<u>, <s4>, "->", stroke: colors.red),
        edge(<u>, <d>, "->", stroke: colors.red),

        edge(<s4>, <a2>, "->", stroke: colors.red),
        edge(<s4>, <b2>, "->", stroke: colors.red),

        edge(<s3>, <a1>, "->", stroke: colors.red),
        edge(<s3>, <b1>, "->", stroke: colors.red),

        sqo((0, 5)),
        sq((0, 5), "A", name: <a1>),
        edge(<a1>, <o1>, "->", stroke: colors.purple),
        nd((0, 6), "(", name: <o1>),
        node((0, 6)),

        sqo((1, 5)),
        sq((1, 5), "B", name: <b1>),
        edge(<b1>, <c1>, "->", stroke: colors.purple),
        nd((1, 6), ")", name: <c1>),
        node((1, 6)),

        sqo((2, 5)),
        sq((2, 5), "C", name: <c>),
        edge(<c>, <os>, "->", stroke: colors.purple),
        nd((2, 6), "[", name: <os>),
        node((2, 6)),

        sqo((3, 5)),
        sq((3, 5), "A", name: <a2>),
        edge(<a2>, <o2>, "->", stroke: colors.purple),
        nd((3, 6), "(", name: <o2>),
        node((3, 6)),

        sqo((4, 5)),
        sq((4, 5), "B", name: <b2>),
        edge(<b2>, <c2>, "->", stroke: colors.purple),
        nd((4, 6), ")", name: <c2>),
        node((4, 6)),

        sqo((5, 5)),
        sq((5, 5), "D", name: <d>),
        edge(<d>, <cs>, "->", stroke: colors.purple),
        nd((5, 6), "]", name: <cs>),
        node((5, 6)),

        nd((-1, 5), "1"),
        nd((-1, 4), "2"),
        nd((-1, 3), "3"),
        nd((-1, 2), "4"),
        nd((-1, 1), "5"),
        nd((-1, 0), "6"),
        nd((0, -1), "1"),
        nd((1, -1), "2"),
        nd((2, -1), "3"),
        nd((3, -1), "4"),
        nd((4, -1), "5"),
        nd((5, -1), "6"),

        node(enclose: (<o1>, <cs>), shape: fletcher.shapes.brace.with(
          label: $w$,
        )),
        node(
          enclose: ((-1, 0), (-1, 5)),
          shape: fletcher.shapes.stretched-glyph.with(
            glyph: $arrow.t$,
            label: $l$,
            dir: left,
          ),
        ),
        node(
          enclose: ((0, -1), (5, -1)),
          shape: fletcher.shapes.stretched-glyph.with(
            glyph: $arrow$,
            label: $k$,
            dir: top,
          ),
        ),
      ))
    },
  )

  #todo[rekursion vs iteration (buch 149)]

  == Backus-Naur-Form (BNF)

  Spezifikation der Regeln in maschinen-lesbarer Form:

  - Variablen: ```bnf <variablen-name>```
  - Einzelne Zeichen: ```bnf A```
  - Zeichenketten: ```bnf 'BEISPIEL'```
  - Regeln: ```bnf <variablen-name> ::= Ausdruck```
  - Ausdrücke sind Folgen von Variablen, einzelnen Zeichen oder Zeichenketten,
    getrennt durch `|`

  #exbox(title: [BNF für Expression-Term-Factor Grammatik], [
    _Ausgangsgrammatik_

    $
      "expression" & -> "expression" + "term" | "term" \
            "term" & -> "term" * "factor" | "factor" \
          "factor" & -> ( "expression" ) | N \
                 N & -> N Z | Z \
                 Z & -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
    $

    _Backus-Naur-Form_

    ```bnf
    <expression>  ::= <expression> + <term> | <term>
    <term>        ::= <term> * <factor> | <factor>
    <factor>      ::= ( <expression> ) | <number>
    <number>      ::= <number> <digit> | <digit>
    <digit>       ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
    ```
  ])

  == Extended Backus-Naur-Form (EBNF)

  #table(
    columns: (1fr, auto),
    [Definition], [Achtung!],
    [
      - Literale in Anführungszeichen oder Apostroph
      - `=` statt `::=`
      - Variablen ohne `<` und `>`, dürfen Leerzeichen enthalten
      - Komma für Verkettung `,`
      - Regel-Endzeichen `;`
      - Kommentare `(* ... *)`
      - Optionale Wiederholung `{...}`
      - Option `[...]`
      - Gruppierung `(...)`
      - Ausnahme: `-`
    ],
    [
      - Keine Operatorpriorisierung
      - Zweideutig!
      - Keine eindeutige Evaluation!
    ],
  )

  #exbox(title: [EBNF für Expression-Term-Factor Grammatik], [
    // TODO: proper ebnf syntax highlight
    ```ebnf
    expression  = expression, "+", term | term ;
    term        = term, "*", factor, | factor ;
    factor      = "(", expression, ")" | number ;
    number      = digit, { digit } ;
    digit       = "0" | "1" | "2" | "3" | "4" |
                  "5" | "6" | "7" | "8" | "9" ;
    ```
  ])

  == Rechtsrekursion

  Expression-Term-Factor-Grammatik verwendet Links-Rekursion $=>$ korrekte
  Auswertung von links nach rechts. Parsetree wertet aber Ausdrücke von rechts
  nach links aus! Alternative Expression-Term-Factor definition mit
  Rechtsrekursion statt Linksrekursion:

  $
     "expression" & -> "term" "expression"' \
    "expression"' & -> + "term" "expression"' | epsilon \
           "term" & -> "factor" "term"' \
          "term"' & -> * "factor" "term"' | epsilon \
         "factor" & -> ( "expression" ) | N \
                N & -> N Z | Z \
                Z & -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  $


  #todo[grid $->$ table]

  = Stack

  Unendlich grosser Speicher

  - Immer nur das oberste Element sichtbar
  - Beliebig tief

  == Stackautomat / Pushdown Automaton (PDA)

  Kann Sprachen akzeptieren, die nicht regulär sind, ist aber nicht
  deterministisch. *Beachte*: $Gamma != Sigma$ möglich

  #grid(
    columns: (1fr, 1fr),
    align: horizon,
    [
      _Definition_

      Stackautomat $P = (Q, Sigma, Gamma, delta, q_0, F)$

      + $Q$: Zustände
      + $Sigma$: Eingabe-Alphabet
      + $Gamma$: Stack-Alphabet
      + $delta$:
        $Q times Sigma_epsilon times Gamma_epsilon -> P(Q times Gamma_epsilon)$
      + $q_0 in Q$: Startzustand
      + $F subset Q$: Akzeptierzustände
    ],
    [
      _Übergänge_

      #diagram(
        node((0, 0), $p$, shape: fletcher.shapes.circle),
        edge(label: $#tr($a$), #tg($b$) -> #td($c$)$, label-side: left, "-|>"),
        node((6, 0), $q$, shape: fletcher.shapes.circle),
      )

      #tr($a$) vom Input

      #tg($b$) vom Stack entfernen (Bedingung)

      #td($c$) auf den Stack
    ],
  )

  #exbox(title: [Stackautomat für die Sprache ${0^n 1^n | n >= 0}$], align(
    center,
    automaton(
      (
        q0: (q1: "1"),
        q1: (q2: "2", q1: "22"),
        q2: (q3: "3", q2: "33"),
      ),
      final: "q3",
      layout: (
        q0: (0, 2),
        q1: (4, 2),
        q2: (4, 0),
        q3: (0, 0),
      ),
      style: (
        q0-q1: (label: $epsilon, epsilon -> \$$),
        q1-q1: (label: pad(left: 2.5em, $0,epsilon -> 0$), anchor: right),
        q1-q2: (label: pad(left: 6em, $epsilon, epsilon -> epsilon$)),
        q2-q2: (label: pad(left: 2.5em, $1,0 -> epsilon$), anchor: right),
        q2-q3: (label: $epsilon, \$ -> epsilon$, curve: 0),
      ),
    ),
  ))

  #todo[Book 167-168, shift/reduce]

  #todo[diagrams? (slides 8/12)]

  === Ableitung aus CNF

  Ist $L$ eine kontextfreie Sprache, dann gibt es einen Stackautomaten $P$, der
  $L$ akzeptiert, $L = L(P)$.

  _Grundgerüst_

  #align(center, automaton(
    (
      q0: (S: "1"),
      S: (R: "2"),
      R: (A: "3"),
    ),
    final: "A",
    style: (
      R-A: (curve: 0, label: $epsilon, \$ -> epsilon$),
      S-R: (curve: 0, label: $epsilon, epsilon -> S$),
      q0-S: (curve: 0, label: $epsilon, epsilon -> \$$),
    ),
    layout: (
      q0: (0, 0),
      S: (4, 0),
      R: (8, 0),
      A: (12, 0),
    ),
  ))

  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: horizon,
    table-header(
      [Regel $A -> B C$],
      [Regel $A -> a$],
      [Regel $S -> epsilon$],
      [$forall a in Sigma$],
    ),
    diagram(
      node((0, 0), $R$, shape: fletcher.shapes.circle, name: <r>),
      edge(
        <r>,
        <e>,
        label: $epsilon, A -> C$,
        bend: 20deg,
        "-|>",
        label-side: left,
      ),
      edge(
        <e>,
        <r>,
        label: $epsilon, epsilon -> B$,
        bend: 20deg,
        "-|>",
        label-side: left,
      ),
      node((6, 0), $$, shape: fletcher.shapes.circle, name: <e>),
    ),
    diagram(
      node((0, 0), $R$, shape: fletcher.shapes.circle, name: <r>),
      edge(
        (0, 0),
        label: $epsilon, A -> a$,
        "-|>",
        loop-angle: 0deg,
        bend: 125deg,
        label-side: left,
      ),
    ),
    diagram(
      node((0, 0), $R$, shape: fletcher.shapes.circle, name: <r>),
      edge(
        (0, 0),
        label: $epsilon, S -> epsilon$,
        "-|>",
        loop-angle: 0deg,
        bend: 125deg,
        label-side: left,
      ),
    ),

    diagram(
      node((0, 0), $R$, shape: fletcher.shapes.circle, name: <r>),
      edge(
        (0, 0),
        label: $a,a->epsilon$,
        "-|>",
        loop-angle: 0deg,
        bend: 125deg,
        label-side: left,
      ),
    ),
  )

  === PDA $->$ CFG

  _Variablen_

  Wörter beschreiben Pfade durch den Automaten: Variable $A_(p q) =$ Wörter, die
  von $p$ nach $q$ führen mit leerem Stack

  _Regeln_

  Regeln beschreiben, wie sich Wege zerlegen lassen:
  $A_(p q) -> A_(p r) A_(r q) =$
  Wege von $p$ nach $q$ können verstanden werden als Wege von $p$ nach $r$ und
  von dort nach $q$

  ==== Stackautomat standardisieren

  #todo[better diagrams, book 181]
  + Nur ein Akzeptierzustand: Neuen Akzeptierzustand #tr[$q_a$] und Übergänge
    von allen vorherigen Endzuständen zu #tr[$q_a$] erstellen.
    #grid(
      columns: 2,
      align: horizon,
      $ forall q in F: $,
      automaton(
        (
          q: (qa: ""),
          qa: (),
        ),
        final: ("q", "qa"),
        style: (
          qa: (label: $q_a$, stroke: colors.red),
          q-qa: (stroke: colors.red),
        ),
        layout: (q: (0, 0), qa: (3, 0)),
      ),
    )
  + Stack leeren: Mit einem Element $\$$ erweitern, sodass garantiert werden
    kann, dass der Stack am schluss leer ist. #grid(
      columns: 3,
      align: bottom,
      automaton(
        (q0p: (q0: ""), q0: ()),
        final: (),
        style: (
          q0p: (label: $q'_0$, stroke: colors.red),
          q0p-q0: (label: tr[$epsilon, epsilon -> \$$]),
        ),
        layout: (q0p: (0, 0), q0: (3, 0)),
      ),
      align(horizon, $...$),
      automaton(
        (qa: (qap: "", qa: ""), qap: ()),
        initial: (),
        final: ("qa", "qap"),
        style: (
          qap: (label: $q'_a$, stroke: colors.red),
          qa-qap: (label: tr[$epsilon, \$ -> epsilon$], stroke: colors.red),
          qa: (label: $q_a$),
          qa-qa: (stroke: colors.red, label: tr[$epsilon, . -> epsilon$]),
        ),
        layout: (qa: (0, 0), qap: (3, 0)),
      ),
    )
  + Jeder Übergang legt entweder ein Zeichen auf den Stack oder entfernt eines
    #grid(
      columns: 3,
      align: bottom,
      automaton(
        (
          p: (q: ""),
          q: (),
        ),
        initial: (),
        final: (),
        style: (p-q: (label: $a,b->c$)),
        layout: (p: (0, 0), q: (3, 0)),
      ),
      align(horizon, $~>$),
      automaton(
        (
          p: (r: ""),
          r: (q: ""),
          q: (),
        ),
        initial: (),
        final: (),
        style: (
          r: (stroke: colors.red),
          p-r: (stroke: colors.red, label: tr[$a,b->epsilon$]),
          r-q: (stroke: colors.red, label: tr[$epsilon,epsilon->c$]),
        ),
        layout: (p: (0, 0), r: (3, 0), q: (6, 0)),
      ),
    ) #grid(
      columns: 3,
      align: bottom,
      automaton(
        (
          p: (q: ""),
          q: (),
        ),
        initial: (),
        final: (),
        style: (p-q: (label: $a,epsilon->epsilon$)),
        layout: (p: (0, 0), q: (3, 0)),
      ),
      align(horizon, $~>$),
      automaton(
        (
          p: (r: ""),
          r: (q: ""),
          q: (),
        ),
        initial: (),
        final: (),
        style: (
          r: (stroke: colors.red),
          p-r: (stroke: colors.red, label: tr[$a,epsilon->t$]),
          r-q: (stroke: colors.red, label: tr[$epsilon,t->epsilon$]),
        ),
        layout: (p: (0, 0), r: (3, 0), q: (6, 0)),
      ),
    )

  #todo[Book 182,183]
  #exbox(todo[visualization])

  ===== Grammatik ablesen

  Ausgangspunkt: standardisierter PDA mit Startzustand $q_0$ und $F = {q_a}$.

  + Startvariable: $A_(q_0, q_a)$
  + Regeln: #{
      let automaton = automaton.with(initial: (), final: ())
      grid(
        columns: (1fr, 2fr, 2fr),
        align: center + horizon,
        automaton((p: (p: "")), style: (p-p: (label: $A_(p p)$))),
        automaton(
          (p: (r: "", q: ""), r: (s: ""), s: (q: ""), q: ()),
          layout: (p: (0, 3), r: (3, 3), q: (0, 0), s: (3, 0)),
          style: (
            p-r: (label: $a,epsilon->t$),
            r-s: (label: $A_(r s)$),
            s-q: (label: $b,t -> epsilon$),
            p-q: (label: $A_(p q)$),
          ),
        ),
        automaton(
          (p: (r: "", q: ""), r: (q: ""), q: ()),
          layout: (p: (0, 2), r: (2, 0), q: (4, 2)),
          style: (
            p-q: (label: $A_(p q)$),
            p-r: (label: $A_(p r)$),
            r-q: (label: $A_(r q)$),
          ),
        ),

        $A_(p p) -> epsilon$,
        $A_(p q) -> a A_(r s) b$,
        $A_(p p) -> A_(p q) -> A_(p r) A_(r q)$,
      )
    }

  #exbox(todo[])

  = Nicht kontextfreie Sprachen

  == Pumping Lemma

  #{
    let v = tr($v$)
    let y = tr($y$)
    let x = tg($x$)
    let u = td($u$)
    let z = td($z$)
    [
      _Pumping Lemma für CFL_

      Ist $L$ eine CFL, dann gibt es eine Zahl $N$, die Pumping Length, derart,
      dass jedes Wort $w in L$ mit $abs(w) >= N$ zerlegt werden kann in fünf
      Teile $w = #u #v #x #y #z$ derart, dass
      + $abs(#v #y) > 0$
      + $abs(#v #x #y) <= N$
      + $#u #v^k #x #y^k #z in L forall k in NN$
      Mit dem Pumping Lemma kann man beweisen, dass eine Sprache *nicht*
      kontextfrei ist.
    ]

    exbox(title: ${a^n b^n c^n | n >= 0}$, [
      + Annahme: $L$ kontextfrei
      + Pumping length $N$
      + Wort: $w = a^N b^N c^N$
      + Zerlegungen: #pad(bottom: 1.25em, top: 1em, block(
          width: 95%,
          stroke: colors.black,
          fill: colors.white,
          inset: 4pt,
          grid(
            columns: (2fr, .5fr, 1.5fr, 1fr, 4fr),
            align: center,
            gutter: 4pt,
            [
              #box(width: 100%, inset: 4pt, stroke: colors.darkblue, td($u$))

              #place(dx: 50% + 0.75em, dy: -2.75em, $a^N$)
            ],
            box(width: 100%, inset: 4pt, stroke: colors.red, tr($v$)),
            [
              #box(width: 100%, inset: 4pt, stroke: colors.green, tg($x$))
              #place(dx: 0% + 0.75em, dy: -2.75em, $N$)
              #place(dx: 0%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
              #place(dx: 1em, dy: 1em, $ stretch(<->, size: #13em)_(<=N) $)
            ],
            [
              #box(width: 100%, inset: 4pt, stroke: colors.red, tr($y$))

              #place(dx: 0% + 0.75em, dy: -2.75em, $b^N$)
            ],
            [
              #box(width: 100%, inset: 4pt, stroke: colors.darkblue, td($z$))

              #place(dx: 55% + 0.75em, dy: -2.75em, $c^N$)
              #place(dx: 15% + 0.5em, dy: -2.75em, $2N$)
              #place(dx: 15%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
              #place(dx: 100%, dy: -2.75em, $3N$)
            ],
          ),
        ))

      + Beim Pumpen nimmt die Anzahl der $a$ und $b$ zu, nicht aber die Anzahl
        der $c$\ $=> #u #v^k #x #y^k #z in.not L forall k eq.not 1$
      + Widerspruch: $L$ nicht kontextfrei
    ])

    [
      ==== Herleitung

      _Grammatik $G$ in CNF_

      $ w in L(G) => S =>^* w $

      _Wiederverwendete Variable_

      $abs(w) >= N$ gross genug $=>$ Variablen werden im Parse Tree
      wiederverwendet Die "unterste" wiederverwendete Variable $A$ erzeugt zwei
      Wörter:
      $
        & A =>^* #v #x #y \
        & A =>^* #x \
      $

      _Pumpen_

      $A =>^* #v #x #y$ anstelle des "untersten" $A =>^* #x$ verwenden

      #todo[diagram]
    ]
  }

  = Unendlich

  #deftbl(
    [Endlich],
    [Eine Menge $A$ heisst _endlich_, wenn jede Injektion $A -> A$ auch eine
      Bijektion ist],
    [Abzählbar unendlich],
    [Eine Menge $A$ heisst _abzählbar unendlich_, wenn es eine Bijektion
      $NN -> A$ gibt, also $A tilde.eq NN$. Bsp: $RR, ZZ, QQ, Sigma^*$, Menge
      aller DEAs/NEAs/PDAs/CFGs],
    [Überabzählbar unendlich],
    [Eine Menge $A$ heisst _überabzählbar unendlich_, wenn sie nicht abzählbar
      unendlich ist. Bsp: $CC, P(NN)$, Menge aller Sprachen $P(Sigma^*)$],
    [Gleich mächtig],
    [Mengen $A$ und $B$ heissen _gleich mächtig_, $A tilde.eq B$, wenn es eine
      Bijektion $A -> B$ gibt],
    [Unendlich],
    [Eine Menge $A$ heisst _unendlich_, wenn sie gleich mächtig wie eine
      Teilmenge ist],
  )

  $A, B, A_k$ abzählbar unendlich, $k in NN$:

  + $A union B, union.big_k A_k$ abzählbar unendlich
  + $A times B$ abzählbar unendlich
  + Abzählbar unendlich: $NN, ZZ, QQ$
  + $P(A)$ überabzählbar unendlich
  + $RR$ überabzählbar unendlich

  = Turing-Maschine (TM)

  Merhere Stacks (Speicherzellen) = RAM (Band).

  Jeder DEA oder NEA kann damit emuliert werden.

  + Der Speicher ist unbegrenzt
  + In jeder Zelle genau ein Zeichen
  + Es ist immer nur eine Speicherzelle einsehbar
  + Der Inhalt der aktuellen Zelle kann beliebig verändert werden
  + Bewegung immer nur eine Zelle nach links oder rechts
  + Kein weiterer Speicher (nur die Zustände eines endlichen Automaten und das
    eine Zeichen)

  #deftbl(
    [Record],
    [Speichereinheit fester grösse],
    [Bandalphabet],
    [Alphabet $Gamma$, welches aus Speicherzellen (Stacks) besteht],
    [Schreib-/Lesekopf],
    [Aktuelle Schreib-/Leseposition],
  )

  #let a = tr[$a$]
  #let b = td[$b$]
  #let L = tg[$L$]
  #let R = tg[$R$]
  #let p = ty[$p$]
  #let q = ty[$q$]
  #grid(
    columns: 2,
    emph[Definition],

    emph[Zustandsdiagramm],
    grid.cell(rowspan: 3)[
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
    [
      #align(horizon, stack(
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
      ))
    ],
    emph[Übergänge],
    [
      - Übergang möglich, wenn #a unter dem Schreib- / Lese-Kopf
      - Aktuelles Feld auf dem Band wird mit #b überschrieben
      - Kopfbewegung: #L links, #R rechts
    ],
  )

  == Arbeitsweise

  _Programmablauf_

  - Input-Wort $w$ auf Band
  - Schreib- / Lesekopf positioniert auf 1. Zeichen
  - Maschine starten, $t(w)$ Einzelschritte ausführen
  - Maschine hält in $q_"accept"$ oder $q_"reject"$: Wort $w$ akzeptiert /
    Verworfen
  Laufzeit: $t(w), t(n) = max {t(w) mid(|) abs(w) <= n}$

  #let qnode = node.with(width: 2em, height: 2em)
  #let tmd = s => align(center, diagram(
    spacing: (0em, 1em),

    edge((-.5, 0), <q0>, "-|>"),

    cnode((1, 0), $ q_0 $, name: <q0>),
    cnode(
      (2.5, 0),
      if s { ty[$ p $] } else { $ p $ },
      name: <p>,
      stroke: if s { colors.yellow } else { colors.fg },
    ),
    cnode(
      (4, 1),
      if s { $ q $ } else { ty[$ q $] },
      name: <q>,
      stroke: if s { colors.fg } else { colors.yellow },
    ),
    edge(
      <p>,
      <q>,
      "-|>",
      stroke: colors.yellow,
      label: $#a -> #b, #R$,
      label-side: right,
    ),

    node(enclose: (<q0>, <p>, <q>), name: <e>),

    edge(
      <e>,
      if s { <a> } else { <b> },
      "-|>",
      bend: if s { 40deg } else { 30deg },
      shift: .1,
    ),

    qnode((0, 2), $ bracket.b $),
    qnode(
      (-.75, 2),
      " ",
      fill: colors.bg,
      stroke: none,
      height: 3em,
      width: 1em,
    ),
    qnode((1, 2), $ 0 $),
    qnode((2, 2), $ 1 $),
    qnode((3, 2), $ 1 $),
    qnode((4, 2), $ 0 $),
    qnode((5, 2), $ #if s { a } else { b } $, name: <a>),
    qnode((6, 2), $ 1 $, name: <b>),
    qnode((7, 2), $ 0 $),
    qnode((8, 2), $ bracket.b $),
    qnode(
      (8.75, 2),
      " ",
      fill: colors.bg,
      stroke: none,
      height: 3em,
      width: 1em,
    ),
  ))

  #table(
    columns: (1fr, 1fr),
    table-header([Vorher], [Nachher]), tmd(true),
    tmd(false),
  )

  #block(breakable: false, exbox(title: ${0^n 1^n | n >= 0}$, [
    #let edge = edge.with(
      marks: "-|>",
      crossing-fill: colors.darkblue.lighten(95%),
      label-side: left,
    )
    #let cedge = edge.with(bend: 135deg, loop-angle: 270deg)
    #align(center, diagram(
      spacing: (12em, 4em),
      node(
        (0, 0),
        width: 3.5em,
        height: 2.5em,
        shape: fletcher.shapes.ellipse,
        name: <qa>,
      ),
      node(
        (2, 0),
        width: 3.5em,
        height: 2.5em,
        shape: fletcher.shapes.ellipse,
        name: <qr>,
      ),
      node(
        (0, 0),
        $ q_"accept" $,
        width: 3em,
        height: 2em,
        shape: fletcher.shapes.ellipse,
      ),
      node(
        (2, 0),
        $ q_"reject" $,
        width: 3em,
        height: 2em,
        shape: fletcher.shapes.ellipse,
      ),
      cnode((0, 1), name: <q0>, $ q_0 $),
      cnode((1, 1), name: <q1>, $ q_1 $),
      cnode((2, 1), name: <q2>, $ q_2 $),
      cnode((1, 2), name: <q3>, $ q_3 $),

      cedge(<q0>, <q0>, label: $x->x,R$),
      edge(<q0>, <q1>, label: $0->x,R$),
      edge(<q0>, <qa>, label: $bracket.b->bracket.b,R$),
      edge(<q0>, <qr>, label: $1->1,R$, bend: 30deg),

      cedge(<q1>, <q1>, label: $x->x,R\ 0->0,R$, loop-angle: 90deg),
      edge(<q1>, <q2>, label: $1->x,R$),
      edge(<q1>, <qr>, label: $bracket.b->bracket.b,R$),

      cedge(<q2>, <q2>, label: $1->1,R$),
      edge(<q2>, <q3>, label: $bracket.b->bracket.b,L$),
      edge(<q2>, <qr>, label: $0->0,R\ x->x,R$, label-side: right),

      edge(<q3>, <q0>, label: $bracket.b->bracket.b,R$),
      cedge(<q3>, <q3>, label: $x->x,L\ 0->0,L\ 1->1,L$),
    ))
  ]))


  == Protokollierung

  Der Gang der Berechnung mit einer TM kann dokumentiert werden, indem der
  Bandinhalt nach jedem einzelnen Verarbeitungsschritt protokolliert wird.

  #table(
    columns: (1fr, 1fr),
    table-header([Links], [Rechts]),
    grid(
      columns: 2,
      align: center + horizon,
      diagram(
        spacing: (0em, 4em),
        cnode((0, 0), tr[$p$]),
        edge("-|>", label: $#a -> #b, #L$, label-side: right),
        cnode((0, 1), tr[$q$]),
      ),
      grid(
        gutter: .5em,
        align: center + horizon,
        columns: 8,
        $ ... $,
        $ a_1 $,
        $ a_2 $,
        tr[$ p $],
        td[$ a $],
        $ a_4 $,
        $ a_5 $,
        $ ... $,

        $ ... $,
        $ a_1 $,
        tr[$ q $],
        $ a_2 $,
        td[$ b $],
        $ a_4 $,
        $ a_5 $,
        $ ... $,
      ),
    ),

    grid(
      columns: 2,
      align: center + horizon,
      diagram(
        spacing: (0em, 4em),
        cnode((0, 0), tr[$p$]),
        edge("-|>", label: $#a -> #b, #R$, label-side: right),
        cnode((0, 1), tr[$q$]),
      ),
      grid(
        gutter: .5em,
        align: center + horizon,
        columns: 8,
        $ ... $,
        $ a_1 $,
        $ a_2 $,
        tr[$ p $],
        td[$ a $],
        $ a_4 $,
        $ a_5 $,
        $ ... $,

        $ ... $,
        $ a_1 $,
        $ a_2 $,
        td[$ b $],
        tr[$ q $],
        $ a_4 $,
        $ a_5 $,
        $ ... $,
      ),
    ),
  )


  #{
    let q0 = tr[$q_0$]
    let q1 = tr[$q_1$]
    let q2 = tr[$q_2$]
    let q3 = tr[$q_3$]
    let qa = tr[$q_"accept"$]
    let pf = colors-l.purple.lighten(60%)
    let tmpex = s => {
      let bpb = box.with(
        outset: 1pt,
        width: 50%,
        height: 100%,
        fill: pf,
      )
      let ub = (a, b, f: false, e: false) => if s {
        (bpb($ underbrace(#a, #b) $),)
      } else {
        (
          $ #b $,
          {
            [
              #if not e {
                if not f {
                  place(
                    dx: -1em,
                    dy: 1em,
                    rotate(80deg, rect(
                      width: 1em,
                      height: 4em,
                      fill: pf,
                    )),
                  )
                } else {
                  place(
                    dx: -4em,
                    dy: 1em,
                    rotate(-80deg, rect(
                      width: 1em,
                      height: 4em,
                      fill: pf,
                    )),
                  )
                }
              }
              #bpb($ #a $)
            ]
          },
        )
      }
      grid(
        align: if s { center } else { center + horizon },
        row-gutter: 1pt,
        columns: range(if s { 6 } else { 7 }).map(_ => 2em),
        rows: 2em,
        bpb($ bracket.b $), ..ub($0$, q0), bpb($ 0 $), bpb($ 1 $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), ..ub($0$, q1), bpb($ 1 $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ 0 $), ..ub($1$, q1), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ 0 $), bpb($ x $), ..ub(
          $1$,
          q2,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ 0 $), bpb($ x $), bpb(
          $ 1 $,
        ), ..ub($bracket.b$, q2, f: true),
        bpb($ bracket.b $), bpb($ x $), bpb($ 0 $), bpb($ x $), ..ub(
          $1$,
          q3,
          f: true,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ 0 $), ..ub($x$, q3, f: true), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), ..ub($0$, q3, f: true), bpb($ x $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), ..ub($x$, q3, f: true), bpb($ 0 $), bpb($ x $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        ..ub($bracket.b$, q3), bpb($ x $), bpb($ 0 $), bpb($ x $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), ..ub($x$, q0), bpb($ 0 $), bpb($ x $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), ..ub($0$, q0), bpb($ x $), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), ..ub($x$, q1), bpb(
          $ 1 $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), bpb($ x $), ..ub(
          $1$,
          q1,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), bpb($ x $), bpb(
          $ x $,
        ), ..ub($bracket.b$, q2, f: true),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), bpb($ x $), ..ub(
          $x$,
          q3,
          f: true,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), ..ub($x$, q3, f: true), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), ..ub($x$, q3, f: true), bpb($ x $), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), ..ub($x$, q3, f: true), bpb($ x $), bpb($ x $), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        ..ub($bracket.b$, q3), bpb($ x $), bpb($ x $), bpb($ x $), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), ..ub($x$, q0), bpb($ x $), bpb($ x $), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), ..ub($x$, q0), bpb($ x $), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), ..ub($x$, q0), bpb(
          $ x $,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), bpb($ x $), ..ub(
          $x$,
          q0,
        ), bpb($ bracket.b $),
        bpb($ bracket.b $), bpb($ x $), bpb($ x $), bpb($ x $), bpb(
          $ x $,
        ), ..ub($bracket.b$, qa, e: true),
      )
    }
    block(breakable: false, exbox(
      title: $L = {0^n 1^n | n >= 0}, w = 0011$,
      align(center, grid(
        columns: 3,
        tmpex(true), align(horizon, text(size: 2em)[$ ~> $]), tmpex(false),
      )),
    ))
  }

  == Varianten

  / Laufzeit: Die Laufzeit einer TM $M$ bei der Verarbeitung eines Wortes
    $w in Sigma^*$ ist die Anzahl $t(w)$ der Schritte, die die Turing-Maschine
    ausführt, bis sie anhält.

  === Nichtdeterministische TM

  #grid(
    columns: 2,
    [
      _Übergangsfunktion_

      Bei jedem Übergang maximal $N$ verschiedene Möglichkeiten: $delta: Q times
      Gamma -> P(Q times Gamma times {L, R})$ \
      $=>$ Mehrere mögliche Berechnungswege

      _Wort akzeptieren_

      $w in L(M)$ wenn es einen Berechnungsweg gibt, der zu $q_"accept"$ führt.
      (auch wenn es Wege gibt, die auf $q_"reject"$ führen!)

      _Simulationsidee_

      Alle Berechnungswege durchführen, maximal $N^(t(n))$
    ],
    [
      _Simulation auf Standard-TM_

      Verwende 3 Bänder:

      + Arbeitsband
      + Kopie von w
      + Liste aller Folgen von Wahlmöglichkeiten

      Simulation

      + Kopiere w von Band 2 auf Band 1
      + Führe TM aus auf Band 1 mit Wahlmöglichkeiten von Band 3
      + Inkrementiere zur nächsten Folge von Wahlmöglichkeiten auf Band 3
    ],
  )

  Simulierbar in $O(N^(t(n))) = 2^O(t(n))$

  === Verschiedene Bandalphabete

  Jedes andere Alphabet als $Sigma = {0,1}$ kann binär codiert werden.

  #{
    let lnode = node.with(height: 2em, width: 7em)
    let snode = node.with(height: 2em, width: 1em)
    let sedge = edge.with(marks: "-|>", corner-radius: 50pt)
    diagram(
      spacing: (0em, 1em),
      lnode((0, 0), $ bracket.b = #[`0x20`] $),
      lnode((1, 0), $ A = #[`0x41`] $),
      lnode((2, 0), $ x = #[`0x87`] $),
      lnode((3, 0), $ 7 = #[`0x37`] $),

      edge((1, -2), (1, 0), "-|>", stroke: 2pt),
    )

    diagram(
      spacing: (0em, 1em),
      snode((0, 0), `0`),
      snode((1, 0), `1`),
      snode((2, 0), `0`),
      snode((3, 0), `0`),
      snode((4, 0), `0`),
      snode((5, 0), `0`),
      snode((6, 0), `0`),

      snode((7, 0), `1`),
      snode((8, 0), `0`),
      snode((9, 0), `0`),
      snode((10, 0), `0`),
      snode((11, 0), `0`),
      snode((12, 0), `0`),
      snode((13, 0), `1`),

      snode((14, 0), `1`),
      snode((15, 0), `1`),
      snode((16, 0), `1`),
      snode((17, 0), `1`),
      snode((18, 0), `0`),
      snode((19, 0), `0`),
      snode((20, 0), `0`),

      snode((21, 0), `0`),
      snode((22, 0), `1`),
      snode((23, 0), `1`),
      snode((24, 0), `0`),
      snode((25, 0), `1`),
      snode((26, 0), `1`),
      snode((27, 0), `1`),

      edge(
        (10, -2),
        (10, -1.5),
        (7, -1.5),
        (7, 0),
        "-|>",
        stroke: 2pt,
        corner-radius: 5pt,
      ),
      sedge((7, 0), (7.5, -2), (8, 0)),
      sedge((8, 0), (8.5, -2), (9, 0)),
      sedge((9, 0), (9.5, -2), (10, 0)),
      sedge((10, 0), (10.5, -2), (11, 0)),
      sedge((11, 0), (11.5, -2), (12, 0)),
      sedge((12, 0), (12.5, -2), (13, 0)),
      sedge((13, 0), (13.5, -2), (14, 0)),
    )
  }

  Simulierbar in Zeit $O(t(n))$

  === Mehrspurmaschine

  #todo[buch ..250.., slides 14]

  Simulierbar in Zeit $O(t(n))$

  === Mehrbandmaschine

  Um eine Mehrbandmaschine mit $n$ Bändern auf einer einfacheren Maschine zu
  simulieren, kann die unabhängige Bewegung der Schreib-/Leseköpfe mithilfe
  eines $2n$-spurigen Bandes (Daten + Zeiger für Schreib-/Lesekopf) nachgebildet
  werden.

  #todo[buch ..250..]

  Simulierbar in Zeit $O(t(n)^2)$

  ==== Harvard- und von Neumann-Architektur

  Die AVR-Mikrokontroller-Familie von Atmel verwendet intern drei unabhängige
  Datenpfade:
  - Flash-Speicher, der den Programmcode enthält
  - Statisches RAM, welches zur Laufzeit veränderliche Daten speichert
  - Peripheriegeräte.

  Die von Neumann-Architektur vereinheitlicht Daten- und Programmspeicher.

  === Einseitig unendliches Band

  Beidseitig unendliches Band kann durch ein Alphabet doppelter Wortbreite
  realisiert werden, somit äquivalent.

  #todo[diagram (buch 235)]

  == Turing-erkennbare Sprachen

  Eine TM erkennt das Wort $w in Sigma^*$, wenn die Maschine auf dem Input $w$
  im Zustand $q_"accept"$ anhält.

  Sind $L_1$ und $L_2$ Turing-erkennbare Sprachen, dann sind auch der
  Durchschnitt $L_1 inter L_2$ und die Vereinigungsmenge $L_1 union L_2$
  Turing-erkennbar.

  Es gibt überabzählbare viele Sprachen $L subset Sigma^*$, die *nicht*
  Turing-erkennbar sind.

  === Aufzähler

  / Aufzähler: TM mit einem Drucker, mit dem Wörter ausgedruckt werden können.

  $L$ ist _rekursiv aufzählbar_ wenn es einen Aufzähler gibt, der alle Wörter
  aufzählen kann. $L$ ist dann auch Turing-erkennbar.

  === Entscheider und entscheidbare Sprachen

  // / Deterministisch: Eine TM $M$ heisst _Entscheider_, wenn sie auf jedem Input
  //   $w$ anhält.
  // / Nichtdeterministisch: Eine nichtdeterministische TM $M$ heisst
  //   _Entscheider_, wenn jede Berechnungsgeschichte terminiert.
  / Turing-erkennbare Sprache: $L$ heisst _Turing-erkennbar_, wenn es eine TM
    $M$ gibt mit $L = L(M)$.
  / Turing-entscheidbare Sprache: $L$ heisst _Turing-entscheidbar_, wenn es
    einen Entscheider $M$ gibt mit $L = L(M)$.
  / Berechenbare Funktion: Eine Funktion $f : Sigma^* -> Sigma^*$ heisst
    _berechenbar_, wenn es eine TM $M$ gibt, die auf jedem Inputwort
    $w in Sigma^*$ anhält und auf dem Band das Outputwort $f(w)$ zurücklässt.

  #todo[nicht entscheidbare Probleme]

  = Entscheidbarkeit

  #quote(
    [
      Die sich mit immer neuen Superlativen gegenseitig überbietenden
      Ankündigungen der IT-Industrie könnten den Eindruck erwecken, dass mit
      geeignet viel Rechenleistung und Speicherplatz kein Informatikproblem
      einer Lösung widerstehen könnte.
    ],
    attribution: [Prof. Dr. Andreas Müller, @autospr[p.~267]],
  )
  > based

  #todo[(Zehntes hilbertsches Problem). Man gebe ein Verfahren an, welches für
    eine beliebige diophantische Gleichung entscheidet, ob sie lösbar ist.]

  Serialisierung ermöglicht, jedes Entscheidungsproblem auf die Verarbeitung
  einer Zeichenkette zurückzuführen, die entweder akzeptiert oder verworfen
  wird. Jedes Problem wird auf diese Weise zu einem Sprachproblem.

  == Entscheider

  #grid(
    columns: 2,
    [
      _Definition_

      Ein _Entscheider_ ist eine Turing-Maschine, die auf jedem beliebigen Input
      anhält.

      Eine Sprache $L$ heisst _entscheidbar_, wenn es einen Entscheider $M$ gibt
      mit $L = L(M)$. Man sagt, $M$ entscheidet $L$.

      _Sprachproblem_

      Jedes Problem $P$ kann in ein Sprachproblem übersetzt werden:
      $ L_P = {w in Sigma^* mid(|) w "ist Lösung des Problems" P} $
    ],
    [
      _Beispiele_

      Leerheitsproblem (Entscheidbar):
      $ E_"DEA" = {lrc(A) mid(|) A "ein DEA und" L(A) = emptyset} $
      Gleichheitsproblem (Entscheidbar):
      $
        "EQ"_"CFG" = {lrc(G_1, G_2) mid(|)
          G_i "CFGs und" L(G_1) = L(G_2)}
      $
      Akzeptanzproblem (Entscheidbar -- nicht für TM!):
      $
        "A"_"DEA" = {lrc(A, w) mid(|)
          A "ein DEA, der" w "akzeptiert"}
      $
      Halteproblem (Nicht entscheidbar):
      $ "HALT"_"TM" = {lrc(M, w) mid(|) M "hält auf Input" w} $

    ],
  )

  == Akzeptanzproblem für Turing-Maschinen

  $
    A_"TM" = {lrc(M, w) mid(|) M "ist eine TM, die das Wort" w in Sigma^* "akzeptiert"}
  $

  _Theorem_

  $A_"TM"$ ist nicht entscheidbar.

  _Beweis_

  Konstruiere aus einem Entscheider $H$ für $A_"TM"$ eine Maschine $D$ mit Input
  $lrc(M)$

  + Lasse $H$ auf Input $lrc(M, lrc(M))$
  + Falls $H$ akzeptiert: $q_"reject"$
  + Falls $H$ verwirft: $q_"accept"$

  Wende jetzt $D$ auf $lrc(D)$ an:

  $
    D(lrc(D)) "akzeptiert" & => D "verwirft" lrc(D) \
      D(lrc(D)) "verwirft" & => D "akzeptiert" lrc(D)
  $

  == Halteproblem

  $
    "HALT"_"TM" = {lrc(M, w) mid(|) "die TM" M "hält auf dem Input" w}
  $
  $=>$ Gleicher Widerspruch wie beim Akzeptanzproblem. Umschreiben des Problems
  in ein neues Programm $S$, welches "Akzeptieren" in "Anhalten" übersetzen
  soll = Reduktion ($A_"TM" <= "HALT"_"TM"$)

  #todo[spezielles/allgemeines Halteproblem]

  == Reduktion

  #grid(
    columns: 2,
    [
      _Reduktionsabbildung_

      Berechenbare Abbildung $f : Sigma^* -> Sigma^*$ so, dass
      $ w in A <=> f(w) in B $

      Notation: $f : A <= B$ heisst "$A$ leichter entscheidbar als $B$"

      _Entscheidbarkeit_

      Falls $B$ entscheidbar, dann $f : A <= B => A$ entscheidbar

      _Beweis_

      Ist $H$ ein Entscheider für $B$, dann ist $H compose f$ ein Entscheider
      für $A$.

      _Folgerung_

      $A$ nicht entscheidbar, $A <= B space => B$ nicht entscheidbar
    ],
    {
      let inode = node.with(stroke: none)
      diagram(
        spacing: (2em, 3em),
        inode((0, 0), $w$, name: <w>),
        inode((0, 1), $A$),
        inode((0, -.75), $Sigma^*$, name: <sw>),
        inode((0, 2), [Entscheider $H compose f$]),

        inode((1, 0), $f(w)$, name: <fw>),
        inode((1, 1), $B$),
        inode((1, -.75), $Sigma^*$, name: <sfw>),
        inode((1, 2), [Entscheider $H$]),
        node(
          enclose: ((0, 0), (0, 1)),
          shape: fletcher.shapes.ellipse,
          name: <a>,
          inset: 1.5em,
          fill: colors-l.darkblue,
        ),
        node(
          enclose: ((1, 0), (1, 1)),
          shape: fletcher.shapes.ellipse,
          name: <b>,
          inset: 1.5em,
          fill: colors-l.darkblue,
        ),
        node(enclose: ((0, 0), (0, 1), <a>, <sw>), name: <ea>, inset: 1.5em),
        node(enclose: ((1, 0), (1, 1), <b>, <sfw>), name: <eb>, inset: 1.5em),

        edge(<w>, <fw>, "-|>"),
        edge(<ea>, <eb>, "-|>", label: $f$, bend: 30deg, shift: 1.25),
        // edge(<a>, <b>, "-|>", shift: 1),
        // edge(<b>, <a>, "<|-", shift: 1),
      )
    },
  )

  == Vergleich der Entscheidbarkeit von Sprachen

  #exbox(todo[])

  == Satz von Rice

  == Lösungsmethoden für Entscheidungsprobleme

  #todo[book 273..]

  = Komplexität

  / Ineffizient: Entscheidbare Probleme mit exorbitant langer Laufzeit sind
    praktisch "nicht lösbar"
  / Problemgrösse: Laufzeit hängt von der Problemgrösse $n$ ab
  / Worst case Laufzeit: Die worst case Laufzeit $t(n)$, die die Maschine zur
    Verarbeitung von Inputs der Länge $n$ braucht, ist $t(n) = max{t(w) mid(|)
      abs(w) <= n}$

  == Hardwareeinfluss

  Nichtdeterministische Hardware kann in Zeit $2^(O(t(n)))$ simuliert werden
  $=>$ NTM ist exponentiell schneller

  == Polynomielle und Exponentielle Laufzeit

  #todo[slides 5]

  #table(
    columns: 2,
    table-header([Polynomielle Probleme], [Exponentielle Probleme]),
    [
      - Gauss-Algorithmus $O(n^3)$
      - ...
    ],

    [
      - Faktorisierung von grossen Zahlen (RSA)
      - ...
    ],
    [Skalierbarkeit],

    [Sicherheit],
  )

  Ein Algorithmus hat _polynomielle Laufzeit_, wenn seine Laufzeit durch ein
  Polynom beschränkt ist: $t(n) = O(n^k)$.

  == Sprachen

  Eine Sprache $L$ gehört zur Klasse #comment[N]P, wenn $L$ von einer
  #comment[nicht]deterministischen TM in #tr[polynomieller Zeit] *entschieden*
  werden kann

  == Polynomielle Verifizierer

  Ein _polynomieller Verifizierer_ für die Sprache $L$ ist eine TM $V$, so dass
  es für jedes $w in Sigma^*$ ein Wort $c$ (das Lösungszertifikat) gibt, für das
  gilt
  $ w in L <=> V "akzeptiert" lrc(w, c) $
  Die Laufzeit von $V$ ist polynomiell in $abs(w)$.

  Eine Sprache ist genau dann in #tr[NP], wenn sie in polynomieller Zeit
  *verifiziert* werden kann.

  #todo[slides 14]

  == Polynomielle Reduktion

  === Polynomieller Laufzeit-Vergleich

  Seien $A$ und $B$ entscheidbare Sprachen. Eine berechenbare Abbildung
  $ f: Sigma^* -> Sigma^* : w |-> f(w) $
  mit
  + $w in A <=> f(w) in B$ (Reduktion)
  + $f (w)$ ist berechenbar in polynomieller Zeit in $abs(w)$
  heisst _polynomielle Reduktion_ $A scripts(<=)_P B$. Lies: $A$ ist polynomiell
  leichter entscheidbar als $B$.

  / Polynomiell äquivalent: Zwei Sprachen $A$ und $B$ heißen _polynomiell
    äquivalent_, geschrieben $A scripts(equiv)_P B$, wenn $A scripts(<=)_P B$
    und $B scripts(<=)_P A$.

  === Satz

  Sei $A scripts(<=)_P B$. Dann gilt
  $
      B in P => & A in P,   &           A in.not P => & B in.not P \
    B in N P => & A in N P, & #h(1em) A in.not N P => & B in.not N P \
  $

  #todo[slides 16,17]

  === Reduktion von HAMPATH

  #todo[]

  == Polynomielle Ausfüllrätsel

  Ein polynomielles Ausfüllrätsel ist eine $n times m$-Tabelle, in die Zeichen
  eines Alphabets $Sigma$ eingefüllt werden müssen, so dass als logische Formel
  ausdrückbare Regeln eingehalten werden, die in polynomieller Zeit ausgewertet
  werden können. (Beispiel: Sudoku)

  / SAT: Boolean satisfiability problem: Gegeben einer aussagenlogischen Formel,
    gibt es eine Zusammensetzung der Variablenwerte, die die Aussage "Wahr"
    werden lassen?
    $ S A T = {phi | phi "ist eine erfüllbare logische Formel"} $

  _Satz_

  Jedes polynomielle Ausfüllrätsel $A$ lässt sich polynomiell auf $S A T$
  reduzieren.

  _Variablen_

  $
        & x_(i j c) = "wahr" \
    <=> & "Feld" (i,j) "der Tabelle enthält Zeichen" c
  $

  _Genau ein Zeichen im Feld $(i,j)$_

  #todo[]
  $
    phi_(i j) = or.big_(c in Sigma) underbrace(
      (
        x_(i j c) and or.big_(d != c)
        x_(i j d)), c "und kein anderes Zeichen in" (i,j)
    )
  $

  _Regeln_

  Spielregeln als Formel $phi$ in Variablen $x_(i j c)$ ausdrücken, die wahr ist
  genau dann, wenn die Regeln erfüllt sind.

  == NP-Vollständigkeit


  #grid(
    columns: (3fr, 2fr),
    align: center,
    [
      Eine entscheidbare Sprache $B$ heisst _NP-vollständig_, wenn sich jede
      Sprache $A$ in NP polynomiell auf $B$ reduzieren lässt:

      $ A scripts(<=)_P B #h(1em) forall A in N P $
    ],
    diagram(
      spacing: (0pt, 1em),
      node((0, 0), $P$),
      node((1, 0), $N P$, stroke: none),
      node(
        (1.25, 0),
        [ ],
        stroke: colors.red,
        fill: colors.red,
        width: 2pt,
        height: 2.25em,
      ),
      node((1.85, 0), tr[NP-vollständig], stroke: none),
      node(enclose: ((0, 0), (1, 0)), inset: 2pt),
      node((0, 1), [leichter], stroke: none),
      node((1, 1), [schwieriger], stroke: none),
      edge((-.5, .5), (1.25, .5), "-|>"),
    ),
  )

  NP-vollständige Probleme sind die "schwierigsten" Probleme in NP. Sie sind
  alle gleich schwierig:

  $
    A, B "NP-vollständig" => (A scripts(<=)_P B and B scripts(<=)_P A space <=>
      space A
      scripts(equiv)_P B)
  $

  _Reduktionsprinzip_

  $
    A "NP-vollständig" space and space B in N P space and space A scripts(<=)_P
    B space => B "NP-vollständig"
  $

  #todo[slides 2]

  Wenn ein Problem NP-vollständig ist:
  - Lösung braucht typischerweise exponentielle Zeit
  - Korrektheit der Lösung ist in polynomieller Zeit zu prüfen

  Umgang mit NP-Vollständigkeit in der Praxis:
  - Spezialfälle ausnützen
  - Problem modifizieren
  - Approximation
  - Zufall oder Heuristik
  - Genetische Algorithmen und ML

  Beispiele:
  - SAT / 3SAT
  - k-VERTEX-COLORING

  === Cook-Levin

  / 3-SAT: Jede Klausel der Normalform hat maximal 3 Literale.

  _Satz_

  SAT ist NP-vollständig.

  Das bedeutet:

  Sei $A$ eine Sprache in NP \
  $=>$ Es gibt eine nichtdeterministische TM $M$, die $A$ in polynomieller Zeit
  $O(t(n))$ entscheidet \
  $=>$ $A$ kann polynomiell auf SAT reduziert werden: $A scripts(<=)_P S A T$

  _Vorgehensweise_

  Beschreibe das Finden der Berechnungsgeschichte von $M$ als ein polynomielles
  Ausfüllrätsel

  #todo[slides 5]
  #todo[slides 7]
  "Ausfüllrätsel" in diesem Fall die Berechnungsgeschichte der TM.

  Überprüfe, ob alle Zustandsübergänge valid sind.

  #todo[book 328-343/368]

  === $S A T scripts(<=)_P 3 S A T$

  $
    {phi | phi "erfüllbare logische Formel"} =>
    {phi | phi "erfüllbare logische Formel in 3CNF"}
  $
  #todo[$->$ Erfüllungsäquivalenz]

  _Beweis von Cook-Levin_
  - Jedes Problem lässt sich auf eine Formel reduzieren
  - Die Reduktion ist polynomiell
  - Die Formel wird aus der Berechnungsgeschichte abgeleitet
  - Die Formel kann in CNF konstruiert werden

  ==== Erfüllungsäquivalente Umformung

  #todo[slides 11]

  === Öffentliches Schlüsselsystem

  #todo[slides 15]

  === Karp-Katalog

  #todo[slides 16]

  $
    "BIP" = {lrc(C, d) mid(|) C in M_(n times m) (ZZ), d in ZZ^n, "gibt es" x in
      {0,1}^m "sodass" C x = d } \
    "CLIQUE-COVER" = {lrc(G, k) mid(|) }
  $


  #if cs and not "x-target" in sys.inputs {
    hide(bibliography("cit.bib"))
  } else {
    pagebreak()
    bibliography("cit.bib")
  }
]
