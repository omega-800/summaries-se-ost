#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "DMI",
  name: "Diskrete Mathematik",
  semester: "HS25",
  language: lang,
)
#let tbl = (..body) => deftbl(lang, ..body)

= Aussagenlogik

== Glossar

#tbl(
  [Aussage],
  [
    Feststellender Satz, dem eindeutig "wahr" oder "falsch" zugeordnet werden kann.
    Symbole wie $A,B,C...$ werden dafür verwendet
  ],
  [Aussagenlogische Form],
  [
    Kombination von Aussagen, verknüpft durch Junktoren
  ],
  [Aussageform],
  [
    Aussagen verknüpft mit Variablen
  ],
  [Normalform],
  [
    Standartisierte Aussagenlogische Formen (Formeln)
  ],
  [Negationsnormalform],
  [
    $not$ steht ausschliesslich direkt vor Aussagen oder Konstanten
  ],
  [Verallgemeinerte Disjunktion],
  [
    - Einzelne Aussage oder Negation 
    - wahr oder falsch
    - Disjunktion $A or B$, falls $A$ und $B$ selbst verallgemeinerte Disjunktionen
      sind
  ],
  [Verallgemeinerte Konjunktion],
  [
    - Einzelne Aussage oder Negation
    - wahr oder falsch
    - Konjunktion $A and B$, falls $A$ und $B$ selbst verallgemeinerte Konjunktionen
      sind
  ],
  [Disjunktive Normalform ],
  [
    Disjunktion von (oder eine einzelne) verallgemeinerten Konjunktionen
  ],
  [Konjunktive Normalform ],
  [
    Konjunktion von (oder eine einzelne) verallgemeinerten Disjunktionen
  ],
  [Kontradiktion],
  [
    Immer falsch
  ],
  [Tautologie],
  [
    Immer wahr
  ],
  [Junktoren (/Konnektoren)],
  [
    $not$ Negation \
    $and$ Konjunktion \
    $or$ Disjunktion (einschliessliches oder!) \
    $=>$ Implikation \
    $<=>$ Äquivalenz \
  ],
  [Abtrennungsregel],
  [
    $(A and (A => B)) => B$
  ],
  [Bindungsstärke ],
  [
    $not$ vor $and,or$ vor $=>,<=>$
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

#tbl(
  [Kommutativität],
  [
    $(A and B) <=> (B and A)$ \
    $(A or B) <=> (B or A)$
  ],
  [Assoziativität],
  [
    $A and (B and C) <=> (A and B) and C$ \
    $A or (B or C) <=> (A or B) or C$
  ],
  [Distributivität],
  [
    $A and (B or C) <=> (A and B) or (A and C)$ \
    $A or (B and C) <=> (A or B) and (A or C)$
  ],
  [Absorption],
  [
    $A or (A and B) <=> A$ \
    $A and (A or B) <=> A$
  ],
  [Idempotenz],
  [
    $A or A = A$ \
    $A and A = A$
  ],
  [Doppelte Negation],
  [
    $not (not A) <=> not not A <=> A$
  ],
  [Konstanten],
  [
    $W= "wahr"$ \
    $F= "falsch"$
  ],
  [???],
  [
    $(A => B => C) <=> (A => B) and (B => C)$
  ],
  [de Morgan],
  [
    $not (A and B) <=> not A or not B$ \
    $not (A or B) <=> not A and not B$
  ],
)

= Prädikatenlogik

== Glossar

#tbl(
  [Subjekt],
  [
    - "Konkretes Ding" / Stellvertreter einer Variable
  ],
  [Prädikat],
  [
    - "Eigenschaft", zB "ist eine Primzahl"
    - Prädikate werden oft wie Funktionen geschrieben. Ist $P$ ein Prädikat, dann
      bedeutet $P(x)$, dass $x$ das Prädikat erfüllt. $P(x)$ ist eine Aussageform.
  ],
  [Quantor],
  [
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

#tbl(
  [Folge],
  [
    Nummerierte Liste von Objekten (Folgegliedern)
  ],
  [Reihe],
  [
    Summe von Folgegliedern einer Zahlenfolge
  ],
)

= Mengen

== Glossar

#tbl(
  [Aufzählend],
  [
    ${1,2,3}$
  ],
  [Beschreibend],
  [
    ${x in NN^+ | x < 4}$
  ],
  [Mächtigkeit],
  [
    Anzahl Elemente einer Menge $|M|$
  ],
  [Potenzmenge],
  [
    Menge aller Teilmengen einer Menge $P(M)$ \
    $|P(M)| = 2^(|M|)$
  ],
  [Kartesisches Produkt],
  [
    $A times B = {(a,b) | a in A, b in B}$
  ],
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
  [Funktion/Abbildung],
  [
    - Zuordnung, die jedem Elemend der Definitionsmenge $D$ genau ein Element einer Zielmenge $Z$ zuordnet.
    - Injektive Relation
    - $f: D->Z$
    - Abbildungen mit mehreren Argumenten: $f: A times B -> Z$, $f(a,b) = y$
  ],
  [Graph],
  [
    - Menge von Paaren $(x, f(x))$
    - $G in D times Z$
  ],
  [Relation],
  [
    - Teilmenge des Kartesischen Produktes mehrerer Mengen
    - $ A = product_(i=1)^n A_i, |A_i| = n_i => |A| = product_(i=1)^n n_i $
    - Kleiner-Relation: $R_< = {(a,b) | a in A, b in B, a < b}$
    - Gleich-Relation: $R_= = {(a,b) | a in A, b in B, a = b}$
    - Kleiner-Gleich-Relation: $R_(<=) = R_= union R_< = {(a,b) | a in A, b in B, a <= b}$
  ],
  [Surjektiv],
  [
    - Alle Elemente der Definitions- und Zielmenge sind "verknüpft" / jedes Element der Bildmenge kommt als Bild vor
  ],
  [Injektiv],
  [
    - Alle Inputs haben eindeutige Outputs
    - $a_1 != a_2 => f(a_1) != f(a_2)$
  ],
  [Bijektiv],
  [
    - Surjektiv und Injektiv
  ],
  [Reflexiv],
  [
    - Alle Elemente von A stehen zu sich selbst in Beziehung
    - $a in A => (a,a) in R$
    - $A <=> A$
  ],
  [Symmetrisch],
  [
    - $(a,b) in R and (b,a) in R$
    - $(A <=> B) <=> (B <=> A)$
  ],
  [Transitiv],
  [
    - $(a,b) in R and (b,c) in R => (a,c) in R$
    - $(A <=> B) and (B <=> C) => (A <=> C)$
  ],
  [Äquivalenzrelation],
  [
    - reflexiv, symmetrisch und transitiv
    - $<=>, =$
  ],
  [Irreflexiv],
  [
    - $a in A => not (a,a) in R$
  ],
  [Asymmetrisch],
  [
    - $(a,b) in R => not (b,a) in R$
  ],
  [Antisymmetrisch],
  [
    - $((a,b) in R) and ((b,a) in R) => a = b$
  ],
  [Ordnungsrelation],
  [
    - reflexiv, antisymmetrisch und transitiv
    - $<=$
  ],
  [Symmetrische Differenz],
  [
    - $A Delta B = {x in G | (x in A union B) and not (x in A inter B)}$
    - $A Delta B = (A union B) without (A inter B)$
    - $(A Delta B) Delta C = A Delta (B Delta C)$
  ],
)

= Modulo-Rechnen

Die Modulo-Relation ist eine _Äquivalenzrelation_ auf $ZZ$.

== Glossar

#tbl(
  [Teiler-Relation],
  [
    - Für $a, b in ZZ$ ist die Teiler-Relation $b divides a <=> T(b,a) <=> exists q in ZZ: b q = a$
    - $b divides a <=> -b divides a$
    - $b divides a <=> b divides -a$
    - Ordnungsrelation auf $NN$
  ],
  [Modulo-Relation],
  [
    - Für $a,q,r in ZZ$ ist die Modulo-Relation $R_q (a,r) <=> q divides a - r <=> a equiv r mod q$
  ],
  [$~$],
  [
    - "relates to"
    - $a ~ b <=> (a,b) in R$
  ],
  [Quotient, Rest],
  [
    Zu jeder Zahl $a in ZZ$ und jeder Zahl $b in ZZ$ gibt es eindeutig bestimmte Zahlen $q,r in ZZ$ mit $a=q dot b+r, 0 <= r < b$ \
    Bsp: $7 = 2 dot 3 + 1$ \
    $q$ heisst _Quotient_ \
    $r$ heisst _Rest_ \
  ],
  [Restklassen],
  [
    - $[b]_q = {a in ZZ | a equiv b mod q}, q > 0$
    - $ZZ_q = {[0]_q,[1]_q,[2]_q,...,[q-1]_q} = underbrace({0,1,2,3,...,q-1}, "Vereinfachung")$
  ],
  [Multiplikatives Inverses],
  [
    - Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn $a dot b equiv 1 mod q$
  ],
  [Nullteiler],
  [
    - Wenn für $a,b in ZZ_q: a b equiv 0 mod q$ und $a equiv.not 0 mod q and b equiv.not 0 mod q$, heissen $a,b$ _Nullteiler_
  ],
)

== Rechenregeln

+ $(a+b) mod n = ((a mod n)+(b mod n)) mod n$
+ $(a-b) mod n = ((a mod n)-(b mod n)) mod n$
+ $(a dot b) mod n = ((a mod n) dot b mod n)) mod n$
+ $a^d mod n = (a^(d-x) dot a^x) mod n = ((a^(d-x) mod n) dot (a^x mod n)) mod n$

== Primfaktorenzerlegung

#tbl(
  [$"ggT"(a,b)$],
  [$max{d in NN | d divides a and d divides b}$],
  [$"kgV"(a,b)$],
  [
    - $min{m in NN | a divides m and b divides m}$
    - $(a b)/("ggT"(a,b))$
  ],
  [Teilerfremd],
  [
    - Zwei Zahlen $a,b in NN$ heissen _Teilerfremd_, wenn $"ggT"(a,b) = 1$
    - Sei $p in NN$ eine Primzahl und $q in NN, q < p, q != 0$ dann ist $"ggT"(p,q)=1$
  ],
  [],
  [],
)

== Euklidscher Algorithmus

Seien $a,b in NN, a != b, a != 0, b != 0$ \
Initialisierung: Setze $x:=a,y:=b$ und $q:=x,r:=x-q dot y$ (d.h. bestimme q und r so, dass $x=q dot y+r$ ist) \
Wiederhole bis $r=0$ ist \
Ergebnis: $y = "ggT"(a,b)$

=== Beispiel

$&"ggT"(122,72), a=122, b=72$
- Init:  $x_0 = a = 122, y_0 = b = 72$
- Iteration: #table(
    columns: (auto, auto, auto, auto, auto),
    [],
    [$x_i = y_(i-1)$],
    [$y_i = r_(i-1)$],
    [$q_i=x_i "div" y_i$],
    [$r_i=x_i mod y_i = x_i - q_i dot y_i$],

    [$i=0$], [$122$], [$72$], [$1$], [$50$],
    [$i=1$], [$72$], [$50$], [$1$], [$22$ Muster: $r_(i+1)<r_i$],
    [$i=2$], [$50$], [$22$], [$2$], [$6$],
    [$i=3$], [$22$], [$6$], [$3$], [$4$],
    [$i=4$], [$6$], [$4$], [$1$], [$2$],
    [$i=5$], [$4$], [$2$ *=ggT(122,72)*], [$2$], [$0$ (immer 0 am Schluss)],
  )

== Erweiteter Euklidscher Algorithmus

Seien $a,b in NN, a != b, a != 0, b != 0$ \
Initialisierung: Setze $x:=a,y:=b,q:=x div y,r:=x-q dot y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und r so, dass $x=q dot y+r$ ist) \
Wiederhole bis $r=0$ ist \
Ergebnis: $y = "ggT"(a,b) = s dot a + t dot b$ \
Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t dot v equiv 1 mod a$

=== Beispiel

$"ggT"(99,79)$
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  [$i$],
  [$x = y_(-1)$],
  [$y = r_(-1)$],
  [$q = x div y$],
  [$r=x_i - q_i dot y_i$],
  [$u = s_(-1)$],
  [$s = u_(-1) - q_(-1) dot s_(-1)$],
  [$v = t_(-1)$],
  [$t = v_(-1) - q_(-1) dot t_(-1)$],

  [$i=0$], [$99$], [$79$], [$1$], [$20$], [$1$], [$0$], [$0$], [$1$],
  [$i=1$], [$79$], [$20$], [$3$], [$19$], [$0$], [$1$], [$1$], [$-1$],
  [$i=2$], [$20$], [$19$], [$1$], [$1$], [$1$], [$-3$], [$-1$], [$4$],
  [$i=3$], [$19$], [*$1$*], [$19$], [$0$], [$-3$], [*$4$*], [$4$], [*$-5$*],
)
Daraus folgend:
- $"ggT"(99,79)+1+4 dot 99+(-5) dot 79 <=> 396-395=1$
- $-5$ ist mult. Inv. von $79$ in $ZZ_99$
- $4$ ist mult. Inv. von $99$ in $ZZ_79$

== Kleiner Fermat

Sei $p in NN$ eine Primzahl und $x in ZZ without {0}$ mit $"ggT"(x,p)=1$ \
Dann ist: $x^(p-1) equiv 1 mod p$ \
Daraus folgend:
$
  & x^(p-1) equiv 1 mod p            && | ()^n \
  & <=>x^(n(p-1)) equiv 1 mod p      && | dot x \
  & <=>x^(1+n(p-1)) equiv x mod p \
  & <=>x^(1 mod (p-1)) equiv x mod p
$

== Satz von Euler

Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist $z^(phi(n)) equiv 1 mod n$.

=== Euler'sche $phi$-Funktion (Totient)

Sei $n in NN without {0}$ und $ZZ_n^* = {x in ZZ_n | x "hat ein multiplikatives Inverses in " ZZ_n}$. Dann heisst $phi(n)$:
$
  phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
         & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
         & =abs(ZZ_n^*)
$
Falls $p$ Primzahl ist, dann ist $phi(p) = p-1$

==== Rechenregeln

+ Sei $n in NN$ eine Primzahl, dann $phi(n) = n - 1$
+ Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann $phi(n^p) = n^(p-1) dot n-1)$
+ Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann $phi(n dot m) = phi(n) dot phi(m)$

== RSA Verschlüsselung

+ Wähle 2 Primzahlen $p,q$
+ Berechne $n = p dot q$
+ Berechne $phi(n)=(p-1)(q-1)$
+ Wähle $a,b$ so, dass $a dot b equiv 1 mod phi(n)$
+ Vergesse $p,q,phi(p dot q)$. Brauchen wir nicht und riskieren nur, dass uns jemand hackt
Public key ist nun $n,b$, Private key ist $n,a$ \
Sidenote: Fürs Alphabet muss $n$ grösser sein als $26$ \

= Lineare Algebra

#let g = b => table.cell(fill: colors.green.lighten(60%))[#b]
#let r = b => table.cell(fill: colors.red.lighten(60%))[#b]
#let b = b => table.cell(fill: colors.blue.lighten(60%))[#b]

== Glossar

#tbl(
  [Lineares Gleichungssystem (LGS)],
  [],
  [Koeffizientenmatrix],
  [

  ],
  [Ergebnisvektor],
  [

  ],
  [Lösungsvektor],
  [

  ],
  [Transponieren],
  [

  ],
)

== Pivot-Gleichung

$
  &("I") &&1x_1 + 1x_2 + 1x_3 = -6 \
  &("II") &&x_1 + 2x_2 + 3x_3 = -10 \
  &("III") &&2x_1 + 3x_2 + 6x_3 = -18 \
  &=> \
  &("I'") &&1x_1 + 1x_2 + 1x_3 = -6 \
  &("II'")tr(=("II")-("I")) &&1x_2 + 2x_3 = -4 \
  &("III'")tr(=("III")-2("I")) &&1x_2 + 4x_3 = -6 \
  &=> \
  &("I''") &&1x_1 + 1x_2 + 1x_3 = -6 tg(=> x_1=-6-x_2-x_3 = -6+2+1 =-3)\
  &("II''")tr(=("II")) &&1x_2 + 2x_3 = -4 underbrace(tg(=> x_2 = -4 -2x_3 =-4+2= -2), "Rückwärtssubstitution")\
  &("III''")tr(=("III'")-("II'")) &&2x_3 = -2 tg(=> x_3 = -1)\
$

$ vec(x_1, x_2, x_3) = vec(-3, -2, -1) $

=== Glossar

#tbl(
  [Pivot-Variable],
  [],
)

== Gauss-Tableau

#let ct = table.cell(colspan: 6, align: center)[$=>$]
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [], [$x_1$], [$x_2$], [$x_3$], [$1$], [],
  [$"I"$], [1], [1], [1], [-6], [],
  [$"II"$], [1], [2], [3], [-10], r($-("I")$),
  [$"III"$], [2], [3], [6], [-18], r($-2("II")$),
  ct, [$"I'"$], [1], [1], [1], [-6],
  [], [$"II'"$], g(0), [1], [2], [-4],
  [], [$"III'"$], g(0), [1], [4], [-6],
  r($-("II'")$), ct, [$"I''"$], [1], [1], [1],
  [-6], [], [$"II''"$], g(0), [1], [2],
  [-4], [], [$"III''"$], g(0), g(0), [2],
  [-2], r($*1/2$), ct, [$"I'''"$], [1], [1],
  [1], [-6], r($-("III'''")$), [$"II'''"$], g(0), [1],
  [2], [-4], r($-2("III'''")$), [$"III'''"$], g(0), g(0),
  [1], [-1], [], ct,
)

Koeffizientenmatrix $A = mat(1, 1, 1; 0, 1, 2; 0, 0, 1)$

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [], [$x_1$], [$x_2$], [$x_3$], [$1$], [],
  [$"I''''"$], [1], [1], g(0), [-5], r($-("II''''")$),
  [$"II''''"$], g(0), [1], g(0), [-2], [],
  [$"III''''"$], g(0), g(0), [1], [-1], [],
  ct, [], [1], g(0), g(0), [-3],
  [], [], g(0), [1], g(0), [-2],
  [], [], g(0), g(0), [1], [-1],
  [],
)

Ergebnisvektor $accent(b, harpoon) = vec(-6, -4, -1)$
Lösungsvektor $accent(x, harpoon) = vec(x_1, x_2, x_3)$
Lineares Gleichungssystem $A dot accent(x, harpoon) = accent(b, harpoon)$

#tr($p$) = Anzahl Pivot-Variablen. \
Wenn #tg($b_(p+1)=...=b_m=0$) dann ist das LGS lösbar (homogenes Gleichungssystem), sonst unlösbar. \
Wenn $#tr($p$) = n$ dann hat LGS genau eine Lösung. \
Wenn $#tr($p$) < n$ dann hat LGS unendlich viele Lösungen. \

== Vektoren

=== Glossar

#tbl(
  [Vektor],
  [Liste von Zahlen],
  [Nullvektor],
  [$ve(0) = vec(0, 0, 0)$],
  [Ortsvektor],
  [Ortsvektor $ve(p)$ vom Nullpunkt des Koordinatensystems $vec(0, 0, 0)$ zum Punkt $P$],
  [Richtungsvektor],
  [Richtungsektor $ve(A B)$ vom Punkt $A$ zum Punkt $B$ ist $ve(b) - ve(a)$],
  [Linearkombination],
  [
    Linearkombination der Variabeln $x_1, x_2, x_3$ (Bsp. $3 dot x_1 - 2 dot x_2 + 4 dot x_3 = -6$). Vektoren werden jeweils mit einer Zahl mutlipliziert und miteinander summiert
  ],
  [Lineare Unabhängigkeit],
  [
    $ve(v)_1, ve(v)_2, ..., ve(v)_n$ heissen linear Unabhängig, wenn die Gleichung \
    $lambda_1 dot ve(v)_1, lambda_2 dot ve(v)_2, ..., lambda_n dot ve(v)_n = ve(0)$ genau eine Lösung hat, nämlich \
    $lambda_1 = lambda_2 = ... = lambda_n = 0$ \
    $mat(arrow.t, dots, arrow.t; ve(v)_1, dots, ve(v)_n; arrow.b, dots, arrow.b) dot ve(lambda) = ve(0)$ eindeutig lösbar $= ve(v)_1,...,ve(v)_n$ sind linear unabhängig
  ],
  [Vektorprodukt/Kreuzprodukt],
  [$
    ve(a) times ve(b) = ve(c) \
    vec(a_1, a_2, a_3) times vec(b_1, b_2, b_3) = vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1)
  $],
  [Skalarprodukt],
  [$
    ve(a) prod ve(b) = c \
    vec(a_1, a_2, a_3) prod vec(b_1, b_2, b_3) = a_1 dot b_1 + a_2 dot b_2 + a_3 dot b_3
  $],
  [Orthogonale Projektion],
  [],
  [Betrag/Länge eines Vektors],
  [$
    ve(a) = vec(2, -3, 5) \
    abs(ve(a)) = sqrt(2^2 + (-3)^2 + 5^2) = sqrt(38)
  $],
  [Normalenvektor],
  [\= Vektorprodukt?],
)

=== Vektorenrechnen

Addition: $ ve(v) + ve(w) = vec(1, 2, 3) + vec(5, -9, 4) = vec(1+5, 2+(-9), 3+4) = vec(6, -7, 7) $
Multiplikation mit reellen Zahlen (=Skalare): $ 3 dot ve(v) = 3 dot vec(1, 2, 3) = vec(3 dot 1, 3 dot 2, 3 dot 3) = vec(3, 6, 9) $

=== Rechenregeln

Falls die Vektoren senkrecht zueinanderstehen, ist das Skalarprodukt gleich 0

$
  lambda ve(0) = ve(0) \
  ve(v) + ve(0) = ve(v) \
  -ve(v) = -1 dot ve(v) \
  -ve(v) + ve(v) = ve(0) \
  (lambda mu)ve(v) = lambda(mu ve(v)) = lambda mu ve(v) \
  lambda(ve(v)+ve(w)) = lambda ve(v) + lambda ve(w) \
  ve(v) + (ve(u)+ve(w)) = (ve(v) + ve(u))+ve(w) = ve(v) + ve(u)+ve(w) \
$

=== Kreuzprodukt

#image("./img/kreuzprodukt.png")

==== Eigenschaften

Anti-kommutativ: $ve(a) times ve(b) = -ve(b) times ve(a)$. Konsequenz: $ve(a) times ve(a) = -ve(a) times ve(a) = ve(0)$

Distributiv: $ve(a) times (ve(b) + ve(c)) = ve(a) times ve(b) + ve(a) times ve(c)$

Gemischt-assoziativ: $lambda (ve(a) times ve(b)) = (lambda ve(a)) times ve(b) = ve(a) times (lambda ve(b))$

Das Kreuzprodukt ist *nicht* assoziativ. $ve(a) times ve(b) times ve(c)$ darf man nicht! $(ve(a) times ve(b)) times ve(c) != ve(a) times (ve(b) times ve(c))$

==== Geometrische Eigenschaften

#grid(
  columns: (auto, 1fr),
  [
    #figure(caption: "Rechtssystem", image("./img/rechtssystem.png"))
  ],
  [
    $ve(a) times ve(b)$ steht immer senkrecht auf $ve(a)$ und auf $ve(b)$.

    $ve(a), ve(b), ve(a) times ve(b)$ bilden ein Rechtssystem

    $abs(ve(a) times ve(b)) =$ Flächeninhalt des durch $ve(a)$ und $ve(b)$ aufgespannten Parallelogramms $= abs(ve(a)) dot abs(ve(b)) dot sin(phi)$

    #figure(
      caption: $"Flächeninhalt " h dot a$,
      image("./img/flaecheninhalt-kreuzprodukt.png"),
    )
  ],
)

=== Vektorraum

Ein Vektorraum ist eine Menge $V$ mit den Rechenoperationen:

$ plus.o: V times V -> V, (ve(v),ve(w)) |-> ve(v) plus.o ve(w) $
$ dot.o: RR times V -> V, (lambda,ve(v)) |-> lambda dot.o ve(v) $

Mit den Eigenschaften:

- Vektoraddition:
  - _Assoziativgesetz_: $u plus.o (v plus.o w) = (u plus.o v) plus.o w$
  - Existenz eines _neutralen Elements_ $0_V in V$ mit $v plus.o 0_V = 0_V plus.o v = v$
  - Existenz eines zu $v in V$ _inversen Elements_ $-v in V$ mit $v plus.o (-v) = (-v) plus.o v = 0_V$
  - _Kommutativgesetz_: $v plus.o u = u plus.o v$
- Skalarmultiplikation:
  - $alpha dot.o (u plus.o v) = (alpha dot.o u) plus.o (alpha dot.o v)$
  - $(alpha + beta) dot.o v = (alpha dot.o v) plus.o (beta dot.o v)$
  - $(alpha dot beta) dot.o v = alpha dot.o (beta dot.o v)$
  - $1 dot.o v = v$ für das _Einselement_ $1 in K$ des _Skalarkörpers_

Gelten diese Eigenschaften für die Teilmenge eines grösseren Vektorraums $W$, so nennt man $V$ _Untervektorraum_ von $W$. Heisst: Man hat nur dann einen Untervektorraum $V$, wenn die Produkte der Multiplikation oder Addition der Elemente dieses Raumes auch in $V$ liegen. Untervektorräume sind also unendliche Räume mit n Dimensionen weniger, zB $W$ = 3-Dimensionaler Vektorraum, $V$ = 2-Dimensionaler Untervektorraum.

Kern von $A = U = {ve(x) in RR^n mid(|) A ve(x) = ve(0)}, A in RR^(m times n)$ ist ein Untervektorraum von $RR^n$.

=== Lineare Abbildung

Eine Lineare Abbildung ist eine Funktion
$ L : cases(RR^n &-> RR^m, ve(x) &|-> L(ve(x))) $
mit den Eigenschaften
$
  L(ve(x) + ve(y)) = L(ve(x)) + L(ve(y)) \
  L(lambda ve(x)) = lambda L(ve(x)) \
$
Für jede lineare Abbildung $L: RR^n -> RR^m$ gibt es eine (Abbildungs) Matrix $M in RR^(m times n)$ mit der Eigenschaft, dass $L(ve(x)) = M ve(x)$
$
  M = mat(m_(1 1), ..., m_(1 n); dots.v, dots.v, dots.v; m_(m 1), ..., m_(m n)) \
  m_(i j) = ve(e)_i prod L(ve(e)_j)
$

== Matrizen

=== Glossar

#tbl(
  [Spaltenvektoren],
  [Spalten der Matrix als Vektoren],
  [Zeilenvektoren],
  [Zeilen der Matrix als Vektoren],
  [Rang],
  [Wieviele Spaltenvektoren einer Matrix linear unabhängig sind],
  [Nullmatrix],
  [$0 = mat(0, dots, 0; dots.v, dots.v, dots.v; 0, dots, 0)$],
  [Quadratische Matrix],
  [$M in RR^(n times n)$ Gleichviele Zeichen und Spalten],
  [Diagonalmatrix],
  [(immer quadratisch und symmetrisch): $D=mat(x_1, 0, 0, 0; 0, x_2, 0, 0; 0, 0, x_3, 0; 0, 0, 0, x_4), d_(i j) = 0 "für" i != j$],
  [Einheitsmatrix],
  [(immer diagonal): $E=mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$],
  [Symmetrische Matrix],
  [(immer quadratisch): $A=A^T, a_(i j) = a_(i j), mat(1, 2, 3; 2, 4, 4; 3, 4, 1)$],
  [Obere Dreiecksmatrix],
  [$O = mat(x_1, x_2, x_3; 0, x_4, x_5; 0, 0, x_6), o_(i j) = 0 "für" i > j$],
  [Kovarianzmatrix],
  [immer symmetrisch],
  [Reguläre Matrix],
  [Quadratische Matrix mit höchstem Rang (Rang = Anzahl Spalten/Reihen)],
  [Singuläre Matrix],
  [Quadratische Matrix mit kleinerem Rang (Rang < Anzahl Spalten/Reihen)],
  [Invertierbare Matrix],
  [
    Für $A in RR^(n times n)$ heisst $A$ invertierbar, wenn es eine Matrix $A^(-1)$ gibt, so dass $A dot A^(-1) = A^(-1) dot A = "Einheitsmatrix (E)"$. Dies ist der Fall, wenn $A$ Regulär ist.
  ],
  [Kern],
  [],
  [Determinante],
  [],
)

=== Definition

Matrix mit 2 Zeilen und 3 Spalten
$
  A = mat(1, 4, 5; 2, 3, 7) in RR^(2 times 3)
$
Komponenten von $A$: $a_(i j)$ \
$i$: Zeilenindex, $j$: Spaltenindex. Bsp: $a_23 = 7$ \

=== Matrizen als Vektoren interpretieren

$-> A$ ist ein 6-Dimensionaler VR (Vektorraum)
$
  "Variante 1: " vec(a_11, a_12, a_13, a_14, a_15, a_16)= vec(1, 4, 5, 2, 3, 7) \
  "Variante 2: " vec(a_11, a_12, a_13, a_14, a_15, a_16)= vec(1, 2, 4, 3, 5, 7) \
$

$
  RR^n "interpretiere als" cases(
    RR^(n times 1) -> vec(a_1, a_2, dots.v, a_n) "Spaltenvektor", RR^(1 times n) -> mat(a_1, a_2, dots, a_n) "Zeilenvektor",
  )
$
Zu $A$ gehörige Zeilenvektore $ve(a_1) = mat(1, 4, 5), ve(a_2) = mat(2, 3, 7)$
$ A = mat(<- ve(a_1) ->; <- ve(a_2) ->) = mat(1, 4, 5; 2, 3, 7) $
Zu $A$ gehörige Spaltenvektore $ve(a_1) = vec(1, 2), ve(a_2) = vec(4, 3), ve(a_3) = vec(5, 7)$
$
  A = mat(
    arrow.t, arrow.t, arrow.t; ve(a_1), ve(a_2), ve(a_3); arrow.b, arrow.b, arrow.b
  ) = mat(1, 4, 5; 2, 3, 7)
$

=== Matrizen transponieren

Transponierte Matrix $A in RR^(m times n)$ wäre: $A^T in RR^(n times m)$ \
$A = (a_(i j)), A^T = (a_(j i))$ \
Rolle von Zeile und Spalte vertauscht: $a_(i j) -> a_(j i)$ \
Bsp: $ A = mat(1, 0; 0, 2; 3, 1) in RR^(3 times 2) \
A^T = mat(1, 0, 3; 0, 2, 1) in RR^(2 times 3) \
vec(1, 4, 5)^T =mat(1, 4, 5) $

=== Matrixmultiplikation

Meistens nicht kommutativ ($A dot B != B dot A$)\
$B$ muss genau gleich viele Zeilen haben wie $A$ Spalten\
$
  A in RR^(#tr("m") times #tg("l")), B in RR^(#tg("l") times #tb("n")), C = A dot B in RR^(#tr("m") times #tb("n")) \
  c_(i j) = sum_(k=1)^l a_(i k) b_(k j) \
  #tr($mat(2, 3, 1; 4, -1, 7)$) dot #tb($mat(6, 4; 1, 0; 8, 9)$) = mat(
    (#tr(2) dot #tb(6)+#tr(3) dot #tb(1)+#tr(1) dot #tb(8)), (#tr(2) dot #tb(4)+#tr(3) dot #tb(0)+#tr(1) dot #tb(9))
    ; (#tr(4) dot #tb(6)+#tr(-1) dot #tb(1)+#tr(7) dot #tb(8)), (#tr(4) dot #tb(4)+#tr(-1) dot #tb(0)+#tr(7) dot #tb(9))
  ) = mat(23, 17; 79, 79)
$

=== Rechenregeln

$
  (A dot B) dot C = A dot (B dot C) = A dot B dot C \
  (A + B) dot C = A dot C + B dot C \
  C dot (A + B) = C dot A + C dot B \
  E dot A = A dot E = A "für" A in RR^(n times n) \
  (A^T)^T = A \
  (A+B)^T = A^T + B^T \
  (lambda A)^T = lambda A^T \
  (A dot B)^T = B^T dot A^T \
$

== Analytische Geometrie

#link(
  "https://www.youtube.com/watch?v=6ab1w3KzEHM&list=PLLTAHuUj-zHgQfZHtS3YQpVAfp6Vfb7gP&index=1",
  "beste playlist",
)

=== Geraden

==== Parameterform

$
  g : ve(x) = underbrace(vec(4, 5, 1), "Ortsvektor" ve(p)) + t dot underbrace(vec(-2, 1, 6), "Richtungsvektor" ve(P X)), t in RR
$

=== Ebenen

==== Parameterform

$
  E : underbrace(ve(x), vec(x, y, z)) =
  #td($underbrace(vec(4, 5, 1), "Ortsvektor" ve(o))$)
  + s dot #tr($underbrace(vec(-2, 1, 6), "Spannvektor" ve(A B))$)
  + t dot #tg($underbrace(vec(-1, 5, 4), "Spannvektor" ve(A C))$)
  , s, t in RR
$

==== Normalenform / Koordinatenform

$
  E = [vec(x, y, z) - underbrace(vec(1, 2, 3), "Punkt auf Ebene")] prod underbrace(vec(1, 0, -1), ve(n) "Orthogonal zur Ebene") = 0 \
  => x-1-z+3 = 0
$

==== Hessesche Normalform

Abstand von Punkt $P(2,8,2)$ zur Ebene $E : 2x - y + 4z = 1$

$
  ve(n) = vec(2, -1, 4) \
  abs(ve(n)) = sqrt(21) \
  (2x-y+4z-1)/sqrt(21) \
  => (2 * 2 - 1 * 8 + 4 * 2-1)/sqrt(21) \
  =3/sqrt(21) \
$
