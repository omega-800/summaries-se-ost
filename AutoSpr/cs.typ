#import "../lib.typ": *
#import "./info.typ": info
#import "./shared.typ": autospr-shared

// TODO:
#show: cheatsheet.with(..info)

#todo[
  - Entscheidbarkeit
  - Minimalautomat
  - DEA/NEA/TM/NTM

  - Beispiele:
    - Kann eine NTM in polynomieller Zeit entscheiden, ob ein Ausfüllrätsel eine
      Lösung hat? $->$ Satz von Rice / P Verifizierer / Reduktion
    - Ist Grammatik eindeutig? (FS_2026)5))
    - Parse-tree finden (FS_2022)5))

  - Prüfungsaufgaben:
    - HS_2021)4)
    - FS_2022)4)

  - Credits: Nina Grässli, Jannis Tschan, Jasmin
]

#deftbl(
  [Regulär],
  [Es gibt einen DEA $A$, der $L$ akzeptiert, also $L(A) = L$],
  [Kontextfrei],
  [$L$ kann nur von einem ND PDA erkannt werden],
)

= Vorgehen zu Aufgabentypen

#grid(
  columns: 2,
  [Ist Sprache regulär?],
  [#tg[Ja: DEA / NEA / RegEx]\ #tr[Nein: Pumping Lemma]],

  [Ist Sprache kontextfrei?],
  [#tg[Ja: Stackautomat / CNF / BNF]\ #tr[Nein: Pumping Lemma (CFL)]],

  [Turing-Maschinen], [Berechnungsgeschichte],
  [Ist eine Sprache Turing-Vollständig?],
  todo[#tg[Ja: TM-Simulation] #tr[Nein: Halteproblem]],

  [Kann Problem von einem Computer gelöst werden?],
  todo[Reduktion auf Halteproblem],

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

    6 Schritte des Pumping-Lemma-Beweises: Annahme (A) 1 Punkt, Pumping Length
    (N) 1 Punkt, Wort (W) 1 Punkt, Unterteilung (U) 1 Punkt, Widerspruch beim
    Pumpen (P) 1 Punkt, Folgerung (F) 1 Punkt.
  ],
)

= Nichtdeterministische Endliche Automaten (NEA)

#autospr-shared.nea

#todo[Thompson-NEA]

== Verallgemeinerter NEA (VNEA)

#deftbl(
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

= Kontextfreie Sprachen (CFL)

#autospr-shared.cfg

#grid(columns: 2, ..autospr-shared.parsetree)

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

  Pumping Lemma und Annahme L kontextfrei (PL) 1 Punkt, Pumping Length (N) 1
  Punkt, Wahl eines Wortes (W) 1 Punkt, Unterteilung (U) 1 Punkt, Widerspruch
  beim Pumpen (P) 1 Punkt, Schlussfolgerung (S) 1 Punkt.
])

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

=== Ableitungsdreieck

#autospr-shared.ableitungsdreieck.join()

=== BNF

#autospr-shared.bnf

= Stackautomat (PDA)

#autospr-shared.pda.def

#autospr-shared.pda.diag

== Stackautomat standardisieren

#todo[]

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

#todo[]

= Turing Maschinen

#autospr-shared.tm.def

#box(height: 2em, autospr-shared.tm.diag)

#autospr-shared.tm.trans

#todo[berechnungsgeschichte]

== Berechnungsgeschichte

#grid(columns: 2, align: horizon, ..([Links], [Rechts])
    .zip(autospr-shared.tmp.map(n => align(center, n)))
    .join())

$ L = {0^n 1^n | n >= 0}, w = 0011 $

#colbreak()
#align(center, (autospr-shared.tmpex)(true))
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

#colbreak()
#align(center, (autospr-shared.tmpex)(false))

== Varianten

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

== Entscheidbare Probleme

#let cxb = (c, m) => [#box(inset: .25em, fill: c, [#m Entscheidbar])]
#let cxr = cxb(colors-l.red, $crossmark$)
#let cxg = cxb(colors-l.green, $checkmark$)
#let problem = (m, t, d) => grid(
  columns: 2,
  if t { cxg } else { cxr },
  m,
  grid.cell(colspan: 2, {
    if t [Wie] else [Denn]
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

#exbox(
  title: [
    Man sagt, die Sprache sei links-kürzbar, wenn man von einem Wort ein
    beliebiges Anfangsstück entfernen kann und das verkürzte Wort immer noch ein
    Wort der Sprache ist. Also zum Beispiel
    $A S D F in L => S D F, D F, F, epsilon in L$. Wie könnte man ein Programm
    aufbauen, welches immer anhält und mit welchem man andere Programme
    analysieren kann, ob deren akzeptierte Sprache links-kürzbar ist?
  ],
  [
    Die Eigenschaft einer Sprache, links-kürzbar zu sein, ist eine nichttriviale
    Eigenschaft. Die Liste der Wörter in der Aufgabenstellung bildet eine
    links-kürzbare Sprache, die Sprache bestehend nur aus dem Wort BIBER hat
    diese Eigenschaft nicht. Der Satz von Rice besagt jetzt, dass man kein
    Programm schreiben kann, welches entscheiden könnte, ob die akzeptierte
    Sprache die Eigenschaft hat, links-kürzbar zu sein.

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

#exbox(todo[])

= NP

Eine Sprache $L$ gehört zur Klasse #comment[N]P, wenn $L$ von einer
#comment[nicht]deterministischen TM in #tr[polynomieller Zeit] *entschieden*
werden kann

#todo[]

== Polynomielle Verifizierer

Ein _polynomieller Verifizierer_ für die Sprache $L$ ist eine TM $V$, so dass es
für jedes $w in Sigma^*$ ein Wort $c$ (das Lösungszertifikat) gibt, für das gilt
$ w in L <=> V "akzeptiert" lrc(w, c) $
Die Laufzeit von $V$ ist polynomiell in $abs(w)$.

Eine Sprache ist genau dann in #tr[NP], wenn sie in polynomieller Zeit
*verifiziert* werden kann.

#exbox(title: "Square killer", [
  Square Killer ist eine Variante von Sudoku, die auf einem $n^2 times n^2$
  Spielfeld gespielt wird. Die normalen Sudoku-Regeln gelten, zusätzlich muss
  aber die Zahl der Ziffern in einem zusammenhängenden grauen Gebiet ("Käfig")
  eine Quadratzahl sein.

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
    [1], [Sudoku-Verifizierer], [polynomiell],

    [2],
    [Für jedes Feld überprüfen, ob die Summe der Zahlen im gleichen Käfig eine
      Quadratzahl ist.],
    [$O(n^4 dot n^4)$],

    [], [Total], [polynomiell],
  )
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

=== Damen

#todo[]

== Reduktion

/ Polynomielle Reduktion: $A scripts(<=)_P B$. Lies: $A$ ist polynomiell
  leichter entscheidbar als $B$.


#todo[]


== NP-Vollständig

Reduktion auf NP-Vollständiges Problem

Zu beachten (Punkteverteilung):
- Lösungsprinzip der Reduktion erwähnen (1P)
- Auswahl eines geeigneten Vergleichsproblems (1P)
- Reduktionsabbildung (\*P)
- Schlussfolgerung: NP-Vollständig und somit nicht effizient lösbar (1P)

#todo[]

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

  #set text(size: 9pt)
  #autospr-shared.np-c-diag
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
      .join()
  )

  = Reguläre Ausdrücke

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

  == VNEA zu Regex

  Keine Übergänge nach $q_0$ und nur ein Akzeptierzustand

  #autospr-shared.vna2reg

  Nach Entfernen aller Zwischenzustände $q_"rip" in Q$ bleibt ein regulärer
  Ausdruck $r$ von $A$

  #autospr-shared.vna2reg2

]
