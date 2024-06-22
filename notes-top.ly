\version "2.25.17"

\include "notes.ily"

\score {
  \new Staff {
    <<
      \main-notes
      {
        \new Staff \with {
          \hide Clef
          \hide NoteHead
          \hide OttavaBracket
          \hide LedgerLineSpanner
          \hide StaffSymbol
        } {
          \supplemental-notes
        }
      }
    >>
  }
}

