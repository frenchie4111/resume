INPUT_FILE_NAME=Resume.md

PANDOC=pandoc
NODE=node

SRC=src
DIST=dist
OUTPUT_NAME=Resume

PANDOC_ARGS=\
	-c $(SRC)/reset.css \
	-c $(SRC)/style.css \
	--section-divs \
	--self-contained \
	-f markdown+fenced_divs \
	-t html5

default: html html_browser pdf_make

dir:
	mkdir -p $(DIST)

mv_scripts: dir
	cp $(SRC)/*.js $(DIST)

html: dir mv_scripts
	$(PANDOC) $(PANDOC_ARGS) -o $(DIST)/$(OUTPUT_NAME).html $(SRC)/$(INPUT_FILE_NAME)

html_browser: html
	cat $(SRC)/Header.html $(DIST)/$(OUTPUT_NAME).html > $(DIST)/$(OUTPUT_NAME)Browser.html

pdf_make: html
	$(NODE) make_pdf.js $(DIST)/$(OUTPUT_NAME).html $(DIST)/$(OUTPUT_NAME).pdf

pdf: pdf_make
	open $(DIST)/$(OUTPUT_NAME).pdf

watch: default
	echo "open http://localhost:8000/$(OUTPUT_NAME)Browser.html"
	nodemon -w src/ -e css,md,html,js -x "/bin/bash build_and_serve.sh"
