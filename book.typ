#import "@preview/shiroa:0.3.1": *

#show: book

#book-meta(
  title: "summaries-se-ost",
  description: "Summaries for the software engineering bachelor's at OST",
  repository: "https://github.com/omega-800/summaries-se-ost",
  repository-edit: "https://github.com/omega-800/summaries-se-ost/edit/main/github-pages/docs/{path}",
  authors: ("omega-800",),
  language: "en",
  summary: [
    = Summaries

    #chapter("tmp/test/sample-page.typ")[Hello, typst]
    // - #chapter("RheKoI/doc.typ", section: "1.1")[RheKoI]
  ],
)
#build-meta(
  dest-dir: "./web",
)
