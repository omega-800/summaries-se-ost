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
    lambda ve(0) = ve(0) \
    ve(v) + ve(0) = ve(v) \
    -ve(v) = -1 dot ve(v) \
    -ve(v) + ve(v) = ve(0) \
    (lambda mu)ve(v) = lambda(mu ve(v)) = lambda mu ve(v) \
    lambda(ve(v)+ve(w)) = lambda ve(v) + lambda ve(w) \
    ve(v) + (ve(u)+ve(w)) = (ve(v) + ve(u))+ve(w) = ve(v) + ve(u)+ve(w) \
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
    - Blöcke können sich teilweise überlappen. Das kann sinnvoll sein, wenn dadurch
      grössere Blöcke entstehen.
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
    Mutating Collection while iterating over it: ConcurrentModificationException \
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
    #tr([*Unchecked*]) #tg([*Checked*])
    #diagram(
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
)
