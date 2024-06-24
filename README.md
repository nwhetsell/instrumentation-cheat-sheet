# Instrumentation Cheat Sheet

This is a “cheat sheet” that shows ranges of musical instruments in a compact format.
You can download it [here](https://github.com/nwhetsell/instrumentation-cheat-sheet/releases/download/v3/instrumentation-cheat-sheet.pdf).

To create it yourself, you need [TeX Live](https://tug.org/texlive/), [biber](https://sourceforge.net/projects/biblatex-biber/), and [LilyPond](https://lilypond.org) v2.25.3 or later (for [`\musicLength`](https://gitlab.com/lilypond/lilypond/-/commit/8c34733e3173649f7e66cbb07ce03225ca33c0e1)).
On macOS, the easiest way to install these is probably using [Homebrew](https://brew.sh):

```sh
brew install texlive nwhetsell/biber/biber@2.19 nwhetsell/lilypond/lilypond-unstable
```

After either adding the `biber` and `lilypond` executables to your `PATH` or linking them—

```sh
brew link biber@2.19 lilypond-unstable
```

—you should be able to create the cheat sheet by running:

```sh
make
```
