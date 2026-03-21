#import "../lib.typ": *

// TODO: filter, use info.typ + doc.typ content

#let did = 69420
#add-deck(id: did, "DMI", "Diskrete Mathematik")
#let add-note = ta.add-note.with(deck: did)

#add-note(
  id: "3001",
  [Aussage],
  [Feststellender Satz, dem eindeutig "wahr" oder "falsch" zugeordnet werden kann. \ Symbole wie $A,B,C...$ werden dafür verwendet],
)
#add-note(
  id: "3002",
  [Aussagenlogische Form],
  [Kombination von Aussagen, verknüpft durch Junktoren],
)
#add-note(
  id: "3003",
  [Aussageform],
  [ Aussagen verknüpft mit Variablen ],
)
#add-note(
  id: "3004",
  [Normalform],
  [ Standartisierte Aussagenlogische Formen (Formeln) ],
)
#add-note(
  id: "3005",
  [Negationsnormalform],
  [ $not$ steht ausschliesslich direkt vor Aussagen oder Konstanten ],
)
#add-note(
  id: "3006",
  [Verallgemeinerte Disjunktion],
  [ Einzelne Aussage oder Negation \ wahr oder falsch \ Disjunktion $A or B$, falls $A$ und $B$ selbst verallgemeinerte Disjunktionen sind \ ],
)
#add-note(
  id: "3007",
  [Verallgemeinerte Konjunktion],
  [ Einzelne Aussage oder Negation \ wahr oder falsch \ Konjunktion $A and B$, falls $A$ und $B$ selbst verallgemeinerte Konjunktionen sind \ ],
)
#add-note(
  id: "3008",
  [Disjunktive Normalform ],
  [ Disjunktion von (oder eine einzelne) verallgemeinerten Konjunktionen ],
)
#add-note(
  id: "3009",
  [Konjunktive Normalform ],
  [ Konjunktion von (oder eine einzelne) verallgemeinerten Disjunktionen ],
)
#add-note(id: "3010", [Kontradiktion], [ Immer falsch ])
#add-note(id: "3011", [Tautologie], [ Immer wahr ])
#add-note(
  id: "3012",
  [Junktoren (/Konnektoren)],
  [ $not$ Negation \ $and$ Konjunktion \ $or$ Disjunktion (einschliessliches oder!) \ $=>$ Implikation \ $<=>$ Äquivalenz \ ],
)
#add-note(
  id: "3013",
  [Abtrennungsregel],
  [ $(A and (A => B)) => B$ ],
)
#add-note(
  id: "3014",
  [Bindungsstärke ],
  [ $not$ vor $and,or$ vor $=>,<=>$ ],
)

#add-note(id: "3015", $(A => B)$, $(not B => not A)$)
#add-note(id: "3016", $(A => B)$, $(not A or B)$)
#add-note(
  id: "3017",
  $(A <=> B)$,
  $(A and B) or (not A and not B)$,
)
#add-note(id: "3018", $not (A => B)$, $A and not B$)
#add-note(id: "3019", $A or (not A and B)$, $A or B$)
#add-note(id: "3020", $A and (A => B)$, $B$)
#add-note(
  id: "3021",
  $(A => B => C)$,
  $(A => B) and (B => C)$,
)

#add-note(
  id: "3022",
  [Kommutativität],
  [ $(A and B) <=> (B and A)$ \ $(A or B) <=> (B or A)$ ],
)
#add-note(
  id: "3023",
  [Assoziativität],
  [ $A and (B and C) <=> (A and B) and C$ \ $A or (B or C) <=> (A or B) or C$ ],
)
#add-note(
  id: "3024",
  [Distributivität],
  [ $A and (B or C) <=> (A and B) or (A and C)$ \ $A or (B and C) <=> (A or B) and (A or C)$ ],
)
#add-note(
  id: "3025",
  [Absorption],
  [ $A or (A and B) <=> A$ \ $A and (A or B) <=> A$ ],
)
#add-note(
  id: "3026",
  [Idempotenz],
  [ $A or A = A$ \ $A and A = A$ ],
)
#add-note(
  id: "3027",
  [Doppelte Negation],
  [ $not (not A) <=> not not A <=> A$ ],
)
#add-note(
  id: "3028",
  [Konstanten],
  [ $W= "wahr"$ \ $F= "falsch"$ ],
)
#add-note(
  id: "3029",
  [de Morgan],
  [ $not (A and B) <=> not A or not B$ \ $not (A or B) <=> not A and not B$ ],
)

#add-note(
  id: "3030",
  [Subjekt],
  [ "Konkretes Ding" / Stellvertreter einer Variable ],
)
#add-note(
  id: "3031",
  [Prädikat],
  [ "Eigenschaft", zB "ist eine Primzahl" \ Prädikate werden oft wie Funktionen geschrieben. Ist $P$ ein Prädikat, dann bedeutet $P(x)$, dass $x$ das Prädikat erfüllt. $P(x)$ ist eine Aussageform. ],
)
#add-note(
  id: "3032",
  [Quantor],
  [ $forall$ Allquantor (Für alle) \ $exists$ Existenzquantor (Es existiert) ],
)

#add-note(id: "3033", [Induktion], $A(1) and (A(n) => A(n+1)) => A(m), m in NN$))

#add-note(
  id: "3034",
  [Induktion Beispiel: $2 divides (6^n)$],
  [
    + Verankerung: $n = 0$
      - $2 divides (6^0)$
    + Induktionsschritt $n->n+1$
      - $2 divides (6^(n+1))$
      + Induktionsannahme: $2 divides (6^n)$
      + Behauptung: $2 divides (6^(n+1))$
      + Beweis: Verwendung der Annahme, um Richtigkeit der Behauptung zu zeigen
  ],
)

#add-note(
  id: "3035",
  [Direkter Beweis],
  $f(n) = f_1 (n) = f_2 (n) = ... = f_m (n) = g(n)$,
)
#add-note(
  id: "3036",
  [Dfferenz gleich Null],
  $f(n) - g(n) = 0 => f(n) = g(n)$,
)
#add-note(id: "3037", [Äquivalenzumformung], [TODO])
#add-note(
  id: "3038",
  [Dritte Grösse (vereinfachen)],
  $g(n) = h(n) = f(n)$,
)

#add-note(
  id: "3039",
  [Folge],
  [ Nummerierte Liste von Objekten (Folgegliedern) ],
)
#add-note(
  id: "3040",
  [Reihe],
  [ Summe von Folgegliedern einer Zahlenfolge ],
)

#add-note(id: "3041", [Aufzählend], [ ${1,2,3}$ ])
#add-note(
  id: "3042",
  [Beschreibend],
  [ ${x in NN^+ mid(|) x < 4}$ ],
)
#add-note(
  id: "3043",
  [Mächtigkeit],
  [ Anzahl Elemente einer Menge \ $abs(M)$ ],
)
#add-note(
  id: "3044",
  [Potenzmenge],
  [ Menge aller Teilmengen einer Menge \ $P(M)$ \ $abs(P(M)) = 2^(abs(M))$ ],
)
#add-note(
  id: "3045",
  [Teilermenge],
  [ $T(n) =$ Menge der Teiler der Zahl $n$ ],
)
#add-note(
  id: "3046",
  [Kartesisches Produkt],
  [ $A times B = {(a,b) mid(|) a in A, b in B}$ ],
)

#add-note(id: "3047", $overline(overline(A))$, $A$)
#add-note(id: "3048", $A inter overline(A)$, $emptyset$)
#add-note(id: "3049", $A union overline(A)$, $M$)
#add-note(
  id: "3050",
  $overline(A inter B)$,
  $overline(A) union overline(B)$,
)
#add-note(
  id: "3051",
  $overline(A union A)$,
  $overline(A) inter overline(B)$,
)

#add-note(
  id: "3052",
  [Funktion/Abbildung],
  [ Zuordnung, die jedem Elemend der Definitionsmenge $D$ genau ein Element einer Zielmenge $Z$ zuordnet. \ Injektive Relation \ $f: D->Z$ \ Abbildungen mit mehreren Argumenten: $f: A times B -> Z$, $f(a,b) = y$ ],
)
#add-note(
  id: "3053",
  [Graph],
  [ Menge von Paaren $(x, f(x))$ \ $G in D times Z$ ],
)
#add-note(
  id: "3054",
  [Relation],
  [ Teilmenge des Kartesischen Produktes mehrerer Mengen \ $ A = product_(i=1)^n A_i, abs(A_i) = n_i => abs(A) = product_(i=1)^n n_i $ \ Kleiner-Relation: $R_< = {(a,b) mid(|) a in A, b in B, a < b}$ \ Gleich-Relation: $R_= = {(a,b) mid(|) a in A, b in B, a = b}$ \ Kleiner-Gleich-Relation: $R_(<=) = R_= union R_< = {(a,b) mid(|) a in A, b in B, a <= b}$ ],
)
#add-note(
  id: "3055",
  [Surjektiv],
  [ Alle Elemente der Definitions- und Zielmenge sind "verknüpft" / jedes Element der Bildmenge kommt als Bild vor ],
)
#add-note(
  id: "3056",
  [Injektiv],
  [ Alle Inputs haben eindeutige Outputs \ $a_1 != a_2 => f(a_1) != f(a_2)$ ],
)
#add-note(
  id: "3057",
  [Bijektiv],
  [ Surjektiv und Injektiv ],
)
#add-note(
  id: "3058",
  [Reflexiv],
  [ Alle Elemente von A stehen zu sich selbst in Beziehung \ $a in A => (a,a) in R$ \ $A <=> A$ ],
)
#add-note(
  id: "3059",
  [Symmetrisch],
  [ $(a,b) in R and (b,a) in R$ \ $(A <=> B) <=> (B <=> A)$ ],
)
#add-note(
  id: "3060",
  [Transitiv],
  [ $(a,b) in R and (b,c) in R => (a,c) in R$ \ $(A <=> B) and (B <=> C) => (A <=> C)$ ],
)
#add-note(
  id: "3061",
  [Äquivalenzrelation],
  [ reflexiv, symmetrisch und transitiv \ $<=>, =$ ],
)
#add-note(
  id: "3062",
  [Irreflexiv],
  [ $a in A => not (a,a) in R$ ],
)
#add-note(
  id: "3063",
  [Asymmetrisch],
  [ $(a,b) in R => not (b,a) in R$ ],
)
#add-note(
  id: "3064",
  [Antisymmetrisch],
  [ $((a,b) in R) and ((b,a) in R) => a = b$ ],
)
#add-note(
  id: "3065",
  [Ordnungsrelation],
  [ reflexiv, antisymmetrisch und transitiv \ $<=$ ],
)
#add-note(
  id: "3066",
  [Symmetrische Differenz],
  [ $A Delta B = {x in G mid(|) (x in A union B) and not (x in A inter B)}$\ $A Delta B = (A union B) without (A inter B)$\ $(A Delta B) Delta C = A Delta (B Delta C)$ ],
)


#add-note(
  id: "3067",
  [Die Modulo-Relation ist eine],
  [_Äquivalenzrelation_ auf $ZZ$],
)
#add-note(
  id: "3078",
  [Teiler-Relation],
  [ Für $a, b in ZZ$ ist die Teiler-Relation $b divides a <=> T(b,a) <=> exists q in ZZ: b q = a$ \ $b divides a <=> -b divides a$ \ $b divides a <=> b divides -a$ \ Ordnungsrelation auf $NN$ ],
)
#add-note(
  id: "3079",
  [Modulo-Relation],
  [ Für $a,q,r in ZZ$ ist die Modulo-Relation $R_q (a,r) <=> q divides a - r <=> a equiv r mod q$ ],
)
#add-note(
  id: "3080",
  [$~$],
  [ "relates to" \ $a ~ b <=> (a,b) in R$ ],
)
#add-note(
  id: "3081",
  [Quotient, Rest],
  [ Zu jeder Zahl $a in ZZ$ und jeder Zahl $b in ZZ$ gibt es eindeutig bestimmte Zahlen $q,r in ZZ$ mit $a=q dot b+r, 0 <= r < b$ \ Bsp: $7 = 2 dot 3 + 1$ \ $q$ heisst _Quotient_ \ $r$ heisst _Rest_ \ ],
)
#add-note(
  id: "3082",
  [Restklassen],
  [ $[b]_q = {a in ZZ mid(|) a equiv b mod q}, q > 0$ \ $ZZ_q = {[0]_q,[1]_q,[2]_q,...,[q-1]_q} = underbrace({0,1,2,3,...,q-1}, "Vereinfachung")$ ],
)
#add-note(
  id: "3083",
  [Multiplikatives Inverses],
  [ Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn $a dot b equiv 1 mod q$ ],
)
#add-note(
  id: "3084",
  [Nullteiler],
  [ Wenn für $a,b in ZZ_q: a b equiv 0 mod q$ und $a equiv.not 0 mod q and b equiv.not 0 mod q$, heissen $a,b$ _Nullteiler_ ],
)

#add-note(
  id: "3085",
  $(a+b) mod n$,
  $((a mod n)+(b mod n)) mod n$,
)
#add-note(
  id: "3086",
  $(a-b) mod n$,
  $((a mod n)-(b mod n)) mod n$,
)
#add-note(
  id: "3087",
  [$(a dot b) mod n$],
  [$((a mod n) dot b mod n) mod n$],
)
#add-note(
  id: "3088",
  $a^d mod n$,
  $(a^(d-x) dot a^x) mod n = ((a^(d-x) mod n) dot (a^x mod n)) mod n$,
)

#add-note(
  id: "3089",
  [$"ggT"(a,b)$],
  [$max{d in NN mid(|) d divides a and d divides b}$],
)
#add-note(
  id: "3090",
  [$"kgV"(a,b)$],
  [ $min{m in NN mid(|) a divides m and b divides m}$ \ $(a b)/("ggT"(a,b))$ ],
)
#add-note(
  id: "3091",
  [Teilerfremd],
  [ Zwei Zahlen $a,b in NN$ heissen _Teilerfremd_, wenn $"ggT"(a,b) = 1$ \ Sei $p in NN$ eine Primzahl und $q in NN, q < p, q != 0$ dann ist $"ggT"(p,q)=1$ ],
)
#add-note(
  id: "3092",
  [Euklidscher Algorithmus],
  [Seien $a,b in NN, a != b, a != 0, b != 0$ \
    Initialisierung: Setze $x:=a,y:=b$ und $q:=x,r:=x-q dot y$ (d.h. bestimme q und r so, dass $x=q dot y+r$ ist) \
    Wiederhole bis $r=0$ ist \
    Ergebnis: $y = "ggT"(a,b)$],
)

//Euklidscher Algorithmus Beispiel
//
//$&"ggT"(122,72), a=122, b=72$
//- Init:  $x_0 = a = 122, y_0 = b = 72$
//- Iteration: #table(
//    columns: (auto, auto, auto, auto, auto),
//    [],
//    [$x_i = y_(i-1)$],
//    [$y_i = r_(i-1)$],
//    [$q_i=x_i "div" y_i$],
//    [$r_i=x_i mod y_i = x_i - q_i dot y_i$],
//
//    [$i=0$], [$122$], [$72$], [$1$], [$50$],
//    [$i=1$], [$72$], [$50$], [$1$], [$22$ Muster: $r_(i+1)<r_i$],
//    [$i=2$], [$50$], [$22$], [$2$], [$6$],
//    [$i=3$], [$22$], [$6$], [$3$], [$4$],
//    [$i=4$], [$6$], [$4$], [$1$], [$2$],
//    [$i=5$], [$4$], [$2$ *=ggT(122,72)*], [$2$], [$0$ (immer 0 am Schluss)],
//  )

#add-note(
  id: "3093",
  [Erweiteter Euklidscher Algorithmus],
  [
    Seien $a,b in NN, a != b, a != 0, b != 0$ \
    Initialisierung: Setze $x:=a,y:=b,q:=x div y,r:=x-q dot y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und r so, dass $x=q dot y+r$ ist) \
    Wiederhole bis $r=0$ ist \
    Ergebnis: $y = "ggT"(a,b) = s dot a + t dot b$ \
    Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t dot v equiv 1 mod a$
  ],
)

#add-note(
  id: "3094",
  [Erweiteter Euklidscher Algorithmus Spalten],
  [ $i$ \
    $x = y_(-1)$ \
    $y = r_(-1)$ \
    $#text(fill: red)[$q$] = x div y$ \
    $r=x_i - #text(fill: red)[$q_i$] dot y_i$ \
    $u = #text(fill: blue)[$s_(-1)$]$ \
    $#text(fill: blue)[$s$] = u_(-1) - #text(fill: red)[$q_(-1$]) dot #text(fill: blue)[$s_(-1)$]$ \
    $v = #text(fill: green)[$t_(-1)$]$ \
    $#text(fill: green)[$t$] = v_(-1) - #text(fill: red)[$q_(-1$]) dot #text(fill: green)[$t_(-1)$]$ ],
)

// === Beispiel

// $"ggT"(99,79)$
// #table(
//   columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
//   [$i$],
//   [$x = y_(-1)$],
//   [$y = r_(-1)$],
//   [$#text(fill: red)[$q$] = x div y$],
//   [$r=x_i - #text(fill: red)[$q_i$] dot y_i$],
//   [$u = #text(fill: blue)[$s_(-1]$)$],
//   [$#text(fill: blue)[$s$] = u_(-1) - #text(fill: red)[$q_(-1]$) dot #text(fill: blue)[$s_(-1]$)$],
//   [$v = #text(fill: green)[$t_(-1]$)$],
//   [$#text(fill: green)[$t$] = v_(-1) - #text(fill: red)[$q_(-1]$) dot #text(fill: green)[$t_(-1]$)$],
//
//   [$i=0$], [$99$], [$79$], [$1$], [$20$], [$1$], [$0$], [$0$], [$1$],
//   [$i=1$], [$79$], [$20$], [$3$], [$19$], [$0$], [$1$], [$1$], [$-1$],
//   [$i=2$], [$20$], [$19$], [$1$], [$1$], [$1$], [$-3$], [$-1$], [$4$],
//   [$i=3$], [$19$], [#text(fill: red)[$1$]], [$19$], [$0$], [$-3$], [#text(fill: red)[$4$]], [$4$], [#text(fill: red)[$-5$]],
// )
// Daraus folgend:
// - $"ggT"(99,79)+1+4 dot 99+(-5) dot 79 <=> 396-395=1$
// - $-5$ ist mult. Inv. von $79$ in $ZZ_99$
// - $4$ ist mult. Inv. von $99$ in $ZZ_79$

#add-note(
  id: "3095",
  [Kleiner Fermat],
  [Sei $p in NN$ eine Primzahl und $x in ZZ without {0}$ mit $"ggT"(x,p)=1$ \
    Dann ist: $x^(p-1) equiv 1 mod p$ \
    Daraus folgend:
    $
      & x^(p-1) equiv 1 mod p            && | ()^n \
      & <=>x^(n(p-1)) equiv 1 mod p      && | dot x \
      & <=>x^(1+n(p-1)) equiv x mod p \
      & <=>x^(1 mod (p-1)) equiv x mod p
    $],
)

#add-note(id: "3096", [Satz von Euler], [
  Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist $z^(phi(n)) equiv 1 mod n$.
])

#add-note(
  id: "3097",
  [Euler'sche $phi$-Funktion (Totient)],
  [
    Sei $n in NN without {0}$ und $ZZ_n^* = {x in ZZ_n mid(|) x "hat ein multiplikatives Inverses in " ZZ_n}$. Dann heisst $phi(n)$:
    $
      phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
             & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
             & =abs(ZZ_n^*)
    $
    Falls $p$ Primzahl ist, dann ist $phi(p) = p-1$
  ],
)

#add-note(
  id: "3098",
  [Sei $n in NN$ eine Primzahl, dann $phi(n) =$],
  [$n - 1$],
)
#add-note(
  id: "3099",
  [Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann $phi(n^p) =$],
  $n^(p-1) dot (n-1)$,
)
#add-note(
  id: "3100",
  [Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann $phi(n dot m) =$],
  $phi(n) dot phi(m)$,
)

#add-note(id: "3101", [RSA Verschlüsselung], [
  + Wähle 2 Primzahlen $p,q$
  + Berechne $n = p dot q$
  + Berechne $phi(n)=(p-1)(q-1)$
  + Wähle $a,b$ so, dass $a dot b equiv 1 mod phi(n)$
  + Vergesse $p,q,phi(p dot q)$. Brauchen wir nicht und riskieren nur, dass uns jemand hackt
  Public key ist nun $n,b$, Private key ist $n,a$ \
  Sidenote: Fürs Alphabet muss $n$ grösser sein als $26$ \
])

// = Lineare Algebra

// == Glossar
//
// #tbl(
//   [Lineares Gleichungssystem (LGS)],
//   [],
//   [Koeffizientenmatrix],
//   [ ],
//   [Ergebnisvektor],
//   [ ],
//   [Lösungsvektor],
//   [ ],
//   [Transponieren],
//   [ ],
// )

#add-note(id: "3102", [Pivot-Gleichung], [$
    &("I") &&1x_1 + 1x_2 + 1x_3 = -6 \
    &("II") &&x_1 + 2x_2 + 3x_3 = -10 \
    &("III") &&2x_1 + 3x_2 + 6x_3 = -18 \
    &=> \
    &("I'") &&1x_1 + 1x_2 + 1x_3 = -6 \
    &("II'")#text(fill: red)[=("II"-("I"))] &&1x_2 + 2x_3 = -4 \
    &("III'")#text(fill: red)[=("III"-2("I"))] &&1x_2 + 4x_3 = -6 \
    &=> \
    &("I''") &&1x_1 + 1x_2 + 1x_3 = -6 #text(fill: green)[=> x_1=-6-x_2-x_3 = -6+2+1 =-3]\
    &("II''")#text(fill: red)[=("II")] &&1x_2 + 2x_3 = -4 underbrace(#text(fill: green)[=> x_2 = -4 -2x_3 =-4+2= -2], "Rückwärtssubstitution")\
    &("III''")#text(fill: red)[=("III'"-("II'"))] &&2x_3 = -2 #text(fill: green)[=> x_3 = -1]\
  $ \

  $ vec(x_1, x_2, x_3) = vec(-3, -2, -1) $
])

// === Glossar
//
// #tbl(
//   [Pivot-Variable],
//   [],
// )

#add-note(id: "3103", [Gauss-Tableau], [
  #let ct = table.cell(colspan: 6, align: center)[$=>$]
  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    [], [$x_1$], [$x_2$], [$x_3$], [$1$], [],
    [$"I"$], [1], [1], [1], [-6], [],
    [$"II"$],
    [1],
    [2],
    [3],
    [-10],
    table.cell(fill: red.lighten(60%))[$-("I")$],
    [$"III"$],
    [2],
    [3],
    [6],
    [-18],
    table.cell(fill: red.lighten(60%))[$-2("II")$],
    ct, [$"I'"$], [1], [1], [1], [-6],
    [], [$"II'"$], table.cell(fill: green.lighten(60%))[0], [1], [2], [-4],
    [], [$"III'"$], table.cell(fill: green.lighten(60%))[0], [1], [4], [-6],
    table.cell(fill: red.lighten(60%))[$-("II'")$],
    ct,
    [$"I''"$],
    [1],
    [1],
    [1],
    [-6], [], [$"II''"$], table.cell(fill: green.lighten(60%))[0], [1], [2],
    [-4],
    [],
    [$"III''"$],
    table.cell(fill: green.lighten(60%))[0],
    table.cell(fill: green.lighten(60%))[0],
    [2],
    [-2],
    table.cell(fill: red.lighten(60%))[$dot 1/2$],
    ct,
    [$"I'''"$],
    [1],
    [1],
    [1],
    [-6],
    table.cell(fill: red.lighten(60%))[$-("III'''")$],
    [$"II'''"$],
    table.cell(fill: green.lighten(60%))[0],
    [1],
    [2],
    [-4],
    table.cell(fill: red.lighten(60%))[$-2("III'''")$],
    [$"III'''"$],
    table.cell(fill: green.lighten(60%))[0],
    table.cell(fill: green.lighten(60%))[0],
    [1], [-1], [], ct,
  )

  Koeffizientenmatrix $A = mat(1, 1, 1; 0, 1, 2; 0, 0, 1)$

  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    [], [$x_1$], [$x_2$], [$x_3$], [$1$], [],
    [$"I''''"$],
    [1],
    [1],
    table.cell(fill: green.lighten(60%))[0],
    [-5],
    table.cell(fill: red.lighten(60%))[$-("II''''")$],
    [$"II''''"$],
    table.cell(fill: green.lighten(60%))[0],
    [1],
    table.cell(fill: green.lighten(60%))[0],
    [-2],
    [],
    [$"III''''"$],
    table.cell(fill: green.lighten(60%))[0],
    table.cell(fill: green.lighten(60%))[0],
    [1],
    [-1],
    [],
    ct,
    [],
    [1],
    table.cell(fill: green.lighten(60%))[0],
    table.cell(fill: green.lighten(60%))[0],
    [-3],
    [],
    [],
    table.cell(fill: green.lighten(60%))[0],
    [1],
    table.cell(fill: green.lighten(60%))[0],
    [-2],
    [],
    [],
    table.cell(fill: green.lighten(60%))[0],
    table.cell(fill: green.lighten(60%))[0],
    [1],
    [-1],
    [],
  )

  Ergebnisvektor $accent(b, harpoon) = vec(-6, -4, -1)$
  Lösungsvektor $accent(x, harpoon) = vec(x_1, x_2, x_3)$
  Lineares Gleichungssystem $A dot accent(x, harpoon) = accent(b, harpoon)$

  #text(fill: red)[$p$] = Anzahl Pivot-Variablen. \
  Wenn #text(fill: green)[$b_(p+1=...=b_m=0)$] dann ist das LGS lösbar (homogenes Gleichungssystem), sonst unlösbar. \
  Wenn $#text(fill: red)[$p$] = n$ dann hat LGS genau eine Lösung. \
  Wenn $#text(fill: red)[$p$] < n$ dann hat LGS unendlich viele Lösungen. \
])

#add-note(id: "3104", [Vektor], [Liste von Zahlen])
#add-note(
  id: "3105",
  [Nullvektor],
  [$accent(0, arrow) = vec(0, 0, 0)$],
)
#add-note(
  id: "3106",
  [Ortsvektor],
  [Ortsvektor $accent(p, arrow)$ vom Nullpunkt des Koordinatensystems $vec(0, 0, 0)$ zum Punkt $P$],
)
#add-note(
  id: "3107",
  [Richtungsvektor],
  [Richtungsektor $accent(A B, arrow)$ vom Punkt $A$ zum Punkt $B$ ist $accent(b, arrow) - accent(a, arrow)$],
)
#add-note(
  id: "3108",
  [Linearkombination],
  [ Linearkombination der Variabeln $x_1, x_2, x_3$ (Bsp. $3 dot x_1 - 2 dot x_2 + 4 dot x_3 = -6$). Vektoren werden jeweils mit einer Zahl mutlipliziert und miteinander summiert ],
)
#add-note(
  id: "3109",
  [Lineare Unabhängigkeit],
  [ $accent(v, arrow)_1, accent(v, arrow)_2, ..., accent(v, arrow)_n$ heissen linear Unabhängig, wenn die Gleichung \ $lambda_1 dot accent(v, arrow)_1, lambda_2 dot accent(v, arrow)_2, ..., lambda_n dot accent(v, arrow)_n = accent(0, arrow)$ genau eine Lösung hat, nämlich \ $lambda_1 = lambda_2 = ... = lambda_n = 0$ \ $mat(arrow.t, dots, arrow.t; accent(v, arrow)_1, dots, accent(v, arrow)_n; arrow.b, dots, arrow.b) dot accent(lambda, arrow) = accent(0, arrow)$ eindeutig lösbar $= accent(v, arrow)_1,...,accent(v, arrow)_n$ sind linear unabhängig ],
)
#add-note(id: "3110", [Vektorprodukt/Kreuzprodukt], [$
  accent(a, arrow) times accent(b, arrow) = accent(c, arrow) \ vec(a_1, a_2, a_3) times vec(b_1, b_2, b_3) = vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1)
$])
#add-note(id: "3111", [Skalarprodukt], [$
  accent(a, arrow) circle.filled.small accent(b, arrow) = c \ vec(a_1, a_2, a_3) circle.filled.small vec(b_1, b_2, b_3) = a_1 dot b_1 + a_2 dot b_2 + a_3 dot b_3
$])
#add-note(id: "3112", [Betrag/Länge eines Vektors], [$
  accent(a, arrow) = vec(2, -3, 5) \ abs(accent(a, arrow)) = sqrt(2^2 + (-3)^2 + 5^2) = sqrt(38)
$])
#add-note(
  id: "3113",
  [Normalenvektor],
  [\= Vektorprodukt?],
)

#add-note(
  id: "3114",
  [Vektorenrechnen Addition],
  $
    accent(v, arrow) + accent(w, arrow) = vec(1, 2, 3) + vec(5, -9, 4) = vec(1+5, 2+(-9), 3+4) = vec(6, -7, 7)
  $,
)
#add-note(
  id: "3115",
  [Vektorenrechnen Multiplikation mit reellen Zahlen (=Skalare)],
  $
    3 dot accent(v, arrow) = 3 dot vec(1, 2, 3) = vec(3 dot 1, 3 dot 2, 3 dot 3) = vec(3, 6, 9)
  $,
)

#add-note(
  id: "3116",
  [Falls die Vektoren senkrecht zueinanderstehen, ist das Skalarprodukt gleich],
  0,
)

#add-note(
  id: "3117",
  $lambda accent(0, arrow)$,
  $accent(0, arrow)$,
)
#add-note(
  id: "3118",
  $accent(v, arrow) + accent(0, arrow)$,
  $accent(v, arrow)$,
)
#add-note(
  id: "3119",
  $-accent(v, arrow)$,
  $-1 dot accent(v, arrow)$,
)
#add-note(
  id: "3120",
  $-accent(v, arrow) + accent(v, arrow)$,
  $accent(0, arrow)$,
)
#add-note(
  id: "3121",
  $(lambda mu)accent(v, arrow)$,
  $lambda(mu accent(v, arrow)) = lambda mu accent(v, arrow)$,
)
#add-note(
  id: "3122",
  $lambda(accent(v, arrow)+accent(w, arrow))$,
  $lambda accent(v, arrow) + lambda accent(w, arrow)$,
)
#add-note(
  id: "3123",
  $accent(v, arrow) + (accent(u, arrow)+accent(w, arrow))$,
  $(accent(v, arrow) + accent(u, arrow))+accent(w, arrow) = accent(v, arrow) + accent(u, arrow)+accent(w, arrow)$,
)

#add-note(
  id: "3124",
  [Kreuzprodukt],
  image("./img/kreuzprodukt.png"),
)

#add-note(
  id: "3125",
  [Anti-kommutativ],
  [ $accent(a, arrow) times accent(b, arrow) = -accent(b, arrow) times accent(a, arrow)$. Konsequenz: $accent(a, arrow) times accent(a, arrow) = -accent(a, arrow) times accent(a, arrow) = accent(0, arrow)$],
)
#add-note(
  id: "3126",
  [Distributiv],
  [ $accent(a, arrow) times (accent(b, arrow) + accent(c, arrow)) = accent(a, arrow) times accent(b, arrow) + accent(a, arrow) times accent(c, arrow)$],
)
#add-note(
  id: "3127",
  [Gemischt-assoziativ],
  [ $lambda (accent(a, arrow) times accent(b, arrow)) = (lambda accent(a, arrow)) times accent(b, arrow) = accent(a, arrow) times (lambda accent(b, arrow))$
    Das Kreuzprodukt ist *nicht* assoziativ. $accent(a, arrow) times accent(b, arrow) times accent(c, arrow)$ darf man nicht! $(accent(a, arrow) times accent(b, arrow)) times accent(c, arrow) != accent(a, arrow) times (accent(b, arrow) times accent(c, arrow))$],
)
#add-note(
  id: "3128",
  [Rechtssystem],
  image("./img/rechtssystem.png"),
)
#add-note(
  id: "3129",
  $"Flächeninhalt " h dot a$,
  image("./img/flaecheninhalt-kreuzprodukt.png"),
)

#add-note(
  id: "3130",
  [$accent(a, arrow) times accent(b, arrow)$ steht immer],
  [ senkrecht auf $accent(a, arrow)$ und auf $accent(b, arrow)$.],
)

#add-note(
  id: "3131",
  [$accent(a, arrow), accent(b, arrow), accent(a, arrow) times accent(b, arrow)$ bilden ein],
  [ Rechtssystem],
)

#add-note(
  id: "3132",
  $abs(accent(a, arrow) times accent(b, arrow)) =$,
  [Flächeninhalt des durch $accent(a, arrow)$ und $accent(b, arrow)$ aufgespannten Parallelogramms $= abs(accent(a, arrow)) dot abs(accent(b, arrow)) dot sin(phi)$],
)


#add-note(
  id: "3133",
  [Ein Vektorraum ist],
  [eine Menge $V$ mit den Rechenoperationen:

    $
      plus.o: V times V -> V, (accent(v, arrow),accent(w, arrow)) |-> accent(v, arrow) plus.o accent(w, arrow)
    $
    $
      dot.o: RR times V -> V, (lambda,accent(v, arrow)) |-> lambda dot.o accent(v, arrow)
    $
  ],
)

#add-note(id: "3134", [Ein Vektorraum hat die Eigenschaften], [
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
])


#add-note(
  id: "3135",
  [Kern von $A$],
  [$= U = {accent(x, arrow) in RR^n mid(|) A accent(x, arrow) = accent(0, arrow)}, A in RR^(m times n)$ ist ein Untervektorraum von $RR^n$.],
)

#add-note(
  id: "3136",
  [Eine Lineare Abbildung ist],
  [eine Funktion
    $ L : cases(RR^n &-> RR^m, accent(x, arrow) &|-> L(accent(x, arrow))) $
    mit den Eigenschaften
    $
      L(accent(x, arrow) + accent(y, arrow)) = L(accent(x, arrow)) + L(accent(y, arrow)) \
      L(lambda accent(x, arrow)) = lambda L(accent(x, arrow)) \
    $
    Für jede lineare Abbildung $L: RR^n -> RR^m$ gibt es eine (Abbildungs) Matrix $M in RR^(m times n)$ mit der Eigenschaft, dass $L(accent(x, arrow)) = M accent(x, arrow)$
    $
      M = mat(m_(1 1), ..., m_(1 n); dots.v, dots.v, dots.v; m_(m 1), ..., m_(m n)) \
      m_(i j) = accent(e, arrow)_i circle.filled.small L(accent(e, arrow)_j)
    $
  ],
)

#add-note(
  id: "3137",
  [Spaltenvektoren],
  [Spalten der Matrix als Vektoren],
)
#add-note(
  id: "3138",
  [Zeilenvektoren],
  [Zeilen der Matrix als Vektoren],
)
#add-note(
  id: "3139",
  [Rang],
  [Wieviele Spaltenvektoren einer Matrix linear unabhängig sind],
)
#add-note(
  id: "3140",
  [Nullmatrix],
  [$0 = mat(0, dots, 0; dots.v, dots.v, dots.v; 0, dots, 0)$],
)
#add-note(
  id: "3141",
  [Quadratische Matrix],
  [$M in RR^(n times n)$ Gleichviele Zeichen und Spalten],
)
#add-note(
  id: "3142",
  [Diagonalmatrix],
  [(immer quadratisch und symmetrisch): $D=mat(x_1, 0, 0, 0; 0, x_2, 0, 0; 0, 0, x_3, 0; 0, 0, 0, x_4), d_(i j) = 0 "für" i != j$],
)
#add-note(
  id: "3143",
  [Einheitsmatrix],
  [(immer diagonal): $E=mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$],
)
#add-note(
  id: "3144",
  [Symmetrische Matrix],
  [(immer quadratisch): $A=A^T, a_(i j) = a_(i j), mat(1, 2, 3; 2, 4, 4; 3, 4, 1)$],
)
#add-note(
  id: "3145",
  [Obere Dreiecksmatrix],
  [$O = mat(x_1, x_2, x_3; 0, x_4, x_5; 0, 0, x_6), o_(i j) = 0 "für" i > j$],
)
#add-note(
  id: "3146",
  [Kovarianzmatrix],
  [immer symmetrisch],
)
#add-note(
  id: "3147",
  [Reguläre Matrix],
  [Quadratische Matrix mit höchstem Rang (Rang = Anzahl Spalten/Reihen)],
)
#add-note(
  id: "3148",
  [Singuläre Matrix],
  [Quadratische Matrix mit kleinerem Rang (Rang < Anzahl Spalten/Reihen)],
)
#add-note(
  id: "3149",
  [Invertierbare Matrix],
  [ Für $A in RR^(n times n)$ heisst $A$ invertierbar, wenn es eine Matrix $A^(-1)$ gibt, so dass $A dot A^(-1) = A^(-1) dot A = "Einheitsmatrix (E)"$. Dies ist der Fall, wenn $A$ Regulär ist. ],
)

#add-note(
  id: "3150",
  [Matrix mit 2 Zeilen und 3 Spalten],
  [
    $
      A = mat(1, 4, 5; 2, 3, 7) in RR^(2 times 3)
    $
    Komponenten von $A$: $a_(i j)$ \
    $i$: Zeilenindex, $j$: Spaltenindex. Bsp: $a_23 = 7$ \
  ],
)

#add-note(
  id: "3151",
  [Matrizen als Vektoren interpretieren

    $-> A$ ist ein 6-Dimensionaler VR (Vektorraum)
  ],
  [
    $
      "Variante 1: " vec(a_11, a_12, a_13, a_14, a_15, a_16)= vec(1, 4, 5, 2, 3, 7) \
      "Variante 2: " vec(a_11, a_12, a_13, a_14, a_15, a_16)= vec(1, 2, 4, 3, 5, 7) \
    $

    $
      RR^n "interpretiere als" cases(
        RR^(n times 1) -> vec(a_1, a_2, dots.v, a_n) "Spaltenvektor", RR^(1 times n) -> mat(a_1, a_2, dots, a_n) "Zeilenvektor",
      )
    $
    Zu $A$ gehörige Zeilenvektore $accent(a_1, arrow) = mat(1, 4, 5), accent(a_2, arrow) = mat(2, 3, 7)$
    $
      A = mat(<- accent(a_1, arrow) ->; <- accent(a_2, arrow) ->) = mat(1, 4, 5; 2, 3, 7)
    $
    Zu $A$ gehörige Spaltenvektore $accent(a_1, arrow) = vec(1, 2), accent(a_2, arrow) = vec(4, 3), accent(a_3, arrow) = vec(5, 7)$
    $
      A = mat(
        arrow.t, arrow.t, arrow.t; accent(a_1, arrow), accent(a_2, arrow), accent(a_3, arrow); arrow.b, arrow.b, arrow.b
      ) = mat(1, 4, 5; 2, 3, 7)
    $
  ],
)

#add-note(
  id: "3152",
  [Transponierte Matrix $A in RR^(m times n)$ wäre],
  [ $A^T in RR^(n times m)$ \
    $A = (a_(i j)), A^T = (a_(j i))$ \
    Rolle von Zeile und Spalte vertauscht: $a_(i j) -> a_(j i)$ \
    Bsp: $ A = mat(1, 0; 0, 2; 3, 1) in RR^(3 times 2) \
    A^T = mat(1, 0, 3; 0, 2, 1) in RR^(2 times 3) \
    vec(1, 4, 5)^T =mat(1, 4, 5) $
  ],
)

#add-note(id: "3153", [Matrixmultiplikation], [

  Meistens nicht kommutativ ($A dot B != B dot A$)\
  $B$ muss genau gleich viele Zeilen haben wie $A$ Spalten\
  $
    A in RR^(#text(fill: red)["m"] times #text(fill: green)["l"]), B in RR^(#text(fill: green)["l"] times #text(fill: blue)["n"]), C = A dot B in RR^(#text(fill: red)["m"] times #text(fill: blue)["n"]) \
    c_(i j) = sum_(k=1)^l a_(i k) b_(k j) \
    #text(fill: red)[$mat(2, 3, 1; 4, -1, 7)$] dot #text(fill: blue)[$mat(6, 4; 1, 0; 8, 9)$] = mat(
      (#text(fill: red)[2] dot #text(fill: blue)[6]+#text(fill: red)[3] dot #text(fill: blue)[1]+#text(fill: red)[1] dot #text(fill: blue)[8]), (#text(fill: red)[2] dot #text(fill: blue)[4]+#text(fill: red)[3] dot #text(fill: blue)[0]+#text(fill: red)[1] dot #text(fill: blue)[9])
      ; (#text(fill: red)[4] dot #text(fill: blue)[6]+#text(fill: red)[-1] dot #text(fill: blue)[1]+#text(fill: red)[7] dot #text(fill: blue)[8]), (#text(fill: red)[4] dot #text(fill: blue)[4]+#text(fill: red)[-1] dot #text(fill: blue)[0]+#text(fill: red)[7] dot #text(fill: blue)[9])
    ) = mat(23, 17; 79, 79)
  $
])

#add-note(
  id: "3154",
  $(A dot B) dot C$,
  $A dot (B dot C) = A dot B dot C$,
)
#add-note(
  id: "3155",
  $(A + B) dot C$,
  $A dot C + B dot C$,
)
#add-note(
  id: "3156",
  $C dot (A + B)$,
  $C dot A + C dot B$,
)
#add-note(
  id: "3157",
  $E dot A$,
  $A dot E = A "für" A in RR^(n times n)$,
)
#add-note(id: "3158", $(A^T)^T$, $A$)
#add-note(id: "3159", $(A+B)^T$, $A^T + B^T$)
#add-note(id: "3160", $(lambda A)^T$, $lambda A^T$)
#add-note(id: "3161", $(A dot B)^T$, $B^T dot A^T$)

#add-note(
  id: "3162",
  [Parameterform],
  $
    g : accent(x, arrow) = underbrace(vec(4, 5, 1), "Ortsvektor" accent(p, arrow)) + t dot underbrace(vec(-2, 1, 6), "Richtungsvektor" accent(P X, arrow)), t in RR
  $,
)

#add-note(
  id: "3163",
  [Ebenen Parameterform],
  $
    E : underbrace(accent(x, arrow), vec(x, y, z)) =
    #text(fill: purple)[$underbrace(vec(4, 5, 1, "Ortsvektor" accent(o, arrow)))$]
    + s dot #text(fill: red)[$underbrace(vec(-2, 1, 6, "Spannvektor" accent(A B, arrow)))$]
    + t dot #text(fill: green)[$underbrace(vec(-1, 5, 4, "Spannvektor" accent(A C, arrow)))$]
    , s, t in RR
  $,
)

#add-note(
  id: "3164",
  [ Normalenform / Koordinatenform],
  $
    E = [vec(x, y, z) - underbrace(vec(1, 2, 3), "Punkt auf Ebene")] circle.filled.small underbrace(vec(1, 0, -1), accent(n, arrow) "Orthogonal zur Ebene") = 0 \
    => x-1-z+3 = 0
  $,
)

#add-note(id: "3165", [Hessesche Normalform], [

  Abstand von Punkt $P(2,8,2)$ zur Ebene $E : 2x - y + 4z = 1$

  $
    accent(n, arrow) = vec(2, -1, 4) \
    abs(accent(n, arrow)) = sqrt(21) \
    (2x-y+4z-1)/sqrt(21) \
    => (2 dot 2 - 1 dot 8 + 4 dot 2-1)/sqrt(21) \
    =3/sqrt(21) \
  $
])
