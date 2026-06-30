#import "../lib.typ": *
#import "./info.typ": info
#import "./shared.typ": autospr-shared

// TODO:
#show: cheatsheet.with(..info)

#let cbox = (f, t, c, clr: colors.darkblue) => cetz.draw.content(f, t, align(
  center + horizon,
  box(
    text(fill: clr, c),
    stroke: 1pt + clr,
    // fill: clr.lighten(50%),
    width: 100% - .25em,
    height: 100% - .5em,
  ),
))
#let gbox = cbox.with(clr: colors.green)
#let rbox = cbox.with(clr: colors.red)
= Vorwort

partially yoinked from #link(
  "https://github.com/jasmin-f/Studium-Informatik/tree/main/Semester%202",
  "Jasmin Fässler",
), #link(
  "https://github.com/grnin/zusammenfassungen",
  "Nina Grässli
  & Jannis Tschan",
) and Lukas Hunziker. Motivated by
#link("https://ministry.bandcamp.com/track/i-will-refuse", "Ian MacKaye")

= Vorgehen zu Aufgabentypen

#table(
  columns: 2,
  table-header([Frage], [Antwort]), [Ist Sprache regulär?],
  [#tg[Ja: DEA / NEA / RegEx]\ #tr[Nein: Pumping Lemma]],

  [Ist Sprache kontextfrei?],
  [#tg[Ja: Stackautomat / CNF / BNF]\ #tr[Nein: Pumping Lemma (CFL)]],

  [Turing-Maschinen], [Berechnungsgeschichte],
  [Ist eine Sprache Turing-Vollständig?],
  [#tg[Ja: TM-Simulation]\ #tr[Nein: Halteproblem]],

  [Kann Problem von einem Computer gelöst werden?],
  [Reduktion auf Halteproblem],

  [Kann ein Programm entscheiden, ob zulässige Inputs eine Eigenschaft
    erfüllen?],
  [Satz von Rice],

  [Kann eine nichtdeterministische Maschine ... entscheiden?],
  [NP-Verifizierer],

  [Warum kann ein Problem nicht gelöst werden?],
  [Reduktion auf NP-Vollständiges Problem],
)

= Deterministische Endliche Automaten (DEA)

#grid(
  columns: (auto, 1fr),
  autospr-shared.dea.def,

  autospr-shared.dea.tbl,
)

#align(center, autospr-shared.dea.aut)

#exbox(
  title: $L = {w in {0,1}^* mid(|) abs(w)_0 - abs(w)_1 equiv 0 mod 2}$,
  align(center, automaton(
    (
      q0: (q1: (0, 1)),
      q1: (q0: (0, 1)),
    ),
    final: "q0",
    layout: (
      q0: (0, 0),
      q1: (2, 0),
    ),
  )),
)

#exbox(
  title: $L = {w in {0,1}^* mid(|) abs(w)_0 equiv.not abs(w)_1 mod 3}$,
  align(center, automaton(
    (
      q0: (q1: 0, q2: 1),
      q1: (q2: 0, q0: 1),
      q2: (q0: 0, q1: 1),
    ),
    final: ("q1", "q2"),
    layout: (
      q0: (0, 1),
      q1: (1, -.5),
      q2: (2, 1),
    ),
    style: (
      q0-q1: (curve: 0),
      q1-q0: (curve: .75),
      q1-q2: (curve: 0),
      q2-q1: (curve: .75),
      q2-q0: (curve: 0),
      q0-q2: (curve: .75),
    ),
  )),
)

#exbox(
  title: ```re a+ba+```,
  align(center, automaton(
    (
      q0: (q1: "a", q3: "b"),
      q1: (q1: "a", q2: "b"),
      q2: (q3: "b", q2: "a"),
      q3: (q3: ("a", "b")),
    ),
    final: ("q1", "q2"),
    layout: (
      q0: (0, 1.5),
      q1: (1.5, 1.5),
      q2: (1.5, 0),
      q3: (0, 0),
    ),
    style: (
      q1-q1: (anchor: right),
      q2-q2: (anchor: right),
      q3-q3: (anchor: left),
    ),
  )),
)

#exbox(
  title: $L = {w in {a,b}^* mid(|) 2 divides abs(w)_a and 2 divides.not abs(w)_b}$,
  align(center, automaton(
    (
      q0: (q1: " ", q2: " "),
      q1: (q0: "a", q3: " "),
      q2: (q0: "b", q3: " "),
      q3: (q2: "a", q1: " "),
    ),
    final: "q3",
    layout: (
      q0: (0, 1.5),
      q1: (1.5, 1.5),
      q2: (1.5, 0),
      q3: (0, 0),
    ),
    style: (
      q0-q1: (curve: .25, label: (dist: -.2)),
      q1-q0: (curve: .25, label: (dist: -.2)),
      q1-q3: (curve: .25, label: (dist: -.2)),
      q3-q1: (curve: .25, label: (dist: -.2)),
      q0-q2: (curve: .25, label: (dist: -.2)),
      q2-q0: (curve: .25, label: (dist: -.2)),
      q2-q3: (curve: .25, label: (dist: -.2)),
      q3-q2: (curve: .25, label: (dist: -.2)),
    ),
  )),
)

= Pumping Lemma (DEA)

Um zu beweisen, dass eine Sprache *nicht* regulär ist

Vorgehen:
#autospr-shared.pl

#exbox(
  title: [$L = {0^n 1^n mid(|) n >= 0}$ ist nicht regulär],
  [
    + Annahme: $L$ ist regulär
    + $exists N in NN$, Pumping Length
    + $w = 0^N 1^N$
    + Unterteilung $w = tg(x)tr(y)td(z)$
      #pad(top: 1.5em, block(
        width: 100% * 5 / 6,
        stroke: colors.black,
        inset: 2pt,
        grid(
          columns: (1fr, 1fr, 3fr),
          align: center,
          gutter: 2pt,
          box(width: 100%, inset: 4pt, stroke: colors.green, [#tg($x$)]),
          box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
          [
            #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$)
              $1$])
            #place(dx: 10% + 0.75em, dy: -3.75em, [$N$])
            #place(dx: 10%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
            #place(dx: 100%, dy: -3.75em, [$2N$])
          ],
        ),
      ))
      #pad(top: 1.5em, block(
        width: 100%,
        stroke: colors.black,
        inset: 2pt,
        grid(
          columns: (1fr, 1fr, 1fr, 3fr),
          align: center,
          gutter: 2pt,
          box(width: 100%, inset: 4pt, stroke: colors.green, [#tg($x$)]),
          box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
          box(width: 100%, inset: 4pt, stroke: colors.red, [#tr($y$) $0$]),
          [
            #box(width: 100%, inset: 4pt, stroke: colors.darkblue, [#td($z$)
              $1$])
            #place(dx: 10% - 0.25em, dy: -3.75em, [$N + abs(#tr($y$))$])
            #place(dx: 10%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
            #place(dx: 100% - 3.25em, dy: -3.75em, [$2N + abs(#tr($y$))$])
          ],
        ),
      ))
    + Pumpen: nur die Anzahl der $1$ wird erhöht, Anzahl $1$ bleibt
    + $tg(x)tr(y)^k td(z) in.not L$ für $k != 1$, Widerspruch zum Pumping Lemma
  ],
)
#exbox(
  title: [$L=$ alle korrekte Integralausdrücke],
  [
    + Annahme: $L$ ist regulär
    + $exists N in NN$, Pumping Length
    + $w = integral_(a 1)^(b 1) integral_(a 2)^(b 2) ... integral_(a N)^(b N)
      dif x_N ... dif x_2 dif x_1 in L$
    + Unterteile $w = tg(x)tr(y)td(z)$, wobei $abs(y) >= 1 and abs(x y) <= N
      and x y^k z in L$
    + Pumpen: Der Teil $tg(x)tr(y)$ enthält keine $dif x_k$, beim pumpen nimmt
      also nur die Anzahl der Integralzeichen zu, so dass kein korrekter
      Integralausdruck stehen bleibt.
    + Der Widerspruch zeigt, dass die Annahme, $L$ sei regulär, nicht haltbar
      ist. Also ist $L$ nicht regulär.

    #line(length: 100%, stroke: colors.comment)
    6 Schritte des Pumping-Lemma-Beweises: Annahme (A) 1 Punkt, Pumping Length
    (N) 1 Punkt, Wort (W) 1 Punkt, Unterteilung (U) 1 Punkt, Widerspruch beim
    Pumpen (P) 1 Punkt, Folgerung (F) 1 Punkt.
  ],
)

#exbox(title: $L = w in {0,1}^* mid(|) abs(w)_0 >= f(abs(w)_1)$, [
  Sei $f : NN -> NN$ eine streng monoton wachsende Funktion. Eine solche
  Funktion nimmt beliebig grosse Werte an und es gilt $f(n) >= n$ für alle
  $n in NN$.

  #line(length: 100%, stroke: colors.darkblue)

  + Annahme: $L$ ist regulär.
  + Nach dem Pumping Lemma gibts die Pumping Length $N$
  + Wir wählen das Wort $0^(f(N)) 1^N in L$.
  + Nach dem Pumping Lemma lässt sich das Wort $w$ in drei Teile $w = x y z$
    zerlegen mit $abs(x y) <= N$ und $abs(y) > 0$. Weil $f(N) >= N$ enthält $y$
    ausschliesslich Nullen. \
    #canvas(length: 2em, {
      import cetz.draw: *
      content((0, 8.5), $0$)
      content((3, 8.5), $N$)
      content((7.5, 8.5), $f(N)$)
      content((10, 8.5), $f(N) + N$)
      line((7.5, 8), (7.5, 7))
      rect((-.075, 8), (10.075, 7), stroke: colors.black)
      gbox((0, 8), (1, 7), $x$)
      rbox((1, 8), (2, 7), $y$)
      cbox((2, 8), (10, 7), $#h(1em) 0^(f(N)) quad z #h(6em) 1^N$)
      content((11.5, 7.5), $in L$)

      content((0, 6), $0$)
      content((3, 6), $N$)
      content((9, 6), $f(N) + abs(y) >= f(N)$)
      line((8.5, 5.5), (8.5, 4.5))
      rect((-.075, 5.5), (11.075, 4.5), stroke: colors.black)
      gbox((0, 5.5), (1, 4.5), $x$)
      rbox((1, 5.5), (2, 4.5), $y$)
      rbox((2, 5.5), (3, 4.5), $y$)
      cbox(
        (3, 5.5),
        (11, 4.5),
        $#h(1em) 0^(f(N) + abs(y)) quad z #h(6em) 1^N #h(1em)$,
      )
      content((11.5, 5), $in L$)

      content((0, 3.5), $0$)
      content((3, 3.5), $N$)
      content((7, 3.5), $f(N) - abs(y) < f(N)$)
      line((6.5, 3), (6.5, 2))
      rect((-.075, 3), (9.075, 2), stroke: colors.black)
      gbox((0, 3), (1, 2), $x$)
      cbox((1, 3), (9, 2), $#h(2em) 0^(f(N) - abs(y)) quad z #h(4em) 1^N$)
      content((11.5, 2.5), $in.not L$)
    })
  + Beim Aufpumpen wird die Anzahl der Nullen grösser, das bedeutet aber nicht,
    dass das Wort nicht mehr in der Sprache enthalten ist, da nur
    $abs(w)_0 >= f(abs(w)_1)$ verlangt ist. Beim Abpumpen wird allerdings die
    Anzahl der Nullen kleiner, $x z$ enthält nur noch $f(N) - abs(y)$ Nullen.
    Damit haben wir $abs(x z)_0 = f(N) - abs(y) < f(N) = abs(x z)_1$, das Wort
    $x z$ ist also nicht mehr in $L$, im Widerspruch zur Aussage des Pumping
    Lemmas.
  + Der Widerspruch zeigt, dass Annahme, $L$ sie regulär, nicht haltbar ist.
    Also ist $L$ nicht regulär.
])

#exbox(
  title: $L = {w in Sigma^* mid(|) abs(w)_0 - abs(w)_1 = plus.minus 2},
  space Sigma = {0,1}$,
  [
    Wähle Wort:
    #align(center, canvas(length: 2em, {
      import cetz.draw: *
      content((0, 8.5), $0$)
      content((5, 8.5), $N$)
      content((10, 8.5), $2N + 2$)
      line((5, 8), (5, 7))
      rect((-.075, 8), (10.075, 7), stroke: colors.black)
      content((2.5, 7.5), $0$)
      content((7.5, 7.5), $1$)
    }))
    Unterteile:
    #align(center, canvas(length: 2em, {
      import cetz.draw: *
      content((0, 8.5), $0$)
      content((5, 8.5), $N$)
      content((10, 8.5), $2N + 2$)
      line((5, 8), (5, 7))
      rect((-.075, 8), (10.075, 7), stroke: colors.black)
      gbox((0, 8), (2, 7), $x$)
      rbox((2, 8), (4, 7), $y$)
      cbox((4, 8), (10, 7), $z$)
    }))
    Da $abs(y)$ nur aus Nullen bestehen kann, hat das Wort $v = x z$, aus dem
    der Teil $abs(y)$ abgepumpt worden ist, weniger Nullen. Die Anzahl der
    Nullen ist daher mindestens um 3 geringer als die Anzahl der Einsen, das
    abgepumpte Wort $v$ ist nicht mehr in der Sprache $L$: $v
    in.not L$.
  ],
)

= Nichtdeterm. Endliche Automaten (NEA)

#autospr-shared.nea

== Verallgemeinerter NEA (VNEA)

#deftbl(
  [Regulär],
  [Es gibt einen DEA $A$, der $L$ akzeptiert, also $L(A) = L$],
  [Regulärer Ausdruck],
  [Zeichenkette $r$ zur Beschreibung einer regulären Sprache $L = L(r)$],
  [Reguläre Operationen],
  $
    L(r_1) union L(r_2) = & L(r_1 | r_2) \
          L(r_1) L(r_2) = & L(r_1 r_2) \
               L(r_1)\* = & L(r_1 \*)
  $,
  [Verallgemeinerter NEA],
  [$"NEA"_epsilon$, dessen Übergänge mit regulären Ausdrücken beschriftet sind],
)
=== Primitive reguläre Ausdrücke

Reguläre Ausdrücke für Wörter mit Länge $<= 1$
#let saut = (..args) => automaton(..args.pos(), ..args.named(), style: (
  state: (stroke: colors.fg, radius: .2, extrude: .7),
  "": (stroke: colors.fg),
  "q": (label: (text: "")),
))
#table(
  columns: (auto, auto, 1fr),
  table-header($L = L(r)$, $r$, $"NEA"$), $emptyset$, $emptyset$,
  saut(("": ()), final: ()), ${epsilon}$, ${epsilon}$,
  saut(("": ())), ${a}$, $a$,
  saut(("": (q: "a"), "q": ())), ${o,s,t}$, $[o s t]$,
  saut(("": (q: ("o", "s", "t")), q: ())), ${a,b,...,s}$, $[a-s]$,
  saut(("": (q: "[a-s]"), q: ())), $Sigma$, $.$,
  saut(("": (q: "S"), "q": ())),
)

#exbox(
  title: $L = {w x w^t | w, x in Sigma^* and abs(w) <= 2}, Sigma = {a,b}$,
  [
    Das Wort $w^t$ ist die gespiegelte Version des Wortes $w$. Ist die Sprache
    $L$ regulär?

    Ja, alle diese Beweise sind gültig:
    + $w = epsilon$ darf sein und daher kann $w = x in Sigma^*$ sein. Es folgt
      $L = Sigma^*$, diese Sprache ist also regulär
    + Regex: ```re aa.*aa|ab.*ba|ba.*ab|bb.*bb|a.*a|b.*b|.*```
    + NEA: #align(center, automaton(
        (
          q0: (q8: "b", q1: "a", q6: "e"),
          q1: (q4: "b", q3: "e", q2: "a"),
          q2: (q2: "*", q5: "a"),
          q3: (q3: "*", q5: "e"),
          q4: (q4: "*", q5: "b"),
          q5: (q7: "a"),
          q6: (q6: "*", q7: "e"),
          q7: (),
          q8: (q11: "b", q10: "e", q9: "a"),
          q9: (q9: "*", q12: "a"),
          q10: (q10: "*", q12: "e"),
          q11: (q11: "*", q12: "b"),
          q12: (q7: "b"),
        ),
        final: "q7",
        layout: (
          q0: (0, 3),
          q1: (1, 1),
          q2: (2, 0),
          q3: (2, 1),
          q4: (2, 2),
          q5: (3, 1),
          q6: (2, 3),
          q7: (4, 3),
          q8: (1, 5),
          q9: (2, 4),
          q10: (2, 5),
          q11: (2, 6),
          q12: (3, 5),
        ),
        style: (
          transition: (label: (dist: .1, pos: .05, angle: auto), curve: .4, stroke: .5pt + colors.fg),
          state: (radius: 1.25em, extrude: .8),
          q0: (initial: bottom),
          q2-q2: (curve: .1),
        ),
      ))
  ],
)

= Kontextfreie Sprachen (CFL)

/ Kontextfrei: $L$ kann nur von einem ND PDA erkannt werden

#autospr-shared.cfg

#context grid(columns: 2, ..autospr-shared.parsetree)

#colbreak()

#exbox(title: [Ist $L$ kontextfrei?], [
  $ L = {w u w^t | w, u in Sigma^* and abs(u) <= 3}, Sigma = {a,b} $
  ($w^t$ ist das gespiegelte Wort von $w$)
  #line(length: 100%, stroke: colors.darkblue)
  Die Sprache ist kontextfrei, weil die folgende kontextfreie Grammatik die
  Sprache erzeugen kann:
  $
    S -> & a S a | b S b | U \
    U -> & epsilon | A | A A | A A A \
    A -> & a | b
  $

  Alternativ kann man auch einen Stackautomaten angeben, der die Sprache
  akzeptiert.

  #line(length: 100%, stroke: colors.comment)

  Grammatik für A (A) 1 Punkt, Schachtelungsidee (S) 2 Punkt, der mittlere Teil
  kann leer sein (U) 1 Punkt, der mittlere Teil kann aus a und b bestehen (B) 1
  Punkt, Schlussfolgerung kontextfrei (K) 1 Punkt.
])

== Pumping Lemma (CFL)

Um zu beweisen, dass eine Sprache *nicht* kontextfrei ist

#let v = tr($v$)
#let y = tr($y$)
#let x = tg($x$)
#let u = td($u$)
#let z = td($z$)

Voraussetzungen:
+ $abs(#v #y) > 0$
+ $abs(#v #x #y) <= N$
+ $fora(k in NN, #u #v^k #x #y^k #z in L)$

#exbox(title: $L = {w in {0,1}^* | w = 0^k 1 0^l 1 0^k 1 0^l}$, [
  + Annahme: $L$ ist kontextfrei
  + Nach dem Pumping Lemma $exists N in NN$, Pumping Length
  + Wähle das Wort $w = 0^N 1 0^N 1 0^N 1 0^N$
  + Nach dem Pumping Lemma gibt es eine Aufteilung von $w$ in fünf Teile $w = u
    v x y z$ derart, dass $abs(v x y) <= N and abs(v y) >= 1$. Ausserdem ist
    jedes gepumpte Wort $u v^k x y^k z in L$.
  + Da sich die Anzahl der Einsen beim Pumpen nicht ändern darf, müssen $v$ und
    $y$ vollständig in einem Nullen-Block enthalten sein. Daher kann sich nur
    die Anzahl der Nullen in höchstens zwei Nullen-Blöcken ändern. Die beiden
    Blöcke müssen wegen $abs(v x y) <= N$ ausserdem benachbart sein. \
    Zum ersten Nullen-Block gehört der dritte, der gleich viele Nullen enthalten
    muss, zum zweiten gehört der vierte. Wie auch immer die beiden Blöcke
    gewählt werden, ändert sich die Anzahl Nullen in den Blöcken, aber nicht in
    den zugehörigen Blöcken. Das gepumpte Wort kann also nicht mehr in $L$ sein.
  + Dieser Widerspruch zeigt, dass die Annahme, $L$ sei kontextfrei, nicht
    haltbar ist. Also ist $L$ nicht kontextfrei.

  #line(length: 100%, stroke: colors.comment)

  Pumping Lemma und Annahme L kontextfrei (PL) 1 Punkt, Pumping Length (N) 1
  Punkt, Wahl eines Wortes (W) 1 Punkt, Unterteilung (U) 1 Punkt, Widerspruch
  beim Pumpen (P) 1 Punkt, Schlussfolgerung (S) 1 Punkt.
])

#exbox(title: $L = {a^i b^j c^k d^l mid(|) i = k and j = l}$, [
  Wähle Wort:
  #align(center, canvas(length: 2em, {
    import cetz.draw: *
    content((0, 8.5), $0$)
    content((2.5, 8.5), $N$)
    content((5, 8.5), $2N$)
    content((7.5, 8.5), $3N$)
    content((10, 8.5), $4N$)
    line((5, 8), (5, 7))
    line((2.5, 8), (2.5, 7))
    line((7.5, 8), (7.5, 7))
    rect((-.075, 8), (10.075, 7), stroke: colors.black)
    content((1.25, 7.5), $a$)
    content((3.75, 7.5), $b$)
    content((6.25, 7.5), $c$)
    content((8.75, 7.5), $d$)
  }))

  Unterteile:

  #align(center, canvas(length: 2em, {
    import cetz.draw: *
    content((0, 8.5), $0$)
    content((2.5, 8.5), $N$)
    content((5, 8.5), $2N$)
    content((7.5, 8.5), $3N$)
    content((10, 8.5), $4N$)
    line((5, 8), (5, 7))
    line((2.5, 8), (2.5, 7))
    line((7.5, 8), (7.5, 7))
    rect((-.075, 8), (10.075, 7), stroke: colors.black)

    cbox((0, 8), (1.5, 7), $u$)
    rbox((1.5, 8), (2.25, 7), $v$)
    gbox((2.25, 8), (3.25, 7), $x$)
    rbox((3.25, 8), (4, 7), $y$)
    cbox((4, 8), (10, 7), $z$)

    content((2.75, 6.5), $<-- <= N -->$)
  }))
  Wegen $abs(v x y) <= N$ können $v$ und $y$ Zeichen aus höchstens zwei der vier Blöcke enthalten. Beim
  Pumpen werden sich daher die Anzahlen von zwei benachbarten Arten von Zeichen ändern,
  nicht aber der anderen Zeichen, die in gleicher Zahl vorhanden sein sollten. Damit ist ein
  gepumptes Wort nicht mehr in $L$.
])
#colbreak()

#exbox(title: ${a^n b^n c^n | n >= 0}$)[
  Wort: $w = a^N b^N c^N$
  #pad(top: 1.5em, bottom: 1.5em, block(
    width: 95%,
    stroke: colors.black,
    inset: 2pt,
    grid(
      columns: (2fr, .5fr, 1.5fr, 1fr, 4fr),
      align: center,
      gutter: 2pt,
      [
        #box(width: 100%, inset: 4pt, stroke: colors.darkblue, td($u$))

        #place(dx: 50% + 0.75em, dy: -3.75em, $a^N$)
      ],
      box(width: 100%, inset: 4pt, stroke: colors.red, tr($v$)),
      [
        #box(width: 100%, inset: 4pt, stroke: colors.green, tg($x$))
        #place(dx: 0% + 0.75em, dy: -3.75em, $N$)
        #place(dx: 0%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
        #place(
          dx: 0.5em,
          dy: 1em,
          $ stretch(<-, size: #3em) <=N stretch(->, size: #3em) $,
        )
      ],
      [
        #box(width: 100%, inset: 4pt, stroke: colors.red, tr($y$))

        #place(dx: 0% + 0.75em, dy: -3.75em, $b^N$)
      ],
      [
        #box(width: 100%, inset: 4pt, stroke: colors.darkblue, td($z$))

        #place(dx: 55% + 0.75em, dy: -3.75em, $c^N$)
        #place(dx: 15% + 0.5em, dy: -3.75em, $2N$)
        #place(dx: 15%, dy: -0.75em, rotate(90deg, line(length: 2em + 2pt)))
        #place(dx: 100%, dy: -3.75em, $3N$)
      ],
    ),
  ))
  Beim Pumpen nimmt die Anzahl der $a$ und $b$ zu, nicht aber die Anzahl der $c$
  $=> fora(k eq.not 1, #u #v^k #x #y^k #z in.not L)$
]

// #exbox(todo[FS_2024)6)])

== Chomsky-Normalform (CNF)

- $S$ kommt auf der rechten Seite nicht vor
- Jede Regel von der Form $A -> B C$ oder $A -> a$
- $S -> epsilon$ ist erlaubt

=== Umwandlung

+ Neue Startvariable $S_0 -> S$ (wenn nötig)
+ $epsilon$-Regeln:
  $
    cases(reverse: #true, A -> epsilon, B -> A C) => cases(B &-> A C, &-> #comment($A$) C)
  $
+ Unit-Rules:
  $ cases(reverse: #true, A -> B, B -> C D) => cases(A -> C D, B -> C D) $
+ Verkettungen:
  $
           A -> & u_1 u_2 ... u_n \
           A -> & u_1 A_1, A_1 -> u_2 A_2, ..., A_(n-2) -> u_(n-1) u_n \
    "falls" u_i & "ein Terminalsymbol:" A_(i-1) -> U_i A_i, U_i -> u_i
  $

#context autospr-shared.cnfex

#colbreak()

=== Ableitungsdreieck

#autospr-shared.ableitungsdreieck.join()

=== BNF

#autospr-shared.bnf

= Stackautomat (PDA)

#autospr-shared.pda.def

#autospr-shared.pda.diag

#colbreak()

== Grammatik ablesen

Ist $L$ eine kontextfreie Sprache, dann gibt es einen Stackautomaten $P$, der
$L$ akzeptiert, $L = L(P)$.

#context autospr-shared.cnf2pdadiag

#let (ns, vs) = autospr-shared.cnf2pdatbl.chunks(4)
#grid(
  columns: (auto, 1fr),
  align: horizon,
  ..ns.zip(vs).join()
)

= Turing Maschinen

#autospr-shared.tm.def

#box(height: 2em, autospr-shared.tm.diag)

#autospr-shared.tm.trans

== Prüfung

#tr[Bei der Letzten Aufgabe (Welche Sprache wird von $M$ akzeptiert?) muss eine
  ausformulierte Begründung stehen.]

== Berechnungsgeschichte

#grid(columns: 2, align: horizon, ..([Links], [Rechts])
    .zip(autospr-shared.tmp.map(n => align(center, n)))
    .join())

$ L = {0^n 1^n | n >= 0}, w = 0011 $

#colbreak()
#align(center, (autospr-shared.tmpex)(true))

#colbreak()
#align(center, (autospr-shared.tmpex)(false))
#colbreak()

== Varianten

=== Nichtdeterministische TM

_Übergangsfunktion_

Bei jedem Übergang maximal $N$ verschiedene Möglichkeiten: $delta: Q times
Gamma -> P(Q times Gamma times {L, R})$ \
$=>$ Mehrere mögliche Berechnungswege

_Wort akzeptieren_

$w in L(M)$ wenn es einen Berechnungsweg gibt, der zu $q_"accept"$ führt. (auch
wenn es Wege gibt, die auf $q_"reject"$ führen!)

_Simulation auf Standard-TM_

Verwende 3 Bänder:

+ Arbeitsband
+ Kopie von w
+ Liste aller Folgen von Wahlmöglichkeiten

_Simulation_

+ Kopiere w von Band 2 auf Band 1
+ Führe TM aus auf Band 1 mit Wahlmöglichkeiten von B. 3
+ Inkrementiere zur nächsten Folge auf Band 3

Simulierbar in $O(N^(t(n))) = 2^O(t(n))$

=== Verschiedene Bandalphabete

Jedes andere Alphabet kann binär codiert werden.

Simulierbar in Zeit $O(t(n))$

=== Mehrspurmaschine

Simulierbar in Zeit $O(t(n))$

=== Mehrbandmaschine

Die unabhängige Bewegung der Schreib-/Leseköpfe auf einer $n$-Band Maschine kann
mithilfe eines $2n$-spurigen Bandes (Daten + Zeiger für Schreib-/Lesekopf)
nachgebildet werden.

Simulierbar in Zeit $O(t(n)^2)$

=== Einseitig unendliches Band

Beidseitig unendliches Band kann durch ein Alphabet doppelter Wortbreite
realisiert werden, somit äquivalent.

== Turing-erkennbare Sprachen

Eine TM erkennt das Wort $w in Sigma^*$, wenn die Maschine auf dem Input $w$ im
Zustand $q_"accept"$ anhält.

Sind $L_1$ und $L_2$ Turing-erkennbare Sprachen, dann sind auch der Durchschnitt
$L_1 inter L_2$ und die Vereinigungsmenge $L_1 union L_2$ Turing-erkennbar.

=== Aufzähler

/ Aufzähler: TM mit einem Drucker, mit dem Wörter ausgedruckt werden können.

$L$ ist _rekursiv aufzählbar_ wenn es einen Aufzähler gibt, der alle Wörter
aufzählen kann. $L$ ist dann Turing-erkennbar.

= Entscheidbarkeit

/ Entscheider: eine Turing-Maschine, die auf jedem beliebigen Input anhält.
/ Turing-entscheidbare Sprache: $L$ heisst _Turing-entscheidbar_, wenn es einen
  Entscheider $M$ gibt mit $L = L(M)$.

#colbreak()

== Entscheidbare Probleme

#let cxb = (c, m) => [#box(inset: .25em, fill: c, [#m Entscheidbar])]
#let cxr = cxb(colors-l.red, $crossmark$)
#let cxg = cxb(colors-l.green, $checkmark$)
#let problem = (m, t, d) => grid(
  columns: 2,
  if t { cxg } else { cxr },
  m,
  grid.cell(colspan: 2, {
    if t [Wie:] else [Denn:]
    d
  }),
)
=== Leerheitsprobleme
#problem($ E_"DEA" = {lrc(A) | L(A) = emptyset} $, true, [
  Minimalautomat hat keinen Akzeptierzustand
])
#problem($ E_"CFG" = {lrc(G) | L(G) = emptyset} $, true, [ Chomksy-Normalform ])
#problem($ E_"TM" = {lrc(M) | L(M) = emptyset} $, false, [
  Reduktion möglich: $A_"TM" <= E_"TM"$])
=== Gleicheitsprobleme
#problem($ "EQ"_"DEA" = {lrc(A_1, A_2) | L(A_1) = L(A_2)} $, true, [
  Vergleich der minimalen Automaten, oder Leerheitsproblem bei:
  $L(A_1) triangle L(A_2)$
])
#problem($ "EQ"_"CFG" = {lrc(G_1, G_2) | L(G_1) = L(G_2)} $, false, [
  Es gibt eine Reduktion $"ALL"_"CFG" <= "EQ"_"CFG"$ . Da $"ALL"_"CFG"$ nicht
  entscheidbar, auch $"EQ"_"CFG"$ nicht entscheidbar.
])
#problem($ "EQ"_"TM" = {lrc(M_1, M_2) | L(M_1) = L(M_2)} $, false, [
  $"EQ"_"PDA"$ nicht entscheidbar
])
=== Akzeptanzprobleme
#problem($ A_"DEA" = {lrc(A, w) | w in L(A)} $, true, [
  Regex-Engines simulieren beliebige DEAs auf beliebigen Input-Wörtern $w$])
#problem($ A_"CFG" = {lrc(G, w) | w in L(G)} $, true, [
  CYK, deterministischer Parse-Algorithmus
])
#problem($ "A" epsilon_"CFG" = {lrc(G, w) | epsilon in L(G)} $, true, [
  wenn CNF Regel $S->epsilon$ enthält
])
#problem($ A_"TM" = {lrc(M, w) | w in L(M)} $, false, [ Halteproblem ])
=== Alle Wörter produzieren
#problem($ "ALL"_"CFG" = {lrc(G) | G "produziert" Sigma^*} $, false, [
  (Gegenteil von E Problem mit TM) $A_"TM" <= "ALL"_"PDA"$])
#problem($ "ALL"_"PDA" = {lrc(P) | P "akzeptiert" Sigma^*} $, false, [
  Reduktionsabbildung der Gegenteil akzeptiert])
=== Weitere
#problem($ "HALT"_"TM" = {lrc(M, w) | M "hält auf Input" w} $, false, [
  Auf $A_"TM"$ reduziert $->$ nicht entscheidbar])

== Satz von Rice

Ist $P$ eine nichttriviale Eigenschaft Turing-erkennbarer Sprachen, dann ist
$P_(T M)$ nicht entscheidbar.

Eine Eigenschaft $P$ Turing-erkennbarer Sprachen heisst _nichttrivial_, wenn es
zwei Turing-Maschinen $M_1$ und $M_2$ gibt, wobei $M_1$ die Eigenschaft hat und
$M_2$ nicht.

#colbreak()

#exbox(
  title: "Links-kürzbar",
  [
    Man sagt, die Sprache sei links-kürzbar, wenn man von einem Wort ein
    beliebiges Anfangsstück entfernen kann und das verkürzte Wort immer noch ein
    Wort der Sprache ist. Also zum Beispiel
    $A S D F in L => S D F, D F, F, epsilon in L$. Wie könnte man ein Programm
    aufbauen, welches immer anhält und mit welchem man andere Programme
    analysieren kann, ob deren akzeptierte Sprache links-kürzbar ist?

    #line(length: 100%, stroke: colors.darkblue)

    Die Eigenschaft einer Sprache, links-kürzbar zu sein, ist eine nichttriviale
    Eigenschaft. Die Liste der Wörter in der Aufgabenstellung bildet eine
    links-kürzbare Sprache, die Sprache bestehend nur aus dem Wort BIBER hat
    diese Eigenschaft nicht. Der Satz von Rice besagt jetzt, dass man kein
    Programm schreiben kann, welches entscheiden könnte, ob die akzeptierte
    Sprache die Eigenschaft hat, links-kürzbar zu sein.

    #line(length: 100%, stroke: colors.comment)

    Satz von Rice (R) 1 Punkt, Eigenschaft (E) 1 Punkt, zwei Sprachen (Z) 1
    Punkt, Eigenschaft ist nicht trivial (T) 1 Punkt, Schlussfolgerung nicht
    entscheidbar (N) 2 Punkt.
  ],
)

=== Lösungsanleitung einer Prüfungsfrage:

- Nichttriviale Eigenschaft $P$ aufschreiben
- Die beiden Sprachen $L(M_1)$ und $L(M_2)$ bilden (meistens kann man die leere
  Menge oder $Sigma^*$ als eine dieser Sprachen verwenden)
- Gibt es ein Programm, welches beide Sprachen erkennen kann? Sind beide
  Sprachen Turing erkennbar?
- Dann besagt der Satz von Rice, dass die Sprache nicht entscheidbar ist


#exbox(title: "Datum", [

  Ein häufig wiederkehrende Aufgabe in der Softwareentwicklung ist die
  Beurteilung, ob eine Zeichen- kette ein gültiges Datum ist. Daher könnte es
  nützlich sein, ein Tool zur Verfügung zu haben, welches ein Programm
  analysieren kann und eine Aussage liefern kann, ob das Programm nur korrekte
  Daten akzeptiert. Gibt es ein solches Tool?

  #line(length: 100%, stroke: colors.darkblue)
  Nein. Dies ist das Entscheidungsproblem für die Eigenschaft $"DATES"_"TM"$,
  wobei die Eigenschaft $"DATES"$ besagt, dass die Sprache nur aus korrekten
  Daten besteht. Diese Eigenschaft ist nicht trivial, denn

  $
    L_1 = & {2024-07-19} space && "hat die Eigenschaft DATES", \
    L_2 = & {b l u b b}        && "hat die Eigenschaft nicht."
  $
  Beide Sprachen können von einer Turing-Maschine erkannt werden. Nach dem Satz
  von Rice ist $"DATES"_"TM"$ nicht entscheidbar.

  #line(length: 100%, stroke: colors.comment)

  Eigenschaft DATES (P) 1 Punkt, zwei Sprachen (L) 1 Punkt, Eigenschaft ist
  nicht trivial (T) 1 Punkt, Anwendung des Satzes von Rice (R) 2 Punkte.
])

= NP

Eine Sprache $L$ gehört zur Klasse #comment[N]P, wenn $L$ von einer
#comment[nicht]deterministischen TM in #tr[polynomieller Zeit] *entschieden*
werden kann

== Polynomielle Verifizierer

Ein _polynomieller Verifizierer_ für die Sprache $L$ ist eine TM $V$, so dass es
für jedes $w in Sigma^*$ ein Wort $c$ (das Lösungszertifikat) gibt, für das gilt
$ w in L <=> V "akzeptiert" lrc(w, c) $
Die Laufzeit von $V$ ist polynomiell in $abs(w)$.

Eine Sprache ist genau dann in #tr[NP], wenn sie in polynomieller Zeit
*verifiziert* werden kann.

#tr[Bei der Prüfung Entscheidbarkeit und Zertifikat erwähnen!]

#colbreak()

#exbox(title: [$n times m$ Kuromasu], table(
  columns: 3,
  [], [Schritt], [Aufwand],
  [1], [Für jedes Feld mit einer Zahl überprüfe, ob es weiss ist.], $O(n m)$,
  [2],
  [Für jedes schwarz Feld überprüfe, ob die vertikalen und horizontalen Nachbarn
    weiss sind],
  $O(n m)$,

  [3],
  [Ausgehend vom ersten weissen Feld, färbe alle horizontal oder vertikal
    benachbarten weissen oder roten Felder rot ein, bis kein weiteren Felder
    eingefärbt werden können. Wenn ein weisse Feld übrig bleibt, ist die Regel 3
    verletzt.],
  $O(n^2 m^2)$,

  [4],
  [Von jedem Feld mit einer Zahl ausgehend zähle die horizontal und ver- tikal
    benachbarten sichtbaren weissen Felder und überprüfe, ob die An- zahl mit
    der Zahl übereinstimmt.],
  $O(n^2 m + n m^2)$,

  [], [Total], $O(n^2 m^2)$,
))

#exbox(title: "Square killer", [
  Square Killer ist eine Variante von Sudoku, die auf einem $n^2 times n^2$
  Spielfeld gespielt wird. Die normalen Sudoku-Regeln gelten, zusätzlich muss
  aber die Zahl der Ziffern in einem zusammenhängenden grauen Gebiet ("Käfig")
  eine Quadratzahl sein.

  #line(length: 100%, stroke: colors.darkblue)

  Das Problem ist natürlich entscheidbar, man kann die endlich vielen möglichen
  Zahlenverteilungen durchprobieren und die Regeln überprüfen.

  Die Fragestellung ist gleichbedeutend mit der Frage, ob es einen polynomiellen
  Verifizierer gibt.

  Für einen polynomiellen Verifizierer brauchen wir ein Lösungszertifikat, wir
  nehmen dafür die Zahlen, die in den Feldern stehen. Folgende
  Verifikationsschritte sind noch nötig:

  #table(
    columns: 3,
    [], [Schritt], [Aufwand],
    [1], [Sudoku-Verifizierer], [$O(n^6)$],

    [2],
    [Für jedes Feld überprüfen, ob die Summe der Zahlen im gleichen Käfig eine
      Quadratzahl ist.],
    [$O(n^4 dot n^4)$],

    [], [Total], [$O(n^8)$],
  )

  #line(length: 100%, stroke: colors.comment)

  Entscheidbarkeit (E) 1 Punkt, Verifizierer (V) 1 Punkt, Zertifikat (Z) 1
  Punkt, bestehende Sudoku Regeln sind in polynomieller Zeit verifizierbar (S) 1
  Punkt, Verifikation von zwei zusätzlichen Regel (R) 1 Punkt, Laufzeit
  polynomiell (L) 1 Punkt.
])

=== $m$-Sudoku

_Entscheidbar?_ Ja: $n = m^4 =$ Anzahl Felder \
_Zertifikat:_ Vollständig ausgefülltes Sudoku \
_Vorgehen:_
#table(
  columns: 3,
  [], [Schritt], [Aufwand],
  [1],
  [Jedes Feld: Zeichen kommt auf der Zeile nicht mehr vor],
  [$O(n^4 dot n^2)$],

  [2],
  [Jedes Feld: Zeichen kommt in der Spalte nicht mehr vor],
  [$O(n^4 dot n^2)$],

  [3],
  [Jedes Feld: Zeichen kommt im Unterquadrat nicht vor],
  [$O(n^4 dot n^2)$],

  [], [Total], [$O(n^6)$],
)

=== Nurikabe

_Entscheidbar?_ Ja: $n = u v =$ Anzahl Felder. Alle Belegungen des Spielfeldes
mit schwarzen Feldern können überprüft werden, ob sie die Regeln einhalten. \
_Zertifikat:_ Liste der schwarzen Felder \
_Vorgehen:_
#table(
  columns: 3,
  [], [Schritt], [Aufwand],
  [1],
  [Für jedes Zahlfeld ($O(n)$) verwendet man einen Markieralgorithmus, der alle
    zum Gebiet dieses Zahlfeldes gehörenden weissen Felder bestimmt ($O(n)$
    Durchgänge mit Aufwand $O(n)$).],
  [$O(n^3)$],

  [2],
  [Trifft dieser Algorithmus auf ein weiteres Zahlfeld, ist der erste Teil von
    Regel 1 verletzt ($-> q_"reject"$).],
  [$O(n)$],

  [3],
  [Weicht die Zahl der gefundenen weissen Felder vom Inhalt des Zahlfeldes ab,
    ist der zweite Teil von Regel 1 verletzt ($-> q_"reject"$).],
  [$n dot O(n)$],

  [4],
  [Ebenfalls mit einem Markieralgorithmus wird überprüft, ob das schwarze Gebiet
    zusammenhängend ist.],
  [$O(n^2)$],

  [5],
  [Für jedes schwarze Feld wird überprüft, ob es Teil eines $2 times 2$- Tümpels
    ist.],
  [$O(n)$],

  [], [Total], [$O(n^3)$],
)

#colbreak()

=== Damen

Das $n$-Damenproblem ist die Aufgabe, eine Platzierung von $n$ Damen auf einem
$n times n$-Schachfeld zu finden, so dass sich die Damen nicht gegenseitig
schlagen können.

_Entscheidbar?_ Ja, es kann ein polynomieller Verifizierer erstellt werden. \
_Zertifikat:_ Das Wort $(n,r_1,r_2,...,r_n) in "QUEENS"$, wobei $r_i$ die
Zeilennummer der Dame in Spalte $i$ ist. \
_Vorgehen:_
#table(
  columns: 3,
  [], [Schritt], [Aufwand],
  [1],
  [Enthält das Wort genau $n + 1$ natürliche Zahlen zwischen $1$ und $n$?],
  [$O(n log(n))$],

  [2], [Sind die Zahlen $r_i$ alle verschieden?], [$O(n^2 log(n)^2)$],

  [3],
  [Sind keine Damen in der gleichen Diagonalen platziert?],
  [$O(n^2 log(n)^2)$],

  [], [Total], [$O(n^2 log(n)^2)$],
)
Die Faktoren $log(n)$ kommen daher, dass mit $n$ auch die Länge der Zahlen wie
$log(n)$ anwächst. Entsprechend nimmt auch die Zeit zu, jede dieser Zahlen zu
verarbeiten. Die gesamte Laufzeit ist schneller als $O(n^3)$, also polynomiell.
Damit ist der oben beschriebene Algorithmus ein polynomieller Verifizierer.

== Reduktion

/ Polynomielle Reduktion: $A scripts(<=)_P B$. Lies: $A$ ist polynomiell
  leichter entscheidbar als $B$.

== NP-Vollständig

Reduktion auf NP-Vollständiges Problem

Zu beachten (Punkteverteilung):
- Lösungsprinzip der Reduktion erwähnen (1P)
- Auswahl eines geeigneten Vergleichsproblems (1P)
- Reduktionsabbildung (\*P)
- Schlussfolgerung: NP-Vollständig und somit nicht effizient lösbar (1P)

= Turing-Vollständig

Eine Sprache $A$ heisst eine _Programmiersprache_, wenn es eine Abbildung
$c : A |-> Sigma^*$ gibt, wobei $c(w)$ ein Programm für eine universelle
Turing-Maschine ist.

Eine Programmiersprache heisst _Turing-vollständig_, wenn in ihr jede beliebige
Turing-Maschine simuliert werden kann.

#pagebreak()
= Karp-Katalog

== Probleme mit $k$ Zahlen
#(
  grid(
    columns: (1fr, 1fr), ..autospr-shared
      .np-c-list
      .pairs()
      .map(((k, v)) => v.pairs())
      .join()
      .filter(((k, v)) => k != "desc" and "k" in v)
      .map(((k, _)) => k)
  )
)
#(
  autospr-shared
    .np-c-list
    .pairs()
    .map(((k, v)) => [
      #if (
        k
          in (
            "Mengen",
            "Aufteilung in zwei Mengen",
            "Pfade in Graphen",
            "Logik",
          )
      ) { colbreak() }
      == #k

      #if "desc" in v { v.desc }

      #(
        v
          .pairs()
          .filter(((k, _)) => k != "desc")
          .map(((k, v)) => [
            === #k

            #let cnt = if "desc" in v {
              v.desc
              [\ ]
              if "ex" in v [
                _Beispiel:_ #v.ex.at(0) \
                _Lösung:_ #v.ex.at(1)
              ]
            }
            #if "img" in v {
              set grid(gutter: 0pt)
              wrap-content(
                [
                  #if "k" in v { $ k = #v.k $ }
                  #v.img
                ],
                cnt,
                align: right,
              )
            } else {
              cnt
            }
          ])
          .join()
      )
    ])
    .join()
)

#[
  #set page(columns: 2) if not "x-target" in sys.inputs

  #set text(size: 12pt)

  = Mengen

  #(
    autospr-shared
      .prodautsets
      .zip(autospr-shared.setsets, autospr-shared.finsets)
      .map((((n, v), d, f)) => block(breakable: false)[
        == #n

        #grid(
          columns: 2,
          grid.cell(rowspan: 2, v), d, [Endzustände: \ #f],
        )
      ])
      .chunks(2)
      .intersperse((colbreak(),))
      .join()
      .join()
  )

  = Karp Katalog
  #set text(size: 9pt)
  #autospr-shared.np-c-diag
  #set text(size: 12pt)

  #colbreak()

  = Reguläre Ausdrücke

  == VNEA zu Regex

  Keine Übergänge nach $q_0$ und nur ein Akzeptierzustand

  #autospr-shared.vna2reg

  Nach Entfernen aller Zwischenzustände $q_"rip" in Q$ bleibt ein regulärer
  Ausdruck $r$ von $A$

  #autospr-shared.vna2reg2

  #exbox(
    title: $
      L = {w in Sigma^* mid(|) abs(w)_0 - abs(w)_1 equiv 0 mod 2},
      space Sigma = {0,1}
    $,
    [
      #grid(
        columns: 3,
        align: horizon,
        [Es gibt den Automaten],
        automaton(
          (
            q0: (q1: (0, 1)),
            q1: (q0: (0, 1)),
          ),
          final: "q0",
        ),
        [$=>$ L ist regulär],
      )
      Umwandlung zu RegEx:
      #grid(
        columns: 2,
        align: horizon,
        automaton(
          (
            s: (q0: "e"),
            q0: (q1: (0, 1), f: "e"),
            q1: (q0: (0, 1)),
            f: (),
          ),
          layout: (
            s: (0, 0),
            q0: (2, 0),
            q1: (2, 2),
            f: (4, 0),
          ),
          final: "f",
        ),
        automaton(
          (
            s: (q0: "e"),
            q0: (q0: "(0|1)(0|1)", f: "e"),
            f: (),
          ),
          layout: (
            s: (0, 0),
            q0: (2, 0),
            f: (4, 0),
          ),
          final: "f",
        ),

        automaton(
          (
            s: (f: "((0|1)(0|1))*"),
            f: (),
          ),
          layout: (
            s: (0, 0),
            f: (4, 0),
          ),
          final: "f",
        ),
        [$=>$ RegEx:
          #show raw: set text(size: 2em)
          ```re /((0|1)(0|1))*/```
        ],
      )
    ],
  )
  #colbreak()

  #(
    autospr-shared
      .regexops
      .map(((t, d, p)) => [
        == #t

        #d

        #align(center, p)
      ])
      .join()
  )

]
