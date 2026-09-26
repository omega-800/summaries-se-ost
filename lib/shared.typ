#import "./ctx.typ": *
#import "./mafs.typ": *
#import "./overrides.typ": *
// TODO: i18n

#let translations = (
  de: (
    associativity: [Assoziativität],
    distributivity: [Distributivität],
    commutativity: [Kommutativität],
    transposing: [Transponierung],
    identity_matrix: [Identitätsmatrix],
    inverting: [Invertierung],
    determinate: [Determinante],
    scalars: [Skalare],
  ),
  en: (
    associativity: [Associativity],
    distributivity: [Distributivity],
    commutativity: [Commutativity],
    transposing: [Transposing],
    identity_matrix: [Identity matrix],
    inverting: [Inverting],
    determinate: [Determinate],
    scalars: [Scalars],
  ),
)

#let trans = k => context translations.at(text.lang).at(k)
#let mathfml-diagrams = (w, h) => {
  let lmrk = mark => place(
    center + horizon,
    circle(fill: colors.bg, stroke: colors.darkblue, radius: 2pt),
  )
  let xs = lq.linspace(-1, 2, num: 100)
  (
    pdfunif: diagram2d(
      height: h,
      width: w,
      xlim: (-1.2, 2.2),
      legend: (position: top + left),
      title: $P D F quad "unif"(0,1)$,
      lq.plot(
        (-2, 0),
        (0, 0),
        stroke: colors.darkblue,
        label: $f(x)$,
        mark: lmrk,
      ),
      lq.plot((0, 1), (1, 1), stroke: colors.darkblue, mark: lmrk),
      lq.plot((1, 3), (0, 0), stroke: colors.darkblue, mark: lmrk),
    ),
    cdfunif: diagram2d(
      height: h,
      width: w,
      legend: (position: top + left),
      title: $C D F quad "unif"(0,1)$,
      lq.plot(
        xs,
        xs.map(unifcdf(0, 1)),
        mark: none,
        label: $F(x)$,
      ),
    ),
    dfdiag: c => {
      let m = 4
      let sig = 1
      let npdf = pdf(m, sig)
      let ncdf = cdf(m, sig)
      let xs = lq.linspace(0, 8, num: 100)
      let (fn, l, n) = if c { (ncdf, $C D F$, $F(x)$) } else {
        (npdf, $P D F$, $f(x)$)
      }
      diagram2d(
        height: h,
        width: w,
        title: l,
        ylim: (-.05, 1.05),
        yaxis: (tick-distance: .1),
        lq.plot(
          xs,
          xs.map(fn),
          mark: none,
          label: n,
        ),
        lq.plot(
          (m, m),
          (0, fn(m)),
          stroke: (
            paint: colors.purple,
            dash: "dashed",
          ),
          mark: none,
        ),
        ..if c {
          (
            lq.plot(
              (0, m),
              (fn(m), fn(m)),
              stroke: (
                paint: colors.purple,
                dash: "dashed",
              ),
              mark: none,
            ),
            lq.fill-between(
              xs.filter(x => x < m),
              xs.filter(x => x < m).map(fn),
              fill: shade(
                x: 5pt,
                y: 5pt,
                stroke: colors.darkblue.transparentize(50%),
              ),
              label: $A = 1/2 = F(tp(mu))$,
            ),
          )
        } else {
          (
            lq.fill-between(
              xs,
              xs.map(fn),
              fill: shade(
                x: 5pt,
                y: 5pt,
                stroke: colors.darkblue.transparentize(50%),
              ),
              label: $A = 1$,
            ),
          )
        },
        lq.place(m, fn(m) + .15, tp[$mu$]),
        lq.place(m + sig / 2, .06, box(
          fill: colors.bg,
          inset: (x: 2pt),
          tg[$sigma$],
        )),
        lq.place(m - sig / 2, .06, box(
          fill: colors.bg,
          inset: (x: 2pt),
          tg[$sigma$],
        )),
        lq.plot(
          (m + sig, m + sig),
          (0, fn(m + sig)),
          stroke: (
            paint: colors.green,
            dash: "dashed",
          ),
          mark: none,
        ),
        lq.plot(
          (m - sig, m - sig),
          (0, fn(m - sig)),
          stroke: (
            paint: colors.green,
            dash: "dashed",
          ),
          mark: none,
        ),
        lq.line(
          (m - sig, .1),
          (m, .1),
          stroke: colors.green,
          toe: tiptoe.stealth,
          tip: tiptoe.stealth,
        ),
        lq.line(
          (m + sig, .1),
          (m, .1),
          stroke: colors.green,
          toe: tiptoe.stealth,
          tip: tiptoe.stealth,
        ),
      )
    },
  )
}


#let shared = (
  calc-rsa: context if text.lang == "de" [
    + Wähle zwei Primzahlen $p,q$
    + Berechne $n = p dot q$
    + Berechne $phi(n)=(p-1)(q-1)$
    + Wähle $a,b$ so, dass $a dot b equiv 1 mod phi(n)$
    + Vergesse $p,q,phi(p dot q)$. Brauchen wir nicht und riskieren nur, dass
      uns jemand hackt

    Public key ist nun $n,b$, Private key ist $n,a$ \

    - Verschlüsseln: $z = c^a mod n$ \
    - Entschlüsseln: $c = z^b mod n = c^a^b mod n$ \
  ] else [
    + Choose two prime numbers $p,q$
    + Calculate $n = p dot q$
    + Calculate $phi(n)=(p-1)(q-1)$
    + Choose $a,b$, so that $a dot b equiv 1 mod phi(n)$
    + Forget $p,q,phi(p dot q)$

    Public key is now $n,b$, private key is $n,a$ \

    - Encrypt: $z = c^a mod n$ \
    - Decrypt: $c = z^b mod n = c^a^b mod n$ \
  ],
  e-euklid: [
    Seien $a,b in NN, a != b, a != 0, b != 0$ \
    Initialisierung: Setze
    $x:=a,y:=b,q:=x div y,r:=x-q dot y,(u,s,v,t)=(1,0,0,1)$ (d.h. bestimme q und
    r so, dass $x=q dot y+r$ ist) \
    Wiederhole bis $r=0$ ist \
    Ergebnis: $y = "ggT"(a,b) = s dot a + t dot b$ \
    Wenn $"ggT"(a,b)=1$ ist, dann folgt: $t dot v equiv 1 mod a$

    #exbox(title: $"ggT"(99,79)$, [#table(
        columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
        table-header(
          [$i$],
          [$x = y_(-1)$],
          [$y = r_(-1)$],
          [$#tr($q$) = x div y$],
          [$r=x - #tr($q$) dot y$],
          [$u = #tb($s_(-1)$)$],
          [$#tb($s$) = u_(-1) - #tr($q_(-1)$) dot #tb($s_(-1)$)$],
          [$v = #tg($t_(-1)$)$],
          [$#tg($t$) = v_(-1) - #tr($q_(-1)$) dot #tg($t_(-1)$)$],
        ),

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
      - $"ggT"(99,79)=4 dot 99+(-5) dot 79 <=> 396-395=1$
      - $99 + (-5) = 94$ ist mult. Inv. von $79$ in $ZZ_99$
      - $79 + 4 = 83 equiv 4$ ist mult. Inv. von $99$ in $ZZ_79$
    ])
  ],
  euler: context if text.lang == "de" [
    Sei $n in NN without {0}$ und $z in ZZ$ mit $"ggT"(z,n)=1$. Dann ist
    $z^(phi(n)) equiv 1 mod n$.
  ] else [
    Let $n in NN without {0}$ and $z in ZZ$ with $"gcd"(z,n)=1$. Then
    $z^(phi(n)) equiv 1 mod n$.
  ],
  euler-phi: context if text.lang == "de" [
    Sei $n in NN without {0}$ und
    $ZZ_n^* = {x in ZZ_n mid(|) x "hat ein multiplikatives Inverses in " ZZ_n}$.
    \
    Dann heisst $phi(n)$:
    $
      phi(n) & = "Anz. Elemente in " ZZ_n "mit mult. Inversen" \
             & ="Anz. Zahlen" 1<=q<=n "mit ggt"(q,n)=1 \
             & =abs(ZZ_n^*)
    $

    _Rechenregeln_

    + Sei $n in NN$ eine Primzahl, dann $phi(n) = n - 1$
    + Sei $n in NN$ eine Primzahl und $p in NN without {0}$, dann
      $phi(n^p) = n^(p-1) dot (n-1)$
    + Seien $m,n in NN without {0}$ und $"ggT"(m,n) = 1$, dann
      $phi(n dot m) = phi(n) dot phi(m)$
  ] else [
    Let $n in NN without {0}$ and
    $ZZ_n^* = {x in ZZ_n mid(|) x "has a multiplicative inverse in " ZZ_n}$.
    \
    Then $phi(n)$ defines:
    $
      phi(n) & = "Nr. of elements in " ZZ_n "with mult. inv." \
             & ="Amount of Numbers " 1<=q<=n "with gcd"(q,n)=1 \
             & =abs(ZZ_n^*)
    $
    We also call those numbers _relatively prime with $n$_.

    _Rules_

    + Let $n in NN$ a prime number, then $phi(n) = n - 1$
    + Let $n in NN$ a prime number and $p in NN without {0}$, then
      $phi(n^p) = n^(p-1) dot (n-1)$
    + Let $m,n in NN without {0}$ and $"gcd"(m,n) = 1$, then
      $phi(n dot m) = phi(n) dot phi(m)$
  ],
  pred-rules: grid(
    columns: (1.5fr, 2fr, 2.5fr),
    $
      & (A => B) <=> (not B => not A) \
      & (A => B) <=> (not A or B) \
    $,
    $
      & (A <=> B) <=> (A and B) or (not A and not B) \
      & not (A => B) <=> A and not B \
    $,
    $
      & A or (not A and B) <=> A or B \
      & (A => B => C) <=> (A => B) and (B => C)
    $,
  ),
  pred-rules-tbl: deftbl(
    [Abtrennungsregel],
    [
      $(A and (A => B)) => B$
    ],
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
    [de Morgan],
    [
      $not (A and B) <=> not A or not B$ \
      $not (A or B) <=> not A and not B$
    ],
  ),
  mult-inv: [
    Für $a in ZZ_q$ ist $b in ZZ_q$ das _multiplikative inverse_ von a, wenn
    $a dot b equiv 1 mod q$
  ],
  rss-def: context $
    R S S = sum_(i=1)^N underbrace(
      (#td($y_i$) - #tp($f(x_i)$))^2, #if text.lang == "de" [Im Diagramm als
        #tr([rote\ Vierecke]) repräsentiert] else [Represented as #tr([red\
          squares]) in the example]
    ) \
    R S S(#tp($m,b$)) = sum_(i=1)^N (#td($y_i$) - #tp($(m x_i + b)$))^2 >= 0, R S S: RR^2 -> RR
  $,
  rss-ex: context exbox(
    title: if text.lang == "de" [Lineare regression von Gehältern nach
      Alter] else [Linear regression of salaries by age],
    [
      $
        RSS(#tp($m,b$)) = sum_(i=1)^N (#tp($(m x_i + b)$) - #td($y_i$))^2 >= 0, RSS: RR^2 -> RR
      $

      #let rng = suiji.gen-rng-f(42)
      #let xs = range(0, 10)
      #let (rng, ys1) = deviate-x(rng, xs)
      #let (rng, ys2) = deviate-x(rng, xs)
      #let (rng, ys3) = deviate-x(rng, xs)
      #let (rng, ys4) = deviate-x(rng, xs)
      #let ysall = ys1.zip(ys2, ys3, ys4).map(ys => ys.sum() / ys.len())
      #let (m, b) = linear-regression(xs, ysall)
      #let rss-rect = (ys, n) => {
        let y = m * xs.at(n) + b
        let w = ys4.at(n) - y
        (
          lq.rect(
            n,
            y,
            width: -w,
            height: w,
            stroke: colors.red,
            fill: colors.red.transparentize(80%),
            label: $RSS_#(n * 6 + 20)$,
          ),
          lq.line(
            (n, y),
            (n, ys4.at(n)),
            stroke: (
              paint: colors.darkblue,
              thickness: 2pt,
              cap: "round",
              dash: "dashed",
            ),
          ),
          lq.plot(
            (n, n),
            (ys4.at(n), ys4.at(n)),
            mark: mark => place(
              center + horizon,
              circle(
                fill: colors.darkblue,
                stroke: colors.darkblue,
                radius: 2pt,
              ),
            ),
            mark-color: colors.black,
            z-index: 99,
          ),
        )
      }

      #align(center, diagram2d(
        // title: $RSS = #rss(xs.map(t => t * 6 + 20), ysall.map(t => t * 10000 + 20000))$,
        yaxis: (
          lim: (-0.5, 11),
          label: if text.lang == "de" [Gehalt] else [Salary],
          format-ticks: (ticks, ..) => ticks.map(t => str(t * 10000 + 20000)),
        ),
        xaxis: (
          lim: (-0.5, 11),
          label: if text.lang == "de" [Alter] else [Age],
          format-ticks: (ticks, ..) => ticks.map(t => str(t * 6 + 20)),
        ),
        width: 10cm,
        height: 10cm,
        legend: (position: horizon + right),
        lq.scatter(xs, ys1, color: colors.darkblue),
        lq.scatter(xs, ys2, color: colors.darkblue),
        lq.scatter(xs, ys3, color: colors.darkblue),
        lq.scatter(xs, ys4, color: colors.darkblue),
        lq.plot(
          xs,
          xs.map(x => m * x + b),
          color: colors.purple,
          label: if text.lang == "de" [Lineare\ regression] else [Linear\
            regression],
        ),
        ..rss-rect(ys4, 6),
        ..rss-rect(ys4, 2),
      ))],
  ),
  vec-rules: $
             lambda ve(0) = & ve(0) \
            ve(v) + ve(0) = & ve(v) \
                   -ve(v) = & -1 dot ve(v) \
           -ve(v) + ve(v) = & ve(0) \
         (lambda mu)ve(v) = & lambda(mu ve(v)) = lambda mu ve(v) \
      lambda(ve(v)+ve(w)) = & lambda ve(v) + lambda ve(w) \
    ve(v) + (ve(u)+ve(w)) = & (ve(v) + ve(u))+ve(w) = ve(v) + ve(u)+ve(w) \
  $,
  mat-rules: context deftbl(
    definition: "Rules",
    trans("associativity"),
    $
      (A + B) + C = A + (B + C) = A + B + C \
      (A dot B) dot C = A dot (B dot C) = A dot B dot C \
    $,
    trans("distributivity"),
    $
      C dot (A + B) = C dot A + C dot B \
      (A + B) dot C = A dot C + B dot C
    $,
    trans("commutativity"),
    $
      A + B = B + A \
      A dot B != B dot A \
    $,
    trans("transposing"),
    $
      (A^top)^top = A \
      (A+B)^top = A^top + B^top \
      (lambda A)^top = lambda A^top \
      (A dot B)^top = B^top dot A^top \
      A_(i j) = A^top_(j i) \
    $,
    trans("identity_matrix"),
    $
      bb(1) dot A = A dot bb(1) = A "for" A in RR^(n times n) \
    $,
    trans("inverting"),
    $
      A dot A^(-1) = A^(-1) dot A = bb(1) \
    $,
    trans("determinate"),
    $
      det(lambda M) = lambda^n det(M), M in RR^(n times n) \
      det mat(A, *; 0, B) = det(A) dot det(B) \
      det(A dot B) = det(A) dot det(B) \
      det(A^(-1)) = 1/det(A) \
      det(A^top) = det(A)
    $,
    trans("scalars"),
    $
      (lambda + mu) A = lambda A + mu A \
      (lambda mu) A = lambda (mu A) \
      lambda (B + C) = lambda B + lambda C \
      lambda (B C) = (lambda B) C = B (lambda) C
    $,
  ),
  kv-diag: [
    Je grösser die Blöcke, desto einfacher wird das Ergebnis. Dabei müssen aber
    bestimmte Regeln eingehalten werden:

    - Die Blöcke müssen immer rechteckig sein und
    - die Grösse einer Zweierpotenz haben, also 2, 4, 8, 16, 32, ...
    - Die Blöcke können auch über den Rand hinaus gehen und mit der
      gegenüberliegenden Seite verbunden werden,
    - Blöcke können sich teilweise überlappen. Das kann sinnvoll sein, wenn
      dadurch grössere Blöcke entstehen.
    - Werte, die sowohl einfach als auch negiert vorkommen, werden gestrichen
    - Ein Block wird nur berücksichtigt, wenn seine Einsen nicht vollständig in
      anderen Blöcken enthalten sind. Andernfalls entsteht ein nichtessentieller
      Term, der redundant ist, da andere Terme bereits die gleichen
      Variablenbelegungen abdecken und nicht weiter vereinfacht werden können.

    #let rectg = cetz.draw.rect.with(
      fill: colors.green.transparentize(60%),
      stroke: colors.green,
    )
    #let rectd = cetz.draw.rect.with(
      fill: colors.darkblue.transparentize(60%),
      stroke: colors.darkblue,
    )
    #let rectr = cetz.draw.rect.with(
      fill: colors.red.transparentize(60%),
      stroke: colors.red,
    )
    #let ccvs = it => canvas(length: 1.5em, {
      cetz.draw.grid(
        (0, 0),
        (4, 4),
      )
      it
    })

    #grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: center,
      grid.cell(colspan: 3, [_OK_]),
      grid.cell(colspan: 3, [_NOK_]),
      ccvs({
        rectg((0, 3), (2, 1))
        rectd((2, 4), (4, 0))
      }),
      ccvs({
        rectg((0, 3), (1, 1))
        rectg((3, 3), (4, 1))
      }),
      ccvs({
        rectd((0, 0), (1, 1))
        rectd((3, 0), (4, 1))
        rectd((0, 3), (1, 4))
        rectd((3, 3), (4, 4))
      }),
      ccvs({ rectr((1, 1), (3, 4)) }),
      ccvs({
        rectr((0, 0), (1, 1))
        rectr((1, 1), (2, 2))
        rectr((2, 2), (3, 3))
        rectr((3, 3), (4, 4))
      }),
      ccvs({
        cetz.draw.line(
          (1, 0),
          (1, 3),
          (3, 3),
          (3, 2),
          (2, 2),
          (2, 0),
          fill: colors.red.transparentize(60%),
          stroke: colors.red,
        )
      }),
    )
  ],
  oopsndpage: [
    #let nwr = (height: 6pt, fill: colors-l.red)
    #let nwg = (height: 6pt, fill: colors-l.green)
    #let nt = t => box(inset: 1pt, baseline: -6pt, text(
      hyphenate: false,
      size: 5pt,
    )[#t])
    = Iterators \
    ```java
    Iterator<String> it = stringList.iterator();
    while (it.hasNext()) {
      String s = it.next();
      System.out.println(s);
    }
    ```
    Mutating Collection while iterating over it: ConcurrentModificationException
    \
    = Exceptions \
    #table(
      columns: (1fr, 1fr),
      table-header([Error], [Exception]), [Critical, don't handle],
      [Runtime, handleable],
      [OutOfMemoryError, StackOverflowError, AssertionError],

      [IOException],
    )
    #table(
      columns: (1fr, 1fr),
      table-header([Checked], [Unchecked]),
      [Must be handled (or throws-\ declaration)],

      [Not necessary], [Checked by compiler],
      [Compiler doesn't check], [Exception, not RuntimeException],
      [RuntimeException, Error],
    )
    Child Exception gets caught in catch clause with parent class
    ```java
    void test() throws ExceptionA, ExceptionB {
      String c = clip("asdf");
      throw new ExceptionB("wack");
    }

    // finally ALWAYS executes, even on unhandled Exc.
    try {
      test();
    } catch (ExceptionA | ExceptionB e) {
      // ...
    } finally { }

    try { ... } catch(NullPointerException e) {
      throw e; // -->leaves blocks-->
    } catch (Exception e) {
      // above e won't get caught!
    } finally {
      // will still get executed
    }

    1 / 0; // ArithmeticException div by zero

    String s = "";
    s = null;
    s.toUpperCase(); // NullPointerException

    int[] arr = new int[] {1, 2, 3};
    int elem = arr[8]; // ArrayIndexOutOfBoundsException
    ```
    #tr([*Unchecked*]) #tg([*Checked*]) #diagram(
      spacing: (2pt, 12pt),
      node(..nwg, (2, 1), nt("Throwable"), name: <throwable>),
      node(..nwr, (1, 2), nt("Error"), name: <error>),
      node(..nwg, (2, 2), nt("Exception"), name: <exception>),
      node(..nwr, (1, 3), nt("RuntimeException"), name: <runtime>),
      node(..nwg, (2, 3), nt("IllegalAccessE"), name: <illegal>),
      node(..nwg, (3, 3), nt("ClassNotFoundE"), name: <class>),
      node(..nwr, (1, 4), nt("NullPointerE"), name: <null>),
      node(..nwr, (2, 4), nt("IndexOutOfBoundsE"), name: <index>),
      node(..nwr, (3, 4), nt("IllegalArgumentE"), name: <arg>),
      node(..nwr, (2, 5), nt("ArrayIndexOutOfBoundsE"), name: <aindex>),
      edge(<error>, <throwable>, "-|>"),
      edge(<exception>, <throwable>, "-|>"),
      edge(<runtime>, <exception>, "-|>"),
      edge(<illegal>, <exception>, "-|>"),
      edge(<class>, <exception>, "-|>"),
      edge(<index>, <runtime>, "-|>"),
      edge(<null>, <runtime>, "-|>"),
      edge(<arg>, <runtime>, "-|>"),
      edge(<aindex>, <index>, "-|>"),
    ) \
    = Important stuff
    - Hashing should be added to equals fn's for strict equality
    - Check if ```java input == null```
    - Check if ```java array.length == 0```
    - ```java IllegalArgumentException("reason")```
    - try/catch finally block *always* executes
    #colbreak()
    = IO \
    ```java
    try (var fr = new FileReader("text.txt")) {
      int input = fr.read();
      while (input >= 0) {
        if (input == ';') { /* do something */ }
        input = fr.read();
      }
    }

    try (FileWriter writer = new FileWriter("out.txt",
        StandardCharsets.UTF_8, true)) { // append
      writer.write("weeoo\n");
    }

    try {
      var input = new FileInputStream("text.txt");
      int i = input.read();
      while(i != -1) {
         System.out.print((char)i);
         i = input.read();
      }
      input.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

    try (BufferedReader reader = new BufferedReader(
        new FileReader("text.txt",
          StandardCharsets.UTF_8))) {
      String line;
      while ((line = reader.readLine()) != null) {
          System.out.println(line);
      }
    }

    try (
        FileReader reader = new FileReader("in.txt");
        FileWriter writer = new FileWriter("out.txt")
      ) {
      int i = input.read();
      while(i >= 0) {
        writer.write(i);
        i = input.read();
      }
    }
    ```
    = Try with
    ```java
    try (var output = new FileOutputStream("f.txt")) {
      output.write("Hello".getBytes());
    } catch (IOException e) {
      System.out.println("Error writing file");
    } finally {
      System.out.println("Done");
    }
    ```
    = Serializing \
    ```java
    class X implements Serializable { }
    // Serializing
    try (var stream = new ObjectOutputStream(
        new FileOutputStream("s.bin"))) {
      stream.writeObject(new X());
    }
    // Deserializing
    try (var stream = new ObjectInputStream(
        new FileInputStream("s.bin"))) {
      X x = (X) stream.readObject();
    }
    ```
    = Function \
    ```java
    public interface Function<T, R> {
      R apply(T t);

      static <T> Function<T, T> identity();

      <V> Function<T, V> andThen(
        Function<? super R, ? extends V> after);

      <V> Function<V, R> compose(
        Function<? super V, ? extends T> before);
    }
    ```
    #colbreak()
    = Predicate
    ```java
    public interface Predicate<T> {
      boolean test(T t);
    }

    static void removeAll(Collection<Person> collection,
        Predicate criterion) {
      var it = collection.iterator();
      while (it.hasNext())
        if (criterion.test(it.next()))
          it.remove();
    }
    ```
    = Comparable \
    ```java
    public interface Comparable<T> {
      int compareTo(T obj);
    }

    var l = new ArrayList<Integer>(asList(3,2,4,5,1));
    l.sort((a, b) -> a > b ? 1 : -1); // ==
    l.sort((a, b) -> a - b);          // 1,2,3,4,5

    class Person implements Comparable<Person> {
      private final String firstName, lastName;
      @Override
      public int compareTo(Person other) {
        int result = lastName.compareTo(other.lastName);
        if (result == 0)
          result = firstName.compareTo(other.firstName);
        return result;
      }

      static int compareByAge(Person a, Person b) {
        return Integer.compare(a.getAge(), b.getAge());
      }
    }
    List<Person> people = ...;
    Collections.sort(people);
    people.sort(Person::compareByAge);
    ```
    = Comparator \
    ```java
    class AgeComparator implements Comparator<Person> {
       @Override
       public int compare(Person a, Person b) {
         return Integer.compare(a.getAge(), b.getAge());
       }
    }
    Collections.sort(people, new AgeComparator());
    people.sort(new AgeComparator());

    people.sort(Comparator
      .comparing(Person::getAge)
      .thenComparing(Person::getFirstName)
      .reversed())

    Comparator.comparing(Person::getName,
      (s1, s2) -> s2.compareTo(s1));
    // ==
    Comparator.comparing(Person::getName).reversed();

    Comparator<T> nullsLast(Comparator<T> c);
    Comparator<T> nullsFirst(Comparator<T> c);
    Comparator<T> comparing(Function<T,U> keyExtractor,
      Comparator<U> c);
    Comparator<T> comparingInt(ToIntFunction<T,U> f);
    ```
    = FunctionalInterface \
    Any interface with a single abstract method is a functional interface
    ```java
    @FunctionalInterface
    public interface ShortToByteFunction {
        byte applyAsByte(short s);
    }
    @FunctionalInterface
    public interface PersonStringifier {
        String getNameAndAge(Person p);
    }
    ```
    #colbreak()
    = Collection \
    ```java
    boolean add(E e);
    boolean remove(Object o);
    boolean equals(Object o);
    int hashCode();
    int size();
    boolean isEmpty();
    Object[] toArray();
    void clear();
    boolean contains(Object o);
    boolean addAll(Collection<? extends E> c);
    boolean containsAll(Collection<?> c);
    boolean removeAll(Collection<?> c);
    boolean retainAll(Collection<?> c);

    Set<String> noDup = new HashSet<>();
    ```
    = Collection implementations
    ```java
    // List
    int indexOf(Object o);
    int lastIndexOf(Object o);
    E get(int index);
    subList(int from, int to);
    void sort(Comparator<? super E> c);

    // Stack
    E peek();
    E pop();
    E push(E item);
    boolean empty();
    int search(Object o);

    // Queue
    E element();      // throws -> peek();     doesn't
    E remove();       // throws -> poll();     doesn't
    boolean add(E e); // throws -> offer(E e); doesn't

    // Set
    // (I) SortedSet -> (C) TreeSet
    // (C) HashSet, (C) LinkedHashSet

    // Map
    // HashMap
    boolean containsKey(Object key);
    boolean containsValue(Object value);
    Set<Map.Entry<K, V>>> entrySet();
    V get(Object key);
    V put(K key, V value);
    V putIfAbsent(K key, V value);
    V replace(K key, V value);
    V remove(Object key);
    V getOrDefault(Object key, V defaultValue);
    Set<K> keySet();
    Collection<V> values();
    ```
    = Lambdas
    ```java
    String pattern = readFromConsole();
    //     vvv not final -> Error
    while (pattern.length() == 0)
      pattern = readFromConsole();
    Utils.removeAll(people, p ->
        p.getLastName().contains(pattern));
    // local variable ... referenced from a lambda expression must be final or effectively final

    // Predicate      :: a -> boolean
    Predicate<Integer> isLarge = (v) -> v > 69420;
    // Function       :: a -> b
    Function<Integer, String> str = (v) -> "" + v;
    // Supplier       :: a
    Supplier<String> hello = () -> "Hello, World!";
    // Consumer       :: a -> void
    Consumer<Integer> consoomer = (v) -> log(v);
    // UnaryOperator  :: a -> a
    UnaryOperator<Integer> more = (v) -> v * v;
    // BinaryOperator :: a -> a -> a
    BinaryOperator<Integer> less = (a, b) -> a - b;
    ```
    #colbreak()
    = Streams
    ```java
    import java.util.stream.*;

    people
      .stream()
      .distinct()
      .filter(p -> p.getAge() >= 18)
      .skip(5)
      .limit(10)
      .map(p -> p.getLastName())
      .sorted()
      .forEach(System.out::println);

    people
      .stream()
      .reduce(0, (acc,cur) -> acc + cur.getAge());

    list.stream().mapToInt(Integer::intValue);
    list.stream().mapToInt(Integer::parseInt);
    ```
    = Optional (Haskell / Rust in bloat) \
    ```java
    T get(); // NoSuchElementException
    boolean isPresent();
    void ifPresent(Consumer<T> consumer);
    T orElse(T other);
    static Optional<T> empty();
    static Optional<T> of(T value);
    ```
    = Methods \
    ```java
    boolean allMatch(Predicate<T> predicate);
    boolean anyMatch(Predicate<T> predicate);
    boolean noneMatch(Predicate<T> predicate);
    static Stream<T> concat(Stream<T> a, Stream<T> b);
    Stream<T> distinct();
    Stream<R> flatMap(Function<T, R> mapper);
    Stream<T> limit(long maxSize);
    Stream<T> skip(long maxSize);
    Stream<T> sorted(Comparator<T> comparator);
    ```
    = Terminal operations \
    ```java
    Optional<T> min(Comparator<T> comparator);
    Optional<T> max(Comparator<T> comparator);
    Optional<T> findAny();
    Optional<T> findFirst();
    void forEach(Consumer<T> action);
    long count();
    void forEachOrdered(Consumer<T> action);
    // IntStream
    average();
    sum();
    ```
    = Collectors \
    ```java
    // List
    s.collect(Collectors.toList());
    // TreeSet
    s.collect(Collectors.toCollection(TreeSet::new));
    // String
    s.collect(Collectors.joining(", "));
    // Integer
    s.collect(Collectors.summingInt(Person::getAge));
    // Map<String, Person>
    s.collect(Collectors.groupingBy(Person::getCity));
    // Map<String, Integer>
    s.collect(Collectors.groupingBy(Person::getCity,
      Collectors.summingInt(Person::getSalary));
    // Map<boolean, List<Person>>
    s.collect(Collectors.partitioningBy(s ->
      s.getAge() > 18))
    ```
    = More API's we "should" be provided with
    Yes I'm salty, thanks for pointing that out
    ```java
    // Integer
    static int parseInt(String s);
    // System
    arraycopy(Object src, int srcPos, Object dest,
        int destPos, int length);
    // Arrays
    static <T> List<T> asList(T... a);
    // example usage
    String[] B = new String[4];
    HashSet<String> H = new HashSet<>(Arrays.asList(B));
    ```
  ],
  bsttraversal: [
    // TODO: https://github.com/typst/typst/issues/6419
    #let (rbn, gbn, obn, pbn, bbn, A, B, C, D, E) = bn-abbrevs
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: right + horizon,
      gutter: 2pt,
      grid.cell(rowspan: 5, {
        let node = node.with(stroke: none, width: 1em, height: 1em)
        align(left, diagram(
          rbn((2, 0), [D], name: <d>),
          gbn((1, 1), [B], name: <b>),
          obn((3, 1), [E], name: <e>),
          pbn((0, 2), [A], name: <a>),
          bbn((2, 2), [C], name: <c>),

          edge(<d>, <b>),
          edge(<d>, <e>),
          edge(<b>, <a>),
          edge(<b>, <c>),
        ))
      }),
      [Preorder (W-L-R)], stack(dir: ltr, D, B, A, C, E), [Postorder (L-R-W)],
      stack(dir: ltr, A, C, B, E, D),

      [Inorder (L-W-R)], stack(dir: ltr, A, B, C, D, E),

      [Breadth-First/ Level-Order],
      stack(dir: ltr, D, B, E, A, C),
    )
  ],
  blockcipher: (
    desc: [
      Block ciphers take an input of a fixed size and return an output of the
      same size

      #grid(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
        gutter: 1pt,
        inset: .5em,
        align: center,
        grid.cell(colspan: 7, fill: colors-l.green)[plaintext],
        grid.cell(colspan: 1)[],
        grid.cell(colspan: 2, fill: colors-l.green)[block 1],
        grid.cell(colspan: 2, fill: colors-l.green)[block 2],
        grid.cell(colspan: 2, fill: colors-l.green)[block 3],
        grid.cell(colspan: 1, fill: colors-l.green)[block 4],
        grid.cell(colspan: 1, fill: colors-l.blue)[padding],
        grid.cell(colspan: 8)[$arrow.b$ Encryption... $arrow.b$],
        grid.cell(colspan: 2, fill: colors-l.purple)[c block 1],
        grid.cell(colspan: 2, fill: colors-l.purple)[c block 2],
        grid.cell(colspan: 2, fill: colors-l.purple)[c block 3],
        grid.cell(colspan: 2, fill: colors-l.purple)[c block 4],
        grid.cell(colspan: 8, fill: colors-l.purple)[ciphertext],
      )

      - Block ciphers attempt to hide the transformation from message to
        ciphertext through confusion and diffusion
      - Most block ciphers are SP-Networks

      The Advanced Encryption Standard (AES) is an SP-Network

      - Almost everything uses AES
      - There are others (e.g. Feistel Ciphers)
    ],
    ecb: [

      - Just encrypt each block one after another with same key
      - Weak to redundant data divulging patterns
      - Electronic codebook is not recommended!

      #let ecb-diag(n, d: auto, e: true) = {
        let d = if d == auto { n } else { d }
        (
          node((n + 1, 0), if e { $P_#d$ } else { $C_#d$ }),
          edge("->"),
          node((n + 1, 1), if e [Encrypt] else [Decrypt]),
          edge("->"),
          node((n + 1, 2), if e { $C_#d$ } else { $P_#d$ }),
          edge((n, 1), (n + 1, 1), label: [K], "->", label-pos: 0%),
        )
      }
      #diagram(
        spacing: (2em, 1em),
        node((-1, 0), [_Encryption_], stroke: none),
        ..ecb-diag(1),
        ..ecb-diag(3, d: 2),
        node((5, 1), $...$, stroke: none),
        ..ecb-diag(6, d: "n"),
      )
      #line(length: 100%, stroke: colors.darkblue)
      #diagram(
        spacing: (2em, 1em),
        node((-1, 0), [_Decryption_], stroke: none),
        ..ecb-diag(1, e: false),
        ..ecb-diag(3, d: 2, e: false),
        node((5, 1), $...$, stroke: none),
        ..ecb-diag(6, d: "n", e: false),
      )
    ],
    cbc: [

      - XOR the IV with the first input, then XOR the output of each cipher
        block with the next input
        - Not parallelizable
        - It is better than ECB but not perfect

      #let cbc-diag(n, d: auto, e: true) = {
        let d = if d == auto { n } else { d }
        let (xn, en) = if e { (1, 2) } else { (2, 1) }
        let (xe, ee) = if e { (3, 1) } else { (0, 2) }
        (
          node((n + 1, 0), if e { $P_#d$ } else { $C_#d$ }),
          edge((n + 1, 0), (n + 1, 1), "->"),
          node(
            (n + 1, xn),
            shape: xor-shape,
            width: 1em,
            height: 1em,
            stroke: colors.fg,
          ),
          edge((n + 1, 1), (n + 1, 2), "->"),
          node((n + 1, en), if e [Encrypt] else [Decrypt]),
          edge((n + 1, 2), (n + 1, 3), "->"),
          node((n + 1, 3), if e { $C_#d$ } else { $P_#d$ }),
          edge((n, 1), (n + 1, 1), "->"),
          edge((n, en), (n + 1, en), label: [K], "->", label-pos: 0%),
          (
            if n == 1 {
              edge((n, xn), (n + 1, xn), "->", label: [IV], label-pos: 0%)
            } else {
              edge((n - 2, xe), (n - 1, xe), (n - 1, ee), (n + 1, ee), "->")
            }
          ),
          (
            if n == 4 {
              edge((n + 1, xe), (n + 2, xe), (n + 2, ee), (n + 3, ee), "->")
            }
          ),
        )
      }
      #diagram(
        spacing: (2em, 1em),
        node((-1, 0), [_Encryption_], stroke: none),
        ..cbc-diag(1),
        ..cbc-diag(4, d: 2),
        node((7, 3), $...$, stroke: none),
        ..cbc-diag(9, d: "n"),
      )
      #line(length: 100%, stroke: colors.darkblue)
      #diagram(
        spacing: (2em, 1em),
        node((-1, 0), [_Decryption_], stroke: none),
        ..cbc-diag(1, e: false),
        ..cbc-diag(4, d: 2, e: false),
        node((7, 2), $...$, stroke: none),
        ..cbc-diag(9, d: "n", e: false),
      )
    ],
  ),
  streamcipher: [
    Inputs: Secret key + Public nonce (aka IV)

    We can approximate a one-time pad by generating an infinite pseudo-random
    keystream

    - Stream ciphers work on messages of any length (no blockification required)
    - The nonce guarantees that each keystream is unique, even if the same key
      is reused
  ],
  ciphersuites: [
    #tr[TLS]\_#td[ECDHE]\_#tg[RSA]\_WITH\_#tp[AES\_128\_GCM]\_#ty[SHA256] \
    #tr[TLS]\_#td[ECDHE]\_#tg[RSA]\_WITH\_#tp[AES\_256\_GCM]\_#ty[SHA384] \
    #tr[TLS]\_#td[ECDHE]\_#tg[RSA]\_WITH\_#tp[CHACHA20\_POLY1305]\_#ty[SHA256] \
    #tr[TLS]\_#td[DHE]\_#tg[RSA]\_WITH\_#tp[AES\_128\_GCM]\_#ty[SHA256] \
    #tr[TLS]\_#td[DHE]\_#tg[RSA]\_WITH\_#tp[AES\_256\_GCM]\_#ty[SHA384] \

    #tr(box([Encryption\ protocol]))\_#td(box([Key\ exchange\ algorithm]))\_#tg(box([Signature\ algorithm]))\_WITH\_#tp(box([Bulk\ encryption\ algorithm]))\_#ty(box([Message\
      Authentication\ Code (MAC)])) \
  ],
  pki: (
    components: {
      let edge = edge.with(marks: "-|>")
      let nd = node.with(width: 6em, height: 3em)
      align(center, diagram(
        spacing: (2em, 2em),
        node(enclose: (<ch>, <ts>, <pse>), stroke: (
          paint: colors.fg,
          dash: "dashed",
        )),
        nd(name: <ch>, (0, 1), [Certificate\ Holder]),
        nd(name: <ts>, (0, 0), [Trust Store]),
        nd(name: <pse>, (0, 2), [Pers. Sec.\ Env. (PSE)]),

        node(enclose: (<ra>, <car>, <ca>, <va>, <tsa>, <db>), stroke: (
          paint: colors.fg,
          dash: "dashed",
        )),
        nd(name: <ra>, (1, 2), [RA]),
        nd(name: <car>, (2, 0), [CA\ (Root)]),
        nd(name: <ca>, (2, 1), [CA\ (Sub)]),
        nd(name: <va>, (3, 1), [VA]),
        nd(name: <crl>, (3, 2), [CRL\ OCSP]),
        nd(name: <tsa>, (1, 0), [TSA]),
        nd(name: <db>, (2, 2), [Repo]),

        edge(<ch>, <ts>),
        edge(<ch>, <pse>),
        edge(<ch>, <ra>),
        edge(<ca>, <ch>),
        edge(<ra>, <ca>),
        edge(<tsa>, <ca>),
        edge(<tsa>, <ch>),
        edge(<car>, <ca>, shift: .1),
        edge(<ca>, <car>, shift: .1),
        edge(<ca>, <va>, shift: .1),
        edge(<va>, <ca>, shift: .1),
        edge(<va>, <crl>),
        edge(<ca>, <db>),
        // node(name: <tsm>, (0, 0), [Trust Store]),
        // node(name: <pki>, (0, 0), [PKI Processes]),
        // node(name: <psem>, (0, 0), [PSE]),
      ))
    },
  ),
  diffiehellman: [

    - With Diffie-Hellman, two parties can jointly agree a shared secret over an
      insecure channel
    - Every communication handshake on the internet is powered by DH
    - We are exchanging some parts of the mathematical key and then we secretly
      create the key ourselves

    Process:
    - #tp[*$p$*] is usually 4096 or 6144 bits
    - #tp[*$g$*] is a primitive root of #tp[*$p$*]
    - #tr[*private keys*] are values between 1 and #tp[*$p$*]
    - The #td[*shared secret*] (often called the pre-master secret) serves as
      the foundation for deriving all subsequent session keys.
      - The raw shared secret is not used directly for encryption, as it is
        typically a very large integer (e.g., 4096 bits in RSA or DH) and may
        not have uniform entropy.
      - We derive a master secret using a hashed-key derivation function (HKDF),
        for example the SHA-256 hash function
    - The only way to find #tr[*a*] or #tr[*b*] is to solve the Discrete
      Logarithm Problem.

    #{
      let anode = node.with(fill: colors-l.yellow.lighten(30%))
      let bnode = node.with(fill: colors-l.comment.lighten(30%))
      let pnode = node.with(fill: colors-l.purple.lighten(30%))
      let edge = edge.with(marks: "-|>")
      diagram(
        node-shape: fletcher.shapes.pill,
        spacing: (4em, 1em),

        node(
          width: 17em,
          (-.85, 0),
          align(left, [
            1. Agree on #tp[*public parameters* (prime and generator)]
          ]),
          stroke: none,
        ),
        node(
          width: 17em,
          (-.85, 1),
          align(left, [
            2. Combine #tr[*private key*]\ with #tp[*the parameters*]
          ]),
          stroke: none,
        ),
        node(
          width: 17em,
          (-.85, 2),
          align(left, [
            3. Send resulting #tg[*public\ keys*] to each other
          ]),
          stroke: none,
        ),
        node(
          width: 17em,
          (-.85, 3),
          align(left, [
            4. Combine other's #tg[*pubkey*] with\ #tr[*private key*] to get
              shared
              #td[*secret*]
          ]),
          stroke: none,
        ),

        anode((0, -1), [Alice], stroke: none, shape: fletcher.shapes.rect),
        anode((0, 0), strong(tr($a=4$)), name: <a1>),
        anode(
          (0, 2),
          strong($#tg($a_"pub"$)=#tp($5$)^#tr($4$) mod #tp($23$) = #tg($4$)$),
          name: <a2>,
        ),
        anode(
          (0, 3),
          strong(
            $#td[$s$] = #place(dy: -.4em, dx: -.25em, box(radius: 50%, inset: .75em, fill: colors-l.comment.lighten(30%)))#tg($10$)^#tr($4$) mod #tp($23$) = #td[$18$]$,
          ),
          name: <a3>,
        ),

        pnode((.5, -1), [Public], stroke: none, shape: fletcher.shapes.rect),
        pnode((.5, 1), strong(tp($p=23,g=5$)), name: <p>),

        bnode((1, -1), [Bob], stroke: none, shape: fletcher.shapes.rect),
        bnode((1, 0), strong(tr($b=3$)), name: <b1>),
        bnode(
          (1, 2),
          strong($#tg($b_"pub"$)=#tp($5$)^#tr($3$) mod #tp($23$) = #tg($10$)$),
          name: <b2>,
        ),
        bnode(
          (1, 3),
          strong(
            $#td[$s$] = #place(dy: -.4em, dx: -.5em, box(radius: 50%, inset: .75em, fill: colors-l.yellow.lighten(30%)))#tg($4$)^#tr($3$) mod #tp($23$) = #td[$18$]$,
          ),
          name: <b3>,
        ),

        edge(<a1>, <p>, label: [1]),
        edge(<p>, <a2>, label: [2]),
        edge(<a1>, <a3>, label: [4], bend: -80deg),
        edge(<a1>, <a2>, label: [2]),
        edge(<a2>, <b3>, label: [3], label-pos: 30%),

        edge(<b1>, <p>, label: [1]),
        edge(<p>, <b2>, label: [2]),
        edge(<b1>, <b3>, label: [4], bend: 80deg),
        edge(<b1>, <b2>, label: [2]),
        edge(<b2>, <a3>, label: [3], label-pos: 30%),
      )
    }

    Elliptic-Curve Diffie Hellman (ECDH) is becoming the standard nowadays due
    to shorter keys.
  ],
  unifdef: [
    The _uniform probability distribution_ $unif(0, 1)$ characterizes an
    experiment in which one number is chosen from the sample space
    $Omega = [0;1]$ in such a way, that all numbers of $Omega$ have an equal
    chance to occur.
  ],
  cdfdef: [
    Whenever $Omega subset RR$, we can use $PP$ to define the _cumulative
    distribution function_ (CDF)
    $
                         F(alpha) = & PP((-oo;alpha] inter Omega) \
      lim_(alpha -> -oo) F(alpha) = & 0 \
       lim_(alpha -> oo) F(alpha) = & 1 \
    $
  ],
  cdfex: [
    #let diags = mathfml-diagrams(49%, 4cm)

    #exbox(
      title: [Cumulative distribution function $F$ and probability density
        function $f$ for $unif(a, b)$],
      [
        $
                     F : & cases(
                             RR & -> [0;1],
                             x & |-> bb(1)_[a;b] (x) dot (x - a)/(b - a) +
                                 bb(1)_((b;oo)) (x)
                           ) \
          F'(x) = f(x) = & cases(1/(b-a) &"if" a < x < b, 0 &"else")
                           = (bb(1)_((a;b)) (x))/(b-a) = "density for" X ~ unif(a, b) \
           PP (X <= x) = & integral_(-oo)^x f(t) dif t = integral_(-oo)^x (bb(1)_((a;b)) (t))/(b-a) dif t =^(a < x < b) integral_a^x 1/(a-b) dif t =
                           (x-a)/(b-a)
        $

        #diags.pdfunif
        #diags.cdfunif
      ],
    )
  ],
  pdfdef: [
    A function $f : RR -> RR^+$, such that
    $
      integral_(-oo)^oo f(t) dif t = 1
    $
    is called _probability density function_ (PDF). With any PDF we can
    associate a CDF
    $
      F(alpha) = integral_(-oo)^alpha f(t) dif t
    $
    and a probability measure $PP$ that associates the probability of the event
    $E
    subset RR$ to occur with the area of all points underneath the function
    $f(t)$ whose $t$-values reside in $E$:
    $
      PP(E) = integral_(t in E) f(t) dif t
    $
  ],
  univariate-normal-def: [
    #let diags = mathfml-diagrams(49%, 4cm)

    The probability density of the normal / Gaussian distribution is given by
    $
      f(x) = 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) (x - mu)^2)
    $
    in which $mu$ and $sigma$ are parameters, denoted as #tp[mean value ($mu$)]
    and #tg[standard deviation ($sigma$)].

    $
      integral_(mu-sigma)^(mu+sigma) 1/sqrt(2 pi sigma^2) e^(-1/(2 sigma^2) (x - mu)^2) dif t approx 0.68
    $

    #let m = 4
    #let sig = 1
    #(diags.dfdiag)(false)
    #(diags.dfdiag)(true)
    $
      tp(mu = #m), #h(2em) tg(sigma = #sig)
    $
    The value of the CDF evaluated at $x$ represents the area of the PDF from
    $-oo$ to $x$, thus giving the probability of an experiment be in $(-oo;x]$.

    All normal distributions can be defined with the help of the so called
    _standard normal distribution_
    $
      phi(x) = 1/sqrt(2 pi) e^(-1/2 x^2)
    $
    for which $mu = 0$ and $sigma = 1$. The general normal distribution can then
    be expressed in terms of the standard normal distribution using the formula
    $
      f(x|mu,sigma) = 1/sigma phi ((x-mu)/sigma)
    $

    The _error function_ is defined through
    $
      erf(x) = 2/sqrt(pi) integral_0^x e^(-t^2) dif t
    $
    or its Taylor series
    $
      erf(x) = 2/sqrt(pi) sum_(k=0)^oo (-1)^k/(k! (2k+1)) x^(2k+1)
    $
    and can be approximated through hyperbolic functions
    $
      erf(x) approx tanh(2 / sqrt(pi) (x + 11 / 123 x^3))
    $
    Given this function, one can show, that the CDF of the normal distribution
    is given by
    $
      F(x|mu,sigma) = 1/2 (1+erf((x-mu)/sqrt(2 sigma^2)))
    $
  ],
  rule-68-95-99: [
    The *68–95–99.7 rule*, also known as the empirical rule, for a normal
    distribution is a shorthand used to remember the percentage of values that
    lie within an interval estimate in a normal distribution: approximately 68%,
    95%, and 99.7% of the values lie within one, two, and three standard
    deviations of the mean, respectively.
    $
      PP(mu - 1 sigma <= X <= mu + 1 sigma) approx & 68.27% \
      PP(mu - 2 sigma <= X <= mu + 2 sigma) approx & 95.45% \
      PP(mu - 3 sigma <= X <= mu + 3 sigma) approx & 99.73% \
    $

    #{
      let m = 4
      let sig = 1
      let npdf = pdf(m, sig)
      let xs = lq.linspace(0, 8, num: 100)
      let (fn, l, n) = (npdf, $P D F$, $f(x)$)
      let xs1 = xs.filter(x => x <= m + sig and x >= m - sig)
      let xs2 = xs.filter(x => x >= m + sig and x <= m + 2 * sig)
      let xs22 = xs.filter(x => x <= m - sig and x >= m - 2 * sig)
      let xs3 = xs.filter(x => x >= m + 2 * sig and x <= m + 3 * sig)
      let xs32 = xs.filter(x => x <= m - 2 * sig and x >= m - 3 * sig)
      align(center, diagram2d(
        height: 15em,
        width: 80%,
        title: l,
        yaxis: (tick-distance: .1),
        lq.plot(xs, xs.map(fn), mark: none, label: n),
        lq.plot((m, m), (0, fn(m)), stroke: (paint: colors.purple, dash: "dashed"), mark: none),
        lq.fill-between(
          xs1,
          xs1.map(fn),
          fill: shade(x: 5pt, y: 5pt, stroke: colors.darkblue.transparentize(50%)),
          label: $plus.minus 1 sigma -> 68.27%$,
        ),
        lq.fill-between(
          xs2,
          xs2.map(fn),
          fill: shade(x: 5pt, y: 5pt, stroke: colors.red.transparentize(50%)),
          label: $plus.minus 2 sigma -> 95.45%$,
        ),
        lq.fill-between(xs22, xs22.map(fn), fill: shade(x: 5pt, y: 5pt, stroke: colors.red.transparentize(50%))),
        lq.fill-between(
          xs3,
          xs3.map(fn),
          fill: shade(x: 5pt, y: 5pt, stroke: colors.purple.transparentize(50%)),
          label: $plus.minus 3 sigma -> 99.73%$,
        ),
        lq.fill-between(xs32, xs32.map(fn), fill: shade(x: 5pt, y: 5pt, stroke: colors.purple.transparentize(50%))),
        lq.place(m, -.06, tp[$mu$]),

        lq.plot((m + sig, m + sig), (0, fn(m + sig)), stroke: (paint: colors.green, dash: "dashed"), mark: none),
        lq.plot((m - sig, m - sig), (0, fn(m - sig)), stroke: (paint: colors.green, dash: "dashed"), mark: none),

        lq.plot(
          (m + 2 * sig, m + 2 * sig),
          (0, fn(m + 2 * sig)),
          stroke: (paint: colors.green, dash: "dashed"),
          mark: none,
        ),
        lq.plot(
          (m - 2 * sig, m - 2 * sig),
          (0, fn(m - 2 * sig)),
          stroke: (paint: colors.green, dash: "dashed"),
          mark: none,
        ),

        lq.place(m + sig / 2, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.place(m - sig / 2, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.line((m - sig, -.1), (m, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),
        lq.line((m + sig, -.1), (m, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),

        lq.place(m + 1.5 * sig, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.place(m - 1.5 * sig, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.line((m - 2 * sig, -.1), (m - sig, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),
        lq.line((m + 2 * sig, -.1), (m + sig, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),

        lq.place(m + 2.5 * sig, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.place(m - 2.5 * sig, -.06, box(fill: colors.bg, inset: (x: 2pt), tg[$sigma$])),
        lq.line((m - 3 * sig, -.1), (m - 2 * sig, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),
        lq.line((m + 3 * sig, -.1), (m + 2 * sig, -.1), stroke: colors.green, toe: tiptoe.stealth, tip: tiptoe.stealth),
      ))
    },
  ],
)
