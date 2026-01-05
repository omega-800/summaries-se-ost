# Summaries Bachelor Software Engineering at OST

## Structure

```
.
└── ModuleName
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
nix run .#ModuleName-deck   # work on flashcards
typ2anki ModuleName         # import flashcards
```

## ~stolen from~ inspired by: 

- https://github.com/grnin/Zusammenfassungen
- https://gitlab.com/Yutubi/typst-template-ost
- https://github.com/jasmin-f/Studium-Informatik
