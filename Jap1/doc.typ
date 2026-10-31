#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)

#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Basics

Each _mora_ in japanese is represented by one character or digraph in each
writing system. This may be a vowel, consonant followed by a vowel or the nasal
sonorant.

= Hiragana (ひらがな)

Hiragana is the phonetic lettering system, meaning "common" or "plain" kana.
#td[Blue] is the pronunciation, #tp[purple] if it deviates and #tg[green] shows
how to type it in romaji.

#let mkcells(rows, cols, cells) = (
  [],
  [],
  ..cols.map(emph),
  ..rows
    .enumerate()
    .map(((i, r)) => {
      (
        emph(r),
        ..cells
          .at(i)
          .zip(([], ..cols))
          .map(((h, c)) => {
            let bx = (it, c) => box(
              fill: c,
              inset: 1pt,
              radius: 1em,
              height: .75em,
              width: 2.5em,
              text(size: .75em, it),
            )
            if h == none {
              []
            } else if type(h) == content {
              {
                bx([#c#r], colors-l.darkblue)

                align(bottom, text(size: 1.5em, h))
              }
            } else {
              {
                box(stack(
                  dir: ttb,
                  if "p" in h { bx(h.p, colors-l.purple) },
                  if "t" in h { bx(h.t, colors-l.green) },
                ))
                [\ ]
                align(bottom, text(size: 1.5em, h.c))
              }
            }
          }),
      )
    })
    .join(),
)


#table(
  columns: (auto, ..range(15).map(_ => 1fr)),
  rows: (
    auto,
    auto,
    ..range(5).map(_ => 4em),
    auto,
    auto,
    ..range(3).map(_ => 4em),
  ),
  align: center,
  [], table.cell(colspan: 10)[Basic],
  table.cell(colspan: 5)[Dakuten/Han-Dakuten],
  ..mkcells(
    ([A], [I], [U], [E], [O]),
    (
      [K],
      [S],
      [T],
      [N],
      [H],
      [M],
      [Y],
      [R],
      [W],
      [G],
      [Z],
      [D],
      [B],
      [P],
    ),
    (
      (
        [あ],
        [か],
        [さ],
        [た],
        [な],
        [は],
        [ま],
        [や],
        [ら],
        [わ],
        [が],
        [ざ],
        [だ],
        [ば],
        [ぱ],
      ),
      (
        [い],
        [き],
        (c: [し], p: [SHI]),
        (c: [ち], p: [CHI]),
        [に],
        [ひ],
        [み],
        none,
        [り],
        none,
        [ぎ],
        (c: [じ], p: [JI]),
        (c: [ぢ], p: [JI], t: [DI]),
        [び],
        [ぴ],
      ),
      (
        [う],
        [く],
        [す],
        (c: [つ], p: [TSU]),
        [ぬ],
        (c: [ふ], p: [HU/FU]),
        [む],
        [ゆ],
        [る],
        (c: [を], p: [O], t: [WO]),
        [ぐ],
        [ず],
        (c: [づ], p: [ZU], t: [DU]),
        [ぶ],
        [ぷ],
      ),
      (
        [え],
        [け],
        [せ],
        [て],
        [ね],
        [へ],
        [め],
        none,
        [れ],
        none,
        [げ],
        [ぜ],
        [で],
        [べ],
        [ぺ],
      ),
      (
        [お],
        [こ],
        [そ],
        [と],
        [の],
        [ほ],
        [も],
        [よ],
        [ろ],
        (c: [ん], p: [N]),
        [ご],
        [ぞ],
        [ど],
        [ぼ],
        [ぽ],
      ),
    ),
  ),
  table.cell(colspan: 16)[_Combination_],
  ..mkcells(
    (
      [A],
      [U],
      [O],
    ),
    (
      [KY],
      [SH],
      [CH],
      [NY],
      [HY],
      [MY],
      [],
      [RY],
      [],
      [GY],
      [JY],
      [DY],
      [BY],
      [PY],
    ),
    (
      (
        none,
        [きゃ],
        [しゃ],
        [ちゃ],
        [にゃ],
        [ひゃ],
        [みゃ],
        none,
        [りゃ],
        none,
        [ぎゃ],
        [じゃ],
        (c: [ぢゃ], p: [JYA], t: [DYA]),
        [びゃ],
        [ぴゃ],
      ),
      (
        none,
        [きゅ],
        [しゅ],
        [ちゅ],
        [にゅ],
        [ひゅ],
        [みゅ],
        none,
        [りゅ],
        none,
        [ぎゅ],
        [じゅ],
        (c: [ぢゅ], p: [JYU], t: [DYU]),
        [びゅ],
        [ぴゅ],
      ),
      (
        none,
        [きょ],
        [しょ],
        [ちょ],
        [にょ],
        [ひょ],
        [みょ],
        none,
        [りょ],
        none,
        [ぎょ],
        [じょ],
        (c: [ぢょ], p: [JYO], t: [DYO]),
        [びょ],
        [ぴょ],
      ),
    ),
  ),
)

= Katakana (カタカナ)

#todo(table(
  columns: (auto, ..range(10).map(_ => 1fr)),
  rows: (
    auto,
    ..range(5).map(_ => 4em),
  ),
  align: center,
  ..mkcells(
    ([A], [I], [U], [E], [O]),
    ([K], [S], [T], [N], [H], [M], [Y], [R], [W]),
    (
      ([ア], [カ], [サ], [タ], [ナ], [ハ], [マ], [ヤ], [ラ], [ワ]),
      ([イ], [キ], [シ], [チ], [ニ], [ヒ], [ミ], none, [リ], none),
      (
        [ウ],
        [ク],
        [ス],
        [ツ],
        [ヌ],
        [フ],
        [ム],
        [ユ],
        [ル],
        (c: [ン], p: [NA]),
      ),
      ([エ], [ケ], [セ], [テ], [ネ], [ヘ], [メ], none, [レ], none),
      ([オ], [コ], [ソ], [ト], [ノ], [ホ], [モ], [ヨ], [ロ], [ヲ]),
    ),
  )
))
