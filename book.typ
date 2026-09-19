#import "@preview/shiroa:0.4.0": *

#show: book

#let chd = m => chapter(m + "/doc.typ", m)
#let chs = m => chapter(m + "/cs.typ", m)
// TODO: dynamic pages: wait for readdir? or hacky ls | xargs + shiroa patch?
#book-meta(
  title: "summaries-se-ost",
  description: "Summaries for the software engineering bachelor's at OST",
  repository: "https://github.com/omega-800/summaries-se-ost",
  repository-edit: "https://github.com/omega-800/summaries-se-ost/edit/main/github-pages/docs/{path}",
  authors: ("omega-800",),
  language: "en",
  summary: [

    // FIXME: shiroa PR page-sidebar.typ:93
    // items.sum() bug when no content
    = Summaries

    // == HS 25

    - #chd("An1I")
    - #chd("DMI")
    - #chd("CN1")
    - #chd("Dbs1")
    - #chd("EnglScience")
    - #chd("RheKoI")

    // == FS 26

    - #chd("An2I")
    - #chd("MathFML")
    - #chd("AutoSpr")
    - #chd("DigCod")
    - #chd("FP")
    - #chd("CN2")
    - #chd("CySec")

    // == HS 26

    - #chd("WrStat")
    - #chd("LinAlg")
    - #chd("AlgDat")
    - #chd("SEP1")
    - #chd("PmQm")
    - #chd("Bsys1")
    - #chd("NIoSec")
    - #chd("CPl")
    - #chd("WE1")
    - #chd("AIFo")

    // == Misc

    - #chd("EC")

    = Cheatsheets

    // == HS 25

    - #chs("DMI")
    - #chs("OOP1")
    - #chs("Dbs1")

    // == FS 26

    // FIXME: - #chs("MathFML")
    - #chs("AutoSpr")
    - #chs("OOP2")
    - #chs("CN2")
    - #chs("CySec")
  ],
)
#build-meta(
  dest-dir: "./web",
)
