#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "DMI",
  name: "Diskrete Mathematik",
  semester: "HS25",
  language: lang
)
#let tbl =(..body)=> deftbl(lang,..body)

= Aussagenlogik

== Glossar

#tbl(
  [Aussage], [
    - Feststellender Satz, dem eindeutig "wahr" oder "falsch" zugeordnet werden kann
    - Symbole wie $A,B,C...$ werden dafür verwendet
  ], [Aussagenlogische Form], [
    - Kombination von Aussagen, verknüpft durch Junktoren
  ], [Aussageform ], [
    - Aussagen verknüpft mit Variablen
  ], [Normalform], [
    - Standartisierte Aussagenlogische Formen (Formeln)
  ], [Negationsnormalform], [
    - $not$ steht ausschliesslich direkt vor Aussagen oder Konstanten
  ], [Verallgemeinerte Disjunktion], [
    - Einzelne Aussage oder Negation
    - wahr oder falsch
    - Disjunktion $A or B$, falls $A$ und $B$ selbst verallgemeinerte Disjunktionen
      sind
  ], [Verallgemeinerte Konjunktion], [
    - Einzelne Aussage oder Negation
    - wahr oder falsch
    - Konjunktion $A and B$, falls $A$ und $B$ selbst verallgemeinerte Konjunktionen
      sind
  ], [Disjunktive Normalform ], [
    - Disjunktion von (oder eine einzelne) verallgemeinerten Konjunktionen
  ], [Konjunktive Normalform ], [
    - Konjunktion von (oder eine einzelne) verallgemeinerten Disjunktionen
  ], [Kontradiktion], [
    - Immer falsch
  ], [Tautologie], [
    - Immer wahr
  ], [Junktoren (/Konnektoren)], [
    - $not$ Negation
    - $and$ Konjunktion
    - $or$ Disjunktion (einschliessliches oder!)
    - $=>$ Implikation
    - $<=>$ Äquivalenz
  ], [Abtrennungsregel], [
    - $(A and (A => B)) => B$
  ], [Bindungsstärke ], [
    - $not$ vor $and,or$ vor $=>,<=>$
  ],
)

== Formeln

$(A => B) <=> (not B => not A)$ \
$(A => B) <=> (not A or B)$ \
$(A <=> B) <=> (A and B) or (not A and not B)$ \
$not (A => B) <=> A and not B$ \
$A or (not A and B) <=> A or B$ \
Abtrennungsregel: $A and (A => B) => B$

#pagebreak()

== Rechenregeln

#tbl([Kommutativität], [
  - $(A and B) <=> (B and A)$
  - $(A or B) <=> (B or A)$
], [Assoziativität], [
  - $A and (B and C) <=> (A and B) and C$
  - $A or (B or C) <=> (A or B) or C$
], [Distributivität], [
  - $A and (B or C) <=> (A and B) or (A and C)$
  - $A or (B and C) <=> (A or B) and (A or C)$
], [Absorption], [
  - $A or (A and B) <=> A$
  - $A and (A or B) <=> A$
], [Idempotenz], [
  - $A or A = A$
  - $A and A = A$
], [Doppelte Negation], [
  - $not (not A) <=> not not A <=> A$
], [Konstanten], [
  - W=wahr
  - F=falsch
], [???], [
  - $(A => B => C) <=> (A => B) and (B => C)$
], [de Morgan], [
  - $not (A and B) <=> not A or not B$
  - $not (A or B) <=> not A and not B$
])

= Prädikatenlogik

== Glossar

#tbl(
  [Subjekt], [
    - "Konkretes Ding" / Stellvertreter einer Variable
  ], [Prädikat], [
    - "Eigenschaft", zB "ist eine Primzahl"
    - Prädikate werden oft wie Funktionen geschrieben. Ist $P$ ein Prädikat, dann
      bedeutet $P(x)$, dass $x$ das Prädikat erfüllt. $P(x)$ ist eine Aussageform.
  ], [Quantor], [
    - $forall$ Allquantor (Für alle)
    - $exists$ Existenzquantor (Es existiert)
  ],
)

= Beweisen

#corr([TODO: MEHR BEWEISE])

== Induktion

$A(1) and (A(n) => A(n+1)) => A(m), m in NN$

Beispiel: $2|(6^n)$

+ Verankerung: $n = 0$
  - $2|(6^0)$
+ Induktionsschritt $n->n+1$
  - $2|(6^(n+1))$
  + Induktionsannahme: $2|(6^n)$
  + Behauptung: $2|(6^(n+1))$
  + Beweis: Verwendung der Annahme, um Richtigkeit der Behauptung zu zeigen

=== Techniken

+ Direkter Beweis $f(n) = f_1 (n) = f_2 (n) = ... = f_m (n) = g(n)$
+ Dfferenz gleich Null $f(n) - g(n) = 0 => f(n) = g(n)$
+ Äquivalenzumformung 
+ Dritte Grösse (vereinfachen) $g(n) = h(n) = f(n)$

= Direkte, iterative und rekursive Berechnungen

== Glossar

#tbl([Folge], [
  - Nummerierte Liste von Objekten (Folgegliedern)
], [Reihe], [
  - Summe von Folgegliedern einer Zahlenfolge
])

= Mengen

== Glossar

#tbl(
[Aufzählend], [
  - ${1,2,3}$ 
], [Beschreibend], [
  - ${x in NN^+ | x < 4}$
], [Mächtigkeit], [
  - Anzahl Elemente einer Menge
  - $|M|$
], [Potenzmenge], [
  - Menge aller Teilmengen einer Menge
  - $P(M)$
  - $|P(M)| = 2^(|M|)$
], [Kartesisches Produkt], [
  - $A times B = {(a,b) | a in A, b in B}$
], [], [
], [], [
], [], [
]
)

== Rechenregeln

Für die Mengen A und B in der Obermenge M gelten die folgenden Aussagen:

$overline(overline(A)) = A$ \
$A inter overline(A) = emptyset$ \
$A union overline(A) = M$ \
$overline(A inter B) = overline(A) union overline(B)$ \
$overline(A union A) = overline(A) inter overline(B)$ \

= Formeln, Abbildungen, Relationen

== Glossar

#tbl(
  [Funktion/Abbildung], [
  - Zuordnung, die jedem Elemend der Definitionsmenge $D$ genau ein Element einer Zielmenge $Z$ zuordnet.
  - Injektive Relation
  - $f: D->Z$
  - Abbildungen mit mehreren Argumenten: $f: A times B -> Z$, $f(a,b) = y$
], [Graph], [
  - Menge von Paaren $(x, f(x))$
  - $G in D times Z$
], [Relation], [
  - Teilmenge des Kartesischen Produktes mehrerer Mengen
  - $ A = product_(i=1)^n A_i, |A_i| = n_i => |A| = product_(i=1)^n n_i $
  - Kleiner-Relation: $R_< = {(a,b) | a in A, b in B, a < b}$
  - Gleich-Relation: $R_= = {(a,b) | a in A, b in B, a = b}$
  - Kleiner-Gleich-Relation: $R_(<=) = R_= union R_< = {(a,b) | a in A, b in B, a <= b}$
], [Surjektiv], [
  - Alle Elemente der Definitions- und Zielmenge sind "verknüpft" / jedes Element der Bildmenge kommt als Bild vor
], [Injektiv], [
  - Alle Inputs haben eindeutige Outputs
  - $a_1 != a_2 => f(a_1) != f(a_2)$
], [Bijektiv], [
  - Surjektiv und Injektiv
], [Reflexiv], [
  - Alle Elemente von A stehen zu sich selbst in Beziehung
  - $a in A => (a,a) in R$
  - $A <=> A$
], [Symmetrisch], [
  - $(a,b) in R and (b,a) in R$
  - $(A <=> B) <=> (B <=> A)$
], [Transitiv], [
  - $(a,b) in R and (b,c) in R => (a,c) in R$ 
  - $(A <=> B) and (B <=> C) => (A <=> C)$
], [Äquivalenzrelation], [
  - reflexiv, symmetrisch und transitiv
  - $<=>, =$
], [Irreflexiv], [
  - $a in A => not (a,a) in R$
], [Asymmetrisch], [
  - $(a,b) in R => not (b,a) in R$
], [Antisymmetrisch], [
  - $((a,b) in R) and ((b,a) in R) => a = b$
], [Ordnungsrelation], [
  - reflexiv, antisymmetrisch und transitiv
  - $<=$
], [Symmetrische Differenz], [
  - $A Delta B = {x in G | (x in A union B) and not (x in A inter B)}$
  - $A Delta B = (A union B) without (A inter B)$
  - $(A Delta B) Delta C = A Delta (B Delta C)$
])

= Modulo-Rechnen

== Glossar

#tbl(
[Teiler-Relation], [
  - Für $a, b in ZZ$ ist die Teiler-Relation $b divides a <=> T(b,a) <=> exists q in ZZ: b q = a$
  - $b divides a <=> -b divides a$
  - $b divides a <=> b divides -a$
  - Ordnungsrelation auf $NN$
], [Modulo-Relation], [
  - Für $a,q,r in ZZ$ ist die Modulo-Relation $R_q (a,r) <=> q divides a - r <=> a equiv r mod q$
], [$~$], [
  - "relates to"
  - $a ~ b <=> (a,b) in R$
], [], [

], [], [

]
)
