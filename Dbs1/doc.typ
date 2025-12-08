#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "Dbs1",
  name: "Datenbanksysteme 1",
  semester: "HS25",
  language: lang,
)
#let tbl = (..body) => deftbl(lang, ..body)
#let pgdoc = l => link(l, "Postgres Dokumentation")

= Glossar

#tbl(
  [Entität],
  [],
  [Kardinalität von Beziehungen],
  [],
  [Kardinalität von Attributen],
  [],
  [Basisdatentyp],
  [],
  [Mehrwertiges Attribut],
  [],
  [Schwache Entity Menge],
  [],
  [Spezialisierung],
  [],
  [Surrogate Key],
  [],
  [Zusammengesetztes Attribut],
  [],
  [Zweitschlüssel],
  [],

  [Datenbank],
  [],
  [System-Katalog (sog. Information Schema wo die DBMS die DB-Objekte Schema, Tabelle, etc. verwaltet)],
  [],
  [Datenbankschema],
  [],
  [Datenbasis],
  [],
  [Datenunabhängigkeit],
  [],
  [DBMS],
  [],
  [DBS],
  [],
  [Implementierungsschema],
  [],
  [Impedance-Mismatch],
  [],
  [Konsistenz],
  [],
  [ODBMS],
  [],
  [ORDBMS],
  [],
  [Persistenz],
  [],
  [RDBMS],
  [],
)


= UML

#tbl(
  [Assoziation],
  [],
  [Aggregation],
  [],
  [Komposition],
  [],
  [Multiplizität],
  [],
  [Vererbung],
  [],
  [Notiz],
  [],
)

== Vererbung zusätzliche Notizen

#tbl(
  [Disjoint],
  [Objekt ist Instanz von genau einer Unterklasse.],
  [Overlapping],
  [
    Objekt kann Instanz von mehreren überlappenden Unterklassen sein;
    Objekt kann im Laufe seines Lebens die Unterklassen-Zugehörigkeit wechseln.
  ],
  [Complete],
  [Alle Subklassen sind definiert],
  [Incomplete],
  [Zusätzliche Subklassen sind erlaubt],
)

== Krähenfussnotation

= Datenbankmodelle

#tbl(
  [Hierarchisches],
  [],
  [Netzwerk],
  [],
  [Objektorientiertes],
  [],
  [Objektrelationales-Datenmodell],
  [],
  [Relationales],
  [],
)

= Ansi-Modell

#tbl(
  [Logische Ebene],
  [Logische Struktur der Daten, Definition durch logisches Schema «Trägermodell» (Zugriff auf die Daten durch DBMS von Speichermedium)],
  [Interne Ebene],
  [Speicherstrukturen, Definition durch internes Schema (Beziehungen zwischen den Daten, Tabellen etc.)],
  [Externe Ebene],
  [Sicht einer Benutzerklasse auf Teilmenge der DB, Definition durch externes Schema (Daten, auf die der Benutzer zugreifen kann)],
  [Mapping],
  [Zwischen den Ebenen ist eine mehr oder weniger komplexe Abbildung notwendig],
)

#corr([TODO: Folien zusammenfassungen am schluss])

= Datenbank-Entwurfsprozess

#image("./img/db-entwurfsprozess.png")

== Konzeptionelles Modell

== Logisches Modell

== Physisches Modell

== Relationales Modell

= Normalformen

#image("img/nf.png")

#tbl(
  [Funktionale Abhängigkeit],
  [
    B ist voll funktional abhängig von A falls zu jedem Wert A genau ein Wert B existiert

    $A -> B$
  ],

  [Atomar],
  [],

  [Voll funktional abhängig],
  [],

  [Teilweise funktional abhängig],
  [],

  [Transitiv abhängig],
  [],
)

== NF1

- attributwerte sind atomar

== NF2

- Nichtschlüsselatribute voll vom Schlüssel abhängig
- Besteht der PK nur aus einem einzigen Attribut (ist er also nicht
  zusammengesetzt), so bereits automatisch die 2. NF gegeben.
- Eine Tabelle ist NICHT in 2. NF, wenn sie einen zusammengesetzten Schlüssel hat
  und mind. ein Nichtschlüsselattribut von nur einem Teil des Schlüssels
  funktional abhängig ist.

== NF3

- Keine transitiven Abhängigkeiten

== BCNF

- Keine Abhängigkeiten vom Schlüssel

= Relationale Algebra

#link("https://users.informatik.uni-halle.de/~brass/db23/slides/dd_relal.pdf")

#table(
  columns: (auto, auto, 1fr, 1fr),
  table.header([Begriff], [], [Bedeutung], [Beispiel]),
  [Projektion],
  [$pi$],
  [],
  [
    $pi_(A 1,A 4) (T)$ = ```sql SELECT A1,A4 FROM T;```
  ],

  [Selektion],
  [$sigma$],
  [sigma steht für =, >, <, !=, <=, >=],
  [$sigma_(A 1 > 30) (T)$ = ```sql SELECT * FROM T WHERE A1 > 30;```],

  [Umbenennung],
  [$rho$],
  [],
  [$rho_("ang1" <- "angestellter")$ = ```sql SELECT * FROM angestellter AS ang1;```],

  [Kartesisches \ Produkt],
  [$times$],
  [CROSS JOIN],
  [$(R 1 times R 2)$ = ```sql SELECT * FROM R1,R2;```],

  [Verbund/Join],
  [$join$],
  [Voraussetung: Attribute r[a] und r[b] sind vereinigungsverträglich (typkompatibel)],
  [ ],

  [Theta-join],
  [$join_theta$],
  [theta steht für $=, >, <, !=, <=, >=$],
  [$R [a theta b] S$ = ```sql SELECT R.* FROM R JOIN S ON R.R2 :theta S.S2;```],

  [Equi-join],
  [$join_=$],
  [$theta$ ist $=$],
  [
    $R attach(limits(join), b: A=B) S$ = ```sql SELECT * FROM R JOIN S ON R.A = S.B;```

    $ R attach(limits(join), b: A=B) S = rho_(A=B) (R times S) $
  ],

  [Natural join],
  [$join$],
  [equi join ohne doppelte spalten],
  [
    ```sql SELECT * FROM R NATURAL JOIN S;```

    on R.R2 = S.S2 kann theoretisch ausgelassen werden, dabei werden implizit gleich heissende columns verglichen
  ],

  [Outer join],
  [$join.l join.r \ join.l.r$],
  [verbindet tupel auch ohne übereinstimmung],
  [],

  [Semi-join], [$times.l times.r$], ["left outer join ohne join"], [],
)

= (Postgre)SQL

#corr([
  Glossar: Änderbare-Sicht; BLOB; CLOB; CREATE-SEQUENCE; Datenbankschema; Dreiwertige-Logik; Entity-Integritaet; Integritätsart; Integritätsbedingung; Integritätspruefung; Isolationsgrad; Materialisierte-Sicht; Namensraum; Nicht-Änderbare-Sicht; SET-TRANSACTION; Sicht; SichtenZurModellierungVonGeneralisierung; Single-Row-Funktionen; Spaltenausdruck; SQL-Funktionen; SQL-Gruppenfunktion; SQL-Operator; View-Updating-Problem; Virtuelle-Sicht; Zeitstempel;
])

#corr([
  Window-Funktionen (Syntax mit "OVER"). Eigentliche Window-Funktionen kennen (also zusätzlich zu den Aggregationsfunktionen MIN/MAX/SUM/AVG), namentlich: row_number(), rank(), dense_rank(), percent_rank(), percent_rank(), ntile(), lag(), lead(), first_value(), last_value(), nth_value().
  Common Table Expressions (CTE) inkl. Rekursion.
  "Exotische" Funktionen werden ggf. in den Prüfungs-Aufgaben vorgegeben.
  Glossar: Aggregatfunktionen; ANY-ALL; Ausdruck; AVG (Gruppenfunktionen); BETWEEN-Operator; CASE; COUNT (Gruppenfunktionen); EXISTS; FALSE; FROM-Klausel; GROUP-BY-Klausel; GROUPING; GROUPING-SETS; Gruppenfunktionen; HAVING-Klausel; IN-Operator; IS-NULL-Operator; Join; Join-Tabelle; Join-Typ-SQL; Konkatenation ('||'); Korrelierte-Unterabfrage; LENGTH; LIKE; LOB; Logischer-Operator; LOWER; MAX (Gruppenfunktionen); MIN (Gruppenfunktionen); MOD; Non-Equi-Join; NULL; Operator; ORDER-BY-Klausel; RANK (Gruppenfunktionen); RegulaererAusdruck; SELECT; SELECT-Klausel; SFW-Block; Skalare-Unterabfrage; Spaltenbedingung; Such-Klausel; Suchbedingung; SUM (Gruppenfunktionen); TO-CHAR; TO-DATE; TO-NUMBER; TRUE; Typkonvertierungsfunktion; Unterabfrage; Verbund; Vereinigungskonform; Vergleichsoperator; WHERE-Klausel; Wildcard; WITH-Klausel.
])

== Glossar

#tbl(
  [Operatorbaum],
  [],
  [Semantische Integrität],
  [],
  [Relation],
  [],
  [Surrogate key],
  [],
  [],
  [],
)

== DDL (Data Definition Language)

#pgdoc("https://www.postgresql.org/docs/current/ddl.html")

Definiert Befehle für das Kreieren, Löschen und Modifizieren von Tabellendefinitionen, von externen Sichten (Views), von Constraints und von einigen anderen Datenbankobjekten (Index, Cluster) für die Optimierung der Abbildung von der logischen auf die interne Ebene.

=== Wichtigste Befehle

Zusätzlich kann ```sql IF (NOT) EXISTS``` hinzugefügt werden oder der ```sql CREATE``` mit ```sql CREATE OR REPLACE``` ausgetauscht werden. Beim ```sql DROP``` Befehl kann ```sql CASCADE``` hinzugefügt werden.

```sql
CREATE SCHEMA s;    DROP SCHEMA s;
CREATE DOMAIN d;    DROP DOMAIN d;
CREATE TABLE t;     DROP TABLE t;     ALTER TABLE t;  TRUNCATE TABLE t;
CREATE VIEW v;      DROP VIEW v;
CREATE INDEX i;     DROP INDEX i;
CREATE DATABASE db; DROP DATABASE db;
```

=== Beispiel CREATE TABLE <create_table>

```sql
CREATE TABLE schema_name.table_name (
  counter SERIAL NOT NULL,
  important INT NOT NULL,
  field INT NOT NULL UNIQUE,
  very_long_name VARCHAR(666) DEFAULT "Based PostgreSQL user",
  age INT CHECK (age > 18),
  reference INT NOT NULL,
  someday DATE DEFATUL SYSDATE,
  another_ref INT FOREIGN KEY REFERENCES other_table.id ON UPDATE RESTRICT,
  PRIMARY KEY (counter, important),
  FOREIGN KEY (reference) REFERENCES third_table.id ON DELETE CASCADE,
  CHECK (field BETWEEN 69 AND 420)
)
```

=== Datentypen

#pgdoc("https://www.postgresql.org/docs/current/datatype.html") \
Sinnvolle Konversionen und Rundungen werden implizit durchgeführt.

#tbl(
  [INTEGER/INT],
  [Integer (4 bytes)],
  [BIGINT],
  [Large integer (8 bytes)],
  [SMALLINT],
  [Small integer (2 bytes)],
  [REAL],
  [Single precision floating-point number (4 bytes)],
  [NUMERIC(precision,scale)],
  [Exact numeric of selectable precision],
  [DOUBLE PRECISION],
  [Double precision floating-point number (8 bytes)],
  [SERIAL],
  [Auto-incrementing integer (4 bytes)],
  [BIGSERIAL],
  [Auto-incrementing large integer (8 bytes)],
  [SMALLSERIAL],
  [Auto-incrementing small integer (2 bytes)],
  [CHARACTER/CHAR(size)],
  [Fixed-length, blank-padded string],
  [VARCHAR(size)],
  [Variable-length, non-blank-padded string],
  [TEXT],
  [Variable-length character string],
  [BOOLEAN],
  [Logical Boolean (true/false)],
  [DATE],
  [Calendar date (year, month, day)],
  [TIME],
  [Time of day (no time zone)],
  [TIMESTAMP],
  [Date and time (no time zone)],
  [TIMESTAMP WITH TIME ZONE],
  [Date and time with time zone],
  [INTERVAL],
  [Time interval],
  [JSON],
  [JSON data],
  [UUID],
  [Universally unique identifier],
  [ARRAY OF base_type],
  [#corr("TODO")],
)

==== Type casting

"::"
CAST

=== Contraints

#pgdoc("https://www.postgresql.org/docs/current/ddl-constraints.html")

#tbl(
  [PRIMARY KEY],
  [Attribut ist Primärschlüssel und damit "UNIQUE" und "NOT NULL" ],
  [NOT NULL],
  [Attributwerte müssen immer einen definierter Wert haben (default ist NULL) ],
  [UNIQUE],
  [Attributwerte aller Tupels der Tabelle müssen eindeutig sein. UNIQUE in Kombination mit NOT NULL definiert einen Sekundärschlüssel. UNIQUE in Kombination mit NULL bedeutet, dass alle Attributwerte ungleich NULL eindeutig sein müssen.  ],
  [CHECK],
  [erlaubt die Definition von weiteren Einschränkungen (siehe Beispiele) ],
  [DEFAULT],
  [setzt einen Defaultwert, dieser gilt wenn beim Einfügen eines Tupels mit INSERT kein Attributwert angegeben wird. ],
  [REFERENCES],
  [Attribut ist Fremdschlüssel ],
)

=== ALTER TABLE

#pgdoc("https://www.postgresql.org/docs/current/ddl-alter.html")

Sollte bei foreign Keys bevorzugt werden, da somit rekursive Referenzen einfacher umgesetzt werden können.

```sql
ALTER TABLE table_name
  ADD CONSTRAINT constraint_name
  CHECK (counter < 1337);

ALTER TABLE other_table
  ADD CONSTRAINT fk_that
  FOREIGN KEY (that) REFERENCES table_name (counter);
```

=== Referentielle Integrität

Der Fremdschlüssel in einer abhängigen Tabelle muss als Wert entweder einen aktuellen Wert des Schlüssels der referenzierten Tabelle (1:n) oder NULL (1c:n) aufweisen. Diese referentielle Integritätsbedingung kann bei Einfüge-, Lösch- und Änderungsoperationen verletzt werden und sollte daher vom DBMS überprüft werden.

Trigger:
```sql
ON UPDATE
ON DELETE
```
Aktion:
```sql
CASCADE
RESTRICT
SET DEFAULT
SET NULL
```

Siehe @create_table.

=== Index

#link("https://md.infs.ch/s/WvhPX6dPn", "Blogpost Stefan Keller")

#link("https://use-the-index-luke.com/", "Use the index, luke")

Ein Index ist eine Hilfsdatenstruktur, die zu einem gegebenen Attributwert die Adressen der Tupel mit diesem Attributwert liefert.

#tbl(
  [B-Baum],
  [],
  [Bitmap-Index],
  [],
  [Cluster],
  [],
  [Füllgrad],
  [],
  [Hash],
  [],
  [Heap],
  [],
  [Indexe],
  [],
  [ISAM],
  [],
  [Physische-Speicherstruktur],
  [],
  [Überlaufseite],
  [],
  [zusammengesetzter Index],
  [],
  [Partieller Index],
  [],
)

#corr([
  Indexe und Speicherstrukturen sowie Optimierung:
  Index-Algorithmen, v.a. die erwähnten Index-Arten, B-Baum und B+-Baum, sowie speziell Einfügen und Löschen in einen B-Baum!
  Zusammengesetzter Index; partieller Index; funktionaler Index; Index mit INCLUDE.
  Die "10 Möglichkeiten der Optimierung eines DBMS wie PostgreSQ" sowie die Tipps zu Indexe.
])

Zwei Datenstrukturen:
- Data Pages (Heaps)
- Suchbaum

Zugriff Baum:
- Durchwandern des Baumes
- Verfolgen der Blattknoten-Kette
- Tabellenzugriff (falls nötig)

- Primär-Index vs Sekundär-Index
- Sekundärer Index vs Integrierter (Clustered) Index

```sql
CREATE INDEX mytable_col_idx ON mytable (col);

SELECT id,nr,txt FROM test;
CREATE INDEX magic_idx ON test (nr,id) INCLUDE txt;

CREATE EXTENSION btree_gist;
CREATE INDEX mytable_col_idx2 ON mytable (col) USING gist (col);

DROP INDEX mytable_col_idx;
```

#corr([TODO: Beispiele])

==== B-Tree


=== Schema

#pgdoc("https://www.postgresql.org/docs/current/ddl-schemas.html")

Ein Schema ist ein Menge von DB-Objekten, welche zu einer logischen Datenbank gehören. Ein Schema kann folgende Objekte beinhalten: Tabellen, Sichten, Zusicherungen (Assertions), Berechtigungen etc.

#corr([TODO: Beispiele])

=== Permissions

#pgdoc("https://www.postgresql.org/docs/current/ddl-priv.html")

#corr([TODO: Beschreibung, Beispiele])

== DML (Data Manipulation Language)

#pgdoc("https://www.postgresql.org/docs/current/dml.html")

=== Execution order

#corr([TODO:])

=== INSERT

#pgdoc("https://www.postgresql.org/docs/current/dml-insert.html")

```sql
INSERT INTO table_name (important, field, reference) VALUES (3, 99, 7);

INSERT INTO other_table VALUES (20, "Goodbye world.") RETURNING counter;
```

==== INSERT ... SELECT

```sql
INSERT INTO combined_table
  SELECT t.age, t.very_long_name FROM table_name AS t
  INNER JOIN other_table AS o ON t.reference = o.id;
```

=== UPDATE

#pgdoc("https://www.postgresql.org/docs/current/dml-update.html")

Mit dem Update-Befehl können bestehende Tupel in der Datenbank modifiziert werden.

```sql
UPDATE table_name
  SET field = field * 2
  WHERE field IN (71,73,74);
```

=== DELETE

#pgdoc("https://www.postgresql.org/docs/current/dml-delete.html")

```sql
DELETE FROM table_name
  WHERE field > 300;
```

=== SELECT

#pgdoc("https://www.postgresql.org/docs/current/sql-select.html")

```sql
SELECT field FROM table_name;

SELECT important, CONCAT(very_long_name, age) AS personal_info
  FROM table_name
  WHERE counter > 21
  GROUP BY personal_info
  ORDER BY age, counter DESC
  LIMIT 77;
```

==== Prädikate (WHERE)

#pgdoc(
  "https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-WHERE",
)

```sql
BETWEEN ... AND ...
IN (..., ...)
LIKE '___%'         -- 3 chars or more
LIKE '%asd'         -- ending with "asd"
AND
OR
IS (NOT) NULL
```

==== Aggregatfunktionen

#pgdoc("https://www.postgresql.org/docs/current/functions-aggregate.html")

```sql
MAX()
MIN()
AVG()
SUM()
COUNT()
```

==== Gruppierung (GROUP BY and HAVING)

#pgdoc(
  "https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-GROUP",
)

_GROUP BY_ teilt die Resultattabelle in Gruppen auf, die in der GROUP BY - Spalte gleiche Werte aufweisen. NULL-Werte einer GROUP-BY Spalte werden als separate Gruppe behandelt.

Die _HAVING_ Klausel kann nur nach einer GROUP-BY Klausel stehen. Sie erlaubt die Auswahl von Zeilen, die durch die Anwendung der GROUP BY Bedingung entstehen (analog der WHERE-Klausel). Die Bedingung der HAVING-Klausel muss mit einer Funktion beginnen, welche in der
SELECT-Klausel vorkommen muss.

```sql
SELECT very_long_name, age, COUNT(*)
  FROM table_name
  GROUP BY age, very_long_name
  HAVING COUNT(*) > 2;
```

==== Join

#pgdoc("https://www.postgresql.org/docs/current/tutorial-join.html"), #link("https://www.atlassian.com/data/sql/sql-join-types-explained-visually", "Visuelle Beispiele Atlassian"), #link("https://www.codecademy.com/resources/docs/sql/commands/left-join", "Visuelle Beispiele CodeCademy")

Die Join-Operation verbindet Tabellen über Spalten mit dem gleichen Datentyp. Damit können Beziehungen zwischen den Tabellen (realisiert über Fremdschlüssel) aufgelöst werden.

===== CROSS JOIN

Gibt das kartesische Produkt der beiden Tabellen zurück, d.h. jede Zeile aus der ersten Tabelle wird mit jeder Zeile aus der zweiten Tabelle kombiniert.

```sql
SELECT a.*, b.*
  FROM a
  CROSS JOIN b;
```

===== INNER JOIN

Gibt nur die Zeilen zurück, die in beiden Tabellen übereinstimmen.

```sql
SELECT a.*, b.*
  FROM a
  INNER JOIN b ON a.id = b.id;
```

===== LEFT JOIN

Gibt alle Zeilen aus der linken Tabelle zurück und die übereinstimmenden Zeilen aus der rechten Tabelle. Wenn es keine Übereinstimmung gibt, werden NULL-Werte für die rechte Tabelle zurückgegeben.

===== RIGHT JOIN

Wie left join, nur umgekehrt.

===== FULL OUTER JOIN

Gibt alle Zeilen zurück, die in einer der beiden Tabellen vorhanden sind. Wenn es keine Übereinstimmung gibt, werden NULL-Werte für die Tabelle zurückgegeben, in der keine Übereinstimmung gefunden wurde.

===== JOIN LATERAL

Ein spezieller Typ von Join, der es ermöglicht, eine Unterabfrage zu verwenden, die auf Zeilen der äußeren Abfrage basiert. Dies ist nützlich für komplexe Abfragen, bei denen die Ergebnisse einer Unterabfrage von den Ergebnissen der äußeren Abfrage abhängen.

```sql
SELECT a.*, b.*
  FROM table_a AS a,
    JOIN LATERAL (SELECT * FROM table_b WHERE table_b.id = a.id) AS b;
```

==== Mengenoperationen

#pgdoc("https://www.postgresql.org/docs/current/queries-union.html")

Jede dieser Operationen kann mit ```sql ALL``` postfixed werden, um die Duplikate beizubehalten.

===== UNION

Kombiniert die Ergebnisse zweier oder mehrerer SELECT-Abfragen und gibt alle Zeilen zurück, ausschließlich Duplikate.

```sql
SELECT r1, r2
FROM A
UNION ALL
SELECT r1, r2
FROM B;
```

===== INTERSECT

Gibt die gemeinsamen Zeilen aus zwei SELECT-Abfragen zurück. Das Ergebnis enthält nur die Zeilen, die in beiden Abfragen vorhanden sind.

===== EXCEPT (MINUS)

Gibt die Zeilen aus der ersten SELECT-Abfrage zurück, die nicht in der zweiten SELECT-Abfrage vorhanden sind.

==== Unterabfragen

#pgdoc("https://www.postgresql.org/docs/current/functions-subquery.html")

Eine Unterabfrage darf nur einen Spaltennamen oder einen Ausdruck und keine ORDER BY - Klausel enthalten.

Verschachteltes Beispiel:

```sql
SELECT name
  FROM mitarbeiter
  WHERE id IN
  (SELECT mitarbeiterNr
    FROM projektZuteilung
    WHERE projNr IN
    (SELECT projNr
      FROM projekt INNER JOIN mitarbeiter
      ON projekt.projLeiter = mitarbeiter.id
      WHERE name = 'Kropotkin, Peter'
    )
  );
```

===== =

Vergleicht den Wert einer Spalte mit dem Ergebnis einer Unterabfrage. Unterabfrage darf nur einen Wert zurückliefern.

```sql
SELECT *
  FROM mitarbeiter
  WHERE gehalt = (SELECT MAX(gehalt) FROM mitarbeiter);
```

===== IN

Überprüft, ob der Wert einer Spalte in der Menge der Ergebnisse einer Unterabfrage enthalten ist.

```sql
SELECT *
  FROM bestellungen
  WHERE kundenID IN (SELECT id FROM kunden WHERE land = 'CH');
```

===== EXISTS

Überprüft, ob eine Unterabfrage mindestens eine Zeile zurückgibt.

```sql
SELECT name
  FROM mitarbeiter
  WHERE EXISTS
  (SELECT * FROM projektZuteilung WHERE mitarbeiterNr = mitarbeiter.id);
```

===== ANY

Überprüft, ob der Wert einer Spalte irgendeinen Wert in der Menge der Ergebnisse einer Unterabfrage erfüllt.

```sql
SELECT *
  FROM mitarbeiter
  WHERE gehalt > ANY (SELECT gehalt FROM manager);
```

===== ALL

Überprüft, ob der Wert einer Spalte alle Werte in der Menge der Ergebnisse einer Unterabfrage erfüllt.

==== Window functions

#pgdoc("https://www.postgresql.org/docs/current/tutorial-window.html")

Window Functions sind spezielle SQL-Funktionen, die Berechnungen über eine Menge von Zeilen durchführen, die mit der aktuellen Zeile in Beziehung stehen.

```sql
SELECT
  mitarbeiter,
  gehalt,
  RANK() OVER (ORDER BY gehalt DESC) as gehaltsrang
FROM
  mitarbeitertabelle;

SELECT
  persnr,
  name,
  LAG(salaer, 1) OVER (
    PARTITION BY abtnr
  ORDER BY
    salaer DESC
  ) - salaer AS differenz
FROM
  angestellter;
```

===== Funktionen

#pgdoc("https://www.postgresql.org/docs/current/functions-window.html")

#tbl(
  [RANK()],
  [Vergibt Rangpositionen mit Berücksichtigung von Gleichständen. Bei mehreren gleichen Werten erhalten diese den gleichen Rang, und die nächste Position wird übersprungen],
  [ROW_NUMBER()],
  [Weist jeder Zeile eine eindeutige fortlaufende Nummer zu. Auch bei gleichen Werten erhält jede Zeile eine unterschiedliche Nummer],
  [LAG(value, offset)],
  [Greift auf den Wert einer vorherigen Zeile im Fenster zu],
  [LEAD(value, offset)],
  [Greift auf den Wert einer nachfolgenden Zeile im Fenster zu],
  [FIRST_VALUE(value)],
  [Liefert den ersten Wert in der definierten Fenstermenge. Nützlich für Vergleiche mit dem Anfangswert einer Partition],
)

===== OVER Klausel

#tbl(
  [ORDER BY],
  [Sortiert die Zeilen innerhalb des Fensters nach einem oder mehreren Spalten. Bestimmt die Reihenfolge, in der Berechnungen für Window Functions durchgeführt werden],
  [PARTITION BY],
  [Teilt das Resultset in Partitionen, auf die Window Functions separat angewendet werden. Ermöglicht Berechnungen innerhalb definierter Gruppen, ohne die Gesamtergebnismenge zu ändern],
)

== Views

Eine View ist eine virtuelle Tabelle, welche auf eine oder mehrere Tabellen oder Views abgebildet
wird. Die Abbildung wird mit einer Select-Anweisung definiert. Die Daten der View werden erst zur
Ausführungszeit aus den darunter liegenden Tabellendaten hergeleitet.

Die Views erlauben es, dass verschiedene Benutzer die Daten unterschiedlich strukturiert sehen.
Mit Views kann die Formulierung von Abfragen, die sich über mehrere Tabellen erstrecken, verein-
facht werden. Views erlauben einen wirksamen Zugriffsschutz, da es möglich ist, Spalten der da-
runterliegenden Tabellen auszublenden.

```sql
CREATE VIEW mitarbeiter_public (id, name, tel) AS
  SELECT id, name, tel
  FROM mitarbeiter;
```

=== Common table expressions

Hilfs-Query in einer WITH-Klausel (Temporäre Tabellen während des Statements). Query-Name immer im FROM.

#corr([TODO:])

```sql
WITH queryName AS ( SELECT * FROM myTable )
SELECT * FROM queryName;

WITH tmptable(name, bezeichnung, zeitanteil) AS (
  SELECT name, bezeichnung, zeitanteil
  FROM angestellter a
  JOIN projektzuteilung pz ON pz.persnr=a.persnr
  JOIN projekt p ON p.projnr=pz.projnr
)
SELECT name AS "Mitarb.", bezeichnung AS "Projekt", zeitanteil AS "Zeit" FROM tmptable;
```

==== Recursive

Ein rekursives CTE referenziert sich selbst, um Teilmengen der Daten zurückzugeben, bis alle Ergebnisse erhalten sind.

```sql
WITH RECURSIVE untergebene(persnr, name, chef) AS (
  SELECT A.persnr, A.name, A.chef FROM angestellter A
  WHERE A.chef = 1010 UNION ALL -- recursive term
    SELECT A.persnr, A.name, A.chef FROM angestellter A
  INNER JOIN untergebene B ON B.persnr = A.chef
)
SELECT * FROM untergebene ORDER BY chef, persnr;
```

== Funktionen

```sql
CREATE PROCEDURE
EXEC
```

== DCL (Data Control Language)

#corr([
  Glossar: Zugriffsrechte, Sicherheit-in-Datenbanksystemen.
])

=== Benutzerverwaltung

#pgdoc("https://www.postgresql.org/docs/current/sql-createrole.html")
#pgdoc("https://www.postgresql.org/docs/current/user-manag.html")

_ROLE_: Oberbegriff für Benutzer (_USER_) oder Gruppe (_GROUP_).

```sql
CREATE ROLE user_name
WITH LOGIN PASSWORD 'password';

-- set current user
SET ROLE user_name;

DROP ROLE user_name;
```

=== Berechtigungen

#pgdoc("https://www.postgresql.org/docs/current/ddl-priv.html")

==== System

```sql
GRANT INSERT ON TABLE table_name TO user_name;
REVOKE INSERT ON TABLE table_name TO user_name;
```

==== Objekt

```sql
ALTER ROLE user_name CREATEROLE, CREATEDB, INHERIT;
```

=== Gruppen

```sql
CREATE ROLE manager;
GRANT SELECT ON table_name TO manager;
GRANT manager TO user_name;
```

=== Read-only user

```sql
-- creating
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
CREATE ROLE readonlyuser WITH LOGIN ENCRYPTED PASSWORD 'readonlyuser' NOINHERIT;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonlyuser;
-- assign permissions to read all newly tables created in the future (by others):
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonlyuser;
-- deleting
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM readonlyuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE SELECT ON TABLES FROM readonlyuser;
DROP USER readonlyuser;
```

=== RBAC (Role-Based Access Control)

Ist das, was oben erklärt wird.

=== RLS (Row-Level Security)

- Check-Constraint auf Tabelle pro Rolle (sozusagen ein zusätzliches WHERE)
- (Tipp: Aufpassen bei TRUNCATE, REFERENCES und VIEWS)

```sql
CREATE TABLE exams (
  id SERIAL,
  student_name TEXT,
  grade DECIMAL(2,1),
  added TIMESTAMP DEFAULT current_timestamp,
  teacher_pguser VARCHAR(60) DEFAULT current_user
);

CREATE POLICY policy_teachers_see_own_exams ON exams
FOR ALL
TO PUBLIC
USING (teacher_pguser = current_user);

ALTER TABLE exams
ENABLE ROW LEVEL SECURITY;
```

== Prepared statements

#pgdoc("https://www.postgresql.org/docs/current/sql-prepare.html")

== Transaktionen

- Fault Tolerance: Bei Server-Crash kann Operation wiederholt werden oder wird ganz gecancelt (nicht nur Hälfte durchgeführt)
- Concurrency: Isolation der Transaktionen, Parallelität wird ermöglicht.
- _A_ Atomicity: Vollständig oder gar nicht
- _C_ Consistency: Konsistenter Zustand bleibt erhalten
- _I_ Isolation: Transaktion soll von anderen isoliert sein
- _D_ Durability: Alle Änderungen sind persistent

#corr([
  Transaktionen:
  Serialisierbarkeit, Serialisierbarkeitsgraph (kein Betriebsmittelgraph: siehe unten).
  Grundlagen und Prinzip MVCC kennen.
  Isolation Levels.
  Fehlersituationen (beim Scheduling): Dirty Read, etc.
  Glossar: 2-Phasen-Sperrprotokoll; ACID; Ausfuehrungsplan; Backup; COMMIT; Datenkonsistenz (Transaktion); DEADLOCK; Dirty-Read; Fehlererholung (Transaktion); Inkonsistenz; Integritätspruefung; Isolationsgrad; Konflikt; Konsistenz; Lesekonsistenz (Transaktion); Locking; Logging (WAL); Lost-Update; Mehrbenutzerbetrieb (Transaktion); Serialisierbarkeit; Non-Repeatable-Read; Optimistisches-Lockverfahren (Locking); Persistenz; Pessimistisches-Lockverfahren (Locking); Phantom; Recovery; ROLLBACK; Semantische-Integritaet; SET-TRANSACTION; SLOCK (=shared lock); Starviation; Transaktion; UNLOCK; SLOCK, XLOCK.
])

```sql
BEGIN;

COMMIT;
```

```sql
BEGIN;

ROLLBACK;
```

=== Transaktionsisolation

#link("https://pgdash.io/blog/postgres-transactions.html")

```sql
READ UNCOMMITTED
READ COMMITTED
REPEATABLE READ
SERIALIZABLE
```

==== Fehlertypen

- Dirty Read
- Fuzzy Read
- Phantom Read
- Serialization Anomaly

==== READ COMMITTED

Standart-Isolationsstufe in PostgreSQL. \
Jede Abfrage sieht nur Daten, die vor Beginn der Abfrage committed wurden. Verhindert "Dirty Reads"

==== REPEATABLE READ

Verhindert "Non-Repeatable Reads". Verwendet Snapshot-Isolation. Höherer Speicherbedarf durch Snapshots.

==== SERIALIZABLE

Falls die gleiche Spalte in mehreren Transaktionen UPDATEd wird, werden die Transaktionen abgebrochen (ausser die erste).

=== Savepoints

#pgdoc("https://www.postgresql.org/docs/current/sql-savepoint.html")

```sql
BEGIN;
...
SAVEPOINT savepoint1;
...
ROLLBACK TO SAVEPOINT savepoint1;
COMMIT;
```

=== Serialisierbarkeit

#link("https://www.youtube.com/watch?v=01MDhIXiXIY")

#tbl(
  [Seriell],
  [Wenn alle Transaktionen in einem Schedule geordnet sind],
  [Konfliktäquivalent],
  [Wenn die Rehenfolge aller Paare von konfligierenden Aktionen in beiden Schedules gleich ist],
  [Konfliktserialisierbar],
  [Wenn ein Schedule konfliktäquivalent zu einem seriellen Schedule ist],
)

== Backup und Recovery

#corr([
  Backup und Recovery:
  Begriffe WAL, NAS (Network Attached Storage), RAID (Redundant Array of independend Disks)
  Fehlersituationen (beim Speichern): 1. Fehler/ROLLBACK, 2. Memory-Fehler/-Verlust, 3. Disk-Fehler-Verlust
  WAL-Logging
  Aspekte des DB-Backups: Physischer vs. logischer Backup, Full vs. incremental Backup.
])
