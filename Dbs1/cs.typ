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
#show table.cell: set text(size: 4pt)
#let nw = (width: 10pt, height: 10pt)
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
Redundanzfreiheit, Datenintegrität, Kapselung, #corr("TODO: 2 weitere") \
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
#h(1em) #text(style: "italic","fk") INT FOREIGN KEY REFERENCES t2, \
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
*Complete*: Alle Subklassen sind definiert \
*Incomplete*: Zusätzliche Subklassen sind erlaubt \
*Disjoint*: Ist Instanz von genau einer Unterklasse \
*Overlapping*: Kann Instanz von mehreren überlappenden Unterklassen sein \
_Normalisierung_ \
*1NF*: Atomare Attributwerte \
*2NF*: Nichtschlüsselattr. voll vom Schlüssel abhängig \
*3NF*: Keine transitiven Abhängigkeiten \
*BCNF*: Nur abhängigkeiten vom Schlüssel \
*(Voll-)funktionale Abhängigkeit*: 
B hängt von A ab, zu jedem Wert von A gibt es genau einen Wert von B ($A -> B$) \
*Transitive Abhängigkeit*: B hängt vom Attribut A ab, C hängt von B ab ($A -> B and B -> C => A -> C$) \
*Denormalisierung*: In geringere NF zurückführen (Verbessert Performance und reduziert Joins-Komplexität) \
_Anomalien_ \
Einfügeanomalie, Löschanomalie, Änderungsanomalie \
_Data Definition Language (DDL)_
```sql
CREATE SCHEMA s;
CREATE TABLE t (id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  grade DECIMAL(2,1) NOT NULL,
fk INT FOREIGN KEY REFERENCES t2.id ON DELETE CASCADE,
  added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  u VARCHAR(9) DEFAULT CURRENT_USER,
  CHECK (grade between 1 and 6));
ALTER TABLE t2 ADD CONSTRAINT c PRIMARY KEY (a, b);
TRUNCATE/DROP TABLE t;
```
_Vererbung_ \
*Tabelle pro Sub- und Superklasse*: \
```sql
-- TODO: check if correct
CREATE TABLE sup (id SERIAL PRIMARY KEY, -- 3.a
  name TEXT UNIQUE);
CREATE TABLE sub1 (id SERIAL PRIMARY KEY, age INT);
CREATE TABLE sub2 (id SERIAL PRIMARY KEY);
ALTER TABLE sub1 ADD CONSTRAINT id FOREIGN KEY
  REFERENCES sup (id); -- Auch für sub2
```
*Tabelle pro Subklasse*: Enthält jeweil. Subklassattribute \
```sql
CREATE TABLE sub1 (id SERIAL PRIMARY KEY, -- 3.b
  name TEXT UNIQUE, age INT);
CREATE TABLE sub2 (id SERIAL PRIMARY KEY,
  name TEXT UNIQUE);
```
*Einzige Tabelle für Superklasse*: Enthält alle Attribute \
```sql
CREATE TABLE sup (id SERIAL PRIMARY KEY, -- 3.c
  name TEXT UNIQUE, age INT);
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
Implicit #corr("TODO")
```sql
CAST(5 AS float8) = 5::float8
```
_Data Manipulation Language (DML)_
```sql
FROM -> JOIN -> WHERE -> GROUP BY -> HAVING -> 
  SELECT (WINDOW FUNCTIONS) -> ORDER BY -> LIMIT
INSERT INTO t (added, grade) VALUES ('2002-10-10', 1) 
  RETURNING id;
```
_Views_ \
Resultate werden jedes mal dynamisch queried \
```sql
CREATE VIEW v (id, u) AS SELECT id, u FROM t;
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
_Row-Level Security (RLS)_ \
```sql
CREATE TABLE exams (id SERIAL, -- other fields...
  teacher VARCHAR(60) DEFAULT current_user);
CREATE POLICY teachers_see_own_exams ON exams
  FOR ALL TO PUBLIC USING (teacher = current_user);
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
```
_Temporäre Tabellen_ \
#corr("TODO") \
_Data Control Language (DCL)_
```sql
CREATE ROLE u WITH LOGIN PASSWORD ''; -- user
GRANT INSERT ON TABLE t TO u;
ALTER ROLE u CREATEROLE, CREATEDB, INHERIT;
CREATE ROLE r; -- group
GRANT r TO u; -- put user u in group r
REVOKE CREATE ON SCHEMA s FROM r;
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
_Common Table Expressions (CTE)_ \
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
_INDEX_
```sql
CREATE INDEX i ON t /*USING BTREE*/ (grade, UPPER(u));
CREATE INDEX j ON t (fk) INCLUDE (added) WHERE fk > 4;
DROP INDEX i;
```
_Transaktionen_ \
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
SET TRANSACTION ISOLATION LEVEL ...;-- for transaction
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL ...; -- for session
```
#let cr = table.cell(fill: colors.red, sym.crossmark)
#let cg = table.cell(fill: colors.green, sym.checkmark)
#let cb = table.cell(fill: colors.blue, sym.star)
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
  [Garantiert Serialisierbar],
  [Keine Deadlocks],
  [Keine Cascading Rollbacks],
  [Keine Konflikt-Rollbacks],
  [Hohe Parallelität],
  [Realistisch (ohne Voranalyse)],

  [Two-Phase Locking], cg, cr, cr, cg, cr, cr,
  [Strict 2PL], cg, cr, cg, cg, cr, cg,
  [Preclaiming 2PL], cg, cg, cg, cg, cr, cr,
  [Validation-based], cg, cg, cr, cr, cg, cg,
  [Timestamp-based], cg, cg, cr, cr, cg, cg,
  [Snapshot Isolation], cr, cb, cg, cr, cg, cg,
  [SSI], cg, cb, cg, cr, cg, cg,
)
\* Deadlock in PSQL mit Snapshot Isolation \
_Relationale Algebra_ \
$pi_(R 1,R 4) (R)$ ```sql SELECT R1,R4 FROM R;``` \
$sigma_(R 1 > 30) (R)$ ```sql SELECT * FROM R WHERE R1 > 30;``` \
$rho_("a" <- "R")$ ```sql SELECT * FROM R AS a;``` \
$R times S$ ```sql SELECT * FROM R,S;``` \
$R attach(limits(join), b: A=B) S$ ```sql SELECT * FROM R JOIN S ON R.A=S.B;``` \
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
    node(..nw, (1, 1), "T1", name: <t1>, fill: colors.blue),
    node(..nw, (2, 1), "T2", name: <t2>, fill: colors.red),
    edge(<t1>, <t2>, shift: (5pt, 5pt), "-|>"),
    edge(<t2>, <t1>, shift: (5pt, 5pt), "-|>"),
  ),
)
/*
*Conflict serializable (serialisierbar)*:
#grid(
  columns: (1fr, 1fr),
  table(
    columns: (1fr, 1fr, 1fr),
    table.header([T1], [T2], [T3]),
    [R(x)], [], [],
    [R(y)], [], [],
    [], [R(x)], [],
    [], [R(z)], [],
    [W(y)], [], [],
    [CT], [], [],
    [], [], [R(y)],
    [], [], [R(z)],
    [], [], [W(y)],
    [], [], [CT],
    [], [W(x)], [],
    [], [W(z)], [],
    [], [CT], [],
  ),
  diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    mark-scale: 60%,
    node-shape: circle,
    node(..nw, (1, 1), "T1", name: <t1>, fill: colors.blue),
    node(..nw, (3, 1), "T2", name: <t2>, fill: colors.red),
    node(..nw, (2, 2), "T3", name: <t3>, fill: colors.green),
    edge(<t1>, <t2>, shift: (5pt, 5pt), "-|>"),
    edge(<t1>, <t3>, shift: (-5pt, -5pt), "-|>"),
    edge(<t3>, <t2>, shift: (-5pt, -5pt), "-|>"),
  ),
)
*/
*Konflikt-Serialisierbar:* \
r1(b) r2(b) w2(b) r2(c) r2(d) w3(a) r4(d) r3(b) w4(d) r5(c) r5(a) w4(c) \
*Konflikt-Äquivalenter serieller Schedule:* \
r1(b) r2(b) w2(b) r2(c) r2(d) w3(a) r3(b) r5(c) r5(a) r4(d) w4(d) w4(c) \
#diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    mark-scale: 60%,
    node-shape: circle,
    node(..nw, (1, 1), "T1", name: <t1>),
    node(..nw, (2, 1), "T2", name: <t2>),
    node(..nw, (3, 1), "T3", name: <t3>),
    node(..nw, (1, 2), "T4", name: <t4>),
    node(..nw, (3, 2), "T5", name: <t5>),
    edge(<t1>, <t2>,"-|>"),
    edge(<t2>, <t3>, "-|>"),
    edge(<t2>, <t4>, "-|>"),
    edge(<t3>, <t5>, "-|>"),
    edge(<t5>, <t4>, "-|>"),
  )

_Backup_ \
#corr("TODO") \
_Vollständiges Backup_ \
#corr("TODO") \
_Inkrementelles Backup_ \
#corr("TODO") \
_Multi-Version Concurrency Control (MVCC)_ \
Ermöglich es, mehreren T gleichzeitig zu laufen \
#corr("TODO") \
_Two-Phase Locking (2PL)_ \
Stellt Isolation der T sicher \
#corr("TODO") \
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
      node(..nw, (3, 1), "10", name: <fst>),
      node(..nw, (4, 1), " ", name: <fst2>),
      node(..nw, (5, 1), " "),
      node(..nw, (6, 1), " "),
      node(..nw, (0, 2), "1"),
      node(..nw, (1, 2), "2", name: <snd>),
      node(..nw, (2, 2), "3", fill: colors.green),
      node(..nw, (3, 2), "7", stroke: colors.green),
      node(..nw, (5, 2), "13"),
      node(..nw, (6, 2), "19", name: <trd>),
      node(..nw, (7, 2), " "),
      node(..nw, (8, 2), " "),
      edge(<fst>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
    )],
  [
    #text(fill: colors.darkblue)[+11,+21]
    #diagram(
      ..dd,
      node(..nw, (4, 1), "3", fill: colors.green, name: <n>),
      node(..nw, (5, 1), "10", name: <fst>),
      node(..nw, (6, 1), " ", name: <fst2>),
      node(..nw, (7, 1), " "),
      node(..nw, (0, 2), "1"),
      node(..nw, (1, 2), "2", name: <snd>),
      node(..nw, (2, 2), " "),
      node(..nw, (3, 2), " "),
      node(..nw, (2, 3), "4", fill: colors.blue),
      node(..nw, (3, 3), "7", stroke: colors.green, name: <frt>),
      node(..nw, (4, 3), " "),
      node(..nw, (5, 3), " "),
      node(..nw, (5, 2), "13"),
      node(..nw, (6, 2), "19", name: <trd>),
      node(..nw, (7, 2), " "),
      node(..nw, (8, 2), " "),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), stroke: colors.darkblue, "-|>"),
    )],

  [
    #text(fill: colors.darkblue)[+12]
    #diagram(
      ..dd,
      node(..nw, (4, 1), "3", name: <n>),
      node(..nw, (5, 1), "10", name: <fst>),
      node(..nw, (6, 1), " ", name: <fst2>),
      node(..nw, (7, 1), " "),
      node(..nw, (0, 2), "1"),
      node(..nw, (1, 2), "2", name: <snd>),
      node(..nw, (2, 2), " "),
      node(..nw, (3, 2), " "),
      node(..nw, (2, 3), "4"),
      node(..nw, (3, 3), "7", name: <frt>),
      node(..nw, (4, 3), " "),
      node(..nw, (5, 3), " "),
      node(..nw, (5, 2), "11", fill: colors.blue, stroke: colors.green),
      node(..nw, (6, 2), "13", fill: colors.green, name: <trd>),
      node(..nw, (7, 2), "19"),
      node(..nw, (8, 2), "21", fill: colors.blue),
      edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
      edge(<fst2>, <trd>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
      edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
    )],
  [#diagram(
    ..dd,
    node(..nw, (4, 1), "3", name: <n>),
    node(..nw, (5, 1), "10", name: <fst>),
    node(..nw, (6, 1), "13", fill: colors.green, name: <fst2>),
    node(..nw, (7, 1), " ", name: <fst3>),
    node(..nw, (0, 2), "1"),
    node(..nw, (1, 2), "2", name: <snd>),
    node(..nw, (2, 2), " "),
    node(..nw, (3, 2), " "),
    node(..nw, (2, 3), "4"),
    node(..nw, (3, 3), "7", name: <frt>),
    node(..nw, (4, 3), " "),
    node(..nw, (5, 3), " "),
    node(..nw, (8, 2), "19"),
    node(..nw, (9, 2), "21", name: <trd>),
    node(..nw, (10, 2), " "),
    node(..nw, (11, 2), " "),
    node(..nw, (6.5, 3), "11", stroke: colors.green),
    node(..nw, (7.5, 3), "12", fill: colors.blue, name: <fth>),
    node(..nw, (8.5, 3), " "),
    node(..nw, (9.5, 3), " "),
    edge(<n>, <snd>, shift: (5pt, -5pt), "-|>"),
    edge(<fst3>, <trd>, shift: (-7pt, 7pt), "-|>"),
    edge(<fst2>, <fth>, shift: (-7pt, 7pt), stroke: colors.darkblue, "-|>"),
    edge(<fst>, <frt>, shift: (-3pt, 3pt), "-|>"),
  )],
)
