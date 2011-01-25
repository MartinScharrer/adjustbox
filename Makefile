TEXMF=${HOME}/texmf
INSTALLDIR=${TEXMF}/tex/latex/adjustbox
DOCINSTALLDIR=${TEXMF}/doc/latex/adjustbox
CP=cp
RMDIR=rm -rf
PDFLATEX=pdflatex -interaction=batchmode
LATEXMK=latexmk -pdf -silent

PACKEDFILES=adjustbox.sty
DOCFILES=adjustbox.pdf
SRCFILES=adjustbox.dtx adjustbox.ins README Makefile

all: unpack doc

package: unpack
class: unpack

${PACKEDFILES}: adjustbox.dtx adjustbox.ins
	yes | pdflatex adjustbox.ins

unpack: ${PACKEDFILES}

# 'doc' and 'adjustbox.pdf' call itself until everything is stable
doc: adjustbox.pdf
	@${MAKE} --no-print-directory adjustbox.pdf

pdfopt: doc
	@-pdfopt adjustbox.pdf .temp.pdf && mv .temp.pdf adjustbox.pdf

adjustbox.pdf: adjustbox.dtx adjustbox.gls adjustbox.ind
	${LATEXMK} adjustbox.dtx

adjustbox.idx adjustbox.glo: adjustbox.dtx
	${LATEXMK} adjustbox.dtx

adjustbox.ind: adjustbox.idx
	-makeindex -s gind.ist -o "$@" "$<"

adjustbox.gls: adjustbox.glo
	-makeindex -s gglo.ist -o "$@" "$<"

.PHONY: test

test: unpack
	for T in test*.tex; do echo "$$T"; pdflatex -interaction=batchmode $$T && echo "OK" || echo "Failure"; done

clean:
	-latexmk -C adjustbox.dtx
	${RM} ${PACKEDFILES} *.zip *.log *.aux *.toc *.vrb *.nav *.pdf *.snm *.out *.fdb_latexmk *.glo *.gls *.hd *.sta *.stp
	${RMDIR} tds

install: unpack doc ${INSTALLDIR} ${DOCINSTALLDIR}
	${CP} ${PACKEDFILES} ${INSTALLDIR}
	${CP} ${DOCFILES} ${DOCINSTALLDIR}
	texhash ${TEXMF}

${INSTALLDIR}:
	mkdir -p $@

${DOCINSTALLDIR}:
	mkdir -p $@

ctanify: ${SRCFILES} ${DOCFILES} adjustbox.tds.zip
	${RM} adjustbox.zip
	zip adjustbox.zip $^ 
	unzip -t adjustbox.zip
	unzip -t adjustbox.tds.zip

zip: adjustbox.zip

tdszip: adjustbox.tds.zip

adjustbox.zip: ${SRCFILES} ${DOCFILES} | pdfopt
	${RM} $@
	zip $@ $^ 

adjustbox.tds.zip: ${SRCFILES} ${PACKEDFILES} ${DOCFILES} | pdfopt
	${RMDIR} tds
	mkdir -p tds/tex/latex/adjustbox
	mkdir -p tds/doc/latex/adjustbox
	mkdir -p tds/source/latex/adjustbox
	${CP} ${DOCFILES}    tds/doc/latex/adjustbox
	${CP} ${PACKEDFILES} tds/tex/latex/adjustbox
	${CP} ${SRCFILES}    tds/source/latex/adjustbox
	cd tds; zip -r ../$@ .

