TEXMF=${HOME}/texmf
INSTALLDIR=${TEXMF}/tex/latex/adjustbox
DOCINSTALLDIR=${TEXMF}/doc/latex/adjustbox
CP=cp
RMDIR=rm -rf
PDFLATEX=pdflatex -interaction=batchmode
LATEXMK=latexmk -pdf -silent
PDFOPT=qpdf --linearize

PACKEDFILES=adjustbox.sty
DOCFILES=adjustbox.pdf 
#adjustbox-de.pdf
SRCFILES=adjustbox.dtx adjustbox.ins README Makefile

all: unpack doc

package: unpack
class: unpack

${PACKEDFILES}: adjustbox.dtx adjustbox.ins
	yes | pdflatex adjustbox.ins

unpack: ${PACKEDFILES}

doc: ${DOCFILES}

pdfopt: doc
	@-${PDFOPT} adjustbox.pdf .temp.pdf && mv .temp.pdf adjustbox.pdf
	@-${PDFOPT} adjustbox-de.pdf .temp.pdf && mv .temp.pdf adjustbox-de.pdf

adjustbox.pdf: adjustbox.dtx
	${LATEXMK} $<

adjustbox-de.pdf: adjustbox-de.tex adjustbox.dtx
	${LATEXMK} $<

adjustbox.tex: unpack

.PHONY: test

test: unpack
	for T in test*.tex; do echo "$$T"; pdflatex -interaction=batchmode $$T && echo "OK" || echo "Failure"; done

clean:
	-latexmk -C adjustbox.dtx
	-latexmk -C adjustbox-de.tex
	${RM} ${PACKEDFILES} *.zip *.log *.aux *.toc *.vrb *.nav *.pdf *.snm *.out *.fdb_latexmk *.glo *.gls *.hd *.sta *.stp *.cod
	${RMDIR} tds

install: unpack doc ${INSTALLDIR} ${DOCINSTALLDIR}
	${CP} ${PACKEDFILES} ${INSTALLDIR}
	${CP} ${DOCFILES} ${DOCINSTALLDIR}
	texhash ${TEXMF}

${INSTALLDIR}:
	mkdir -p $@

${DOCINSTALLDIR}:
	mkdir -p $@

.PHONY: build manual

manual: adjustbox.dtx adjustbox.ins
	-mkdir .manual
	perl ../dtx/dtx.pl adjustbox.dtx .manual/adjustbox.dtx
	cd .manual && latexmk -pdf adjustbox.dtx || rm .manual/adjustbox.aux
	mv .manual/adjustbox.pdf adjustbox.pdf


build: adjustbox.dtx adjustbox.ins README
	rm -rf build/
	mkdir build
	perl ../dtx/dtx.pl adjustbox.dtx build/adjustbox.dtx
	perl ../dtx/dtx.pl storebox.dtx build/storebox.dtx
	${CP} adjustbox.ins README build/
	cd build && yes | tex adjustbox.ins
	cd build && latexmk -pdf adjustbox.dtx
	cd build && latexmk -pdf storebox.dtx
	cd build && ${PDFOPT} adjustbox.pdf opt.pdf && mv opt.pdf adjustbox.pdf
	cd build && ${PDFOPT} storebox.pdf opt.pdf && mv opt.pdf storebox.pdf
	cd build && ctanify adjustbox.dtx adjustbox.ins storebox.dtx *.sty adjpgf.def=tex/latex/adjustbox/ README
	cd build && ${CP} adjustbox.tar.gz /tmp

buildonce: adjustbox.dtx adjustbox.ins README
	rm -rf build/
	mkdir build
	perl ../dtx/dtx.pl adjustbox.dtx build/adjustbox.dtx
	perl ../dtx/dtx.pl storebox.dtx build/storebox.dtx
	${CP} adjustbox.ins README build/
	cd build && yes | tex adjustbox.ins
	cd build && pdflatex adjustbox.dtx
#	cd build && pdflatex storebox.dtx


