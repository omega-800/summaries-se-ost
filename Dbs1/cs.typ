#import "../lib.typ": *
#import "@preview/fletcher:0.5.5" as fletcher: node, shapes
#import shapes: ellipse, pill
#show: cheatsheet.with(
  module: "Dbs1",
  name: "Datenbanksysteme 1",
  semester: "HS25",
  language: "de",
)
#let tf = c => table.cell(fill: colors.blue, c)
#let ts = c => table.cell(fill: colors.green, c)
#let tc = b => table.cell(fill: colors.red.lighten(50%))[#b]
#let sqltbl = (..body) => {
  set text(font: code-font)
  set table(stroke: 0.07em)
  set table.cell(align: center)
  table(..body)
}
#let node = node.with(inset: 2pt)

#{
  let node = node.with(inset: 3pt)
  let edge = edge.with(label-side: right)
  let gr = colors.green.darken(20%)
  let yl = colors.yellow.darken(40%)
  set text(size: 5pt)
  diagram(
    node-stroke: 0.9pt,
    edge-stroke: 0.9pt,
    mark-scale: 40%,
    spacing: (2.5em, 3em),
    node(
      (0, 0),
      text(fill: colors.purple)[Informations-\ anforderungen],
      name: <info>,
      shape: pill,
      stroke: colors.purple,
    ),
    node(
      (2, 0),
      text(fill: colors.red)[Datenverarbeitungs-\ anforderungen],
      name: <daten>,
      shape: pill,
      stroke: colors.red,
    ),
    node(
      (2, 2),
      text(fill: colors.darkblue)[DBMS-\ Charakteristika],
      name: <dbms>,
      shape: pill,
      stroke: colors.darkblue,
    ),
    node(
      (2.1, 3),
      text(fill: gr)[Hardware/BS-\ Charakteristika],
      name: <hw>,
      shape: pill,
      stroke: gr,
    ),
    node(
      (1, 0),
      [Anforderungs-\ analyse],
      name: <anal>,
      fill: colors.blue,
      stroke: colors.blue,
    ),
    edge("->", text(
      style: "italic",
      fill: colors.comment,
    )[Anforderungs-\ spezifikation]),
    node(
      (1, 1),
      [Konzeptioneller\ DB-Entwurf],
      name: <konz>,
      fill: colors.blue,
      stroke: colors.blue,
    ),
    edge("->", text(
      style: "italic",
      fill: colors.comment,
    )[Konzeptionelles\ Datenmodell]),
    node(
      (1, 2),
      [Logischer\ DB-Entwurf],
      name: <log>,
      fill: colors.blue,
      stroke: colors.blue,
    ),
    edge("->", text(
      style: "italic",
      fill: colors.comment,
    )[Logisches\ Datenmodell]),
    node(
      (1, 3),
      [Physischer\ Entwurf],
      name: <phys>,
      fill: colors.blue,
      stroke: colors.blue,
    ),
    edge("->", text(
      style: "italic",
      fill: colors.comment,
    )[\ Physisches\ Datenmodell\ (Schema)]),
    node((1, 4), [\ ], fill: colors.blue, stroke: colors.blue, shape: circle),
    node(
      (0, 1),
      text(fill: yl)[(1) UML-\ Klassendiagramm],
      name: <uml>,
      stroke: none,
    ),
    node(
      (0, 2),
      text(fill: yl)[(2) Relationale\ Schreibweise],
      name: <rel>,
      stroke: none,
    ),
    node(
      (0, 3),
      text(fill: yl)[(3) DB-Schema\ (PG SQL)],
      name: <sql>,
      stroke: none,
    ),
    edge(<info>, <anal>, "-|>", stroke: colors.purple),
    edge((0.2, 0), (0.2, 0.9), (1, 0.9), "-|>", stroke: colors.purple),
    edge(<daten>, <anal>, "-|>", stroke: colors.red),
    edge((1.5, 0), (1.5, 0.9), (1, 0.9), "-|>", stroke: colors.red),
    edge((1.5, 0), (1.5, 1.9), (1, 1.9), "-|>", stroke: colors.red),
    edge((1.5, 0), (1.5, 2.9), (1, 2.9), "-|>", stroke: colors.red),
    edge(<dbms>, <log>, "-|>", stroke: colors.darkblue),
    edge((1.6, 2), (1.6, 3), (1, 3), "-|>", stroke: colors.darkblue),
    edge(<hw>, <phys>, "-|>", shift: 0.1, stroke: gr),
    edge(<uml>, <konz>, "-|>", stroke: yl),
    edge(<rel>, <log>, "-|>", stroke: yl),
    edge(<sql>, <phys>, "-|>", stroke: yl),
  )
}

_Glossar_
#table(
  columns: (auto, 1fr),
  [Term], [Definition],
  [Impedance-Mismatch],
  [Diskrepanz zwischen Datenstrukturen auf Applikations- und Datenbankebene],

  [System-/Datenkatalog],
  [Enthält Metadaten über die Datenbankobjekte, z.B. Tabellen und Schemata.],

  [Datenbankschema],
  [Struktur einer Datenbank, die die Organisation der Daten und Beziehungen beschreibt.],

  [Datenbasis], [Der physische Speicherort],
  [Surrogate Key], [Künstlich generierter PK],
  [Referentielle\ Integrität],
  [Fremdschlüssel muss zu einem Wert der referenzierten Tabelle oder NULL zeigen],

  [Datenunabhängigkeit],
  [Daten in einer DB ändern können, ohne dass Anwendungen geändert werden müssen],

  [Data Pages], [Kleinste Speicher-Dateneinheiten einer DB],
  [Heaps], [Unsortierte Datenorganisation],
  [Semantische\ Integrität],
  [Daten sind nicht nur syntaktisch, sondern auch inhaltlich korrekt, insbesondere nach T],

  [Data dictionary], [Zentrale Sammlung von Metadaten über die Daten im DBMS],
)
_Datenbankmodelle_ \
#deftbl(
  [Hierarchisch],
  [Daten sind in einer baumartigen Struktur geordnet],
  [Netzwerk],
  [Flexiblere Struktur als hierarchisch, Erlaubt mehrere Pfade zwischen Entitäten],
  [Objektorientiert],
  [Speichert Daten und ihr Verhalten in Form von Obj.],
  [Objektrelational],
  [Kombiniert objektorientierte + relationale Prinzipien],
  [Relational],
  [Speichert Daten in Tabellen (Relationen) und verwaltet Beziehungen durch Schlüssel],
)
#grid(
  columns: (auto, auto, auto),
  [
    1-Tier \
    #diagram(
      node((0, 0), [
        Gerät \
        #diagram(
          spacing: (0pt, 1.5em),
          node((0, 0), "Applikation"),
          edge("<->"),
          node((0, 1), [Lokale\ Datenbank]),
        )
      ]),
    )
  ],
  [
    2-Tier \
    #diagram(
      spacing: (0pt, 2.5em),
      node((0, 0), [
        Client \
        #diagram(
          node((0, 0), "Applikation", name: <asdf2>),
        )
      ]),
      edge("<->", [Netzwerk]),
      node((0, 1), [
        Server \
        #diagram(
          node((0, 0), "Datenbank", name: <asdf>),
        )
      ]),
    )
  ],
  [
    3-Tier \
    #diagram(
      spacing: (0pt, 2.5em),
      node((0, 0), [
        Client \
        #diagram(
          node((0, 0), "Applikation"),
        )
      ]),
      edge("<->", [Netzwerk]),
      node((0, 1), [
        Server \
        #diagram(
          spacing: (0pt, 1.5em),
          node((0, 0), "Applikationsserver"),
          edge("<->"),
          node((0, 1), "Datenbank"),
        )
      ]),
    )
  ],
)
_DataBase System (DBS)_ \
Besteht aus DBMS und Datenbasen \
_DataBase Management System (DBMS)_ \
#grid(
  columns: (auto, auto),
  [
    - `(A)` Transaktionen
    - `(C)` Konsistenz
    - `(I)` Mehrbenutzerbetrieb
    - `(D)` Grosse Datenmengen
    - `(D)` Sicherheit
  ],
  [
    - Datentypen
    - Abfragesprache
    - Backup & Recovery
    - Redundanzfreiheit
    - Kapselung
  ],
)
#colbreak()
_ANSI Modell_ \
*Logische Ebene*: Logische Struktur der Daten \
*Interne Ebene*: Speicherstrukturen, Definition durch internes Schema (Beziehungen, Tabellen etc.) \
*Externe Ebene*: Sicht einer Benutzerklasse auf Teilmenge der DB, Definition durch externes Schema  \
*Mapping*: Zwischen den Ebenen ist eine mehr oder weniger komplexe Abbildung notwendig \
_Relationales Modell_ \
PK sind #underline("unterstrichen"), FK sind #text(style: "italic", "kursiv") \
tabellenname ( \
#h(1em) #underline("id") SERIAL PRIMARY KEY, \
#h(1em) grade DECIMAL(2,1) NOT NULL, \
#h(1em) #text(style: "italic", "fk") INT FOREIGN KEY REFERENCES t2, \
#h(1em) u VARCHAR(9) DEFAULT CURRENT_USER, \
); \
_Unified Modeling Language (UML)_ \
#let nw2 = (width: 52pt, height: 8pt)
#let nw3 = (width: 1pt, height: 8pt)
#let nt2 = t => text(
  size: 5pt,
)[#t]
#diagram(
  node-stroke: none,
  spacing: (16pt, 1em),
  node(..nw2, (1, 1), nt2("Eins"), name: <fst>),
  node(..nw3, (2, 1), "", name: <fst2>),
  edge(<fst>, <fst2>, "1-"),
  node(..nw2, (3, 1), nt2("Mehrere"), name: <snd>),
  node(..nw3, (4, 1), "", name: <snd2>),
  edge(<snd>, <snd2>, "n-"),

  node(..nw2, (1, 2), nt2[Eins (zwingend)], name: <trd>),
  node(..nw3, (2, 2), "", name: <trd2>),
  edge(<trd>, <trd2>, "1!-"),
  node(..nw2, (3, 2), nt2[Mehrere (mind. 1)], name: <frt>),
  node(..nw3, (4, 2), "", name: <frt2>),
  edge(<frt>, <frt2>, "n!-"),

  node(..nw2, (1, 3), nt2[0 oder eins], name: <fth>),
  node(..nw3, (2, 3), "", name: <fth2>),
  edge(<fth>, <fth2>, "1?-"),
  node(..nw2, (3, 3), nt2[0 oder mehrere], name: <sxt>),
  node(..nw3, (4, 3), "", name: <sxt2>),
  edge(<sxt>, <sxt2>, "n?-"),


  node(..nw2, (1, 4), nt2("Assoziation"), name: <nnt>),
  node(..nw3, (2, 4), "", name: <nnt2>),
  edge(<nnt>, <nnt2>, "straight-"),
  node(..nw2, (3, 4), nt2("Komposition"), name: <ttt>),
  node(..nw3, (4, 4), "", name: <ttt2>),
  edge(<ttt>, <ttt2>, "composition-"),

  node(..nw2, (1, 5), nt2("Aggregation"), name: <ele>),
  node(..nw3, (2, 5), "", name: <ele2>),
  edge(<ele>, <ele2>, "aggregation-"),
  node(..nw2, (3, 5), nt2("Vererbung"), name: <twt>),
  node(..nw3, (4, 5), "", name: <twt2>),
  edge(<twt>, <twt2>, "inheritance-"),
)

*Complete*: Alle Subklassen sind definiert \
*Incomplete*: Zusätzliche Subklassen sind erlaubt \
*Disjoint*: Ist Instanz von genau einer Unterklasse \
*Overlapping*: Kann Instanz von mehreren überlappenden Unterklassen sein \
_Normalisierung_ \
*1NF*: Atomare Attributwerte: _track_  aufteilen \
#grid(
  columns: (5fr, auto, 6fr),
  sqltbl(
    columns: (1fr, 6fr),
    tf[id],
    [track],
    tf[1],
    tc[Fugazi: Song \#1],
  ),
  $=>$,
  sqltbl(
    columns: (1fr, 3fr, 3fr),
    tf[id],
    [interpret],
    [titel],
    tf[1],
    [Fugazi],
    [Song \#1],
  ),
)
*2NF*: Nichtschlüsselattr. voll vom Schlüssel abhängig.
Ist PK atomar, dann 2NF gegeben. Im Beispiel sind nicht alle Attribute des PK notwendig, um _album_ eindeutig zu identifizieren \
#sqltbl(
  columns: (1fr, 1fr, 1fr, 1fr),
  tf[track],
  tf[cd_id],
  [album],
  [titel],
  tf[1],
  tc[1],
  tc[Repeater],
  [Turnover],
  tf[2],
  tc[1],
  tc[Repeater],
  [Song \#1],
)
#grid(
  columns: (2fr, 1fr),
  [$=>$ track], [cd],
  sqltbl(
    columns: (1fr, 1fr, 1fr),
    tf[track],
    tf[cd_id],
    [titel],
    tf[1],
    tf[1],
    [Turnover],
    tf[2],
    tf[1],
    [Song \#1],
  ),
  sqltbl(
    columns: (1fr, 2fr),
    tf[id],
    [album],
    tf[1],
    [Repeater],
  ),
)
*3NF*: Keine transitiven Abhängigkeiten: _land_ ist abhängig von _interpret_ \
#sqltbl(
  columns: (1fr, 2fr, 2fr, 1fr),
  tf[id],
  [album],
  [interpret],
  [land],
  tf[1],
  [Repeater],
  tc[Fugazi],
  tc[USA],
  tf[2],
  [Red Medicine],
  tc[Fugazi],
  tc[USA],
)
#grid(
  columns: (3fr, 2fr),
  [$=>$ cd], [interpret],
  sqltbl(
    columns: (1fr, 2fr, 2fr),
    tf[id],
    [album],
    [interpret],
    tf[1],
    [Repeater],
    [1],
  ),
  sqltbl(
    columns: (1fr, 2fr, 1fr),
    tf[id],
    [name],
    [land],
    tf[1],
    [Fugazi],
    [USA],
  ),
)
*BCNF*: Nur abhängigkeiten vom Schlüssel \
*(Voll-)funktionale Abhängigkeit*:
B hängt von A ab, zu jedem Wert von A gibt es genau einen Wert von B ($A -> B$) \
*Teilweise funkt. Abh.*: B hängt von A ab, aber auch von einem Teil eines zusammengesetzten Schlüssels. \
*Transitive Abhängigkeit*: B hängt vom Attribut A ab, C hängt von B ab ($A -> B and B -> C => A -> C$) \
*Denormalisierung*: In geringere NF zurückführen (Verbessert Performance und reduziert Joins-Komplexität) \
_Anomalien_ \
Einfügeanomalie, Löschanomalie, Änderungsanomalie \
#colbreak()
_BNF_ \
#{
  show raw: set text(size: 4pt)
  ```bnf
  <select> := [ 'WITH' [ 'RECURSIVE' ] <with_query> [, ...] ]
  'SELECT' [ 'ALL' | 'DISTINCT' [ 'ON' ( <expression> [, ...] ) ] ]
      [ { * | <expression> [ [ 'AS' ] <output_name> ] } [, ...] ]
      [ 'FROM' <from_item> [, ...] ]
      [ 'WHERE' <condition> ]
      [ 'GROUP BY' [ 'ALL' | 'DISTINCT' ] <grouping_elem> [, ...] ]
      [ 'HAVING' <condition> ]
      [ 'WINDOW' <window_name> 'AS' ( <window_def> ) [, ...] ]
      [ { 'UNION' | 'INTERSECT' | 'EXCEPT' } [ 'ALL' | 'DISTINCT' ] <select> ]
      [ 'ORDER BY' <expression> [ 'ASC' | 'DESC' | 'USING' <op> ] [ 'NULLS' { 'FIRST' | 'LAST' } ] [, ...] ]
      [ 'LIMIT' { <count> | 'ALL' } ]
      [ 'OFFSET' <start> [ 'ROW' | 'ROWS' ] ]

  <from_item> := <table> [ * ] [ [ 'AS' ] <alias> [ ( <col_alias> [, ...] ) ] ]
      [ 'LATERAL' ] ( <select> ) [ [ 'AS' ] <alias> [ ( <col_alias> [, ...] ) ] ]
      <with_query_name> [ [ 'AS' ] <alias> [ ( <col_alias> [, ...] ) ] ]
      <from_item> <join_type> <from_item> { 'ON' <join_condition> | 'USING' ( <join_column> [, ...] ) [ 'AS' <join_using_alias> ] }
      <from_item> 'NATURAL' <join_type> <from_item>
      <from_item> 'CROSS JOIN' <from_item>

  <with_query> := <name> [ ( <col_name> [, ...] ) ] 'AS' ( <select> | <values> | <insert> | <update> | <delete> | <merge> )
          [ 'USING' <cycle_path_col_name> ]
  ```
}
_Data Control Language (DCL)_ \
GRANT kann angewendet werden auf: ```sql
TABLE COLUMN VIEW SEQUENCE DATABASE FUNCTION SCHEMA ```
Falls `WITH GRANT OPTION`: Der Berechtigte kann den Zugriff anderen Usern verteilen. $->$ `REVOKE ... CASCADE;`
```sql
CREATE ROLE u WITH LOGIN PASSWORD ''; -- user
GRANT INSERT ON TABLE t TO u WITH GRANT OPTION;
ALTER ROLE u CREATEROLE, CREATEDB, INHERIT;
CREATE ROLE r; -- group
GRANT r TO u; -- put user u in group r
REVOKE CREATE ON SCHEMA s FROM r;
CREATE ROLE u PASSWORD '' IN ROLE r; -- equivalent
```
_Read-only user_
```sql
-- creating
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
CREATE ROLE u WITH LOGIN ENCRYPTED PASSWORD ''
  NOINHERIT; -- don't inherit privileges
GRANT SELECT ON ALL TABLES IN SCHEMA public TO u;
-- read all new tables (also created by others):
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT
  SELECT ON TABLES TO u;
-- deleting
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM u;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE SELECT ON TABLES FROM u;
DROP USER u;
```
_Row-Level Security (RLS)_ \
```sql
CREATE TABLE exams (
  id SERIAL, -- other fields...
  teacher VARCHAR(60) DEFAULT current_user
);
CREATE POLICY teachers_see_own_exams ON exams
  FOR ALL TO PUBLIC USING (teacher = current_user);
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
```
_Data Definition Language (DDL)_ \
#corr("Wichtig: NOT NULL wo notwendig nicht vergessen") \
```sql
CREATE SCHEMA s;
CREATE TABLE t (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  grade DECIMAL(2,1) NOT NULL,
  fk INT FOREIGN KEY REFERENCES t2.id
    ON DELETE CASCADE,
  added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  u VARCHAR(9) DEFAULT CURRENT_USER,
  CHECK (grade between 1 and 6)
);
ALTER TABLE t2 ADD CONSTRAINT c PRIMARY KEY (a, b);
TRUNCATE/DROP TABLE t;
```
_Vererbung_ \
*Tabelle pro Sub- und Superklasse*: \
```sql
CREATE TABLE sup ( -- 3.a
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE
);
CREATE TABLE sub1 (
  id SERIAL PRIMARY KEY,
  age INT
);
CREATE TABLE sub2 (
  id SERIAL PRIMARY KEY
);
ALTER TABLE sub1 ADD CONSTRAINT id FOREIGN KEY
  REFERENCES sup (id);
ALTER TABLE sub2 ADD CONSTRAINT id FOREIGN KEY
  REFERENCES sup (id);
```
*Tabelle pro Subklasse*: Enthält jeweil. Subklassattribute \
```sql
CREATE TABLE sub1 ( -- 3.b
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  age INT
);
CREATE TABLE sub2 (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE
);
```
*Einzige Tabelle für Superklasse*: Enthält alle Attribute \
```sql
CREATE TABLE sup ( -- 3.c
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  age INT
);
```
_Junction Tabellen_ \
```sql
CREATE TABLE a_b(
  a: INTEGER REFERENCES a(id),
  b: INTEGER REFERENCES b(id),
  PRIMARY KEY(a, b)
);
```
_Datentypen_ \
#table(
  columns: (auto, 1fr),
  [Type], [Description],
  [INTEGER/INT], [Integer (4 bytes)],
  [BIGINT], [Large integer (8 bytes)],
  [SMALLINT], [Small integer (2 bytes)],
  [REAL], [Single precision float (4 bytes)],
  [NUMERIC(precision,\ scale)],
  [Exact numeric of selectable precision\ Alias for ```sql DECIMAL(precision, scale)```],

  [DOUBLE PRECISION], [Double precision float (8 bytes)],
  [SERIAL], [Auto-incrementing integer (4 bytes)],
  [BIGSERIAL], [Auto-incrementing large integer (8 bytes)],
  [SMALLSERIAL], [Auto-incrementing small integer (2 bytes)],
  [CHARACTER/\ CHAR(size)], [Fixed-length, blank-padded string],
  [VARCHAR(size)], [Variable-length, non-blank-padded string],
  [TEXT], [Variable-length character string],
  [BOOLEAN], [Logical Boolean (true/false)],
  [DATE], [Calendar date (year, month, day)],
  [TIME], [Time of day (no time zone)],
  [TIMESTAMP], [Date and time (no time zone)],
  [TIMESTAMP WITH\ TIME ZONE], [Date and time with time zone],
  [INTERVAL], [Time interval],
  [JSON], [JSON data],
  [UUID], [Universally unique identifier],
  [ARRAY OF base_type], [Array of values],
)
```sql
NUMERIC(4, 2) /* 99.99 */ NUMERIC(2, 1) /* 9.9 */
VARCHAR(5) /* 'abcde' */  CHAR(5) /* 'abcde' */
```
_Casting_ \
Explizit
```sql
CAST(5 AS float8) = 5::float8
SELECT 'ABCDEFG'::NUMERIC; -- error
SELECT SAFE_CAST('ABCDEFG' AS NUMERIC); -- NULL
```
Implizit
```sql
SELECT 5 + 3.2; -- 5 is cast to 5.0 (numeric)
SELECT 'Number ' || 42; -- 42 is cast to '42'
SELECT true AND 1; -- 1 is treated as true
SELECT CURRENT_TIMESTAMP + INTERVAL '1 day'; -- CURRENT_TIMESTAMP to date
SELECT '100'::text + 1; -- '100' is cast to 100
```
_Views_ \
Resultate werden jedes mal dynamisch queried \
```sql
CREATE VIEW v (id, u) AS SELECT id, u FROM t;
-- complex query
CREATE VIEW cheap_restaurant_view AS
WITH big_restaurant AS (
  SELECT * FROM restaurant
  WHERE anzahl_plaetze >= 20
)
SELECT r.name AS restaurant_name, s.name,
  MIN(g.preis) AS cheap_gericht
FROM big_restaurant r
LEFT JOIN skigebiet s ON (s.id = r.skigebiet_id)
LEFT JOIN menukarte m ON (r.id = m.restaurant_id)
LEFT JOIN menu_gericht mg ON (m.id = mg.menu_id)
LEFT JOIN gericht g ON (g.id = mg.gericht_id)
WHERE ist_tagesmenu = true
GROUP BY r.id, s.id, restaurant_name
HAVING MIN(g.preis) >= 3
ORDER BY cheap_gericht;
```
_Updatable View_ \
Views sind updatable wenn diese Kriterien erfüllt sind: \
- Single base table
- Keine aggregate, DISTINCT, GROUP BY, oder HAVING klauseln
- Alle Spalten müssen zur originalen Tabelle direkt gemappt werden können
_Materialized View_ \
Speichert resultat auf Disk \
```sql
CREATE MATERIALIZED VIEW mv AS SELECT * FROM t;
REFRESH MATERIALIZED VIEW mv; -- refresh results
```
_Temporäre Tabellen_ \
```sql
CREATE TEMPORARY TABLE temp_products (
  id SERIAL PRIMARY KEY,
  product_name TEXT
);

INSERT INTO temp_products (product_name) VALUES
  ('Product A'), ('Product B'), ('Product C');

SELECT ts.product_name, ts.quantity FROM
  temp_sales ts JOIN temp_products tp ON
  ts.product_name = tp.product_name;
```
_Data Manipulation Language (DML)_
```sql
FROM -> JOIN -> WHERE -> GROUP BY -> HAVING ->
  SELECT (WINDOW FUNCTIONS) -> ORDER BY -> LIMIT
```
_Common Table Expressions (CTE)_ \
- Erlauben die zeilenweise Ausgabe
- Erlauben Abfragen quasi als Parameter
- Können rekursiv sein
```sql
-- normal
WITH cte AS (SELECT * FROM t) SELECT * FROM cte;
WITH tmp(id, name) AS (SELECT id, name FROM t)
  SELECT id, name FROM tmptable;
-- recursive
WITH RECURSIVE q AS (SELECT * FROM t WHERE grade>1
  UNION ALL SELECT * FROM t INNER JOIN q ON
  q.u = t.name) SELECT id as 'ID' FROM q;
```
#colbreak()
_Window Functions_
```sql
SELECT id, RANK() OVER
  (ORDER BY grade DESC) as r FROM t;
SELECT id, u, LAG(name, 1) OVER
  (PARTITION BY fk ORDER BY id DESC) FROM t;
-- PERCENT/DENSE_RANK(), FIRST_VALUE(v), LAST_VALUE(n)
-- NTH_VALUE(v,n), NTILE(n), LEAD(v,o), ROW_NUMBER()
```
_INSERT_ \
```sql
INSERT INTO t (added, grade)
  VALUES ('2002-10-10', 1) RETURNING id;
```
_UPDATE_ \
```sql
UPDATE t SET grade = grade+1, name='' WHERE id = 1;
```
_Subqueries_
```sql
SELECT * FROM t WHERE grade > ANY (SELECT g FROM t2);
SELECT * FROM t WHERE EXISTS (SELECT g FROM t2);
-- ALL, ANY, IN, EXISTS, =
```

#grid(
  columns: (auto, auto, auto),
  [
    users (_u_)
    #sqltbl(
      columns: (auto, auto),
      [id],
      [name],
      tf[1],
      tf[Alice],
      tf[2],
      tf[Bob],
    )],
  [
    actions (_a_)
    #sqltbl(
      columns: (auto, auto, auto),
      [id],
      [uid],
      [action],
      ts[7],
      ts[1],
      ts[LOGIN],
      ts[8],
      ts[2],
      ts[VIEW],
      ts[9],
      ts[4],
      ts[LOGIN],
    )],
  [*INFO:* FK _uid_ in den Query-Resultaten unten aus Platzgründen ausgelassen],
)
#grid(
  columns: (auto, auto),
  [_Inner Join_ \
    Zeilen, die in beiden Tabellen matchen
    ```sql
    SELECT u.*, a.* FROM u INNER JOIN a ON u.id = a.uid;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Equi Join_ \
    Wie Inner Join
    ```sql
    SELECT u.*, a.* FROM u JOIN a ON u.id = a.uid;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Natural Join_ \
    Wie Inner Join aber ohne Duplikate
    ```sql
    SELECT u.*, a.* FROM u NATURAL JOIN a ON u.id=a.uid;
    ```
    #corr("TODO: ")
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Semi Join_ \
    Nur Zeilen aus a, wobei b matchen muss
    ```sql
    SELECT * FROM u WHERE EXISTS
    (SELECT 1 FROM a WHERE u.id = a.uid);
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto),
    [],
    tf[],
    tf[],
    [1],
    tf[1],
    tf[Alice],
  ),
)
#grid(
  columns: (auto, auto),
  [_Anti Join_ \
    Nur Zeilen aus a, wobei b nicht matchen darf
    ```sql
    SELECT * FROM u WHERE NOT EXISTS
      (SELECT 1 FROM a WHERE u.id = a.uid);
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto),
    [],
    tf[],
    tf[],
    [1],
    tf[2],
    tf[Bob],
  ),
)
#grid(
  columns: (auto, auto),
  [_Left outer Join_ \
    Alle Zeilen beider Tabellen, NULL für b falls kein match
    ```sql
    SELECT u.*, a.* FROM u LEFT JOIN a ON u.id = a.uid;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
    [2],
    tf[2],
    tf[Bob],
    [],
    [],
  ),
)
#grid(
  columns: (auto, auto),
  [_Right outer Join_ \
    Alle Zeilen beider Tabellen, NULL für a falls kein match
    ```sql
    SELECT u.*, a.* FROM u RIGHT JOIN a ON u.id = a.uid;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
    [3],
    [],
    [],
    ts[8],
    ts[VIEW],
    [4],
    [],
    [],
    ts[9],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Full outer Join_ \
    Alle Zeilen beider Tabellen, NULL falls kein match
    ```sql
    SELECT u.*, a.* FROM u FULL OUTER JOIN a ON u.id = a.uid;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
    [2],
    tf[2],
    tf[Bob],
    [],
    [],
    [3],
    [],
    [],
    ts[8],
    ts[VIEW],
    [4],
    [],
    [],
    ts[9],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Cross Join_ \
    Liefert alle möglichen Kombinationen zweier Tabellen.
    ```sql
    SELECT * FROM u CROSS JOIN a;
    ```
  ],
  sqltbl(
    columns: (auto, auto, auto, auto, auto),
    [],
    tf[],
    tf[],
    ts[],
    ts[],
    [1],
    tf[1],
    tf[Alice],
    ts[7],
    ts[LOGIN],
    [2],
    tf[1],
    tf[Alice],
    ts[8],
    ts[VIEW],
    [3],
    tf[1],
    tf[Alice],
    ts[9],
    ts[LOGIN],
    [4],
    tf[2],
    tf[Bob],
    ts[7],
    ts[LOGIN],
    [5],
    tf[2],
    tf[Bob],
    ts[8],
    ts[VIEW],
    [6],
    tf[2],
    tf[Bob],
    ts[9],
    ts[LOGIN],
  ),
)
#grid(
  columns: (auto, auto),
  [_Union_ \
    "Verbindet" zwei SELECT's ohne Duplikate. \
    Voraussetzung: Spalten müssen ähnliche Datentypen beinhalten
    ```sql
    SELECT name FROM u UNION SELECT action FROM a;
    ```
  ],
  sqltbl(
    columns: (auto, auto),
    [],
    [],
    [1],
    tf[Alice],
    [2],
    tf[Bob],
    [3],
    ts[LOGIN],
    [4],
    ts[VIEW],
  ),
)
_Lateral Join_ \
Join, der Subqueries erlaubt
```sql
SELECT x.*, y.* FROM a AS x JOIN LATERAL
  (SELECT * FROM b WHERE b.id = y.id) AS y ON TRUE;
```
_GROUP BY_
```sql
SELECT id, COUNT(*) FROM t
  GROUP BY grade, id HAVING COUNT(*) > 2;
```
_WHERE_
```sql
BETWEEN 1 AND 5; LIKE '___%'; AND; IS (NOT) NULL
IN (1, 5)      ; LIKE '%asd'; OR ;
```
_Aggregatfunktionen_
```sql
COUNT   ; SUM   ; MIN   ; MAX   ; AVG
```
_Weitere Funktionen_
```sql
COALESCE(a1, a2, ...); -- returns first non-null arg
```
#let cr = table.cell(fill: colors.red, sym.crossmark)
#let cg = table.cell(fill: colors.green, sym.checkmark)
#let cb = table.cell(fill: colors.blue, sym.star)
_Relationale Algebra_ \
$pi_(R 1,R 4) (R)$ ```sql SELECT R1,R4 FROM R;``` #h(1fr) (Projektion)\
$sigma_(R 1 > 30) (R)$ ```sql SELECT * FROM R WHERE R1 > 30;``` #h(1fr) (Selektion)\
$rho_("a" <- "R")$ ```sql SELECT * FROM R AS a;``` #h(1fr) (Umbenennung/Alias)\
$R times S$ ```sql SELECT * FROM R,S;``` #h(1fr) (Kartesisches Produkt)\
$R attach(limits(join), b: A=B) S$ ```sql SELECT * FROM R JOIN S ON R.A=S.B;``` #h(1fr) (Verbund)\
_Dreiwertige Logik_ (cursed)\
```sql
SELECT NULL IS NULL; -- true
SELECT NULL = NULL;  -- [unknown]
```
_INDEX_ \
#table(
  columns: (auto, 1fr, 1fr, 1fr, 1fr),
  [], [B-Tree], [Hash], [BRIN], [ISAM],
  [Gleichheitsabfragen], cg, cg, cr, cg,
  [Range Queries], cg, cr, cg, cr,
  [Sortierte Daten], cg, cr, cg, cg,
  [Grosse Tabellen], cb, table.cell(fill: colors.blue, [bei =]), cg, cg,
  [Häufige abfragen], cg, cb, cg, cr,
  [Direkter zugriff über PK], cg, cg, cr, cb,
  [Überlaufseiten], cg, cg, cr, cg,
)
```sql
CREATE INDEX i ON t/*USING BTREE*/ (grade,UPPER(u));
CREATE INDEX j ON t (fk) INCLUDE (added) WHERE fk>4;
DROP INDEX i;
```
_Transaktionen_ \
Note: In postgres gibt es keine geschachtelten T. \
*Atomicity*: Vollständig oder gar nicht \
*Consistency*: Konsistenter Zustand bleibt erhalten \
*Isolation*: Transaktion ist von anderen T isoliert \
*Durability*: Änderungen sind persistent \
```sql
BEGIN;  SAVEPOINT s;
COMMIT; ROLLBACK /*TO SAVEPOINT s*/;
```
_Isolation_
```sql
SET TRANSACTION ISOLATION LEVEL ...; -- transaction
SET SESSION CHARACTERISTICS AS TRANSACTION
  ISOLATION LEVEL ...; --  session
```
#colbreak()
*READ UNCOMMITTED*: Lesezugriffe nicht synchronisiert (keine Read-lock), Read ignoriert jegliche Sperren \
*READ COMMITTED*: Lesezugriffe nur kurz/temporär synchronisiert (default), setzt für gesamte T Write-Lock, Read-lock nur kurzfristig \
*REPEATABLE READ*: Einzelne Zugriffe ROWS sind synchronisiert, Read und Write Lock für die gesamte T \
*SERIALIZABLE*: Vollständige Isolation nach ACID \
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  [], [Read Uncommitted], [Read Committed], [Repeatable Read], [Serializable],
  [Dirty Write], cb, cb, cb, cr,
  [Dirty Read], cg, cr, cr, cr,
  [Lost Update], cg, cg, cr, cr,
  [Fuzzy Read], cg, cg, cr, cr,
  [Phantom Read], cg, cg, cg, cr,
  [Read Skew], cg, cg, cr, cr,
  [Write Skew], cg, cg, cg, cb,
  [Dauerhaftigkeit], cg, cg, cr, cr,
  [Atomizität], cr, cr, cg, cg,
)
\* Nur in SQL92 möglich, PSQL >= 9.1 verhindert dies \
*Dirty Read*: Lese Daten von nicht committed T's \
*Fuzzy Read*: Versch. Werte beim mehrmaligen Lesen gleicher Daten (da durch andere T geändert) \
*Phantom Read*: Neue/Gelöschte Rows einer anderen T \
*Read Skew*: Daten lesen, die sich während der T ändern \
*Write Skew*: Mehrere T lesen Daten und Ändern sie \
*Deadlock*: Mehrere T blockieren sich, da sie auf die gleiche Ressource warten \
*Cascading Rollback*: T schlägt fehl und alle davon abhängigen T müssen ebenfalls zurückgerollt werden \
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  [],
  [Serialisierbar],
  [Deadlocks],
  [Cascading RollB.],
  [Konflikt-RollB.],
  [Hohe Parallelität],
  [Realistisch],

  [Two-Phase Locking], cg, cg, cg, cr, cr, cr,
  [Strict 2PL], cg, cg, cr, cr, cr, cg,
  [Preclaiming 2PL], cg, cr, cr, cr, cr, cr,
  [Validation-based], cg, cr, cg, cg, cg, cg,
  [Timestamp-based], cg, cr, cg, cg, cg, cg,
  [Snapshot Isolation], cr, cb, cr, cg, cg, cg,
  [SSI], cg, cb, cr, cg, cg, cg,
)
\* Deadlock in PSQL mit Snapshot Isolation \
*SQL Beispiel* \
```sql
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;
```
_Two-Phase Locking (2PL)_ \
Stellt Isolation der T sicher \
+ Growing Phase: Die T kann neue Locks erwerben, jedoch keine freigeben
+ Shrinking Phase: Locks können freigegeben werden, aber keine neuen mehr erworben werden
*Strict 2PL*: T geben locks erst nach commit frei \
*Preclaiming 2PL*: Alle Locks werden zu Beginn der T erstellt\
*#[_S_]hared* _Lock_: Lesezugriffe (mehrere Transaktionen) \
*E#[_X_]clusive* _Lock_: Schreib- & Lesezugriffe (eine Transaktion) \
*Starvation*: T erhält aufgrund von Sperren niemals die Möglichkeit, ihre Arbeit abzuschliessen, da T immer blockiert wird \
_Optimistisches Lockverfahren_ \
T operieren ohne anfängliche Sperren. Überprüfen am Ende falls Konflikte aufgetreten $->$ Änderungen zurücksetzen. \
_Pessimistisches Lockverfahren_ (Preclaiming 2PL)\
T fordern sofort Sperren an, damit andere T nicht gleichzeitig auf dieselben Daten zugreifen oder diese ändern. \
#table(
  columns: (1fr, 1fr),
  [T1], [T2],
  [#corr("TODO: ")], [],
)
_Serialisierbarkeit_ \
*Serieller Schedule*: Führt Transaktionen am Stück aus \
*Nicht serialisierbar*:

#let node = node.with(width: 8pt, height: 8pt, inset: 3pt)
#grid(
  columns: (3fr, 1fr),
  [
    #set text(weight: "bold")
    S1=#td([R1])#math.underbracket([(x)#tr([R2])#math.underbracket([(x)#td([W1])])\(x)#td([R1])\(y)#tr([W2])])\(x)#td([W1])\(y)
  ],
  diagram(
    spacing: (2em, 2em),
    node-shape: circle,
    node((1, 1), "T1", name: <t1>, fill: colors.blue),
    node((2, 1), "T2", name: <t2>, fill: colors.red),
    edge(<t1>, <t2>, shift: (5pt, 5pt), "-|>"),
    edge(<t2>, <t1>, shift: (5pt, 5pt), "-|>"),
  ),
)
*Konfliktpaare*: \
#grid(
  columns: (1fr, 1fr),
  [#td([R1])\(x) < #tr([W2])\(x)], [#tr([R2])\(x) < #td([W1])\(x)],
)
*Konflikt-Serialisierbar:* \
#td([r1(b)])#tr([r2(b)w2(b)r2(c)r2(d)])#tg([w3(a)])#tp([r4(d)])#tg([r3(b)])#tp(
  [w4(d)],
)#tb([r5(c)r5(a)])#tp([w4(c)]) \
*Konflikt-Äquivalenter serieller Schedule:* \
#td([r1(b)])#tr([r2(b)w2(b)r2(c)r2(d)])#tg([w3(a)r3(b)])#tb([r5(c)r5(a)])#tp(
  [r4(d)w4(d)w4(c)],
) \
#diagram(
  spacing: (2em, 2em),
  node-shape: circle,
  node((1, 1), "T1", name: <t1>, fill: colors.darkblue),
  node((2, 1), "T2", name: <t2>, fill: colors.red),
  node((3, 1), "T3", name: <t3>, fill: colors.green),
  node((5, 1), "T4", name: <t4>, fill: colors.purple),
  node((4, 1), "T5", name: <t5>, fill: colors.blue),
  edge(<t1>, <t2>, "-|>"),
  edge(<t2>, <t3>, "-|>"),
  edge(<t2>, <t4>, "-|>", bend: 30deg),
  edge(<t3>, <t5>, "-|>"),
  edge(<t5>, <t4>, "-|>"),
) \
#deftbl(
  [Seriell],
  [Alle T in einem Schedule sind geordnet],
  [Konfliktäquivalent],
  [Rehenfolge aller Paare von konfligierenden Aktionen ist in beiden Schedules gleich],
  [Konfliktserialisierbar],
  [Ein S backslash a regexist konfliktäquivalent zu einem seriellen S],
)
_Vollständiges Backup_ \
Exakte kopie der ganzen DB \
_Inkrementelles Backup_ \
Sichert nur die seit dem letzten Backup geänderten Daten. \
_Logisches Backup (SQL Dump)_ \
Blockiert keine T. Für mittelgrosse Datenmengen, interkompatibel mit neuen PG-Versionen und anderen Maschinen. \
_Physisches Backup (File System)_ \
Datenbank muss gestoppt werden, schneller als logisches Backup, passt nur zu derselben "Major Version" von PG. \
_Multi-Version Concurrency Control (MVCC)_ \
Ermöglich es, mehreren T gleichzeitig zu laufen. Bei jeder Änderung wird eine neue Version der Daten erstellt. Leser sehen die älteren Versionen, während Schreiber die neuesten Versionen sehen. \
_Write-Ahead Log (WAL)_ \
Schreibt Änderungen der T in Log, dann Commit loggen, dann Updates in DB. Kann bei Absturz replayed werden \
*LSN, TaID, PageID, Redo, Undo, PrevLSN* \
_SQL Beispiele_
```sql
CREATE TABLE pferd (
  pnr SERIAL PRIMARY KEY,
  name TEXT,
  alter INT,
  zuechternr INT REFERENCES stall.pk,
  vaternr INT REFERENCES pferd.pk
);
CREATE TABLE stall (
  zuechternr SERIAL PRIMARY KEY,
  name TEXT,
  plz INT,
  ort TEXT,
  strasse TEXT
);

-- Welche Züchter haben in ihren Ställen mindestens 1 Kind von dem Vater mit Namen "Hermes"

-- Eleganteste anfrage unkorreliert
SELECT s.name FROM staelle s
WHERE s.zuechternr IN (
  SELECT p.zuechternr
  FROM pferde p
  JOIN pferde p2 ON p2.pnr = p.vaternr
  WHERE p2.name = 'Hermes'
);
-- Kürzeste anfrage
SELECT DISTINCT s.name FROM staelle s
JOIN pferde p ON p.zuechternr = s.zuechternr
JOIN pferde p2 ON p2.pnr = p.vaternr
WHERE p2.name = 'Hermes';
--
SELECT DISTINCT s.name FROM staelle s
JOIN pferde p ON p.zuechternr = s.zuechternr
WHERE EXISTS (
  SELECT vaternr FROM pferde p2
  WHERE p2.pnr = p.vaternr AND p2.name = 'Hermes'
);
```
_B-Baum_ \
#grid(
  columns: (1fr, 1fr),
  [
    #text(fill: colors.darkblue)[+4]
    #diagram(
      spacing: (0em, 1em),
      node((3, 1), "10", name: <fst>),
      node((4, 1), " ", name: <fst2>),
      node((5, 1), " "),
      node((6, 1), " "),
      node((0, 2), "1"),
      node((1, 2), "2", name: <snd>),
      node((2, 2), "3", fill: colors.green),
      node((3, 2), "7", stroke: colors.green),
      node((5, 2), "13"),
      node((6, 2), "19", name: <trd>),
      node((7, 2), " "),
      node((8, 2), " "),
      edge(<fst>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
    )],
  [
    #text(fill: colors.darkblue)[+11,+21]
    #diagram(
      spacing: (0em, 1em),
      node((4, 1), "3", fill: colors.green, name: <n>),
      node((5, 1), "10", name: <fst>),
      node((6, 1), " ", name: <fst2>),
      node((7, 1), " "),
      node((0, 2), "1"),
      node((1, 2), "2", name: <snd>),
      node((2, 2), " "),
      node((3, 2), " "),
      node((2, 3), "4", fill: colors.blue),
      node((3, 3), "7", stroke: colors.green, name: <frt>),
      node((4, 3), " "),
      node((5, 3), " "),
      node((5, 2), "13"),
      node((6, 2), "19", name: <trd>),
      node((7, 2), " "),
      node((8, 2), " "),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), stroke: colors.darkblue, "-|>"),
    )],

  [
    #text(fill: colors.darkblue)[+12]
    #diagram(
      spacing: (0em, 1em),
      node((4, 1), "3", name: <n>),
      node((5, 1), "10", name: <fst>),
      node((6, 1), " ", name: <fst2>),
      node((7, 1), " "),
      node((0, 2), "1"),
      node((1, 2), "2", name: <snd>),
      node((2, 2), " "),
      node((3, 2), " "),
      node((2, 3), "4"),
      node((3, 3), "7", name: <frt>),
      node((4, 3), " "),
      node((5, 3), " "),
      node((5, 2), "11", fill: colors.blue, stroke: colors.green),
      node((6, 2), "13", fill: colors.green, name: <trd>),
      node((7, 2), "19"),
      node((8, 2), "21", fill: colors.blue),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
    )],
  [#diagram(
    spacing: (0em, 1em),
    node((4, 1), "3", name: <n>),
    node((5, 1), "10", name: <fst>),
    node((6, 1), "13", fill: colors.green, name: <fst2>),
    node((7, 1), " ", name: <fst3>),
    node((0, 2), "1"),
    node((1, 2), "2", name: <snd>),
    node((2, 2), " "),
    node((3, 2), " "),
    node((2, 3), "4"),
    node((3, 3), "7", name: <frt>),
    node((4, 3), " "),
    node((5, 3), " "),
    node((8, 2), "19"),
    node((9, 2), "21", name: <trd>),
    node((10, 2), " "),
    node((11, 2), " "),
    node((6.5, 3), "11", stroke: colors.green),
    node((7.5, 3), "12", fill: colors.blue, name: <fth>),
    node((8.5, 3), " "),
    node((9.5, 3), " "),
    edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
    edge(<fst3>, <trd>, shift: (-7pt, 7pt), "-|>"),
    edge(<fst2>, <fth>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
    edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
  )],
) \
