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

= Codierungen: Vorzeichen, Gleitkomma und Text

Was ist der Unterschied zwischen der Binärzahl 0000 und 0000'0000?
- Beide Zahlen stellen denselben Wert dar, nämlich 0. Allerdings bezieht sich
  0000 auf 4 Bit, 0000'0000 jedoch auf 8 Bit. Diese Unterscheidung ist wichtig,
  da durch die zusätzlichen Nullen auch mehr Speicherplatz impliziert wird.

== Gebrochene Dezimalzahl in Dualzahl umwandeln

#grid(
  columns: (1fr, 1fr),
  [
    1. $
           & 0.625 &&      && dot 2 \
         = & 1.25  && - 1, && dot 2 \
         = & 0.5   && - 0, && dot 2 \
         = & 1     && - 1 \
        => & 0.101
      $
    2. $
           & 0.375  &&      && dot 2 \
         = & 0.75   && - 0, && dot 2 \
         = & 1.5    && - 1, && dot 2 \
         = & 0.5    && - 0, && dot 2 \
         = & 1      && - 1 \
        => & 0.0101
      $
  ],
  [
    3. $
           & 0.16 &&      && dot 2 \
         = & 0.32 && - 0, && dot 2 \
         = & 0.64 && - 0, && dot 2 \
         = & 1.28 && - 1, && dot 2 \
         = & 0.56 && - 0, && dot 2 \
         = & 1.12 && - 1, && dot 2 \
         = & 0.24 && - 0, && dot 2 \
         = & 0.48 && - 0, && dot 2 \
         = & 0.96 && - 0, && dot 2 \
         = & 1.92 && - 1, && dot 2 \
         = & 1.84 && - 1, && dot 2 \
         = & 1.68 && - 1, && dot 2 \
         = & 1.36 && - 1, && dot 2 \
         = & 0.72 && - 0, && dot 2 \
         = & 1.48 && - 1, && dot 2 \
         = & ... \
        => & 0.00 && 1010 && overline(00111101)
      $
  ],
)

== Gebrochene dualzahl in dezimalzahl umwandeln

1. $0.101$

#todo[]

= Algebra der Bits -- von Logik zu Polynomen

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
