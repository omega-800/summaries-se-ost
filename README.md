# Summaries Bachelor Software Engineering at OST

## Structure

```
.
└── ModuleName
    ├── deck.apkg # anki deck
    ├── cs.pdf    # cheatsheet
    ├── cs.typ    # cheatsheet sourcecode
    ├── doc.pdf   # summary
    └── doc.typ   # summary sourcecode
```

## Development

```sh
nix run .#ModuleName        # work on summary
nix run .#ModuleName-cs     # work on cheatsheet
nix run .#ModuleName-anki   # work on flashcards
```

## ~stolen from~ inspired by: 

- https://github.com/grnin/Zusammenfassungen
- https://gitlab.com/Yutubi/typst-template-ost
- https://github.com/jasmin-f/Studium-Informatik
