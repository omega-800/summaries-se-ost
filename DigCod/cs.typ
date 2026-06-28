#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)

= Formeln

// $A,B$ = Ereignisse \
// $E$ = Erfolge \
// $Omega$ = Ergebnismenge\
// $n$ = Ziehungen \
// $k$ = Erfolge \
// $N$ = Anzahl Objekte\
// $K$ = Gesamt mögliche Erfolge \
// $p$ = Wahrscheinlichkeit\

#deftbl(
  definition: "Formel",
  align: horizon,
  [Gegenereignis],
  $ P(overline(A)) = 1 - P(A) $,
  [A und B],
  $ P(A union B) = P(A) + P(B) - P(A inter B) $,
  [A und B (disjunkt)],
  $ P(A union B) = P(A) + P(B) $,
  [A oder B],
  $ P(A or B) = P(A) + P(B) $,
  [B nach A],
  $ P(A and B) = P(A) dot P(B) $,
  [Wahrscheinlichkeit],
  $ abs(E)/abs(Omega) $,
  [Permutation mit W],
  $ (n!)/(k_1 !k_2 !...k_s !) $,
  [Permutation ohne W],
  $ n! $,
  [Variation mit W],
  $ n^k $,
  [Variation ohne W],
  $ (n!)/((n-k)!) $,
  [Kombination mit W],
  $ binom(n+k-1, k) $,
  [Kombination ohne W],
  $ binom(n, k) $,
  [Hypergeometrische\ verteilung],
  $ (binom(K, k) dot binom(N-K, n-k))/(binom(N, n)) $,
  [Fehleranordnung],
  $ p^k (1-p)^(n-k) $,
  [Binomialverteilung],
  $ P(X=k) = binom(n, k) p^k (1-p)^(n-k) $,
  [Bedingte\ Wahrscheinlichkeit],
  $ P(A|B) = (P(A inter B))/(P(B)) $,
  [Multiplikationsregel],
  $
    P(A inter B) = & P(A|B) dot P(B) \
                 = & P(B|A) dot P(A)
  $,
  [Bayes-Theorem],
  $ P(A|B) = (P(B|A) dot P(A))/(P(B)) $,
  [Entscheidungsgehalt],
  $ H_0 = log_2 (N) $,
  [Symbolwahrscheinlichkeit],
  $ p(x) = 1/N $,
  [Informationsgehalt],
  $ I(x) = -log_2 p(x) $,
  [Entropie],
  $ H(x) = -sum_(k=1)^N p(x_k) dot log_2 p(x_k) $,
  [Redundanz Quelle\ (absolut)],
  $ R_Q = H_0 - H(X) $,
  [Redundanz Quelle\ (relativ)],
  $ R_"rel" = R_Q/H_0 $,
  [Codewortlänge],
  $ L(x) = ceil(I(x)) = ceil(-log_2 p(x)) $,
  [Mittlere Codewortlänge],
  $ L(X) = sum_(k=1)^N p(x_k) dot L(x_k) $,
  [Redundanz Code],
  $ R_c = L-H(x) $,
  [Entropie aufeinander-\ folgender Zeichen],
  $ H(X,Y) = H(X) + H(Y|X) $,
  [Kompressionsrate],
  $ R(%) = L_"komprimiert"/L_"original" dot 100 $,
)

= Zahlencodierung / binäre Grundlagen

#todo[]

= Wahrscheinlichkeit

#todo[]

== Kolmogorov Axiome

$
  PP(Omega) = & 1 \
  PP(emptyset) = & 0 \
  fora(A\,B subset Omega\, space A inter B = emptyset, PP(A union B) = & PP(A) + PP(B)) \
  fora(A\,B subset Omega, PP(A union B) = & PP(A) + PP(B) - PP(A inter B))
$

= Information / Entropie

#todo[]

= Quellencodierung

#todo[]

= Mathematische Objekte

#table(
  columns: 4,
  table-header([Eigenschaft], $ZZ$, $RR$, $G F(2^3)$),
  [Elemente],
  [Ganze Zahlen],
  [Reelle Zahlen],

  [8 Elemente], [Addition], tcg, tcg,
  tcg, [Multiplikation], tcg, tcg,
  tcg, [Division], tcr, tcg,
  tcg, [Inverses vorhanden], tcr, tcg,
  tcg, [Struktur], [Ring], [Körper],
  [Körper],
)
