#import "./ankiconf.typ": *
#import "../lib.typ": *

#show: doc => conf(doc)

#card(
  target-deck: "DMI",
  id: "3001",
  q: [Aussage],
  a: [Feststellender Satz, dem eindeutig "wahr" oder "falsch" zugeordnet werden kann. \ Symbole wie $A,B,C...$ werden dafür verwendet],
)
#card(
  target-deck: "DMI",
  id: "3002",
  q: [Aussagenlogische Form],
  a: [Kombination von Aussagen, verknüpft durch Junktoren],
)
#card(
  target-deck: "DMI",
  id: "3003",
  q: [Aussageform],
  a: [ Aussagen verknüpft mit Variablen ],
)
#card(
  target-deck: "DMI",
  id: "3004",
  q: [Normalform],
  a: [ Standartisierte Aussagenlogische Formen (Formeln) ],
)
#card(
  target-deck: "DMI",
  id: "3005",
  q: [Negationsnormalform],
  a: [ $not$ steht ausschliesslich direkt vor Aussagen oder Konstanten ],
)
#card(
  target-deck: "DMI",
  id: "3006",
  q: [Verallgemeinerte Disjunktion],
  a: [ Einzelne Aussage oder Negation \ wahr oder falsch \ Disjunktion $A or B$, falls $A$ und $B$ selbst verallgemeinerte Disjunktionen sind \ ],
)
#card(
  target-deck: "DMI",
  id: "3007",
  q: [Verallgemeinerte Konjunktion],
  a: [ Einzelne Aussage oder Negation \ wahr oder falsch \ Konjunktion $A and B$, falls $A$ und $B$ selbst verallgemeinerte Konjunktionen sind \ ],
)
#card(
  target-deck: "DMI",
  id: "3008",
  q: [Disjunktive Normalform ],
  a: [ Disjunktion von (oder eine einzelne) verallgemeinerten Konjunktionen ],
)
#card(
  target-deck: "DMI",
  id: "3009",
  q: [Konjunktive Normalform ],
  a: [ Konjunktion von (oder eine einzelne) verallgemeinerten Disjunktionen ],
)
#card(target-deck: "DMI", id: "3010", q: [Kontradiktion], a: [ Immer falsch ])
#card(target-deck: "DMI", id: "3011", q: [Tautologie], a: [ Immer wahr ])
#card(
  target-deck: "DMI",
  id: "3012",
  q: [Junktoren (/Konnektoren)],
  a: [ $not$ Negation \ $and$ Konjunktion \ $or$ Disjunktion (einschliessliches oder!) \ $=>$ Implikation \ $<=>$ Äquivalenz \ ],
)
#card(
  target-deck: "DMI",
  id: "3013",
  q: [Abtrennungsregel],
  a: [ $(A and (A => B)) => B$ ],
)
#card(
  target-deck: "DMI",
  id: "3014",
  q: [Bindungsstärke ],
  a: [ $not$ vor $and,or$ vor $=>,<=>$ ],
)

#card(target-deck: "DMI", id: "3015", q: $(A => B)$, a: $(not B => not A)$)
#card(target-deck: "DMI", id: "3016", q: $(A => B)$, a: $(not A or B)$)
#card(
  target-deck: "DMI",
  id: "3017",
  q: $(A <=> B)$,
  a: $(A and B) or (not A and not B)$,
)
#card(target-deck: "DMI", id: "3018", q: $not (A => B)$, a: $A and not B$)
#card(target-deck: "DMI", id: "3019", q: $A or (not A and B)$, a: $A or B$)
#card(target-deck: "DMI", id: "3020", q: $A and (A => B)$, a: $B$)
#card(
  target-deck: "DMI",
  id: "3021",
  q: $(A => B => C)$,
  a: $(A => B) and (B => C)$,
)

#card(
  target-deck: "DMI",
  id: "3022",
  q: [Kommutativität],
  a: [ $(A and B) <=> (B and A)$ \ $(A or B) <=> (B or A)$ ],
)
#card(
  target-deck: "DMI",
  id: "3023",
  q: [Assoziativität],
  a: [ $A and (B and C) <=> (A and B) and C$ \ $A or (B or C) <=> (A or B) or C$ ],
)
#card(
  target-deck: "DMI",
  id: "3024",
  q: [Distributivität],
  a: [ $A and (B or C) <=> (A and B) or (A and C)$ \ $A or (B and C) <=> (A or B) and (A or C)$ ],
)
#card(
  target-deck: "DMI",
  id: "3025",
  q: [Absorption],
  a: [ $A or (A and B) <=> A$ \ $A and (A or B) <=> A$ ],
)
#card(
  target-deck: "DMI",
  id: "3026",
  q: [Idempotenz],
  a: [ $A or A = A$ \ $A and A = A$ ],
)
#card(
  target-deck: "DMI",
  id: "3027",
  q: [Doppelte Negation],
  a: [ $not (not A) <=> not not A <=> A$ ],
)
#card(
  target-deck: "DMI",
  id: "3028",
  q: [Konstanten],
  a: [ $W= "wahr"$ \ $F= "falsch"$ ],
)
#card(
  target-deck: "DMI",
  id: "3029",
  q: [de Morgan],
  a: [ $not (A and B) <=> not A or not B$ \ $not (A or B) <=> not A and not B$ ],
)

#card(
  target-deck: "DMI",
  id: "3030",
  q: [Subjekt],
  a: [ "Konkretes Ding" / Stellvertreter einer Variable ],
)
#card(
  target-deck: "DMI",
  id: "3031",
  q: [Prädikat],
  a: [ "Eigenschaft", zB "ist eine Primzahl" \ Prädikate werden oft wie Funktionen geschrieben. Ist $P$ ein Prädikat, dann bedeutet $P(x)$, dass $x$ das Prädikat erfüllt. $P(x)$ ist eine Aussageform. ],
)
#card(
  target-deck: "DMI",
  id: "3032",
  q: [Quantor],
  a: [ $forall$ Allquantor (Für alle) \ $exists$ Existenzquantor (Es existiert) ],
)

#card(target-deck: "DMI", id: "3033", q: [Induktion], a: $A(1) and (A(n) => A(n+1)) => A(m), m in NN$))

#card(
  target-deck: "DMI",
  id: "3034",
  q: [Induktion Beispiel: $2 divides (6^n)$],
  a: [
    + Verankerung: $n = 0$
      - $2 divides (6^0)$
    + Induktionsschritt $n->n+1$
      - $2 divides (6^(n+1))$
      + Induktionsannahme: $2 divides (6^n)$
      + Behauptung: $2 divides (6^(n+1))$
      + Beweis: Verwendung der Annahme, um Richtigkeit der Behauptung zu zeigen
  ],
)

#card(
  target-deck: "DMI",
  id: "3035",
  q: [Direkter Beweis],
  a: $f(n) = f_1 (n) = f_2 (n) = ... = f_m (n) = g(n)$,
)
#card(
  target-deck: "DMI",
  id: "3036",
  q: [Dfferenz gleich Null],
  a: $f(n) - g(n) = 0 => f(n) = g(n)$,
)
#card(target-deck: "DMI", id: "3037", q: [Äquivalenzumformung], a: [TODO])
#card(
  target-deck: "DMI",
  id: "3038",
  q: [Dritte Grösse (vereinfachen)],
  a: $g(n) = h(n) = f(n)$,
)

#card(
  target-deck: "DMI",
  id: "3039",
  q: [Folge],
  a: [ Nummerierte Liste von Objekten (Folgegliedern) ],
)
#card(
  target-deck: "DMI",
  id: "3040",
  q: [Reihe],
  a: [ Summe von Folgegliedern einer Zahlenfolge ],
)

#card(target-deck: "DMI", id: "3041", q: [Aufzählend], a: [ ${1,2,3}$ ])
#card(
  target-deck: "DMI",
  id: "3042",
  q: [Beschreibend],
  a: [ ${x in NN^+ mid(|) x < 4}$ ],
)
#card(
  target-deck: "DMI",
  id: "3043",
  q: [Mächtigkeit],
  a: [ Anzahl Elemente einer Menge \ $abs(M)$ ],
)
#card(
  target-deck: "DMI",
  id: "3044",
  q: [Potenzmenge],
  a: [ Menge aller Teilmengen einer Menge \ $P(M)$ \ $abs(P(M)) = 2^(abs(M))$ ],
)
#card(
  target-deck: "DMI",
  id: "3045",
  q: [Teilermenge],
  a: [ $T(n) =$ Menge der Teiler der Zahl $n$ ],
)
#card(
  target-deck: "DMI",
  id: "3046",
  q: [Kartesisches Produkt],
  a: [ $A times B = {(a,b) mid(|) a in A, b in B}$ ],
)

#card(target-deck: "DMI", id: "3047", q: $overline(overline(A))$, a: $A$)
#card(target-deck: "DMI", id: "3048", q: $A inter overline(A)$, a: $emptyset$)
#card(target-deck: "DMI", id: "3049", q: $A union overline(A)$, a: $M$)
#card(
  target-deck: "DMI",
  id: "3050",
  q: $overline(A inter B)$,
  a: $overline(A) union overline(B)$,
)
#card(
  target-deck: "DMI",
  id: "3051",
  q: $overline(A union A)$,
  a: $overline(A) inter overline(B)$,
)

#card(
  target-deck: "DMI",
  id: "3052",
  q: [Funktion/Abbildung],
  a: [ Zuordnung, die jedem Elemend der Definitionsmenge $D$ genau ein Element einer Zielmenge $Z$ zuordnet. \ Injektive Relation \ $f: D->Z$ \ Abbildungen mit mehreren Argumenten: $f: A times B -> Z$, $f(a,b) = y$ ],
)
#card(
  target-deck: "DMI",
  id: "3053",
  q: [Graph],
  a: [ Menge von Paaren $(x, f(x))$ \ $G in D times Z$ ],
)
#card(
  target-deck: "DMI",
  id: "3054",
  q: [Relation],
  a: [ Teilmenge des Kartesischen Produktes mehrerer Mengen \ $ A = product_(i=1)^n A_i, abs(A_i) = n_i => abs(A) = product_(i=1)^n n_i $ \ Kleiner-Relation: $R_< = {(a,b) mid(|) a in A, b in B, a < b}$ \ Gleich-Relation: $R_= = {(a,b) mid(|) a in A, b in B, a = b}$ \ Kleiner-Gleich-Relation: $R_(<=) = R_= union R_< = {(a,b) mid(|) a in A, b in B, a <= b}$ ],
)
#card(
  target-deck: "DMI",
  id: "3055",
  q: [Surjektiv],
  a: [ Alle Elemente der Definitions- und Zielmenge sind "verknüpft" / jedes Element der Bildmenge kommt als Bild vor ],
)
#card(
  target-deck: "DMI",
  id: "3056",
  q: [Injektiv],
  a: [ Alle Inputs haben eindeutige Outputs \ $a_1 != a_2 => f(a_1) != f(a_2)$ ],
)
#card(
  target-deck: "DMI",
  id: "3057",
  q: [Bijektiv],
  a: [ Surjektiv und Injektiv ],
)
#card(
  target-deck: "DMI",
  id: "3058",
  q: [Reflexiv],
  a: [ Alle Elemente von A stehen zu sich selbst in Beziehung \ $a in A => (a,a) in R$ \ $A <=> A$ ],
)
#card(
  target-deck: "DMI",
  id: "3059",
  q: [Symmetrisch],
  a: [ $(a,b) in R and (b,a) in R$ \ $(A <=> B) <=> (B <=> A)$ ],
)
#card(
  target-deck: "DMI",
  id: "3060",
  q: [Transitiv],
  a: [ $(a,b) in R and (b,c) in R => (a,c) in R$ \ $(A <=> B) and (B <=> C) => (A <=> C)$ ],
)
#card(
  target-deck: "DMI",
  id: "3061",
  q: [Äquivalenzrelation],
  a: [ reflexiv, symmetrisch und transitiv \ $<=>, =$ ],
)
#card(
  target-deck: "DMI",
  id: "3062",
  q: [Irreflexiv],
  a: [ $a in A => not (a,a) in R$ ],
)
#card(
  target-deck: "DMI",
  id: "3063",
  q: [Asymmetrisch],
  a: [ $(a,b) in R => not (b,a) in R$ ],
)
#card(
  target-deck: "DMI",
  id: "3064",
  q: [Antisymmetrisch],
  a: [ $((a,b) in R) and ((b,a) in R) => a = b$ ],
)
#card(
  target-deck: "DMI",
  id: "3065",
  q: [Ordnungsrelation],
  a: [ reflexiv, antisymmetrisch und transitiv \ $<=$ ],
)
#card(
  target-deck: "DMI",
  id: "3066",
  q: [Symmetrische Differenz],
  a: [ $A Delta B = {x in G mid(|) (x in A union B) and not (x in A inter B)}$\ $A Delta B = (A union B) without (A inter B)$\ $(A Delta B) Delta C = A Delta (B Delta C)$ ],
)


#card(
  target-deck: "DMI",
  id: "3067",
  q: [Die Modulo-Relation ist eine],
  a: [_Äquivalenzrelation_ auf $ZZ$],
)
#card(
  target-deck: "DMI",
  id: "3078",
  q: [Teiler-Relation],
  a: [ Für $a, b in ZZ$ ist die Teiler-Relation $b divides a <=> T(b,a) <=> exists q in ZZ: b q = a$ \ $b divides a <=> -b divides a$ \ $b divides a <=> b divides -a$ \ Ordnungsrelation auf $NN$ ],
)
#card(
  target-deck: "DMI",
  id: "3079",
  q: [Modulo-Relation],
  a: [ Für $a,q,r in ZZ$ ist die Modulo-Relation $R_q (a,r) <=> q divides a - r <=> a equiv r mod q$ ],
)
#card(
  target-deck: "DMI",
  id: "3080",
  q: [$~$],
  a: [ "relates to" \ $a ~ b <=> (a,b) in R$ ],
)
#card(
  target-deck: "DMI",
  id: "3081",
  q: [Quotient, Rest],
  a: [ Zu jeder Zahl $a in ZZ$ und jeder Zahl $b in ZZ$ gibt es eindeutig bestimmte Zahlen $q,r in ZZ$ mit $a=q dot b+r, 0 <= r < b$ \ Bsp: $7 = 2 dot 3 + 1$ \ $q$ heisst _Quotient_ \ $r$ heisst _Rest_ \ ],
)
#card(
  target-deck: "DMI",
  id: "3082",
  q: [Restklassen],
  a: [ $[b]_q = {a in ZZ mid(|) a equiv b mod q}, q > 0$ \ $ZZ_q = {[0]_q,[1]_q,[2]_q,...,[q-1]_q} = underbrace({0,1,2,3,...,q-1}, "Vereinfachung")$ ],
)
#card(
  target-deck: "DMI",
  id: "3083",
  q: [Multiplikatives Inverses],
  a: [ Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn $a dot b equiv 1 mod q$ ],
)
#card(
  target-deck: "DMI",
  id: "3084",
  q: [Nullteiler],
  a: [ Wenn für $a,b in ZZ_q: a b equiv 0 mod q$ und $a equiv.not 0 mod q and b equiv.not 0 mod q$, heissen $a,b$ _Nullteiler_ ],
)

#card(
  target-deck: "DMI",
  id: "3085",
  q: $(a+b) mod n$,
  a: $((a mod n)+(b mod n)) mod n$,
)
#card(
  target-deck: "DMI",
  id: "3086",
  q: $(a-b) mod n$,
  a: $((a mod n)-(b mod n)) mod n$,
)
#card(
  target-deck: "DMI",
  id: "3087",
  q: [$(a dot b) mod n$],
  a: [$((a mod n) dot b mod n) mod n$],
)
#card(
  target-deck: "DMI",
  id: "3088",
  q: $a^d mod n$,
  a: $(a^(d-x) dot a^x) mod n = ((a^(d-x) mod n) dot (a^x mod n)) mod n$,
)

#card(
  target-deck: "DMI",
  id: "3089",
  q: [$"ggT"(a,b)$],
  a: [$max{d in NN mid(|) d divides a and d divides b}$],
)
#card(
  target-deck: "DMI",
  id: "3090",
  q: [$"kgV"(a,b)$],
  a: [ $min{m in NN mid(|) a divides m and b divides m}$ \ $(a b)/("ggT"(a,b))$ ],
)
#card(
  target-deck: "DMI",
  id: "3091",
  q: [Teilerfremd],
  a: [ Zwei Zahlen $a,b in NN$ heissen _Teilerfremd_, wenn $"ggT"(a,b) = 1$ \ Sei $p in NN$ eine Primzahl und $q in NN, q < p, q != 0$ dann ist $"ggT"(p,q)=1$ ],
)
#card(
  target-deck: "DMI",
  id: "3092",
  q: [Euklidscher Algorithmus],
  a: [Seien $a,b in NN, a != b, a != 0, b != 0$ \
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

#card(
  target-deck: "DMI",
  id: "3093",
  q: [Erweiteter Euklidscher Algorithmus],
  a: [
    Seien $a,b in NN, a != b, a != 0, b != 0$ \
    Initialisierung: Setze $x:=a,y:=b,q:=x div y,r:=x-q dot y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und r so, dass $x=q dot y+r$ ist) \
    Wiederhole bis $r=0$ ist \
    Ergebnis: $y = "ggT"(a,b) = s dot a + t dot b$ \
    Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t dot v equiv 1 mod a$
  ],
)

#card(
  target-deck: "DMI",
  id: "3094",
  q: [Erweiteter Euklidscher Algorithmus Spalten],
  a: [ $i$ \
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

#card(
  target-deck: "DMI",
  id: "3095",
  q: [Kleiner Fermat],
  a: [Sei $p in NN$ eine Primzahl und $x in ZZ without {0}$ mit $"ggT"(x,p)=1$ \
    Dann ist: $x^(p-1) equiv 1 mod p$ \
    Daraus folgend:
    $
      & x^(p-1) equiv 1 mod p            && | ()^n \
      & <=>x^(n(p-1)) equiv 1 mod p      && | dot x \
      & <=>x^(1+n(p-1)) equiv x mod p \
      & <=>x^(1 mod (p-1)) equiv x mod p
    $],
)

#card(target-deck: "DMI", id: "3096", q: [Satz von Euler], a: [
  Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist $z^(phi(n)) equiv 1 mod n$.
])

#card(
  target-deck: "DMI",
  id: "3097",
  q: [Euler'sche $phi$-Funktion (Totient)],
  a: [
    Sei $n in NN without {0}$ und $ZZ_n^* = {x in ZZ_n mid(|) x "hat ein multiplikatives Inverses in " ZZ_n}$. Dann heisst $phi(n)$:
    $
      phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
             & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
             & =abs(ZZ_n^*)
    $
    Falls $p$ Primzahl ist, dann ist $phi(p) = p-1$
  ],
)

#card(
  target-deck: "DMI",
  id: "3098",
  q: [Sei $n in NN$ eine Primzahl, dann $phi(n) =$],
  a: [$n - 1$],
)
#card(
  target-deck: "DMI",
  id: "3099",
  q: [Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann $phi(n^p) =$],
  a: $n^(p-1) dot (n-1)$,
)
#card(
  target-deck: "DMI",
  id: "3100",
  q: [Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann $phi(n dot m) =$],
  a: $phi(n) dot phi(m)$,
)

#card(target-deck: "DMI", id: "3101", q: [RSA Verschlüsselung], a: [
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

#card(target-deck: "DMI", id: "3102", q: [Pivot-Gleichung], a: [$
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

#card(target-deck: "DMI", id: "3103", q: [Gauss-Tableau], a: [
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

#card(target-deck: "DMI", id: "3104", q: [Vektor], a: [Liste von Zahlen])
#card(
  target-deck: "DMI",
  id: "3105",
  q: [Nullvektor],
  a: [$accent(0, arrow) = vec(0, 0, 0)$],
)
#card(
  target-deck: "DMI",
  id: "3106",
  q: [Ortsvektor],
  a: [Ortsvektor $accent(p, arrow)$ vom Nullpunkt des Koordinatensystems $vec(0, 0, 0)$ zum Punkt $P$],
)
#card(
  target-deck: "DMI",
  id: "3107",
  q: [Richtungsvektor],
  a: [Richtungsektor $accent(A B, arrow)$ vom Punkt $A$ zum Punkt $B$ ist $accent(b, arrow) - accent(a, arrow)$],
)
#card(
  target-deck: "DMI",
  id: "3108",
  q: [Linearkombination],
  a: [ Linearkombination der Variabeln $x_1, x_2, x_3$ (Bsp. $3 dot x_1 - 2 dot x_2 + 4 dot x_3 = -6$). Vektoren werden jeweils mit einer Zahl mutlipliziert und miteinander summiert ],
)
#card(
  target-deck: "DMI",
  id: "3109",
  q: [Lineare Unabhängigkeit],
  a: [ $accent(v, arrow)_1, accent(v, arrow)_2, ..., accent(v, arrow)_n$ heissen linear Unabhängig, wenn die Gleichung \ $lambda_1 dot accent(v, arrow)_1, lambda_2 dot accent(v, arrow)_2, ..., lambda_n dot accent(v, arrow)_n = accent(0, arrow)$ genau eine Lösung hat, nämlich \ $lambda_1 = lambda_2 = ... = lambda_n = 0$ \ $mat(arrow.t, dots, arrow.t; accent(v, arrow)_1, dots, accent(v, arrow)_n; arrow.b, dots, arrow.b) dot accent(lambda, arrow) = accent(0, arrow)$ eindeutig lösbar $= accent(v, arrow)_1,...,accent(v, arrow)_n$ sind linear unabhängig ],
)
#card(target-deck: "DMI", id: "3110", q: [Vektorprodukt/Kreuzprodukt], a: [$
  accent(a, arrow) times accent(b, arrow) = accent(c, arrow) \ vec(a_1, a_2, a_3) times vec(b_1, b_2, b_3) = vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1)
$])
#card(target-deck: "DMI", id: "3111", q: [Skalarprodukt], a: [$
  accent(a, arrow) circle.filled.small accent(b, arrow) = c \ vec(a_1, a_2, a_3) circle.filled.small vec(b_1, b_2, b_3) = a_1 dot b_1 + a_2 dot b_2 + a_3 dot b_3
$])
#card(target-deck: "DMI", id: "3112", q: [Betrag/Länge eines Vektors], a: [$
  accent(a, arrow) = vec(2, -3, 5) \ abs(accent(a, arrow)) = sqrt(2^2 + (-3)^2 + 5^2) = sqrt(38)
$])
#card(
  target-deck: "DMI",
  id: "3113",
  q: [Normalenvektor],
  a: [\= Vektorprodukt?],
)

#card(
  target-deck: "DMI",
  id: "3114",
  q: [Vektorenrechnen Addition],
  a: $
    accent(v, arrow) + accent(w, arrow) = vec(1, 2, 3) + vec(5, -9, 4) = vec(1+5, 2+(-9), 3+4) = vec(6, -7, 7)
  $,
)
#card(
  target-deck: "DMI",
  id: "3115",
  q: [Vektorenrechnen Multiplikation mit reellen Zahlen (=Skalare)],
  a: $
    3 dot accent(v, arrow) = 3 dot vec(1, 2, 3) = vec(3 dot 1, 3 dot 2, 3 dot 3) = vec(3, 6, 9)
  $,
)

#card(
  target-deck: "DMI",
  id: "3116",
  q: [Falls die Vektoren senkrecht zueinanderstehen, ist das Skalarprodukt gleich],
  a: 0,
)

#card(
  target-deck: "DMI",
  id: "3117",
  q: $lambda accent(0, arrow)$,
  a: $accent(0, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3118",
  q: $accent(v, arrow) + accent(0, arrow)$,
  a: $accent(v, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3119",
  q: $-accent(v, arrow)$,
  a: $-1 dot accent(v, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3120",
  q: $-accent(v, arrow) + accent(v, arrow)$,
  a: $accent(0, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3121",
  q: $(lambda mu)accent(v, arrow)$,
  a: $lambda(mu accent(v, arrow)) = lambda mu accent(v, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3122",
  q: $lambda(accent(v, arrow)+accent(w, arrow))$,
  a: $lambda accent(v, arrow) + lambda accent(w, arrow)$,
)
#card(
  target-deck: "DMI",
  id: "3123",
  q: $accent(v, arrow) + (accent(u, arrow)+accent(w, arrow))$,
  a: $(accent(v, arrow) + accent(u, arrow))+accent(w, arrow) = accent(v, arrow) + accent(u, arrow)+accent(w, arrow)$,
)

#card(
  target-deck: "DMI",
  id: "3124",
  q: [Kreuzprodukt],
  a: image("./img/kreuzprodukt.png"),
)

#card(
  target-deck: "DMI",
  id: "3125",
  q: [Anti-kommutativ],
  a: [ $accent(a, arrow) times accent(b, arrow) = -accent(b, arrow) times accent(a, arrow)$. Konsequenz: $accent(a, arrow) times accent(a, arrow) = -accent(a, arrow) times accent(a, arrow) = accent(0, arrow)$],
)
#card(
  target-deck: "DMI",
  id: "3126",
  q: [Distributiv],
  a: [ $accent(a, arrow) times (accent(b, arrow) + accent(c, arrow)) = accent(a, arrow) times accent(b, arrow) + accent(a, arrow) times accent(c, arrow)$],
)
#card(
  target-deck: "DMI",
  id: "3127",
  q: [Gemischt-assoziativ],
  a: [ $lambda (accent(a, arrow) times accent(b, arrow)) = (lambda accent(a, arrow)) times accent(b, arrow) = accent(a, arrow) times (lambda accent(b, arrow))$
    Das Kreuzprodukt ist *nicht* assoziativ. $accent(a, arrow) times accent(b, arrow) times accent(c, arrow)$ darf man nicht! $(accent(a, arrow) times accent(b, arrow)) times accent(c, arrow) != accent(a, arrow) times (accent(b, arrow) times accent(c, arrow))$],
)
#card(
  target-deck: "DMI",
  id: "3128",
  q: [Rechtssystem],
  a: image("./img/rechtssystem.png"),
)
#card(
  target-deck: "DMI",
  id: "3129",
  q: $"Flächeninhalt " h dot a$,
  a: image("./img/flaecheninhalt-kreuzprodukt.png"),
)

#card(
  target-deck: "DMI",
  id: "3130",
  q: [$accent(a, arrow) times accent(b, arrow)$ steht immer],
  a: [ senkrecht auf $accent(a, arrow)$ und auf $accent(b, arrow)$.],
)

#card(
  target-deck: "DMI",
  id: "3131",
  q: [$accent(a, arrow), accent(b, arrow), accent(a, arrow) times accent(b, arrow)$ bilden ein],
  a: [ Rechtssystem],
)

#card(
  target-deck: "DMI",
  id: "3132",
  q: $abs(accent(a, arrow) times accent(b, arrow)) =$,
  a: [Flächeninhalt des durch $accent(a, arrow)$ und $accent(b, arrow)$ aufgespannten Parallelogramms $= abs(accent(a, arrow)) dot abs(accent(b, arrow)) dot sin(phi)$],
)


#card(
  target-deck: "DMI",
  id: "3133",
  q: [Ein Vektorraum ist],
  a: [eine Menge $V$ mit den Rechenoperationen:

    $
      plus.o: V times V -> V, (accent(v, arrow),accent(w, arrow)) |-> accent(v, arrow) plus.o accent(w, arrow)
    $
    $
      dot.o: RR times V -> V, (lambda,accent(v, arrow)) |-> lambda dot.o accent(v, arrow)
    $
  ],
)

#card(
  target-deck: "DMI",
  id: "3134",
  q: [Ein Vektorraum hat die Eigenschaften],
  a: [
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
  ],
)


#card(
  target-deck: "DMI",
  id: "3135",
  q: [Kern von $A$],
  a: [$= U = {accent(x, arrow) in RR^n mid(|) A accent(x, arrow) = accent(0, arrow)}, A in RR^(m times n)$ ist ein Untervektorraum von $RR^n$.],
)

#card(
  target-deck: "DMI",
  id: "3136",
  q: [Eine Lineare Abbildung ist],
  a: [eine Funktion
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

#card(
  target-deck: "DMI",
  id: "3137",
  q: [Spaltenvektoren],
  a: [Spalten der Matrix als Vektoren],
)
#card(
  target-deck: "DMI",
  id: "3138",
  q: [Zeilenvektoren],
  a: [Zeilen der Matrix als Vektoren],
)
#card(
  target-deck: "DMI",
  id: "3139",
  q: [Rang],
  a: [Wieviele Spaltenvektoren einer Matrix linear unabhängig sind],
)
#card(
  target-deck: "DMI",
  id: "3140",
  q: [Nullmatrix],
  a: [$0 = mat(0, dots, 0; dots.v, dots.v, dots.v; 0, dots, 0)$],
)
#card(
  target-deck: "DMI",
  id: "3141",
  q: [Quadratische Matrix],
  a: [$M in RR^(n times n)$ Gleichviele Zeichen und Spalten],
)
#card(
  target-deck: "DMI",
  id: "3142",
  q: [Diagonalmatrix],
  a: [(immer quadratisch und symmetrisch): $D=mat(x_1, 0, 0, 0; 0, x_2, 0, 0; 0, 0, x_3, 0; 0, 0, 0, x_4), d_(i j) = 0 "für" i != j$],
)
#card(
  target-deck: "DMI",
  id: "3143",
  q: [Einheitsmatrix],
  a: [(immer diagonal): $E=mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$],
)
#card(
  target-deck: "DMI",
  id: "3144",
  q: [Symmetrische Matrix],
  a: [(immer quadratisch): $A=A^T, a_(i j) = a_(i j), mat(1, 2, 3; 2, 4, 4; 3, 4, 1)$],
)
#card(
  target-deck: "DMI",
  id: "3145",
  q: [Obere Dreiecksmatrix],
  a: [$O = mat(x_1, x_2, x_3; 0, x_4, x_5; 0, 0, x_6), o_(i j) = 0 "für" i > j$],
)
#card(
  target-deck: "DMI",
  id: "3146",
  q: [Kovarianzmatrix],
  a: [immer symmetrisch],
)
#card(
  target-deck: "DMI",
  id: "3147",
  q: [Reguläre Matrix],
  a: [Quadratische Matrix mit höchstem Rang (Rang = Anzahl Spalten/Reihen)],
)
#card(
  target-deck: "DMI",
  id: "3148",
  q: [Singuläre Matrix],
  a: [Quadratische Matrix mit kleinerem Rang (Rang < Anzahl Spalten/Reihen)],
)
#card(
  target-deck: "DMI",
  id: "3149",
  q: [Invertierbare Matrix],
  a: [ Für $A in RR^(n times n)$ heisst $A$ invertierbar, wenn es eine Matrix $A^(-1)$ gibt, so dass $A dot A^(-1) = A^(-1) dot A = "Einheitsmatrix (E)"$. Dies ist der Fall, wenn $A$ Regulär ist. ],
)

#card(
  target-deck: "DMI",
  id: "3150",
  q: [Matrix mit 2 Zeilen und 3 Spalten],
  a: [
    $
      A = mat(1, 4, 5; 2, 3, 7) in RR^(2 times 3)
    $
    Komponenten von $A$: $a_(i j)$ \
    $i$: Zeilenindex, $j$: Spaltenindex. Bsp: $a_23 = 7$ \
  ],
)

#card(
  target-deck: "DMI",
  id: "3151",
  q: [Matrizen als Vektoren interpretieren

    $-> A$ ist ein 6-Dimensionaler VR (Vektorraum)
  ],
  a: [
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

#card(
  target-deck: "DMI",
  id: "3152",
  q: [Transponierte Matrix $A in RR^(m times n)$ wäre],
  a: [ $A^T in RR^(n times m)$ \
    $A = (a_(i j)), A^T = (a_(j i))$ \
    Rolle von Zeile und Spalte vertauscht: $a_(i j) -> a_(j i)$ \
    Bsp: $ A = mat(1, 0; 0, 2; 3, 1) in RR^(3 times 2) \
    A^T = mat(1, 0, 3; 0, 2, 1) in RR^(2 times 3) \
    vec(1, 4, 5)^T =mat(1, 4, 5) $
  ],
)

#card(target-deck: "DMI", id: "3153", q: [Matrixmultiplikation], a: [

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

#card(
  target-deck: "DMI",
  id: "3154",
  q: $(A dot B) dot C$,
  a: $A dot (B dot C) = A dot B dot C$,
)
#card(target-deck: "DMI", id: "3155", q: $(A + B) dot C$, a: $A dot C + B dot C$)
#card(target-deck: "DMI", id: "3156", q: $C dot (A + B)$, a: $C dot A + C dot B$)
#card(
  target-deck: "DMI",
  id: "3157",
  q: $E dot A$,
  a: $A dot E = A "für" A in RR^(n times n)$,
)
#card(target-deck: "DMI", id: "3158", q: $(A^T)^T$, a: $A$)
#card(target-deck: "DMI", id: "3159", q: $(A+B)^T$, a: $A^T + B^T$)
#card(target-deck: "DMI", id: "3160", q: $(lambda A)^T$, a: $lambda A^T$)
#card(target-deck: "DMI", id: "3161", q: $(A dot B)^T$, a: $B^T dot A^T$)

#card(
  target-deck: "DMI",
  id: "3162",
  q: [Parameterform],
  a: $
    g : accent(x, arrow) = underbrace(vec(4, 5, 1), "Ortsvektor" accent(p, arrow)) + t dot underbrace(vec(-2, 1, 6), "Richtungsvektor" accent(P X, arrow)), t in RR
  $,
)

#card(
  target-deck: "DMI",
  id: "3163",
  q: [Ebenen Parameterform],
  a: $
    E : underbrace(accent(x, arrow), vec(x, y, z)) =
    #text(fill: purple)[$underbrace(vec(4, 5, 1, "Ortsvektor" accent(o, arrow)))$]
    + s dot #text(fill: red)[$underbrace(vec(-2, 1, 6, "Spannvektor" accent(A B, arrow)))$]
    + t dot #text(fill: green)[$underbrace(vec(-1, 5, 4, "Spannvektor" accent(A C, arrow)))$]
    , s, t in RR
  $,
)

#card(
  target-deck: "DMI",
  id: "3164",
  q: [ Normalenform / Koordinatenform],
  a: $
    E = [vec(x, y, z) - underbrace(vec(1, 2, 3), "Punkt auf Ebene")] circle.filled.small underbrace(vec(1, 0, -1), accent(n, arrow) "Orthogonal zur Ebene") = 0 \
    => x-1-z+3 = 0
  $,
)

#card(target-deck: "DMI", id: "3165", q: [Hessesche Normalform], a: [

  Abstand von Punkt $P(2,8,2)$ zur Ebene $E : 2x - y + 4z = 1$

  $
    accent(n, arrow) = vec(2, -1, 4) \
    abs(accent(n, arrow)) = sqrt(21) \
    (2x-y+4z-1)/sqrt(21) \
    => (2 dot 2 - 1 dot 8 + 4 dot 2-1)/sqrt(21) \
    =3/sqrt(21) \
  $
])
