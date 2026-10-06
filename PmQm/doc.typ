#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Projekt oder Produkt

/ Produkt: ist etwas, das auf dem Markt verkauft werden kann
/ Projekt: eine Methode, die als Resultat ein Produkt hervorbringt

#table(
  columns: (50%, 50%),
  [Projekt], [Produkt],

  [Einmaliges Vorhaben], [Andauernde Entwicklung],

  [Grosser Initialaufwand bis zum ersten sichtbaren Ergebnis],
  [Mit MVP (Minimum Viable Product) sehr schnell ein erstes Ergebnis],

  [Kundennutzen oft erst am Ende], [Schneller und wachsender Kundennutzen],

  [Mit OTOBOS sehr gute Planbarkeit von Zeit, Budget und Scope],
  [Durch agile Entwicklungszyklen ständig ändernde Situation],
)

/ OTOBOS: On Time, On Budget, On Specification
/ Das magische Dreieck: #diagram(
    node((1, 0), shape: fletcher.shapes.pill, [Kosten]),
    edge("<->"),
    node((0, 1), shape: fletcher.shapes.pill, [Scope]),
    edge("<->"),
    node((2, 1), shape: fletcher.shapes.pill, [Zeit]),
    edge((1, 0), "<->"),
  )

= Innovation

Innovation ist der Prozess, bei dem eine Idee in ein Produkt umgewandelt wird,
und einen Mehrwert für den Kunden schafft

/ Inkrementelle Innovation: bedeutet die allmähliche, aber kontinuierliche
  Verbesserung bestehender Technologien (Markt für Smartphones)
/ Disruptive Innovationen: führen zu neuen Technologien (Musik und
  Film-Streaming, digitale Fotographie)
/ Architektonische Innovationen: passen bestehende Komponenten eines Produkts
  einen neuen Markt und Zweck an (Smart Watch, EarPod als Hörgerät)
/ Radikale Innovation: ersetzt bestehende Angebote vollständig und erschliesst
  einen neuen Markt (Cloud Computing, AI)

= Qualität

#table(
  columns: (auto, 1fr),
  table.cell(colspan: 2, [Software Qualität Komponenten]), [Funktionalität],
  [Was kann die Software], [Zuverlässigkeit],
  [in einem vorbestimmten Zeitraum unter vorbestimmten Bedingungen immer gleich
    stabil arbeiten],
  [Effizienz],

  [gute Performance mit minimalen Ressourcenanforderungen Effizienz],
  [Benutzbarkeit / Usability],

  [Wie komfortable und fehlerresistent ist die SW für den Benutzer],
  [Übertragbarkeit],

  [Wie einfach ist die SW auf andere Plattformen / OS übertragbar],
  [Änderbarkeit],

  [Wie einfach können Anpassungen vorgenommen oder neue Releases eingespielt
    werden],
)

== Datenqualität

Jede Applikation und jedes Projekt ist maximal so gut, wie die Qualität der
darin verwalteten Daten. Zu vermeiden sind:

- Unzuverlässige und fehlerhafte Daten
- Inkonsistente und duplizierte Daten

= Projektmanagement

Es wird zwischen agil und klassisch unterschieden
- Klassische Vorgehensmethoden sind formell und strikt, was klare Aussagen zu
  Fortschritt und Inhalt zulässt. Sie haben einen grossen administrativer
  Aufwand und zeigen erst am Schluss den Erfolg.
- Agile Vorgehensmethoden basieren dank iterativem Vorgehen auf schlanken
  Prozessen und eignen sich idealerweise für die Entwicklung und Pflege von
  Produkten. Sie reduzieren die administrativen Aufwände auf ein Minimum.

== Wasserfallmodell

- Beim Wasserfallmodell werden die einzelnen Phasen sequenziell durchlaufen.
- Die nachfolgende Phase kann erst mit vollständigem Abschluss der aktuellen
  Phase beginnen.
- Phasenwiederholungen und -rücksprünge sind eigentlich nicht vorgesehen.
- Sie können aber notwendig sein, wenn eine Phase nicht planmässig erfolgreich
  abgeschlossen werden kann.

=== Definition einer Phase

Im klassischen Projektmanagement werden die Arbeitspakete oder Tasks in logische
Abschnitte, sprich Phasen unterteilt. Jede Phase wird durch einen Meilenstein
terminiert.

Phasenübergänge werden auch "Gates" genannt. Sie werden oft durch ein
übergeordnetes Gremium (z.B. Lenkungsausschuss) freigegeben.

Eine Parallelisierung von Phasen ist nicht vorgesehen, kommt jedoch in der
Praxis vor.

=== Arbeitspakete

Die Aufgaben in einem Projekt werden in Arbeitspakete gepackt. Jedes
Arbeitspaket soll in sich abgeschlossen sein und ein definiertes Ergebnis
liefern. Es soll wenn möglich von einer Person / Team erledigt werden können.
Arbeitspakete sollen den Projektphasen zugeteilt werden können.

== HERMES

Handbuch der Elektronischen Rechenzentren des Bundes, eine Methode zur
Entwicklung von Systemen. HERMES beschreibt verschiedene Szenarien:

- Alle Szenarien haben ein einheitliches Phasenmodell mit vier Phasen. \
  #diagram(
    node(
      (-1, 1),
      stroke: none,
      box(width: 10em, [Projekt-\ initialisierung-\ sauftrag]),
      height: 4em,
      width: .5em,
    ),
    edge(),
    node(
      (-1, 0),
      shape: fletcher.shapes.diamond,
      " ",
      height: 1em,
      width: .5em,
    ),
    node((0, 0), [Initialisierung], shape: fletcher.shapes.chevron),
    node(
      (1, 1),
      stroke: none,
      box(width: 10em, [Projektfreigabe]),
      height: 4em,
      width: .5em,
    ),
    edge(),
    node((1, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
    node((2, 0), [Konzept], shape: fletcher.shapes.chevron),
    node(
      (3, 1),
      stroke: none,
      box(width: 10em, [Phasenfreigabe]),
      height: 2em,
      width: .5em,
    ),
    edge(),
    node((3, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
    node((4, 0), [Realisierung], shape: fletcher.shapes.chevron),
    node(
      (5, 1),
      stroke: none,
      box(width: 10em, [Phasenfreigabe]),
      height: 2em,
      width: .5em,
    ),
    edge(),
    node((5, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
    node((6, 0), [Einführung], shape: fletcher.shapes.chevron),
    node(
      (7, 1),
      stroke: none,
      box(width: 10em, [Projektabschluss]),
      height: 2em,
      width: .5em,
    ),
    edge(),
    node((7, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
  )
- Die Meilensteine entsprechen Quality Gates, an denen über Ergebnisse und das
  weitere Vorgehen entschieden wird.
- Module sind wiederverwendbare Bausteine zur Erstellung von Szenarien.
- Ein Modul enthält die thematisch zusammengehörenden Aufgaben, Ergebnisse und
  Rollen.

=== Rollen

HERMES unterteilt die Organisation in:
/ Stammesorganisation:
  - Organisation des Auftraggebers und des Anwenders in der das Projekt
    angesiedelt ist
  - Rechtliche Einheit, die Strategien und Vorgaben für das Projekt bestimmt
/ Projektorganisation:
  - Temporäre Organisation
  - Wird mit dem Projektinitialisierungsauftrag in kraft gesetzt und mit dem
    Projektabschluss aufgelöst

Hermes beschreibt 17 verschiedene Rollen

=== Aufgaben

In HERMES gibt es für jede der ca. 70 Aufgaben eine Aufgabenbeschreibung. Jeder
Aufgabe ist eine verantwortliche Rolle zugeordnet. Thematisch zusammengehörende
Aufgaben sind in Module gruppiert und den Phasen zugeordnet.

=== Ergebnisse

Für jedes der ca. 70 Ergebnisse gibt es in HERMES eine Ergebnisbeschreibung.
Zudem sind Minimalergebnisse definiert, um die Anforderungen an die
Projekt-Governance zu erfüllen (mehr als 40 Ergebnisse).

=== Sichten auf das Projekt

#grid(
  columns: 2,
  [
    / Sicht des zeitlichen Ablaufs:
      - Welche Aufgaben und Ergebnisse in welcher Phase
      - Welche Meilensteine
    / Sicht der Partner:
      - Rollen und Aufgaben im Projekt
      - Wo arbeitet diese Rolle mit
    / Sicht der Hierarchieebenen:
      - Entscheidungsaufgaben und Ergebnisse
      - Welche Rollen sind der Ebene zugeordnet
  ],
  image("img/hermes.png"),
)

=== Szenarien

Ein Szenario ist auf die Durchführung eines Projekts mit einer spezifischen
Charakteristik ausgerichtet. Die Szenarien bildet den gesamten Lebenszyklus des
Projekts ab. Szenarien bilden Module, die thematisch zusammengehörende Aufgaben
und Ergebnisse gruppieren.

=== Entscheidungsprozess

#grid(
  columns: 2,
  [
    HERMES unterscheidet zwischen:
    - Entscheide durch die Steuerung\ (oben - dunkelgelb)
    - Entscheide durch die Projektführung\ (unten - hellgelb)
  ],
  image("img/hermes-entscheidung.png"),
)

=== HERMES und SCRUM

HERMES deckt den gesamten Lebenszyklus des Projekts ab. SCRUM regelt die
Organisation und die Steuerung des Entwicklungsteams.

=== Vor- und Nachteile

#procontra[
  - Hohe Standardisierung mit klar definierten Phasen, Rollen, Aufgaben,
    Ergebnisse, etc.
  - Viele Tools und mehrsprachige Vorlagen vorhanden
  - Eine Zertifizierung erlaubt die Mitarbeit in Bundesprojekten
  - Einbettung von SCRUM ist klar definiert
  - Passt zu Institutionen, welche ihre Aufträge öffentlich ausschreiben oder
    Dienstleister, welche an den Ausschreibungen teilnehmen
][
  - Sehr starke Vorgaben mit wenig Spielraum
  - Vier Phasen sind etwas knapp bemessen
  - In der Privatwirtschaft und ausserhalb der Schweiz kaum relevant
  - HERMES kann Projekte verkomplizieren und zwar so sehr, dass doch einige
    Bundesprojekte HERMES abspecken
]

== V-Modell

#grid(
  columns: 2,
  [
    Das V-Modell ist ein lineares Vorgehensmodell, das ein Projekt in feste
    definierte Phasen gliedert. Im Vergleich zum ebenfalls linearen
    Wasserfallmodell ergänzt es Testphasen, die den jeweiligen
    Entwicklungsphasen gegenübergestellt sind.

    Das V-Modell wird in Deutschland bei Bundesprojekten oft eingesetzt.
  ],
  image("img/v-modell.png"),
)

== PRINCE2

PRoject IN Controlled Environemnts.

PRINCE2 ist so generisch wie nötig, jedoch so konkret wie möglich, um als
ganzheitliche Projektmethodik wahrgenommen zu werden.

Die Methodik gibt die Empfehlungen und Eckpunkte vor, anhand derer der Rhythmus
für die Meetings und Hinweise zu deren Inhalt gefunden werden kann.

Wichtigstes Grundprinzip ist: Die Methodik *muss* an die Projektumgebung
angepasst werden

PRINCE2 Agile ist eine Erweiterung und Anpassung zum klassischen PRINCE2 für die
agile Welt des Projektmanagements.

=== Vier integrierte Bausteine

+ Sieben Grundprinzipien: oder sieben Leitsätze, die in einem PRINCE2 Projekt
  eingehalten werden sollen
+ Sieben Themen: Beschreiben den Inhalt eines richtigen Projekts (nach PRINCE2)
+ Sieben Prozesse: Beschreiben den Ablauf rund um die sieben Themen
+ Anpassung an die Projektumgebung: Das Framework kann in weiten Teilen
  angepasst werden:
  - Vereinfachung der Methodik: Vereinfachung von Techniken und Praktiken
  - Formalisierung bzw. Informalisierung: Meetings werden angepasst - meist
    informeller
  - Umgestaltung von Formaten: Berichte und Tabellen anpassen
  - Zusammenführung und Splittung: Berichte adressatengerechter gestalten
  - Re-naming: Begrifflichkeiten auf die Organisation anpassen

=== Sieben Grundprinzipien

+ *Fortlaufende geschäftliche Rechtfertigung:* Der Nutzen oder Mehrwert muss
  laufend überprüft werden $->$ Business Case
+ *Lernen aus Erfahrung:* Erfahrungen aus früheren Projekten oder während des
  Projekts werden regelmässig gesammelt und angewendet.
+ *Definierte Rollen und Verantwortlichkeiten:* Diese müssen auch mit den
  entsprechenden Kompetenzen und Know How ausgestattet sein.
+ *Steuern über Management Phasen (abgeschlossene, eigenständige
  Projektphasen):*
  Am Ende muss der Projektmanager an den Lenkungsausschuss rapportieren.
+ *Steuern nach dem Ausnahmeprinzip (Management by Exception):* Gesteuert wird
  über das Ergebnis.
+ *Produktorientierung:* Den Blick auf die vom Projekt zu liefernden Produkte
  lenken
+ *Anpassung an die Projektumgebung:* (siehe Baustein vier)

=== Sieben Themen

+ *Business Case:* fortlaufende geschäftliche Rechtfertigung. Mechanismus um
  "geschäftliche Rechtfertigung" zu erlangen und kontinuierlich zu pflegen
+ *Organisation:* definierte Rollen und Verantwortlichkeiten. WER ist für die
  Umsetzung für WAS verantwortlich?
+ *Qualität:* Produktorientierung. Kundenqualitätserwartungen in
  Projektabnahmekriterien überführen
+ *Pläne:* steuern über Managementphasen ; Produktorientierung. Wie wird die
  Planung umgesetzt und wie wird die Umsetzung gemacht?
+ *Risiko:* Umgang mit Unsicherheiten (positive wie negative) in einem Projekt
+ *Änderungen:* Struktur in das Änderungsverfahren und das
  Konfigurationsmanagement bringen
+ *Fortschritt:* (Reporting, Eskalationen und Toleranzbereich des Projekts).
  Versetzt das Projektmanagement und den Lenkungsausschuss in die Lage,
  Entscheidungen zu treffen.

=== Sieben Prozesse

Die Sieben Prozesse stellen die Ablaufbeschreibung zu den sieben Themen dar. Ein
Prozess ist in PRINCE2 wie in der allgemeinen BWL wie folgt definiert: Für einen
definierten Input wird über eine vorgeschriebene Abfolge von Aktivitäten
Wertschöpfung generiert und ein definierter Output als Mehrwert geliefert.

#image("img/prince2.png")

+ *Vorbereiten eines Projekts:* Starting up a project (SU)
  - Entspricht in etwa einer Vorstudie
  - Oft wird bei grossen Projekten in einer Vorstudie (oder Vorprojekt) die
    Planung des Grossprojekts erstellt und bestimmt, ob es sich überhaupt lohnt,
    es durchzuführen (Business Case, Proof of Concept)
+ *Lenken eines Projekts:* Directing a project (DP)
  - Wichtig für den Lenkungsausschuss - damit dieser in jeder Phase die
    Kontrolle behält
+ *Initiieren eines Projekts:* Initiating a project (IP)
  - Hauptprozess der ersten Projektphase
  - Erstellung des Projektplans und der ersten Arbeitsverteilung
+ *Managen eines Phasenübergangs:* Managing a stage boudary (SB)
  - Definiert den Übergang einer Phase und kommt damit mehrfach identisch vor
+ *Steuern einer Phase:* Controlling a stage (CS)
  - Dieser Prozess ist am umfangreichsten beschrieben, da hier die Hauptarbeit
    des Projektmanagements liegt
+ *Mangen der Produktlieferung:* Managing product delivery (MP)
  - Arbeitspakete innerhalb und am Ende des Projekts übergeben (innerhalb des
    Projektteams und zum Kunden)
+ *Abschliessen eines Projekts:* Closing a project (CP)
  - Erfolgreicher Projektabschluss mit allen Dokumenten und Formalitäten
    sicherstellen

=== PRINCE2 Agile

- Agile Entwicklungsmethoden wie Kanban, SCUM, Extrem Programing, ... stellen
  keinen ganzheitlichen Projektmanagementansatz dar. Der Fokus liegt auf der
  Entwicklung eines Produkts.
- PRINCE2 sagt von sich, einen generischen Ansatz zum umfassenden
  Projektmanagement darzustellen.
- Im Wesentlichen wird nur der Prozess "Managen der Produktlieferung (MP)" durch
  agile Zyklen erweitert. Die übrigen Prozesse bleiben dieselben.

8 Agile Guidance points:

+ *PRINCE2 ist die Basis:* PRINCE2 Agile ist keine neue Version, sondern nur
  eine Leitlinie, wie die Projektumgebung angepasst werden kann.
+ *PRINCE2 Agile ist neutral zum Entwicklungsprozess:* Damit können alle agilen
  Entwicklungsmethoden abgedeckt werden.
+ *Agilität kommt aus der IT. PRINCE2 Agile ist nicht IT-limitiert*
+ *Agile Frameworks sind oft IT-limitiert. PRINCE2 Agile nicht*
+ *PRINCE2 Agile ist nicht limitiert auf SCRUM*
+ *SCRUM und Kanban sind die am weitesten verbreiteten Frameworks*
+ *Agilität ist der Zusammenschluss von Behaviors, Konzepten, Framework und
  Techniken*
+ *Agilität ist nicht binär:* Es stellt sich also nicht die Frage ob agil oder
  nicht, sondern wie viel agil?

== Gantt

Gantt-Diagramme sind eine der gängigsten und effektivsten Methoden, um
Aktivitäten (Aufgaben und Ereignisse) zeitbezogen anzuzeigen.

#image("img/gantt.png")

= Agile Produktentwicklung

#image("img/modelle.png")

== Arbeitspakete

- Alle Aufgaben, die in einem klassischen Projekt ausgeführt werden, müssen in
  Arbeitspakete gepackt werden.
- Für jedes Arbeitspaket muss jemand zuständig sein.
- Wichtige Arbeitspakete werden von einer zweiten Person überprüft
  (4-Augen-Prinzip).
- Arbeitspakete sind in sich abgeschlossen und thematisch zusammenhängend.

== Warum Agile?

/ V-Modell: stellt über die Validierung sicher, dass die Anforderungen und Konzepte auf allen Ebenen sauber validiert werden
/ HERMES: Beschreibt alles in allen Details und stellt alle Templates zur Verfügung
/ PRINCE2: Lässt sich flexibel an alle Umgebungen und Organisationen anpassen

Diese Modelle sind ideal für Werkverträge. Sie ermöglichen ein genau definiertes Ergebnis zu einem
definierten Preis an einem vereinbarten Termin.

Im Laufe eines Projekts ergeben sich immer aber Veränderungen.

=== Stacey-Matrix

#image("img/stacey-matrix.png")

#todo[cynefin]

=== Warum scheitern IT Projekte?

- Schwammige Definition der IT-Projekte
- Planungs- und Methodenfehler
- Projektkommunikation funktioniert nicht
- Fehler bei der Ressourcenzuweisung
- Schlechtes Management von Abnahme und Deployment

=== Warum werden agile Methoden verwendet

/ Schneller Start: da zu dessen Beginn nicht alle Details bereits festgelegt und entschieden sein müssen.
/ Direkter Einfluss des Kunden auf den Projektverlauf: durch die Teilnahme an Meetings, Usability-Tests, Sprint-Planungen und persönliche Abnahme von Sprint- Ergebnissen.
/ Effektivere Arbeitsabläufe: wenig formeller Overhead
/ Hohe Flexibilität: gegenüber geänderten Wettbewerbsanforderungen, Kunden- und Nutzerbedürfnissen.
/ Fehler werden früh erkannt und behoben: damit können Risiken früher erkannt und minimiert werden.
/ Effektive Ergebnisse: die auf Kunden- und Nutzerbedürfnisse zugeschnitten sind
/ Schnelle Ergebnisse: und geringe Zeit bis zur Markteinführung (Time-to-Market)

#todo[agile manifesto]

== SCRUM

#todo[]

== User Story und MVP

#todo[]
