instrumentation-cheat-sheets = \
	instrumentation-cheat-sheet-a4-concert.pdf \
	instrumentation-cheat-sheet-a3-concert.pdf

all : $(instrumentation-cheat-sheets)

notes = \
	notes-top.pdf \
	notes-bottom.pdf

$(instrumentation-cheat-sheets) : instrumentation-cheat-sheet.tex instrumentation-cheat-sheet.bbl $(notes)
	if [[ $@ =~ a4 ]]; then \
	  echo '\def\octaveOffset{1}' > .octave-offset.tex; \
	else \
	  echo '\def\octaveOffset{2}' > .octave-offset.tex; \
	fi
	for _ in {1..2}; do lualatex -interaction=errorstopmode --shell-escape $<; done
	mv $(basename $<).pdf $@

instrumentation-cheat-sheet.bbl : instrumentation-cheat-sheet.bib instrumentation-cheat-sheet.tex $(notes)
	echo '\def\octaveOffset{1}' > .octave-offset.tex
	lualatex --interaction=errorstopmode --shell-escape $(basename $<).tex
	biber $(basename $<)

$(notes) : %.pdf: %.ly notes.ily
	lilypond $<
	pdfcrop $*.pdf
	mv $*-crop.pdf $*.pdf

clean :
	rm -f \
	.note-metrics.tex \
	.octave-offset.tex \
	notes-*.pdf \
	instrumentation-cheat-sheet.aux \
	instrumentation-cheat-sheet.bbl \
	instrumentation-cheat-sheet.bcf \
	instrumentation-cheat-sheet.blg \
	instrumentation-cheat-sheet.log \
	instrumentation-cheat-sheet.run.xml \
	instrumentation-cheat-sheet.out \
	instrumentation-cheat-sheet-*.pdf
