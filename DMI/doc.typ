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

Die Modulo-Relation ist eine _Äquivalenzrelation_ auf $ZZ$.

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
], 
  [Quotient, Rest],[
Zu jeder Zahl $a in ZZ$ und jeder Zahl $b in ZZ$ gibt es eindeutig bestimmte Zahlen $q,r in ZZ$ mit $a=q*b+r, 0 <= r < b$ \
Bsp: $7 = 2 * 3 + 1$ \
$q$ heisst _Quotient_ \
$r$ heisst _Rest_ \
],
[Restklassen],[
  - $[b]_q = {a in ZZ | a equiv b mod q}, q > 0$
  - $ZZ_q = {[0]_q,[1]_q,[2]_q,...,[q-1]_q} = underbrace({0,1,2,3,...,q-1}, "Vereinfachung")$ 
],
  [Multiplikatives Inverses], [
- Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn $a * b equiv 1 mod q$
], [Nullteiler], [
- Wenn für $a,b in ZZ_q: a b equiv 0 mod q$ und $a equiv.not 0 mod q and b equiv.not 0 mod q$, heissen $a,b$ _Nullteiler_
]
)

== Rechenregeln

+ $(a+b) mod n = ((a mod n)+(b mod n)) mod n$
+ $(a-b) mod n = ((a mod n)-(b mod n)) mod n$
+ $(a*b) mod n = ((a mod n)*(b mod n)) mod n$
+ $a^d mod n = (a^(d-x) * a^x) mod n = ((a^(d-x) mod n) * (a^x mod n)) mod n$

== Primfaktorenzerlegung

#tbl(
  [$"ggT"(a,b)$],[$max{d in NN | d divides a and d divides b}$],
  [$"kgV"(a,b)$],[
  - $min{m in NN | a divides m and b divides m}$
  - $(a b)/("ggT"(a,b))$
],
  [Teilerfremd],[
  - Zwei Zahlen $a,b in NN$ heissen _Teilerfremd_, wenn $"ggT"(a,b) = 1$
  - Sei $p in NN$ eine Primzahl und $q in NN, q < p, q != 0$ dann ist $"ggT"(p,q)=1$
],
[],[],
)

== Euklidscher Algorithmus

Seien $a,b in NN, a != b, a != 0, b != 0$ \
Initialisierung: Setze $x:=a,y:=b$ und $q:=x,r:=x-q*y$ (d.h. bestimme q und r so, dass $x=q*y+r$ ist) \
Wiederhole bis $r=0$ ist \
Ergebnis: $y = "ggT"(a,b)$

=== Beispiel

$&"ggT"(122,72), a=122, b=72$
- Init:  $x_0 = a = 122, y_0 = b = 72$
- Iteration: #table(columns: (auto,auto,auto,auto,auto), 
[],[$x_i = y_(i-1)$],[$y_i = r_(i-1)$],[$q_i=x_i "div" y_i$],[$r_i=x_i mod y_i = x_i - q_i*y_i$],
[$i=0$],[$122$],[$72$],[$1$],[$50$],
[$i=1$],[$72$],[$50$],[$1$],[$22$ Muster: $r_(i+1)<r_i$],
[$i=2$],[$50$],[$22$],[$2$],[$6$],
[$i=3$],[$22$],[$6$],[$3$],[$4$],
[$i=4$],[$6$],[$4$],[$1$],[$2$],
[$i=5$],[$4$],[$2$ *=ggT(122,72)*],[$2$],[$0$ (immer 0 am Schluss)],
)

== Erweiteter Euklidscher Algorithmus

Seien $a,b in NN, a != b, a != 0, b != 0$ \
Initialisierung: Setze $x:=a,y:=b,q:=x div y,r:=x-q*y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und r so, dass $x=q*y+r$ ist) \
Wiederhole bis $r=0$ ist \
Ergebnis: $y = "ggT"(a,b) = s * a + t * b$ \
Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t * v equiv 1 mod a$

=== Beispiel

$"ggT"(99,79)$
#table(columns: (auto,auto,auto,auto,auto,auto,auto,auto,auto),
[$i$],[$x = y_(-1)$], [$y = r_(-1)$], [$q = x div y$], [$r=x_i - q_i*y_i$], [$u = s_(-1)$], [$s = u_(-1) - q_(-1) * s_(-1)$], [$v = t_(-1)$], [$t = v_(-1) - q_(-1) * t_(-1)$],
[$i=0$],[$99$],[$79$],[$1$],[$20$],[$1$],[$0$],[$0$],[$1$],
[$i=1$],[$79$],[$20$],[$3$],[$19$],[$0$],[$1$],[$1$],[$-1$],
[$i=2$],[$20$],[$19$],[$1$],[$1$],[$1$],[$-3$],[$-1$],[$4$],
[$i=3$],[$19$],[*$1$*],[$19$],[$0$],[$-3$],[*$4$*],[$4$],[*$-5$*],
)
Daraus folgend: 
- $"ggT"(99,79)+1+4*99+(-5)*79 <=> 396-395=1$ 
- $-5$ ist mult. Inv. von $79$ in $ZZ_99$ 
- $4$ ist mult. Inv. von $99$ in $ZZ_79$ 

== Kleiner Fermat

Sei $p in NN$ eine Primzahl und $x in ZZ without {0}$ mit $"ggT"(x,p)=1$ \
Dann ist: $x^(p-1) equiv 1 mod p$ \
Daraus folgend: 
$   
  &x^(p-1) equiv 1 mod p       &&| ()^n \
  &<=>x^(n(p-1)) equiv 1 mod p &&| * x \
  &<=>x^(1+n(p-1)) equiv x mod p \
  &<=>x^(1 mod (p-1)) equiv x mod p
$

== Satz von Euler

Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist $z^(phi(n)) equiv 1 mod n$.

=== Euler'sche $phi$-Funktion (Totient)

Sei $n in NN without {0}$ und $ZZ_n^* = {x in ZZ_n | x "hat ein multiplikatives Inverses in " ZZ_n}$. Dann heisst $phi(n)$:
$ phi(n) &= "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
         &="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
         &=abs(ZZ_n^*) $
Falls $p$ Primzahl ist, dann ist $phi(p) = p-1$

==== Rechenregeln

+ Sei $n in NN$ eine Primzahl, dann $phi(n) = n - 1$
+ Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann $phi(n^p) = n^(p-1)*(n-1)$
+ Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann $phi(n*m) = phi(n)*phi(m)$

== RSA Verschlüsselung

+ Wähle 2 Primzahlen $p,q$
+ Berechne $n = p * q$ 
+ Berechne $phi(n)=(p-1)(q-1)$
+ Wähle $a,b$ so, dass $a*b equiv 1 mod phi(n)$
+ Vergesse $p,q,phi(p*q)$. Brauchen wir nicht und riskieren nur, dass uns jemand hackt
Public key ist nun $n,b$, Private key ist $n,a$ \
Sidenote: Fürs Alphabet muss $n$ grösser sein als $26$ \
