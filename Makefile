all : instrumentation-cheat-sheet.pdf

instrumentation-cheat-sheet.pdf : instrumentation-cheat-sheet.tex instrumentation-cheat-sheet.bib notes-top.pdf notes-bottom.pdf
	lualatex --interaction=errorstopmode instrumentation-cheat-sheet.tex
	biber instrumentation-cheat-sheet
	for _ in {1..2}; do lualatex -interaction=errorstopmode instrumentation-cheat-sheet.tex; done

notes-top.pdf : notes-top.ly notes.ily
	lilypond notes-top.ly

notes-bottom.pdf : notes-bottom.ly notes.ily
	lilypond notes-bottom.ly

clean :
	rm -f \
	notes-*.pdf \
	instrumentation-cheat-sheet.pdf
