#import "@preview/shiroa:0.3.1": *

#show: book

#let chd = m => prefix-chapter(m + "/doc.typ", m)
#let chs = m => prefix-chapter(m + "/cs.typ", m)
#book-meta(
  title: "summaries-se-ost",
  description: "Summaries for the software engineering bachelor's at OST",
  repository: "https://github.com/omega-800/summaries-se-ost",
  repository-edit: "https://github.com/omega-800/summaries-se-ost/edit/main/github-pages/docs/{path}",
  authors: ("omega-800",),
  language: "en",
  summary: [
    // - #prefix-chapter("./tmp/testpage.typ")[DMI]

    = Summaries
    // works
    - #chd("CN1")
    - #chd("CN2")
    - #chd("EnglScience")

    = Cheatsheets

    - #chs("OOP1")
    - #chs("OOP2")

    // doesn't
    // - #chd("An1I")
    // - #chd("An2I")
    // - #chd("AutoSpr")
    // - #chd("CySec")
    // - #chd("Dbs1")
    // - #chs("Dbs1")
    // - #chd("DigCod")
    // - #chd("DMI")
    // - #chs("DMI")
    // - #chd("EC")
    // - #chd("FP")
    // - #chd("MathFML")
    // - #chd("RheKoI")
  ],
)
#build-meta(
  dest-dir: "./web",
)
