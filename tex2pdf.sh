#!/bin/bash

pflag="FALSE"
image="docker run --rm -v $(pwd):/workdir paperist/alpine-texlive-ja"

usage(){
	echo "Usage: $0 [-p] filename(*.tex)" 1>&2
	exit 1
}

while getopts :p:h OPT
do
	case $OPT in
		u)  uflag="TRUE"
			;;
		h)  usage_exit
			;;
        \?) usage_exit
			;;
	esac
done

shift $((OPTIND - 1))

if [ "$pflag" = "TRUE" ];
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
else
	cat <<- EOS > .latexmkrc
	#!/usr/bin/env perl
	\$pdf_mode         = 3;
	\$latex            = 'uplatex -halt-on-error';
	\$latex_silent     = 'uplatex -halt-on-error -interaction=batchmode';
	\$bibtex           = 'upbibtex';
	\$dvipdf           = 'dvipdfmx %O -o %D %S';
	\$makeindex        = 'mendex %O -o %D %S';
	EOS
fi

$image sh -c "latexmk -C $1 && latexmk $1 && latexmk -c $1"

rm -f *.dvi .latexmkrc
