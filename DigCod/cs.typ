#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)

= Zahlencodierung / binäre Grundlagen

= Codierungen: Vorzeichen, Gleitkomma und Text

Was ist der Unterschied zwischen der Binärzahl 0000 und 0000'0000?
- Beide Zahlen stellen denselben Wert dar, nämlich 0. Allerdings bezieht sich 0000 auf 4 Bit, 0000'0000 jedoch auf 8 Bit. Diese Unterscheidung ist wichtig, da durch die zusätzlichen Nullen auch mehr Speicherplatz impliziert wird.

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

= Information / Entropie

#todo[]

= Quellencodierung

#todo[]
