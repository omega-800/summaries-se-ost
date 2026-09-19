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

= Kombinatorik

Mathematische Disziplin, die sich mit der Frage befasst, wie viele (und welche)
Möglichkeiten es gibt, eine bestimmte Anzahl von Dingen auszuwählen und
miteinander zu kombinieren.

== Zählregeln

/ Disjunkte Vereinigung: $abs(A union B) = abs(A) + abs(B)$
/ Schnittmenge: $abs(A union B) = abs(A) + abs(B) - abs(A inter B)$
/ Paare/Produkt: $abs(A times B) = abs(A) dot abs(B)$

#todo[merge with DigCod and MathFML]

/ Permutation: Auf wieviele Arten kann man $n$ Objekte anordnen?
  $ P_n = n! $
/ Kombination: Auf wieviele Arten kann man $k$ Objekte aus $n$ auswählen?
  $ C_k^n = binom(n, k) $
/ Variation: Auf wieviele Arten kann man $k$ mal unter $n$ verschiedenen
  Objekten auswählen?
  $ V_k^n = n^k $

Binomische Formel:
$
  (a+b)^n = sum_(k=0)^n binom(n, k) a^k b^(n-k)
$

== Erzeugende Funktion

Oftmals lassen sich schwierige kombinatorische Fragestellungen in algebraische
oder analytische Probleme umformulieren. Damit steht dann der Apparat der
Analysis zur Verfügung.

Die Zahlen $a_0, a_1, a_2, ..., a_n$ kann man wie folgt in ein _erzeugende
Funktion_ codieren:
$ f(z) = a_0 + a_1 z + a_2 z^2 + a_3 z^3 + ... $

Für den Platzhalter $z$ soll gar kein Zahlenwert substituiert werden. Vielmehr
dienen die Potenzen $z_k$ nur dazu, die einzelnen Zahlen $a_k$ auseinander zu
halten. Man spricht von einer _formalen Potenzreihe_.

#exbox(title: "Kombination", [
  Die Koeffizienten dieses Polynoms geben an, #tp[auf wie viele Arten] man $k$
  Elemente aus einer $n$-elementigen Menge auswählen kann.
  $
    p_n (z) = (1 + z)^n = sum_(k=1)^n tp(binom(n, k)) z^k
    quad => quad tp(C_k^n = binom(n, k))
  $
])

#todo[]
