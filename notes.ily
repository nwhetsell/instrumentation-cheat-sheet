\version "2.25.17"

main-notes = \relative {
  \clef "bass"
  \ottava -1
  a,,,4 b8
  c4 d e8 f4 \ottava 0 g a b8
  c4 d e8 f4 g a b8
  c4 d e8 f4 g a \clef "treble" b8
  c4 d e8 f4 g a b8
  c4 d e8 f4 g a b8
  \tweak shorten-pair #'(0 . -0.25)
  \ottava 1
  c4 d e8 f4 g a b8
  \tweak shorten-pair #'(-0.75 . -0.5)
  \ottava 2
  c4 d e8 f4 g a b8
  c8
}

supplemental-notes = \relative {
  \clef "bass"
  a,,,4 b8
  c4 d e8 f8
  \ottava 0
  \stopStaff
  s8 s4 s s8
  s4 s s8 s4 s s s8
  \startStaff
  \once \override Staff.Clef.full-size-change = ##t
  \clef "treble"
  c''4 d e8 f4 g a \clef "bass" b8
  c4 d e8 f4 g a b8
  c8
  \stopStaff
  s8 s4 s8 s4 s s s8
  \startStaff
  \once \override Staff.Clef.full-size-change = ##t
  \clef "treble"
  c'4 d e8 f4 g a b8
  \tweak shorten-pair #'(0 . -0.5)
  \ottava 1
  c4 d e8 f4 g a b8
  c8
}

\layout {
  \context {
    \Score
    \remove System_start_delimiter_engraver
    proportionalNotationDuration = \musicLength 1*1/8
    \override SpacingSpanner.strict-note-spacing = ##t
    \override SpacingSpanner.uniform-stretching = ##t
  }
  \context {
    \Staff
    \omit Beam
    \omit Flag
    \omit Stem
    \remove Bar_engraver
    \remove Time_signature_engraver
    \magnifyStaff #(magstep 2)
  }
}

\paper {
  page-breaking = #ly:one-line-auto-height-breaking
  top-margin = 0
  left-margin = 0
  right-margin = 0
  oddFooterMarkup= ##f
}

\pointAndClickOff
