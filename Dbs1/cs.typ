#import "../lib.typ": *
#let lang = "de"
#show: cheatsheet.with(
  module: "Dbs1",
  name: "Datenbanksysteme 1",
  semester: "HS25",
  language: lang,
)
#let tbl = (..body) => deftbl(lang,..body)

- uml diagramm (konzeptionell)
  - assoziationen, bedingungen
- normalisierung (+beispiele)
  - transitiv,(voll) funktional abhängig
- transaktionen
  - isolation levels erklären, welche fehler sie beheben
  - fuzzy read, deadlock, dirty read, write skew, phantom read, serializable snapshot isolation, cascading rollbacks
  - schedule analysieren + Serialisierbarkeitsgraph
- begriffe (physisches schema, DBMS)
- b-baum indexe einfügen

_Unified Modeling Language_
#grid(columns:(auto,auto,auto,auto),
image(height:6pt,"./img/uml_arrow_association.jpg"),"Assoziation",
image(height:6pt,"./img/uml_arrow_composition.jpg"),"Komposition",
image(height:6pt,"./img/uml_arrow_aggregation.jpg"),"Aggregation",
image(height:6pt,"./img/uml_arrow_inheritance.jpg"),"Vererbung",
)
_Normalisierung_ \
1NF: Atomare Attributwerte \
2NF: Nichtschlüsselattr. voll vom Schlüssel abhängig \
3NF: Keine transitiven Abhängigkeiten \
BCNF: Nur abhängigkeiten vom Schlüssel \
_Vererbung_
#corr("(vor & nachteile) (einzige tabelle für superklasse, tabelle pro subklasse, tabelle pro sub- und superklasse)")
_Data Definition Language_
```sql
CREATE SCHEMA s ();
CREATE TABLE t (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE,
  grade DECIMAL(2,1) NOT NULL,
  added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  u VARCHAR(9) DEFAULT CURRENT_USER,
  fk INT FOREIGN KEY REFERENCES t2.id ON DELETE CASCADE,
  CHECK (grade between 1 and 6)
);
ALTER TABLE t2 ADD CONSTRAINT c PRIMARY KEY (a, b);
```
_Usermanagement_
```sql
CREATE ROLE r WITH LOGIN PASSWORD ''
GRANT INSERT ON TABLE t TO r;
REVOKE CREATE ON SCHEMA s FROM r;
ALTER ROLE r CREATEROLE, CREATEDB, INHERIT;
GRANT r TO user_name;
-- read all future created tables 
ALTER DEFAULT PRIVILEGES IN SCHEMA s GRANT SELECT ON TABLES TO readonlyuser;
CREATE POLICY p ON t FOR ALL TO PUBLIC USING (u = current_user);
ALTER TABLE t ENABLE ROW LEVEL SECURITY;
```
_Data Manipulation Language_
```sql
INSERT INTO t (id, grade) VALUES (1, 1) RETURNING id;
```
_Views_
```sql
CREATE VIEW v (id, grade, u) AS SELECT id, grade, u FROM t;
```
_Common Table Expressions_
```sql
WITH RECURSIVE q AS (SELECT * FROM t WHERE grade>1 UNION ALL SELECT * FROM t INNER JOIN q ON q.u = t.name) SELECT id as "ID" FROM q;
```
_Window Functions_
```sql
SELECT id, RANK() OVER (ORDER BY grade DESC) as r FROM t;
```
_Subqueries_
```sql
SELECT * FROM t WHERE grade > ANY/IN/EXISTS (SELECT g FROM t2);
```
_JOIN_
```sql
SELECT y.*, x.* FROM t AS y, JOIN LATERAL (SELECT * FROM t2 WHERE t2.id = y.id) AS x;
```
_GROUP BY_
```sql
SELECT id, COUNT(*) FROM t GROUP BY grade, id HAVING COUNT(*) > 2;
```
_WHERE_
```sql
BETWEEN 1 AND 5; LIKE '___%'
IN (1, 5)      ; LIKE '%asd'
```
_INDEX_
```sql
CREATE INDEX i ON t /*USING BTREE*/ (grade, UPPER(u)) INCLUDE added;
DROP INDEX i;
```
_Transaktionen_
```sql
BEGIN;  SAVEPOINT s;
COMMIT; ROLLBACK /*TO SAVEPOINT s*/;
```
_Isolation_
```sql
READ UNCOMMITTED; READ COMMITTED
REPEATABLE READ ; SERIALIZABLE
```
_Relationale Algebra_ \
$pi_(R 1,R 4) (R)$ ```sql SELECT R1,R4 FROM R;``` \
$sigma_(R 1 > 30) (R)$ ```sql SELECT * FROM R WHERE R1 > 30;``` \
$rho_("a" <- "R")$ ```sql SELECT * FROM R AS a;``` \
$R times S$ ```sql SELECT * FROM R,S;``` \
$R attach(limits(join), b: A=B) S$ ```sql SELECT * FROM R JOIN S ON R.A=S.B;```
_Transaktionen_ \
_Serialisierbarkeit_ \
