# Summaries Bachelor Software Engineering at OST

[Link to summaries as a website](https://omega-800.github.io/summaries-se-ost/)

[Definition "Ehre" (Bsys1)](http://bsys1.jasmin-faessler.ch/)

## Structure

```
.
└── ModuleName
    ├── img       # assets
    ├── info.typ  # module info
    ├── cit.bib   # citations
    ├── deck.apkg # anki deck
    ├── deck.typ  # deck sourcecode
    ├── cs.pdf    # cheatsheet
    ├── cs.typ    # cheatsheet sourcecode
    ├── doc.pdf   # summary
    └── doc.typ   # summary sourcecode
```

## Development

```sh
nix run .#ModuleName        # work on summary
nix run .#ModuleName-cs     # work on cheatsheet
nix run .#ModuleName-apkg   # generate anki deck .apkg

nix run .#compile-all       # update all pdfs
nix run .#genanki           # generate all anki decks
```

## ~Stolen from~ Inspired by:

- https://github.com/grnin/Zusammenfassungen
- https://gitlab.com/Yutubi/typst-template-ost
- https://github.com/jasmin-f/Studium-Informatik
