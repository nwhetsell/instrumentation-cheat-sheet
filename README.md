# Instrumentation Cheat Sheet

This is a “cheat sheet” that shows ranges of musical instruments in a compact format.
There are two versions, with concert pitch at A3 and A4.
You can download the version with A3 concert pitch
[here](https://github.com/nwhetsell/instrumentation-cheat-sheet/releases/download/v14/instrumentation-cheat-sheet-a3-concert.pdf),
and the version with A4 concert pitch
[here](https://github.com/nwhetsell/instrumentation-cheat-sheet/releases/download/v14/instrumentation-cheat-sheet-a4-concert.pdf).

To create the cheat sheet yourself, you need
[TeX Live](https://tug.org/texlive/),
[biber](https://github.com/plk/biber), and
[LilyPond](https://lilypond.org) v2.25.3 or later
(for [`\musicLength`](https://gitlab.com/lilypond/lilypond/-/commit/8c34733e3173649f7e66cbb07ce03225ca33c0e1)).
On macOS, the easiest way to install these is probably using [Homebrew](https://brew.sh):

```sh
brew install biber texlive nwhetsell/lilypond/lilypond-unstable
```

After either adding the `lilypond` executable to your `PATH` or linking it—

```sh
brew link lilypond-unstable
```

—you should be able to create the cheat sheet by running:

```sh
make
```
