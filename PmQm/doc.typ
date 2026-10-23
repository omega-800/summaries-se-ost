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
  #align(center, diagram(
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
  ))
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

/ Klassische Projektmethode: Material bereitlegen, Planung machen, Struktur
  erstellen, Produkt erstellen
/ Agile Produktentwicklung: Erste Möglichkeit zur Nutzung bauen und
  Kontinuierlich verbessern

#image("img/modelle.png")

== Arbeitspakete

- Alle Aufgaben, die in einem klassischen Projekt ausgeführt werden, müssen in
  Arbeitspakete gepackt werden.
- Für jedes Arbeitspaket muss jemand zuständig sein.
- Wichtige Arbeitspakete werden von einer zweiten Person überprüft
  (4-Augen-Prinzip).
- Arbeitspakete sind in sich abgeschlossen und thematisch zusammenhängend.

== Warum Agile?

/ V-Modell: stellt über die Validierung sicher, dass die Anforderungen und
  Konzepte auf allen Ebenen sauber validiert werden
/ HERMES: Beschreibt alles in allen Details und stellt alle Templates zur
  Verfügung
/ PRINCE2: Lässt sich flexibel an alle Umgebungen und Organisationen anpassen

Diese Modelle sind ideal für Werkverträge. Sie ermöglichen ein genau definiertes
Ergebnis zu einem definierten Preis an einem vereinbarten Termin.

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

/ Schneller Start: da zu dessen Beginn nicht alle Details bereits festgelegt und
  entschieden sein müssen.
/ Direkter Einfluss des Kunden auf den Projektverlauf: durch die Teilnahme an
  Meetings, Usability-Tests, Sprint-Planungen und persönliche Abnahme von
  Sprint- Ergebnissen.
/ Effektivere Arbeitsabläufe: wenig formeller Overhead
/ Hohe Flexibilität: gegenüber geänderten Wettbewerbsanforderungen, Kunden- und
  Nutzerbedürfnissen.
/ Fehler werden früh erkannt und behoben: damit können Risiken früher erkannt
  und minimiert werden.
/ Effektive Ergebnisse: die auf Kunden- und Nutzerbedürfnisse zugeschnitten sind
/ Schnelle Ergebnisse: und geringe Zeit bis zur Markteinführung (Time-to-Market)

#todo[agile manifesto]

== SCRUM

SCRUM ist ein dynamischer Ansatz und stützt sich auf regelmässiges Feedback von
Endbenutzern. Er fördert:
- Mehr Zusammenarbeit mit dem Kunden
- Überwindung der Angst vor Veränderungen
- Interaktion mit Menschen im Mittelpunkt jedes Softwareprojektmanagements
- Fokussierung bei der Lieferung von Software

#image("./img/scrum-elements.png", width: 100%)

=== Zeremonien

/ Sprint Planning: (am Anfang jedes Sprints) Das Team definiert, was im
  Increment geliefert und wie es gemacht wird, aber der Produkt Owner
  priorisiert.
/ Daily Scrum: (täglich während der gesamten Sprint-Dauer) Hier werden
  Fortschritte besprochen und Blocker identifiziert.
/ Sprint Review: (Am Ende des Sprints – vor der Auslieferung des Increments)
  Hier wird besprochen, was während des Sprints erreicht wurde. Dabei werden
  Stakeholder ( und Kunden) und Teammitglieder informiert, die dazu Feedback
  geben können.
/ Sprint Retrospective: (nach dem Sprint Review – vor dem nächsten Planning)
  Hier wird besprochen, in welchen Bereichen während des Sprints Erfolge erzielt
  wurden und was noch wie verbessert werden kann.

=== Artefakte

/ Product Backlog: Beinhaltet alle zurzeit bekannten User Stories und wird vom
  Produkt Owner in Zusammenarbeit mit dem Kunden und dem Team gepflegt
/ Sprint Backlog: Beinhaltet die User Stories, an denen in diesem Sprint
  gearbeitet wird
/ Increment: Umgesetzte User Stories geprüft und dokumentiert als neue Version.
  Wird dem Kunden als neue Version zur Verfügung gestellt

=== Fundament

/ Transparenz: Der Fortschritt aller Arbeiten und Aufgaben kann vom gesamten
  Team nachvollzogen werden
/ Überprüfung: Es können jederzeit Kontrollen durchgeführt und Feedback gegeben
  werden
/ Anpassung: Während des gesamten Prozesses können Anpassungen gemacht werden.

== User Story und MVP

Der Product Owner beschreibt in einer User Story die Anforderungen aus
Nutzersicht: Wie wünschen sich Anwender eine Software oder Kunden einen
Liefergegenstand, um ihre Geschäftsziele zu erreichen. Eine User Story besteht
aus wenigen, leicht verständlichen Sätzen. Sie sind kurz, aus Kundensicht,
jedoch spezifisch und detailliert.

INVEST-Kriterien (für gute User Stories):
/ Independent: unabhängig von anderen User Stories
/ Negotiable: verhandelbar ; diskutierbar
/ Valuable: nützlich ; muss Wert stiften
/ Estimable: Aufwände müssen abschätzbar sein
/ Small: klein, damit in einem Sprint umsetzbar
/ Testable: testbar

Eine User Story wird in der agilen Entwicklung anstelle von Anforderungen
erstellt und in einem Backlog abgelegt. Schema: "Wer" möchte "was" [und
"warum"]. Beispiel: "Als [Rolle] möchte ich [Funktion] um [Nutzen]."

=== Theme, Epic und User stories

#image("./img/theme-epis-us.png")

=== MVP

Das MVP ist "die erste Iteration" eines Produkts oder Services, die dem Nutzer
zur Verfügung gestellt wird. Oder es findet noch vorher statt und bildet die
Basis für für den Start der Entwicklung.

Auf den freien Markt:
- Passt meine Lösung zum Problem?
- Wer ist mein idealer erster Kunde?
- Wie erreiche ich meine Kunden?
- Was ist der sinnvolle zweite Schritt?

- Software-Entwicklung braucht oft einen längeren Vorlauf, bevor das MVP dem
  Kunden einen Nutzen bringt und durch Iterationen erweitert werden kann.
- Die Infrastruktur muss soweit bereit stehen, dass die Applikation darauf
  betrieben werden kann. z.B: Applikations-, Datenbank und Web-Service
- Grundfunktionen müssen implementiert sein. z.B: User Indentifizierung und
  Autorisierung, Benutzeroberfläche, ...
- Das MVP muss so viel Funktion liefern, dass die Benutzer damit arbeiten können
  und wollen.
- Das MVP ist der "Erste Eindruck". Ein Produkt hat nur einen "ersten Eindruck",
  daher muss dieser passen.

#table(
  columns: (1fr, 1fr),
  [Schlechtes MVP], [Gutes MVP],
  [
    Bringt zwar Funktionen, ist aber nicht anwendbar. Damit stellt es für den
    Kunden keinen Nutzen dar. Er wird es ablehnen.
  ],
  [
    Beinhaltet alle Ebenen und ist damit voll einsetzbar. Der Kunde kann es im
    vorhandenen(kleinen) Funktionsumfang einsetzen.
  ],

  image("./img/bad-mvp.png"), image("./img/good-mvp.png"),
)

MVP
- Hilft Risiken zu managen
- Ein Produkt zu entwickeln und erfolgreich zu vermarkten ist teuer und braucht
  Zeit
- Leistungen zu entwickeln, die keiner braucht, verschwendet unnötig Kapital,
  das wir nicht haben.
- Lange am Produkt zu arbeiten, führt dazu, dass dich Marktteilnehmer überholen.
Das MVP hilft dir kritischen Ressourcen zu managen und Risiken zu senken. Wenn
dein MVP scheitert, weisst du, dass es noch nicht die beste Idee war.

== Was heisst Agile

Eine Methode wird als "agil" bezeichnet, wenn darin nach den Prinzipien und
Werten des agilen Manifests gearbeitet wird. Das agile Manifest legt den Fokus
auf:
+ Kontinuierliche Auslieferung von funktionierender Software in kurzen
  Zeitabständen
+ Flexibilität bei Änderungen durch Konzentration auf Kundennutzen
+ Zusammenarbeit und Motivation durch Selbstorganisation aller Beteiligten
+ Kontinuierliche Verbesserung und hohe Qualität durch regelmässige Reflexion

=== (1) CICD

#image("./img/cicd.png", width: 100%)

=== (2) Kundennutzen

- Priorität auf wertvolle Software für den Kunden
- Änderungswünsche des Kunden jederzeit begrüssen und integrieren
- Je einfacher, desto besser heisst: Alles Unnötige weglassen

=== (3) Zusammenarbeit

- Informationen stehen jedem zur Verfügung und werden «einfach» gehalten
- Qualität und funktionierende Software gelten als Fortschrittsindikator
- Keine versteckte Agenda oder alternative Fortschrittskontrollen
- Visualisierung der Daten

=== (4) Inspect and Adapt

#grid(
  columns: 2,
  [
    - Sämtliche Bestandteile im Produkt werden regelmässig überprüft und wenn
      notwendig angepasst, d.h. auch wichtige Anforderungen dürfen jederzeit
      einfliessen.
    - Dazu muss regelmässig vom Kunden Feedback eingeholt werden.
    - Auch die eigenen Prozesse werden regelmässig hinterfragt und verbessert.

  ],
  image("./img/agile-4.png"),
)

== Kanban

Entstanden aus dem Toyota Production System.

Diese Themen finden sich auch im Lean Management
/ In Software:
  - Dateneingaben, die nicht nötig sind
  - Bestätigungsklicks, die nicht nötig sind
/ Im Berufsalltag:
  - Sitzungen, die nicht nötig sind
  - Informationen, die nicht nötig sind
  - Arbeitsschritte und Kontrollen, die nicht nötig sind

=== Nutzen

- Arbeit visualisieren
- Ist-Zustand abbilden
- Workflow beobachten
- Beschränkungen einbauen (Fokus auf aktive Aufgaben)
- Menge der gleichzeitig laufenden Arbeiten (Work in Progress) minimieren
- Gesamtarbeit wird in gut überschaubare Teilaufgaben unterteilt
  - Zu grosse Aufgaben fliessen schlecht durch das System (> 3 Tage)
  - Gute Unterstützung bei der Aufwandsschätzung
- Prognosen ableiten (und reagieren)
- Schnelle durchlaufzeiten

=== Prinzipien

+ Beginnt mit dem, was ihr ohnehin schon macht
+ Einigt euch auf allmähliche, schrittweise Veränderungen
+ Berücksichtigt bestehende Prozesse, Rollen und Verantwortlichkeiten
+ Fördert Initiativen auf allen Ebenen

Scrum hat diese Flexibilität nicht. Scrum erwartet von Anfang an einen
definierten Prozess mit definierten Rollen und Zeremonien in definieren Sprints

=== Praktiken

+ Visualisiere deine Arbeit
+ Begrenze die Menge gleichzeitig laufender Arbeitsvorgänge
+ Verwalte den Arbeitsfluss
+ Schaffe Klarheit über Prozessregeln
+ Implementiere Feedbackschleifen
+ Verbessere den Prozess gemeinsam und probiere Neues aus

=== Timebox vs Functionbox

#table(
  columns: (1fr, 1fr),
  [Zeit vor Inhalt], [Inhalt vor Zeit],
  [
    - Fixe Zeitdauer, nicht länger und nicht kürzer
    - Nicht erledigte Arbeiten werden in die nächste Box eingeplant
  ],
  [
    - Fixer Scope, darf nicht gekürzt oder erweitert werden
    - Arbeiten werden immer erledigt
    Das ist aber keine fixe Vorgabe von Kanban. Im Extremfall ist jede User
    Story eine eigene Iteration und wird direkt released (DI/CD)
  ],
)

=== Kanban und Scrum

Teams, die mit Scrum arbeiten, nutzen dafür meist dieselben Boards, ebenfalls
mit Karten. Aber Scrum ist ein separates Framework, auch wenn Kanban dazu
genutzt werden kann. Kanban konzentriert sich auf Prozessverbesserungen. Scrum
hilft den Teams, Arbeit schneller zu erledigen. Dafür organisiert Scrum
"Sprints" -- Arbeitsblöcke mit täglichen Meetings in den Teams und einem
festgelegten Arbeitspensum, das während des Sprintzyklus zu erledigen ist.

== Weitere agile Methoden

=== XP

- Will bewährte Prinzipien in der Entwicklung bis zum Extremen zu Ende denken.
- Das Ergebnis ist ein leichtgewichtiger Prozess für kleine bis mittelgrosse
  Teams und Projekte mit unklaren oder sich stark ändernden Anforderungen.
- XP basiert auf den Werten Kommunikation, Einfachheit, Feedback, Mut und
  Respekt.

==== Wichtigste Grundsätze

/ Zusammensitzen: Entwicklung soll im selben Raum erfolgen
/ Das ganze Team: Alle benötigten Personen sollen ins Team einbezogen sein
/ Informative Arbeitsumgebung: soll die Arbeit widerspiegeln
/ Energiegeladene Arbeit: nur so lange arbeiten, wie man das produktiv und
  dauerhaft tun kann
/ Pair Programming: Alle Programmteile werden von zwei Entwicklern am selben
  Computer gemeinsam entwickelt
/ Stories: Funktionseinheiten werden in Stories beschrieben, die für den Kunden
  sichtbar und verständlich sind
/ Wöchentlicher Zyklus: Arbeit und Umsetzung wird auf wöchentlicher Basis
  geplant
/ Quartalszyklus: einmal im Quartal wird über das Team, das Projekt, den
  Fortschritt und die Ziele nachgedacht
/ Entspannung: In jedem Plan werden Aufgaben eingeplant, die fals zeitlich nötig
  auch weggelassen werden können
/ Zehn-Minuten-Builds: Das System soll in zehn Minuten inklusive Tests erstellt
  werden können
/ Fortlaufende Integration: Abgeschlossene Aufgaben werden immer direkt ins
  System integriert
/ Test-First: Tests werden jeweils vor der Implementierung geschrieben
/ Inkrementelles Design: Das Design soll täglich den Erfordernissen angepasst
  werden

=== Scaled Agile Framework / Agilität im Multiteam

Das Scaled Agile Framework (SAFe) ist das verbreitetste Rahmenwerk, um Scrum
bzw. Agil zu skalieren - sprich, im "Grossen" zu leben. SAFe bietet agile
Lösungen für alle Ebenen einer Organisation: von Teams über Bereiche bis hin zur
Unternehmenssteuerung.

==== Problem: übergreifende Funktionen

Ein Team reicht heute selten aus, um ein Produkt zu entwickeln. Mehrere Teams
müssen koordiniert auf das Gesamtprodukt hin entwickeln. Dazu müssen die Teams
passend geschnitten werden: Story Mapping, Customer Journey (Kundenerlebnis),
Domain Driven Design, etc.

Kann mit Verwaltung gelöst werden (führt aber zu Trägheit und schlechter
Vorhersagbarkeit).
- Aufgaben werden an die Team-Struktur angepasst
- Team-Struktur wird an die Aufgaben angepasst (leider nur selten)

/ Feature Manager:
  Übergreifende Funktionalitäten werden in Teilfunktionen je Team geschnitten.
  Ein Feature Manager definiert die Aufgabenpakete für die einzelnen Teams und
  kontrolliert den Fortschritt. (Delivery Manager/ Chief Product Owner/ Program
  Manage/ Epic Owner)
/ Big Room Planning: setzt auf die Eigenverantwortlichkeit der Teams. Es finden
  sich alle Teammitglieder aller Teams für eine gemeinsame Planung zusammen. Das
  kann eine gemeinsame Planung über einen längeren Zeitraum sein (wie z.B. das
  PI2)-Planning in SAFe).
/ Teamzuordnung:
  - Ein Team übernimmt die Entwicklung der übergeordneten Funktion.
  - Bedingt, dass die verschiedenen Teams möglichst homogene Entwicklungstools
    und Methoden einsetzen.
/ Temporäres Team:
  - Es wird temporär ein Team aus Members der anderen Teams zusammengestellt,
    das die Entwicklung der übergeordneten Funktion übernimmt.
  - Ergibt eine dynamische Teamzusammenstellung und Unruhe in den Teams.

= Rational Unified Process (RUP)

#image("./img/rupdiag.png")

#table(
  columns: (1fr, 1fr),
  [RUP], [Wasserfall],
  [
    - Phasen: Inception, Elaboration, Construction, Transition
    - Iterationen in jeder Phase
    - Zunehmend detailliertere Planung
  ],
  [
    - Phasen abhängig vom Modell
    - Detaillierte Planung am Anfang über alle Phasen
    - Phase ist abgeschlossen, wenn alles erledigt
    - Keine Iterationen, kein zurückspringen
  ],
)

== Allgemein

RUP ist ein Softwareentwicklungsprozess (und keine eigentlichen
Projektmanagement Methode)

=== Vorteile

- RUP orientiert sich im Wesentlichen an Prinzipien
- Neuste Vorgehensweisen (neben Altbewährtem)
- Grosse Verbreitung (IBM und weitere grosse Beratungsfirmen)
- Detaillierte und klare Beschreibung
- Inhalt und Dokumentation in HTML festgehalten
- Anpassbarkeit des Prozesses (oder besser: muss angepasst werden) z.B. mit IBM
  Rational Methode Composer

== Prinzipien

/ Prozess anpassen:
  - Prozess muss an das Projekt angepasst werden
  - Erhöht die Effizienz, die Agilität und führt zu realistischeren Plänen und
    Schätzungen
  - Wie viel Prozess ist notwendig?
  #table(
    columns: 3,
    [$<-$ Weniger prozesse], [], [Mehr prozesse $->$],
    [
      - Einfache Upgrades
      - Entwicklungsprototypen
      - Statische Webanwendungen
    ],
    [
      - Dynamische Webanwendungen
      - Komponentenbasierte Entwicklung (J2, .NET)
    ],
    [
      - Legacy Upgrades
      - Systemfamilien
      - Realtime Enbedded
      - Zertifizierte Qualität
    ],

    [
      - Teams am selben Ort
      - Kleine, einfache Projekte
      - Wenige Stakeholder
      - Interne Rahmenbedingungen
    ],
    [],
    [
      - Verteilte Teams
      - Grosse Projekte
      - Viele Stakeholder
      - Externe Standards, Gesetze, Verträge
    ],
  )

/ Konkurrenzierende Stakeholder-Prioritäten ausgleichen:
  - Unterschiedliche, sich widersprechende Bedürfnisse / Anforderungen müssen
    geklärt werden. was sind die Interessen des Geschäfts und der Anwender?
  - Anforderungen müssen aber am Anfang noch nicht detailliert aufgenommen
    werden. Sie werden sich im Laufe der Entwicklung ändern!
/ Teamübergreifend zusammenarbeiten:
  - Verbessert die Produktivität, erhöht die Wahrung der Geschäftsinteressen und
    verbessert die Kooperation mit dem produktiven Betrieb eines Systems.
/ Wert iterativ demonstrieren:
  - Ermöglicht frühes Reduzieren von Risiken, verbessert die Vorhersehbarkeit im
    Projektverlauf und erhöht das Vertrauen aller Projektbeteiligten.
/ Abstraktionsgrad erhöhen:
  - Damit vermindert sich die Komplexität und die Produktivität kann gesteigert
    werden.
  - Lösungen können wieder verwendet werden.
  - Es werden abstraktere Tools und höhere Sprachen eingesetzt.
  - Der Fokus liegt auf der Architektur.
  - Zur Visualisierung, Spezifikation, Konstruktion und Dokumentation wird ULM
    (Unified Modelling Language) eingesetzt.
/ Ständige Konzentration auf Qualität:
  - Qualität wird nur erreicht, wenn sie während der ganzen Lebensdauer
    angestrebt wird.
  - Das ganze Team ist für die Qualität des Produkts verantwortlich.
  - Durch die ständigen Tests in den Iterationen wird immer auf die Qualität
    fokussiert.

== Phasen

RUP kennt vier Phasen. Jede Phase hat unterschiedliche Schwerpunkte. Die
Aufgeben innerhalb einer Phase müssen nicht abgeschlossen sein, um in die
nächste Phase zu wechseln. Der Phasenplan wird in der Inception Phase in einer
ersten Version erarbeitet und später konkretisiert.

#align(center, diagram(
  node((0, 0), [Inception], shape: fletcher.shapes.chevron),
  node(
    (1, 1),
    stroke: none,
    box(width: 10em, [Lifecycle\ Objective]),
    height: 4em,
    width: .5em,
  ),
  edge(),
  node((1, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
  node((2, 0), [Elaboration], shape: fletcher.shapes.chevron),
  node(
    (3, 1),
    stroke: none,
    box(width: 10em, [Lifecycle\ Architecture]),
    height: 2em,
    width: .5em,
  ),
  edge(),
  node((3, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
  node((4, 0), [Construction], shape: fletcher.shapes.chevron),
  node(
    (5, 1),
    stroke: none,
    box(width: 10em, [Initial Operational\ Capability]),
    height: 2em,
    width: .5em,
  ),
  edge(),
  node((5, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
  node((6, 0), [Transition], shape: fletcher.shapes.chevron),
  node(
    (7, 1),
    stroke: none,
    box(width: 10em, [Product Release]),
    height: 2em,
    width: .5em,
  ),
  edge(),
  node((7, 0), shape: fletcher.shapes.diamond, " ", height: 1em, width: .5em),
))

/ Inception ; Konzeption:
  - Ziele und Vision des Projekts bestimmen
  - Erste Risikoabschätzung
  - Use Cases des Systems grob festhalten (nicht ausformuliert, da sie sicher
    noch ändern)
  - Abschätzung von Kosten und Nutzen
  - Grobe Projektplanung
/ Elaboration ; Ausarbeitung:
  - Anforderungen stabilisieren
  - Höchste Risiken minimieren
  - Use Cases und Anforderungen zu 80% ausarbeiten
  - Architektur definieren ; Architekturprototyp festlegen
    - Dieser wird während der kommenden Phasen kontinuierlich weiterentwickelt,
      bis zu fertigem Produkt
/ Construction ; Erstellung:
  - Entwickeln und Testen der Systemkomponenten basierend auf der Architektur
  - Am Ende dieser Phase ist ein einsetzbares Produkt
/ Transition ; Überführung:
  - Übergabe an den Kunden
  - Abnahme Tests (Beta Tests) und Fehlerbehebung
  - Schulung der User
  - Fertigstellung des Begleitmaterials
  - Ev. Konvertierung der bestehenden Daten

== Iterationen - vier Regeln

+ Inkrementell
  - Ergebnisse einer Iteration sollen den Projektbeteiligten, den Kunden und den
    Anwendern gezeigt werden
  - Feedback einholen und auf Fehlentwicklungen aufmerksam machen
+ Pläne anpassen
  - Nach jedem Inkrement sollen die Pläne angepasst und die Anforderungen
    überprüft werden
+ Änderungen behandeln und verwalten
  - Änderungen sind in Software Projekten sind eher die Regel als die Ausnahme
+ Die grössten Risiken früh ausräumen
  - Risiko Liste erstellen und bei jeder Iteration überarbeiten
  - Risiken in der Phase Elaboration ausräumen (PoC's)

== Disziplinen

/ Business Modelling:
  - Analyse der gegenwärtigen Organisation und Festlegung der
    Geschäftsprozessziele
  - Pflege des fachlichen Wörterbuchs (Glossar) und der Business Rules
  - Business Use Cases (Akteure und Aufgaben zur Erfüllung der Businessziele)
  - Definition der Automatisierungen, die möglich sind
/ Requirements: (über die ganze Lebensdauer des Projekts)
  - Anforderungsmanagementplan und Vision entwickeln
  - Anforderungen und Wünsche der Stakeholder ermitteln
  - Akteure und Use Cases bestimmen
  - Use Cases beschreiben und Prioritäten vergeben
  - Zusätzliche Anforderungen aufnehmen, die keinem Use Case zugeordnet werden
    können
/ Analyse und Design:
  - Architektur Machbarkeit
  - Organisation der wichtigsten Designelemente inkl. Bestehende integrieren
  - Implementierungsmodell identifizieren und strukturieren (Themen, die in der
    SW immer wieder gleich behandelt werden sollen. Z.B. Fehlerbehandlung,
    Logging, …)
  - Laufzeitarchitektur und Verteilung auf Rechnerknoten bestimmen
  - Services für Serviceorientierte Architektur bestimmen
  - Designs von Subsystemen, Klassen, Services und Datenbanken
/ Implementation:
  - Implementierungsmodell (Softwarearchitekt)
  - Designelemente implementieren, Entwicklertests erstellen und durchführen und
    Laufzeitverhalten analysieren (Implementierter)
  - Subsystemintegration (Integrator)
  - Code prüfen (Technischer Prüfer)
/ Test:
  - Identifizieren der Anforderungen, Zielen und Lieferobjekte der Tests in
    dieser Iteration
  - Definition der Qualitätsansprüche an die Tests
  - Beschreibung der konkreten Testtechniken und der Hard- und Softwareumgebung
  - Durchführen der Tests (automatisch oder manuell nach Testdrehbuch)
/ Deployment:
  - Das Deployment kann in Form einer kundenspezifischen Installation, verteilen
    eines Standardprodukts oder über einen Zugang zu einer existierenden
    Umgebung (SaaS) erfolgen
  - Deployment Plan erstellen
  - Beta-Tests und Akzeptanztests managen
  - Lieferliste (Stückliste) erstellen und Fertigungsfreigabe erteilen (für
    Massenverteilungen) oder Zugriff auf Downloadseite ermöglichen
  - Fertiges Produkt verifizieren und Releasenotes schreiben
  - Unterstützungs- und Trainingsmaterial bereitstellen und User (Kunden)
    informieren
/ Configutation- und Change-Management:
  - Erstellen der Konfigurationsmanagement Umgebung (z.B. GIT)
  - Definieren des Change-Prozess
  - Baseline der Software in einem eigenen Workspace integrieren und für die
    weitere Verwendung dokumentieren
/ Environment:
  - Entwicklungsprozess für das Projekt anpassen ; Development Case (Wann,
    wieviel von was)
  - Entwicklungsprozess einführen und Team darin schulen (vergleichbar mit SCUM
    Master)
  - Tool zur Projektunterstützung evaluieren und einführen (inkl. Richtlinien
    für den Umgang damit)
/ Projektmanagement:
  - Planen und Steuern des Projekts
    - Projektstart
    - Entwicklungsplanung
    - Iterationsplanung wie Start und Ende
    - Riskmanagement
    - Quality Assurance,
  - Sicherstellen, dass vorgegebene Rahmenbedingungen eingehalten werden und wo
    nötig Gegensteuer zu geben
    - Maximalbudget
    - Spätester Auslieferungszeitpunkt
    - Funktionalität
  - Projektstatus prüfen und Reviews durchführen
  - Stakeholder Management (Informationen)

== Iterative Projektplanung

Wesentlicher Unterschied zu herkömmlichen Wasserfallprojekten:
- Die Anforderungen sind nicht von Anfang an bekannt.
- Es müssen viele Risiken (insbesondere technische) erwartet werden.
Es werden zwei Arten von Planungen gemacht:
/ Projektplanung (Projekt Schedule):
  grober Zeitplan über die Phasen des Projekts (Interseption, Elaboration,
  Construction, Transition) Dieser Plan wird situativ abgepasst
/ Iterationsplanung: Entspricht im Kleinen am ehesten einem Wasserfallprojekt
  (oder einer Sprintplanung).
  - Es wird jedoch nur gerade die aktuelle Iteration geplant.
  - Für jede Iteration werden Erfolgskriterien festgelegt und am Ende der
    Projektfortschritt damit geprüft.

== Typische Fehler

/ Rückfall in Wasserfallpraktiken:
  - Die vier Phasen des RUP werden mit den Phasen des Wasserfalls verwechselt
  - Dabei wird versucht, schon am Anfang das ganze Projekt im Detail zu planen.
  - Häufig wird dabei das Ziel der „ausführbaren Software“ aus den Augen
    verloren.
/ Verwendung des RUP ohne Anpassung:
  - RUP muss zwingend dem aktuellen Projekt angepasst werden.
  - Für ein kleines Projekt können nicht dieselben Lieferergebnisse wie bei
    einem grossen Projekt erwartet werden.
/ Transformation der Entwicklungsmethode ohne Berücksichtigung des Unternehmens:
  - Die Umstellung auf agile Projektmethoden hat einen Einfluss auf die
    Unternehmenskultur (siehe Agiles Manifest)

= IT-Servicemanagement

- Unternehmen sind zunehmend von der IT abhängig $=>$ wachsender Bedarf an IT
  Services
- Information sind das wertvollste Gut einer Unternehmung
  - Sicherheit (Vertraulichkeit, Verfügbarkeit, Richtigkeit)
  - Cyber Crime wird heute als grösstes Risiko eingeschätzt
- Trend weg von der Entwicklung der IT Anwendungen hin zum Management von IT
  Services (SaaS)
  - Eine Anwendung unterstützt erst dann die Businessziele, wenn sie voll
    einsetzbar ist (fit for purpose ; fit for use) \ Betrieb, Support, Wartung,
    Anpassungen

== Ziele

- Zuverlässige und konsistente IT Services
  - mit hoher Qualität
  - zu tragbaren Kosten
- Abstimmung der IT Services auf die Geschäftsanforderungen
  - Kostenoptimierung
  - Qualitätssicherung (steuerbares Qualitätsniveau)
  - Betriebsoptimierung
- Trennung von Entwicklung und Betrieb
  - neuer Trend: Dev-Ops / AI-Ops
- Definierte Schnittstelle zum Business (Kunde / Benutzer)
  - neuer Trend: Agile IT ; Produkte-Teams

== Business Nutzen

/ Return on Investment (ROI) aus Sicht des Kunden:
  Der Kunde will seine Kosten möglichst bald durch den zusätzlichen Nutzen
  kompensieren können

In einer sehr einfachen Provider-Consumer-Beziehung stellt ein Provider einen
Service zur Verfügung, der von einem Consumer angewendet wird.

Grössere Organisationen setzen eine partnerschaftliche Beziehung zwischen
Provider und Consumer voraus.

Die Utility wie auch die Warranty müssen erfüllt sein, damit der gewünschte
Nutzen entstehen kann. Die Utility wird oft sehr genau in einem Pflichtenheft
oder einer Service Vereinbarung festgelegt. Dabei kommt der Warrantry oft zu
wenig Beachtung zu.

== Vier Service Management Dimensionen

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [Organisation], [Information], [Partner & Supplier], [Value Streams],
  [Struktur], [Technologie], [Beziehungen], [Prozesse],
  [Hierachie], [Knowledge], [Verträge], [Aktivitäten],
  [Kultur], [Inputs], [Vereinbarungen], [Workflows],
  [Kapazität], [Outputs], [], [Controls],
  [Kompetenzen], [Relationship], [], [Prozeduren],
  [Skills], [], [], [],
  [Management], [], [], [],
  [Leadership Style], [], [], [],
  [Kommunikation], [], [], [],
  [Zusammenarbeit], [], [], [],
)

== Service Value System

Kreiert aus Ressourcen Value für den Kunden, um einen Demand zu befriedigen.

#align(center, diagram(
  node((0, 0), [
    Opportunity \
    Demand
  ]),
  edge("-|>"),
  node((1, 0), [
    Governance \
    Service Management \
    Cont. Improvement \
    Capabilities \
    Ressourcen
  ]),
  edge("-|>"),
  node((2, 0), [
    Objectives \
    Value
  ]),
))

- Die grösste Herausforderung einer Organisation in einem agilen Umfeld sind
  Silos.
- Diese sind oft "change resistent" und verhindern den schnellen Zugriff auf
  Informationen und Spezialisten.
- Solche Silos können auch durch Prozesse oder Praktiken (Practices) entstehen,
  wenn diese nicht genügend flexible Schnittstellen aufweisen.
- Silos reduzieren die Effizienz und erhöhen die Kosten und die Risiken.
- Silos erhöhen die Komplexität der Organisation.

Komplexität ist ein Service- und Qualiäts-Killer und Kostentreiber

- ITIL gibt kein fixes System von Value Streams vor.
- Organisationen müssen in der Lage sein, diese selbst zu gestalten und
  regelmässig und schnell den aktuellen Anforderungen anzupassen.
- Die umfassenden Operationen sind in ITIL definiert durch leitende Prinzipien
  (guiding Principals) beschrieben.

#todo[W5]
