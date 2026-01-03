#import "@preview/muchpdf:0.1.2": muchpdf
#import "../lib.typ": *

#let lang = "de"
#show: cheatsheet.with(
  module: "DMI",
  name: "Diskrete Mathematik",
  semester: "HS25",
  columnsnr: 1,
  fsize: 11pt,
  language: lang,
)

#let tbl = (..body) => deftbl(lang, "DMI", ..body)

#muchpdf(read("./img/formelsammlung_cropped.pdf", encoding: none), width: 100%)

#[
  #set page(flipped: false)

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
    [$#tr($q$) = x div y$],
    [$r=x_i - #tr($q_i$) dot y_i$],
    [$u = #tb($s_(-1)$)$],
    [$#tb($s$) = u_(-1) - #tr($q_(-1)$) dot #tb($s_(-1)$)$],
    [$v = #tg($t_(-1)$)$],
    [$#tg($t$) = v_(-1) - #tr($q_(-1)$) dot #tg($t_(-1)$)$],

    [$i=0$], [$99$], [$79$], [$1$], [$20$], [$1$], [$0$], [$0$], [$1$],
    [$i=1$], [$79$], [$20$], [$3$], [$19$], [$0$], [$1$], [$1$], [$-1$],
    [$i=2$], [$20$], [$19$], [$1$], [$1$], [$1$], [$-3$], [$-1$], [$4$],
    [$i=3$],
    [$19$],
    [#tr($1$)],
    [$19$],
    [$0$],
    [$-3$],
    [#tr($4$)],
    [$4$],
    [#tr($-5$)],
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

  Sei $n in NN without {0}$ und $ZZ_n^* = {x in ZZ_n mid(|) x "hat ein multiplikatives Inverses in " ZZ_n}$. Dann heisst $phi(n)$:
  $
    phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
           & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
           & =abs(ZZ_n^*)
  $
  Falls $p$ Primzahl ist, dann ist $phi(p) = p-1$

  ==== Rechenregeln

  + Sei $n in NN$ eine Primzahl, dann $phi(n) = n - 1$
  + Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann $phi(n^p) = n^(p-1) dot (n-1)$
  + Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann $phi(n dot m) = phi(n) dot phi(m)$

  === Kreuzprodukt

  #image("./img/kreuzprodukt.png")

  == Matrizen

  === Glossar

  #tbl(
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
  )


  === Determinante

  #grid(
    columns: (4fr, 1fr),
    $
      & 1 times 1 "Matrix" : det mat(a) = a \
      & 2 times 2 "Matrix" : det mat(a, b; c, d) = a d - c b \
      & 3 times 3 "Matrix" : det mat(a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33) = &&a_11 a_22 a_33 + a_12 a_23 a_31 + a_13 a_21 a_32 \
      & &&- a_31 a_22 a_13 - a_32 a_23 a_11 - a_33 a_21 a_12
    $,
    image("./img/determinante_rechnen.jpg"),
  )

  Bsp:
  $
    det mat(1, 2, 3; 8, 10, 12; 1, 1, 4) &= 2 det mat(1, 2, 3; 4, 5, 6; 1, 1, 4) \
    det mat(1, 2, 3; 8, 10, 12; 1, 1, 4) &= det mat(1, #tr(0), #tr(0) ; 8, 10, 12; 1, 1, 4) + det mat(#tr(0), 2, 3; 8, 10, 12; 1, 1, 4) \
    det mat(1, 2, 3; 8, 10, 12; 1, 1, 4) &= det mat(1, #tr(0), #tr(0) ; 8, 10, 12; 1, 1, 4) + #tr(2) det mat(#tr(0), 1, #tr(0) ; 8, 10, 12; 1, 1, 4) + #tr(3) det mat(#tr(0), #tr(0), 1; 8, 10, 12; 1, 1, 4) \
  $
  Bsp:
  $
    det mat(0, #tr(2), 1; 1, #tg(0), 1; 3, #td(4), 2) &= #tr(-2) det mat(1, 1; 3, 2) + #tg(0) det mat(0, 1; 3, 2) #td(-4) det mat(0, 1; 1, 1) \
    &= -2 (2-3) + 0 - 4(-1) \
    &= 2+4 = 6 \
    "Vorzeichen": &mat(+, -, +, -, ...; -, +, -, +, ...; +, -, +, -, ...; -, +, -, +, ...; dots.v, dots.v, dots.v, dots.v, dots.down) \
    "Vorgehen": &mat(#tr(0), #tb(2), #tr(1) ; 1, #tr(0), 1; 3, #tr(4), 2) -> -2 det mat(1, 1; 3, 2) \
    &mat(0, #tr(2), 1; #tr(1), #tb(0), #tr(1) ; 3, #tr(4), 2) -> 0 det mat(0, 1; 3, 2) \
    &mat(0, #tr(2), 1; 1, #tr(0), 1; #tr(3), #tb(4), #tr(2)) -> - 4 det mat(0, 1; 1, 1) \
  $
  Weitere Eigenschaften:
  - Die Determinante wechselt beim Vertauschen von Zeilen ihr Vorzeichen
  - Wenn wir zu einer Zeile einer Matrix ein Vielfaches einer anderen Zeile dazuzählen, ändert die Determinante ihren Wert nicht

  Weiteres:
  $
    det(lambda M) = lambda^n det(M), M in RR^(n times n) \
    det mat(A, *; 0, B) = det(A) dot det(B) \
    det(A dot B) = det(A) dot det(B) \
    det(A^(-1)) = 1/det(A) \
    det(A^T) = det(A)
  $
]
