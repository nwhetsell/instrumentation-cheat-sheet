all : instrumentation-cheat-sheet.pdf

notes = \
	notes-top.pdf \
	notes-bottom.pdf

instrumentation-cheat-sheet.pdf : instrumentation-cheat-sheet.tex instrumentation-cheat-sheet.bib $(notes)
	lualatex --interaction=errorstopmode instrumentation-cheat-sheet.tex
	biber instrumentation-cheat-sheet
	for _ in {1..2}; do lualatex -interaction=errorstopmode instrumentation-cheat-sheet.tex; done

$(notes) : %.pdf: %.ly
	lilypond $<
	pdfcrop $*.pdf
	mv $*-crop.pdf $*.pdf

clean :
	rm -f \
	notes-*.pdf \
	instrumentation-cheat-sheet.pdf
