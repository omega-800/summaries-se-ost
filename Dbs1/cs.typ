#import "../lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#let lang = "de"
#show: cheatsheet.with(
  module: "Dbs1",
  name: "Datenbanksysteme 1",
  semester: "HS25",
  language: lang,
)
#let tbl = (..body) => deftbl(lang, "Dbs1", ..body)
#let nw = (width: 8pt, height: 8pt)
#let nt = t => box(..nw, baseline: -4pt, align(right, text(
  size: 5pt,
)[#t]))
#let dd = (
  spacing: (0em, 1em),
  node-stroke: 1pt,
  edge-stroke: 1pt,
  node-shape: rect,
  mark-scale: 60%,
)

#image("./img/db-entwurfsprozess.png")
#corr("TODO: glossar") \
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
_Unified Modeling Language (UML)_
#grid(
  columns: (auto, auto, auto, auto),
  image(height: 6pt, "./img/uml_arrow_association.jpg"),
  "Assoziation",
  image(height: 6pt, "./img/uml_arrow_composition.jpg"),
  "Komposition",

  image(height: 6pt, "./img/uml_arrow_aggregation.jpg"),
  "Aggregation",
  image(height: 6pt, "./img/uml_arrow_inheritance.jpg"),
  "Vererbung",
)
#image("./img/crows-foot-notation.webp")
*Complete*: Alle Subklassen sind definiert \
*Incomplete*: Zusätzliche Subklassen sind erlaubt \
*Disjoint*: Ist Instanz von genau einer Unterklasse \
*Overlapping*: Kann Instanz von mehreren überlappenden Unterklassen sein \
_Normalisierung_ \
*1NF*: Atomare Attributwerte \
#corr("TODO: better examples")
#let tcb = b => table.cell(fill: colors.blue)[#b]
#let tcr = b => table.cell(fill: colors.red.lighten(50%))[#b]
#grid(
  columns: (1fr, auto, 1fr),
  table(
    columns: (1fr, 1fr),
    tcb[id], tcr[full_name],
    tcb[1], tcr[First Last],
  ),
  $=>$,
  table(
    columns: (1fr, 1fr, 1fr),
    tcb[id], [first], [last],
    tcb[1], [First], [Last],
  ),
)
*2NF*: Nichtschlüsselattr. voll vom Schlüssel abhängig \
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  tcb[track], [title], tcb[cd_id], tcr[album],
  tcb[1], [Turnover], tcr[1], tcr[Repeater],
  tcb[2], [Repeater], tcr[1], tcr[Repeater],
)
#grid(
  columns: (2fr, 1fr),
  [$=>$ track], [cd],
  table(
    columns: (1fr, 1fr, 1fr),
    tcb[track], tcb[cd_id], [title],
    tcb[1], tcb[1], [Turnover],
    tcb[2], tcb[1], [Repeater],
  ),
  table(
    columns: (1fr, 2fr),
    tcb[id], [album],
    tcb[1], [Repeater],
  ),
)
*3NF*: Keine transitiven Abhängigkeiten \
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  tcb[id], [album], [interpret], [land],
  tcb[1], [Repeater], tcr[Fugazi], tcr[USA],
  tcb[2], [Red Medicine], tcr[Fugazi], tcr[USA],
)
#grid(
  columns: (3fr, 2fr),
  [$=>$ cd], [kuenstler],
  table(
    columns: (1fr, 1fr, 1fr),
    tcb[id], [album], [interpret],
    tcb[1], [Repeater], [1],
  ),
  table(
    columns: (1fr, 1fr, 1fr),
    tcb[id], [name], [land],
    tcb[1], [Fugazi], [USA],
  ),
)
*BCNF*: Nur abhängigkeiten vom Schlüssel \
*(Voll-)funktionale Abhängigkeit*:
B hängt von A ab, zu jedem Wert von A gibt es genau einen Wert von B ($A -> B$) \
*Transitive Abhängigkeit*: B hängt vom Attribut A ab, C hängt von B ab ($A -> B and B -> C => A -> C$) \
*Denormalisierung*: In geringere NF zurückführen (Verbessert Performance und reduziert Joins-Komplexität) \
_Anomalien_ \
Einfügeanomalie, Löschanomalie, Änderungsanomalie \
_Data Control Language (DCL)_ \
If `WITH GRANT OPTION` is specified, the recipient of the privilege can in turn grant it to others. $->$ `REVOKE ... CASCADE;`
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
```sql
SMALLINT  INT     INTEGER   BIGINT  REAL    FLOAT
DOUBLE    NUMERIC(precision,scale)  DECIMAL(p,s)
VARCHAR(size)     TEXT      CHAR(size) -- fixed size
DATETIME  DATE    INTERVAL  TIME    BINARY
CLOB /*Char Large Object*/  BLOB    VARBINARY
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
_Inner Join_ \
Zeilen, die in beiden Tabellen matchen
```sql
SELECT a.*, b.* FROM a INNER JOIN b ON a.id = b.id;
```
_Equi Join_ \
Wie Inner Join
```sql
SELECT a.*, b.* FROM a JOIN b ON a.id = b.id;
```
_Natural Join_ \
Wie Inner Join aber ohne Duplikate
```sql
SELECT a.*, b.* FROM a NATURAL JOIN b ON a.id = b.id;
```
_Semi Join_ \
Nur Zeilen aus a, wobei b matchen muss
```sql
SELECT a.* FROM a WHERE EXISTS
  (SELECT 1 FROM b WHERE a.id = b.id);
```
_Anti Join_ \
Nur Zeilen aus a, wobei b nicht matchen darf
```sql
SELECT a.* FROM a WHERE NOT EXISTS
  (SELECT 1 FROM b WHERE a.id = b.id);
```
_Left outer Join_ \
Alle Zeilen beider Tabellen, NULL für b falls kein match
```sql
SELECT a.*,b.* FROM a LEFT OUTER JOIN b ON a.id=b.id;
```
_Right outer Join_ \
Alle Zeilen beider Tabellen, NULL für a falls kein match
```sql
SELECT a.*,b.* FROM a RIGHT OUTER JOIN b ON a.id=b.id;
```
_Full outer Join_ \
Alle Zeilen beider Tabellen, NULL falls kein match
```sql
SELECT a.*,b.* FROM a FULL OUTER JOIN b ON a.id=b.id;
```
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
COALESCE(a1, a2, ...); // returns first non-null arg
```
#let cr = table.cell(fill: colors.red, sym.crossmark)
#let cg = table.cell(fill: colors.green, sym.checkmark)
#let cb = table.cell(fill: colors.blue, sym.star)
_INDEX_ \
#table(
  columns: (auto, 1fr, 1fr, 1fr),
  [], [B-Tree], [Hash], [BRIN],
  [Gleichheitsabfragen], cg, cg, cr,
  [Range Queries], cg, cr, cg,
  [Sortierte Daten], cg, cr, cg,
  [Grosse Tabellen], cb, cb, cg,
)
\* Hash: Nur bei Gleichheitsabfragen
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
_Relationale Algebra_ \
$pi_(R 1,R 4) (R)$ ```sql SELECT R1,R4 FROM R;``` #h(1fr) (Projektion)\
$sigma_(R 1 > 30) (R)$ ```sql SELECT * FROM R WHERE R1 > 30;``` #h(1fr) (Selektion)\
$rho_("a" <- "R")$ ```sql SELECT * FROM R AS a;``` #h(1fr) (Umbenennung/Alias)\
$R times S$ ```sql SELECT * FROM R,S;``` #h(1fr) (Kartesisches Produkt)\
$R attach(limits(join), b: A=B) S$ ```sql SELECT * FROM R JOIN S ON R.A=S.B;``` #h(1fr) (Verbund)\
_Serialisierbarkeit_ \
*Shared Lock*: Schreib- & Lesezugriffe (eine Transaktion) \
*Exclusive Lock*: Lesezugriffe (mehrere Transaktionen) \
*Serieller Schedule*: Führt Transaktionen am Stück aus \
*Nicht serialisierbar*:
#grid(
  columns: (3fr, 1fr),
  [
    #set text(weight: "bold")
    S1=#td([R1])#math.underbracket([(x)#tr([R2])#math.underbracket([(x)#td([W1])])\(x)#td([R1])\(y)#tr([W2])])\(x)#td([W1])\(y)
  ],
  diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    mark-scale: 60%,
    node-shape: circle,
    node(..nw, (1, 1), nt("T1"), name: <t1>, fill: colors.blue),
    node(..nw, (2, 1), nt("T2"), name: <t2>, fill: colors.red),
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
  node-stroke: 1pt,
  edge-stroke: 1pt,
  mark-scale: 60%,
  node-shape: circle,
  node(..nw, (1, 1), nt("T1"), name: <t1>, fill: colors.darkblue),
  node(..nw, (2, 1), nt("T2"), name: <t2>, fill: colors.red),
  node(..nw, (3, 1), nt("T3"), name: <t3>, fill: colors.green),
  node(..nw, (5, 1), nt("T4"), name: <t4>, fill: colors.purple),
  node(..nw, (4, 1), nt("T5"), name: <t5>, fill: colors.blue),
  edge(<t1>, <t2>, "-|>"),
  edge(<t2>, <t3>, "-|>"),
  edge(<t2>, <t4>, "-|>", bend: 25deg),
  edge(<t3>, <t5>, "-|>"),
  edge(<t5>, <t4>, "-|>"),
) \
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
_Two-Phase Locking (2PL)_ \
#corr("TODO: example")
Stellt Isolation der T sicher \
+ Growing Phase: Die T. kann neue Locks erwerben, jedoch keine freigeben
+ Shrinking Phase: Locks können freigegeben werden, aber keine neuen mehr erworben werden
_Write-Ahead Log (WAL)_ \
Schreibt Änderungen der T in Log, dann Commit loggen, dann Updates in DB. Kann bei Absturz replayed werden \
LSN, TaID, PageID, Redo, Undo, PrevLSN \
_Dreiwertige Logik_ (cursed)\
```sql
SELECT NULL IS NULL; -- true
SELECT NULL = NULL; -- [null]
```
_B-Baum_ \
#grid(
  columns: (1fr, 1fr),
  [
    #text(fill: colors.darkblue)[+4]
    #diagram(
      ..dd,
      node(..nw, (3, 1), nt("10"), name: <fst>),
      node(..nw, (4, 1), nt(" "), name: <fst2>),
      node(..nw, (5, 1), nt(" ")),
      node(..nw, (6, 1), nt(" ")),
      node(..nw, (0, 2), nt("1")),
      node(..nw, (1, 2), nt("2"), name: <snd>),
      node(..nw, (2, 2), nt("3"), fill: colors.green),
      node(..nw, (3, 2), nt("7"), stroke: colors.green),
      node(..nw, (5, 2), nt("13")),
      node(..nw, (6, 2), nt("19"), name: <trd>),
      node(..nw, (7, 2), nt(" ")),
      node(..nw, (8, 2), nt(" ")),
      edge(<fst>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
    )],
  [
    #text(fill: colors.darkblue)[+11,+21]
    #diagram(
      ..dd,
      node(..nw, (4, 1), nt("3"), fill: colors.green, name: <n>),
      node(..nw, (5, 1), nt("10"), name: <fst>),
      node(..nw, (6, 1), nt(" "), name: <fst2>),
      node(..nw, (7, 1), nt(" ")),
      node(..nw, (0, 2), nt("1")),
      node(..nw, (1, 2), nt("2"), name: <snd>),
      node(..nw, (2, 2), nt(" ")),
      node(..nw, (3, 2), nt(" ")),
      node(..nw, (2, 3), nt("4"), fill: colors.blue),
      node(..nw, (3, 3), nt("7"), stroke: colors.green, name: <frt>),
      node(..nw, (4, 3), nt(" ")),
      node(..nw, (5, 3), nt(" ")),
      node(..nw, (5, 2), nt("13")),
      node(..nw, (6, 2), nt("19"), name: <trd>),
      node(..nw, (7, 2), nt(" ")),
      node(..nw, (8, 2), nt(" ")),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), stroke: colors.darkblue, "-|>"),
    )],

  [
    #text(fill: colors.darkblue)[+12]
    #diagram(
      ..dd,
      node(..nw, (4, 1), nt("3"), name: <n>),
      node(..nw, (5, 1), nt("10"), name: <fst>),
      node(..nw, (6, 1), nt(" "), name: <fst2>),
      node(..nw, (7, 1), nt(" ")),
      node(..nw, (0, 2), nt("1")),
      node(..nw, (1, 2), nt("2"), name: <snd>),
      node(..nw, (2, 2), nt(" ")),
      node(..nw, (3, 2), nt(" ")),
      node(..nw, (2, 3), nt("4")),
      node(..nw, (3, 3), nt("7"), name: <frt>),
      node(..nw, (4, 3), nt(" ")),
      node(..nw, (5, 3), nt(" ")),
      node(..nw, (5, 2), nt("11"), fill: colors.blue, stroke: colors.green),
      node(..nw, (6, 2), nt("13"), fill: colors.green, name: <trd>),
      node(..nw, (7, 2), nt("19")),
      node(..nw, (8, 2), nt("21"), fill: colors.blue),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
    )],
  [#diagram(
    ..dd,
    node(..nw, (4, 1), nt("3"), name: <n>),
    node(..nw, (5, 1), nt("10"), name: <fst>),
    node(..nw, (6, 1), nt("13"), fill: colors.green, name: <fst2>),
    node(..nw, (7, 1), nt(" "), name: <fst3>),
    node(..nw, (0, 2), nt("1")),
    node(..nw, (1, 2), nt("2"), name: <snd>),
    node(..nw, (2, 2), nt(" ")),
    node(..nw, (3, 2), nt(" ")),
    node(..nw, (2, 3), nt("4")),
    node(..nw, (3, 3), nt("7"), name: <frt>),
    node(..nw, (4, 3), nt(" ")),
    node(..nw, (5, 3), nt(" ")),
    node(..nw, (8, 2), nt("19")),
    node(..nw, (9, 2), nt("21"), name: <trd>),
    node(..nw, (10, 2), nt(" ")),
    node(..nw, (11, 2), nt(" ")),
    node(..nw, (6.5, 3), nt("11"), stroke: colors.green),
    node(..nw, (7.5, 3), nt("12"), fill: colors.blue, name: <fth>),
    node(..nw, (8.5, 3), nt(" ")),
    node(..nw, (9.5, 3), nt(" ")),
    edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
    edge(<fst3>, <trd>, shift: (-7pt, 7pt), "-|>"),
    edge(<fst2>, <fth>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
    edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
  )],
) \

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
