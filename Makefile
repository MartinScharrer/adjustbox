CONTRIBUTION  = djustbox
NME          = Martin Scharrer
EMIL         = martin@scharrer.me
DIRECTORY     = /mcros/latex/contrib/${CONTRIBUTION}
LICENSE       = free
FREEVERSION   = lppl
CTN_FILE     = ${CONTRIBUTION}.zip
export CONTRIBUTION VERSION NME EMAIL SUMMARY DIRECTORY DONOTANNOUNCE ANNOUNCE NOTES LICENSE FREEVERSION CTAN_FILE


MINDTX       = ${CONTRIBUTION}.dtx
DTXFILES      = ${MINDTX}
INSFILES      = ${CONTRIBUTION}.ins
LTXFILES      = adjustbox.sty trimclip.sty tc-pgf.def tc-dvips.def tc-xetex.def tc-pdftex.def adjcalc.sty adjgrfx.sty
LTXDOCFILES   = ${CONTRIBUTION}.pdf REDME
LTXSRCFILES   = ${DTXFILES} ${INSFILES}
PLINFILES    = #${CONTRIBUTION}.tex
PLINDOCFILES = #${CONTRIBUTION}.?
PLINSRCFILES = #${CONTRIBUTION}.?
GENERICFILES  = #${CONTRIBUTION}.tex
GENDOCFILES   = #${CONTRIBUTION}.?
GENSRCFILES   = #${CONTRIBUTION}.?
SCRIPTFILES   = #${CONTRIBTUION}.pl
SCRDOCFILES   = #${CONTRIBUTION}.?
LLFILES      = ${DTXFILES} ${INSFILES} ${LTXFILES} ${LTXDOCFILES} ${LTXSRCFILES} \
				${PLINFILES} ${PLAINDOCFILES} ${PLAINSRCFILES} \
				${GENERICFILES} ${GENDOCFILES} ${GENSRCFILES} \
				${SCRIPTFILES} ${SCRDOCFILES}
MINFILES     = ${DTXFILES} ${INSFILES} ${LTXFILES}
CTNFILES     = ${DTXFILES} ${INSFILES} ${LTXDOCFILES} ${PLAINDOCFILES} ${GENDOCFILES} ${SCRDOCFILES}

TDSZIP      = ${CONTRIBUTION}.tds.zip

TEXMF       = ${HOME}/texmf
LTXDIR      = ${TEXMF}/tex/ltex/${CONTRIBUTION}/
LTXDOCDIR   = ${TEXMF}/doc/ltex/${CONTRIBUTION}/
LTXSRCDIR   = ${TEXMF}/source/ltex/${CONTRIBUTION}/
GENERICDIR  = ${TEXMF}/tex/generic/${CONTRIBUTION}/
GENDOCDIR   = ${TEXMF}/doc/generic/${CONTRIBUTION}/
GENSRCDIR   = ${TEXMF}/source/generic/${CONTRIBUTION}/
PLINDIR    = ${TEXMF}/tex/plain/${CONTRIBUTION}/
PLINDOCDIR = ${TEXMF}/doc/plain/${CONTRIBUTION}/
PLINSRCDIR = ${TEXMF}/source/plain/${CONTRIBUTION}/
SCRIPTDIR   = ${TEXMF}/scripts/${CONTRIBUTION}/
SCRDOCDIR   = ${TEXMF}/doc/support/${CONTRIBUTION}/

TDSDIR   = tds
TDSFILES = ${LTXFILES} ${LTXDOCFILES} ${LTXSRCFILES} \
		   ${PLINFILES} ${PLAINDOCFILES} ${PLAINSRCFILES} \
		   ${GENERICFILES} ${GENDOCFILES} ${GENSRCFILES} \
		   ${SCRIPTFILES} ${SCRDOCFILES}

BUILDDIR = build

LTEXMK  = latexmk -pdf -quiet
ZIP      = zip -r
WEBBROWSER = firefox
GETVERSION = $(strip $(shell grep '=\*VERSION' -1 ${MAINDTX} | tail -n1))

UXEXTS  = .aux .bbl .blg .cod .exa .fdb_latexmk .glo .gls .lof .log .lot .out .pdf .que .run.xml .sta .stp .svn .svt .toc
CLENFILES = $(addprefix ${CONTRIBUTION}, ${AUXEXTS})

.PHONY: ll doc clean distclean

ll: doc

doc: ${CONTRIBUTION}.pdf

${CONTRIBUTION}.pdf: ${DTXFILES} REDME ${INSFILES} ${LTXFILES}
	${MKE} --no-print-directory build
	cp "${BUILDDIR}/$@" "$@"

ifneq (${BUILDDIR},build)
build: ${BUILDDIR}
endif

${BUILDDIR}: ${MINFILES}
	-mkdir ${BUILDDIR} 2>/dev/null || true
	cp ${MINFILES} README ${BUILDDIR}/
	$(forech DTX,${DTXFILES}, tex '\input ydocincl\relax\includefiles{${DTX}}{${BUILDDIR}/${DTX}}' && rm -f ydocincl.log;)
	cd ${BUILDDIR}; $(forech INS, ${INSFILES}, tex ${INS};)
	cd ${BUILDDIR}; $(forech DTX, ${MAINDTX}, ${LATEXMK} ${DTX};)
	touch ${BUILDDIR}

$(ddprefix ${BUILDDIR}/,$(sort ${TDSFILES} ${CTANFILES})): ${MAINFILES}
	${MKE} --no-print-directory build

clen:
	ltexmk -C ${CONTRIBUTION}.dtx
	${RM} ${CLENFILES}
	${RM} -r ${BUILDDIR} ${TDSDIR} ${TDSZIP} ${CTN_FILE}


distclen:
	ltexmk -c ${CONTRIBUTION}.dtx
	${RM} ${CLENFILES}
	${RM} -r ${BUILDDIR} ${TDSDIR}


instll: $(addprefix ${BUILDDIR}/,${TDSFILES})
ifneq ($(strip $(LTXFILES)),)
	test -d "${LTXDIR}" || mkdir -p "${LTXDIR}"
	cd ${BUILDDIR} && cp ${LTXFILES} "$(bspath ${LTXDIR})"
endif
ifneq ($(strip $(LTXSRCFILES)),)
	test -d "${LTXSRCDIR}" || mkdir -p "${LTXSRCDIR}"
	cd ${BUILDDIR} && cp ${LTXSRCFILES} "$(bspath ${LTXSRCDIR})"
endif
ifneq ($(strip $(LTXDOCFILES)),)
	test -d "${LTXDOCDIR}" || mkdir -p "${LTXDOCDIR}"
	cd ${BUILDDIR} && cp ${LTXDOCFILES} "$(bspath ${LTXDOCDIR})"
endif
ifneq ($(strip $(GENERICFILES)),)
	test -d "${GENERICDIR}" || mkdir -p "${GENERICDIR}"
	cd ${BUILDDIR} && cp ${GENERICFILES} "$(bspath ${GENERICDIR})"
endif
ifneq ($(strip $(GENSRCFILES)),)
	test -d "${GENSRCDIR}" || mkdir -p "${GENSRCDIR}"
	cd ${BUILDDIR} && cp ${GENSRCFILES} "$(bspath ${GENSRCDIR})"
endif
ifneq ($(strip $(GENDOCFILES)),)
	test -d "${GENDOCDIR}" || mkdir -p "${GENDOCDIR}"
	cd ${BUILDDIR} && cp ${GENDOCFILES} "$(bspath ${GENDOCDIR})"
endif
ifneq ($(strip $(PLINFILES)),)
	test -d "${PLINDIR}" || mkdir -p "${PLAINDIR}"
	cd ${BUILDDIR} && cp ${PLINFILES} "$(abspath ${PLAINDIR})"
endif
ifneq ($(strip $(PLINSRCFILES)),)
	test -d "${PLINSRCDIR}" || mkdir -p "${PLAINSRCDIR}"
	cd ${BUILDDIR} && cp ${PLINSRCFILES} "$(abspath ${PLAINSRCDIR})"
endif
ifneq ($(strip $(PLINDOCFILES)),)
	test -d "${PLINDOCDIR}" || mkdir -p "${PLAINDOCDIR}"
	cd ${BUILDDIR} && cp ${PLINDOCFILES} "$(abspath ${PLAINDOCDIR})"
endif
ifneq ($(strip $(SCRIPTFILES)),)
	test -d "${SCRIPTDIR}" || mkdir -p "${SCRIPTDIR}"
	cd ${BUILDDIR} && cp ${SCRIPTFILES} "$(bspath ${SCRIPTDIR})"
endif
ifneq ($(strip $(SCRDOCFILES)),)
	test -d "${SCRDOCDIR}" || mkdir -p "${SCRDOCDIR}"
	cd ${BUILDDIR} && cp ${SCRDOCFILES} "$(bspath ${SCRDOCDIR})"
endif
	touch ${TEXMF}
	-test -f ${TEXMF}/ls-R && texhsh ${TEXMF} || true


instllsymlinks:
	test -d "${LTXDIR}" || mkdir -p "${LTXDIR}"
	-cd ${LTXDIR} && ${RM} ${LTXFILES}
	ln -s $(bspath ${LTXFILES}) ${LTXDIR}
	-test -f ${TEXMF}/ls-R && texhsh ${TEXMF} || true


uninstll:
	${RM} ${LTXDIR} ${LTXDOCDIR} ${LTXSRCDIR} \
		${GENERICDIR} ${GENDOCDIR} ${GENSRCDIR} \
		${PLINDIR} ${PLAINDOCDIR} ${PLAINSRCDIR} \
		${SCRIPTDIR} ${SCRDOCDIR}
	-test -f ${TEXMF}/ls-R && texhsh ${TEXMF} || true


ifneq (${TDSDIR},tdsdir)
tdsdir: ${TDSDIR}
endif
${TDSDIR}: $(ddprefix ${BUILDDIR}/,${TDSFILES})
	${MKE} --no-print-directory install TEXMF=${TDSDIR}

tdszip: ${TDSZIP}

${TDSZIP}: ${TDSDIR}
	-${RM} $@
	cd ${TDSDIR} && ${ZIP} $(bspath $@) *

zip: ${CTN_FILE}

${CTN_FILE}: $(addprefix ${BUILDDIR}/,${CTANFILES}) ${TDSZIP}
	-${RM} $@
	${ZIP} -j $@ $^

uplod: VERSION = ${GETVERSION}

uplod: ${CTAN_FILE}
	ctnupload -p

webuplod: VERSION = ${GETVERSION}
webuplod: ${CTAN_FILE}
	${WEBBROWSER} 'http://dnte.ctan.org/upload.html?contribution=${CONTRIBUTION}&version=${VERSION}&name=${NAME}&email=${EMAIL}&summary=${SUMMARY}&directory=${DIRECTORY}&DoNotAnnounce=${DONOTANNOUNCE}&announce=${ANNOUNCEMENT}&notes=${NOTES}&license=${LICENSE}&freeversion=${FREEVERSION}' &


