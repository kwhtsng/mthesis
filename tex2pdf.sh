#!/bin/sh

file="*.tex"

if [ -f $file ];
then
	cat <<- EOS > .latexmkrc
	#!/usr/bin/env perl
	\$pdf_mode         = 3;
	\$latex            = 'platex -halt-on-error';
	\$latex_silent     = 'platex -halt-on-error -interaction=batchmode';
	\$bibtex           = 'pbibtex';
	\$dvipdf           = 'dvipdfmx %O -o %D %S';
	\$makeindex        = 'mendex %O -o %D %S';
	EOS
	docker run --rm -v $(pwd):/workdir paperist/alpine-texlive-ja \
		sh -c "latexmk -C $1 && latexmk $1 && latexmk -c $1"
    rm -f *.dvi .latexmkrc

else
	echo ".texファイルが存在しません。"
fi
