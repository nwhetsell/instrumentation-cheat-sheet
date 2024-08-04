all : instrumentation-cheat-sheet-a4-concert.pdf instrumentation-cheat-sheet-a3-concert.pdf

notes = \
	notes-top.pdf \
	notes-bottom.pdf

instrumentation-cheat-sheet-a4-concert.pdf : instrumentation-cheat-sheet.tex instrumentation-cheat-sheet.bib $(notes)
	echo '\def\octaveOffset{1}' > .octave-offset.tex
	lualatex --interaction=errorstopmode instrumentation-cheat-sheet.tex
	biber instrumentation-cheat-sheet
	for _ in {1..2}; do lualatex -interaction=errorstopmode instrumentation-cheat-sheet.tex; done
	mv instrumentation-cheat-sheet.pdf instrumentation-cheat-sheet-a4-concert.pdf

instrumentation-cheat-sheet-a3-concert.pdf : instrumentation-cheat-sheet.tex instrumentation-cheat-sheet.bib $(notes)
	echo '\def\octaveOffset{2}' > .octave-offset.tex
	lualatex --interaction=errorstopmode instrumentation-cheat-sheet.tex
	biber instrumentation-cheat-sheet
	for _ in {1..2}; do lualatex -interaction=errorstopmode instrumentation-cheat-sheet.tex; done
	mv instrumentation-cheat-sheet.pdf instrumentation-cheat-sheet-a3-concert.pdf

$(notes) : %.pdf: %.ly
	lilypond $<
	pdfcrop $*.pdf
	mv $*-crop.pdf $*.pdf

clean :
	rm -f \
	notes-*.pdf \
	instrumentation-cheat-sheet-*.pdf
