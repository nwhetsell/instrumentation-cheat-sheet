\version "2.25.3"

\include "notes.ily"

#(define min-note-head-X-extent '(+inf.0 . 0))
#(define max-note-head-X-extent '(0 . -inf.0))
#(define min-note-head-Y +inf.0)

\layout {
  \context {
    \Staff
    \override NoteHead.output-attributes = #(lambda (grob)
      (let* (
          (paper (ly:parser-lookup '$defaultpaper))
          (module (ly:output-def-scope paper))
          (staff-space (variable-ref (module-variable module 'staff-space)))
          (pt (variable-ref (module-variable module 'pt)))
          (grob-system (ly:grob-system grob))
          (X-extent (ly:grob-robust-relative-extent grob grob-system X))
          (Y-extent (ly:grob-robust-relative-extent grob grob-system Y))
          (pt-conversion-factor (/ staff-space pt))
          (car-X-extent (* (car X-extent) pt-conversion-factor))
          (cdr-X-extent (* (cdr X-extent) pt-conversion-factor))
          (car-Y-extent (* (car Y-extent) pt-conversion-factor))
          (updated-extents #f))
        (unless (> car-X-extent (car min-note-head-X-extent))
          (set! min-note-head-X-extent `(,car-X-extent . ,cdr-X-extent))
          (set! updated-extents #t))
        (unless (< cdr-X-extent (cdr max-note-head-X-extent))
          (set! max-note-head-X-extent `(,car-X-extent . ,cdr-X-extent))
          (set! updated-extents #t))
        (unless (> car-Y-extent min-note-head-Y)
          (set! min-note-head-Y car-Y-extent)
          (set! updated-extents #t))
        (when updated-extents
          (let* (
              (file-name (string-join `(,(getcwd) ".note-metrics.tex") file-name-separator-string))
              (output-port (open-output-file file-name)))
            (format output-port
                    "\\def\\minNoteX{~Apt}\n\\def\\minNoteMidpoint{~Apt}\n\\def\\maxNoteMidpoint{~Apt}\n\\def\\minNoteY{~Apt}\n"
                    (car min-note-head-X-extent)
                    (* 0.5 (+ (car min-note-head-X-extent) (cdr min-note-head-X-extent)))
                    (* 0.5 (+ (car max-note-head-X-extent) (cdr max-note-head-X-extent)))
                    min-note-head-Y)
            (close-output-port output-port)))))
  }
}

\score {
  \new Staff {
    <<
      \main-notes
      { \new Staff \supplemental-notes }
    >>
  }
}
