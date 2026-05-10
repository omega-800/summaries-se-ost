#import "../lib.typ": *
#import "./info.typ": info
#import "./shared.typ": autospr-shared

// TODO:
#show: cheatsheet.with(..info)

#todo[
  - Ausfüllrätsel
  - Entscheidbarkeit
  - Halteproblem
  - Liste der NP-Vollständigen Probleme
  - TM Berechnungsgeschichte

  - extras
    - CNF konstruieren
    - Minimalautomat
    - Mengenoperationen
    - DEA/NEA/TM/NTM

  - Beispiele:
    - Ist Sprache x regulär? $->$ Pumping Lemma
    - Ist Sprache x kontextfrei? $->$ Pumping Lemma
    - Kann eine NTM in polynomieller Zeit entscheiden, ob ein Ausfüllrätsel eine
      Lösung hat? $->$ Satz von Rice / P Verifizierer / Reduktion
    - Ist Grammatik eindeutig? (FS_2026)5))
    - Parse-tree finden (FS_2022)5))

  - Prüfungsaufgaben:
    - HS_2021)4)
    - FS_2022)4)
]

#deftbl(
  [Regulär],
  [Es gibt einen DEA $A$, der $L$ akzeptiert, also $L(A) = L$],
  [Kontextfrei],
  [$L$ kann nur von einem ND PDA erkannt werden],
)

= Pumping Lemma (DEA)

Um zu beweisen, dass eine Sprache *nicht* regulär ist

Vorgehen:
+ Annahme: $L$ ist regulär
+ Gemäss Pumping Lemma gibt es die Pumping Length $N$
+ Wähle ein Wort $w in L$ mit $abs(w) >= N$
+ Aufteilung des Wortes gemäss Pumping Lemma
  - $w = #tg($x$)#tr($y$)#td($z$), abs(#tg($x$)#tr($y$)) <= N, abs(#tr($y$)) > 0$
+ Auswirkung des Pumpens
  - $#tg($x$)#tr($y$)^k#td($z$) in.not L$ für mindestens ein $k in NN$ (mit
    Begründung!)
+ Widerspruch $=>$ Annahme kann nicht zutreffen

#todo[Beispiel]
== Beispiel

$L = {0^n 1^n mid(|) n >= 0}$ ist nicht regulär \

+ Annahme: $L$ ist regulär
+ $exists N in NN$, Pumping Length
+ $w = 0^N 1^N$
+ Unterteilung $w = tg(x)tr(y)td(z)$
+ Pumpen: nur die Anzahl der $1$ wird erhöht, Anzahl $1$ bleibt
+ $tg(x)tr(y)^k td(z) in.not L$ für $k != 1$, im Widerspruch zum Pumping
  Lemma

= Pumping Lemma (CFL)

Um zu beweisen, dass eine Sprache *nicht* kontextfrei ist

#let v = tr($v$)
#let y = tr($y$)
#let x = tg($x$)
#let u = td($u$)
#let z = td($z$)

Voraussetzungen:
+ $abs(#v #y) > 0$
+ $abs(#v #x #y) <= N$
+ $#u #v^k #x #y^k #z in L forall k in NN$

#todo[Beispiel]

= Chomsky-Normalform (CNF)

- $S$ kommt auf der rechten Seite nicht vor
- Jede Regel von der Form $A -> B C$ oder $A -> a$
- $S -> epsilon$ ist erlaubt

= Entscheidbarkeit

== Satz von Rice

Ist $P$ eine nichttriviale Eigenschaft Turing-erkennbarer Sprachen, dann ist
$P_(T M)$ nicht entscheidbar.

Eine Eigenschaft $P$ Turing-erkennbarer Sprachen heisst _nichttrivial_, wenn es
zwei Turing-Maschinen $M_1$ und $M_2$ gibt, wobei $M_1$ die Eigenschaft hat und
$M_2$ nicht.

=== Lösungsanleitung einer Prüfungsfrage:

- Nichttriviale Eigenschaft $P$ aufschreiben
- Die beiden Sprachen $L(M_1)$ und $L(M_2)$ bilden (meistens kann man die leere
  Menge oder $Sigma^*$ als eine dieser Sprachen verwenden)
- Gibt es ein Programm, welches beide Sprachen erkennen kann? Sind beide
  Sprachen Turing erkennbar?
- Dann besagt der Satz von Rice, dass die Sprache nicht entscheidbar ist

#todo[Beispiel]

= NP

#todo[]

== Polynomieller Verifizierer

#todo[]

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

== Reduktion

#todo[]

== NP-Vollständig

Reduktion auf NP-Vollständiges Problem

#todo[]

= Karp-Katalog
#(
  autospr-shared
    .np-c-list
    .pairs()
    .map(((k, v)) => [
      == #k

      #if "desc" in v { v.desc }

      #(
        v
          .pairs()
          .filter(((k, _)) => k != "desc")
          .map(((k, v)) => [
            === #k

            #let cnt = if "desc" in v { v.desc }
            #if "img" in v {
              grid(
                columns: (1fr, auto),
                cnt, v.img,
              )
            } else { cnt }
            #if "ex" in v [/ Beispiel: #v.ex]
          ])
          .join()
      )
    ])
    .join()
)

#[
  #set page(columns: 2)


  #autospr-shared.np-c-diag
  #show: columns.with(2)
  #set text(size: 11pt)

  = Mengen

  #(
    autospr-shared
      .prodautsets
      .map(((n, v)) => block(breakable: false)[
        == #n

        #v
      ])
      .join()
  )
]
