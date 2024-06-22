\version "2.25.17"

\include "notes.ily"

#(define min-note-head-X-extent '(+inf.0 . 0))
#(define max-note-head-X-extent '(0 . -inf.0))

\score {
  \new Staff {
    \override NoteHead.output-attributes = #(lambda (grob)
      (let* (
          (paper (ly:parser-lookup '$defaultpaper))
          (module (ly:output-def-scope paper))
          (staff-space (variable-ref (module-variable module 'staff-space)))
          (pt (variable-ref (module-variable module 'pt)))
          (X-extent (ly:grob-robust-relative-extent grob (ly:grob-system grob) X))
          (car-X-extent (* (car X-extent) (/ staff-space pt)))
          (cdr-X-extent (* (cdr X-extent) (/ staff-space pt)))
          (updated-extents #f))
        (unless (> car-X-extent (car min-note-head-X-extent))
          (set! min-note-head-X-extent `(,car-X-extent . ,cdr-X-extent))
          (set! updated-extents #t))
        (unless (< cdr-X-extent (cdr max-note-head-X-extent))
          (set! max-note-head-X-extent `(,car-X-extent . ,cdr-X-extent))
          (set! updated-extents #t))
        (when updated-extents
          (let* (
              (file-name (string-join `(,(getcwd) ".midpoints.tex") file-name-separator-string))
              (output-port (open-output-file file-name)))
            (format output-port
                    "\\def\\minNoteX{~Apt}\n\\def\\minNoteMidpoint{~Apt}\n\\def\\maxNoteMidpoint{~Apt}\n"
                    (car min-note-head-X-extent)
                    (* 0.5 (+ (car min-note-head-X-extent) (cdr min-note-head-X-extent)))
                    (* 0.5 (+ (car max-note-head-X-extent) (cdr max-note-head-X-extent))))
            (close-output-port output-port)))))
    <<
      \main-notes
      { \new Staff \supplemental-notes }
    >>
  }
}

