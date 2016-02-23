
.PHONY: all clean publish

all: raumplan.pdf raumplan.moin

raumplan.moin: raumliste.mkd
	sed -r "s/\|/||/g; s/\^\[([^)]+)\]/<<FootNote\(\1\)>>/g; /---/d;  s/\*\*/\'\'\'/g;" $< > $@

raumplan.pdf: sandplan.pdf raumliste.pdf
	pdftk $^ cat output $@

sandplan.pdf: sandplan.svg
	inkscape $< -A $@

raumliste.pdf: raumliste.mkd
	pandoc $< -o $@

publish: raumplan.pdf
	scp $< sandbox.fsi.uni-tuebingen.de:public_html/tuebix/

clean: 
	rm -f raumliste.pdf raumplan.moin raumplan.pdf sandplan.pdf

