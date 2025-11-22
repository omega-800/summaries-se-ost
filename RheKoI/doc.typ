#import "../lib.typ": *
#let lang = "de"
#show: project.with(
  module: "RheKoI",
  name: "Rhetorische Kommunikation für Informatiker",
  semester: "HS25",
  language: lang
)
#let tbl =(..body)=> deftbl(lang,..body)

= Abstract

- Wiederholung von Schlüsselwörtern
- Relevanz anzeigende Signale – "Von besonderer Bedeutung ist…", "Die zentrale These lautet…"
- Struktur
  - Problem/Ausgangslage + Relevanz/Ziel
  - Vorgehen
  - Ergebnisse, evtl. Bewertung
  - Künftige Arbeiten

= Fünf-Finger-Feedback

#tbl(
[Daumen],[Das war super!],
[Zeigefinger],[Das könnte man besser machen!],
[Mittelfinger],[Das hat mir nicht gefallen!],
[Ringfinger],[Das nehme ich mit!],
[Kleiner Finger],[Das kam zu kurz!],
)

= Persönlichkeitsstile

#image("persoenlichkeitsstile.png")

= Vier Ohren Modell

#image("vier-ohren-modell.png")

= Statuswippe

Hochstatus: Nimmt Raum ein, führt das Gespräch.
Tiefstatus: Macht sich kleiner, ordnet sich unter.

= Grundpositionen

- Ich bin okay, Du bist okay (+/+)
- Ich bin okay, Du bist nicht okay (+/-)
- Ich bin nicht okay, Du bist okay (-/+)
- Ich bin nicht okay, Du bist nicht okay (-/-)

= Ich-Botschaften

#image("ich-botschaften.png")

- Sachebene
- Selbstoffenbarung
- Appell

= Ich-Zustände

#image("ich-zustaende.png")

= Transaktionsarten

#image("transaktionsarten.png")

- Parallele Transaktion
- Gekreuzte Transaktion
- Verdeckte Transaktion

= Gesprächsstörer

- Von sich selbst reden
- Lösungen liefern, Ratschläge erteilen
- Herunterspielen, bagatellisieren, beruhigen
- Ausfragen, dirigieren
- Interpretieren, Ursachen aufzeigen, diagnostizieren
- Vorwürfe machen, moralisieren, urteilen, bewerten
- Befehlen, drohen, warnen

= Gesprächsförderer

- Wiederholung mit eigenen Worten
- Zusammenfassende Wiederholung
- Statement
- Weiterführende Frage
- Klärende Frage
- Aufmerksamkeit signalisieren
