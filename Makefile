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
	-t html5

default: html dir
	cat $(SRC)/Header.html $(DIST)/$(OUTPUT_NAME).html > $(DIST)/$(OUTPUT_NAME)Browser.html
	open $(DIST)/$(OUTPUT_NAME)Browser.html

dir:
	mkdir -p $(DIST)

html: dir
	$(PANDOC) $(PANDOC_ARGS) -o $(DIST)/$(OUTPUT_NAME).html $(SRC)/$(INPUT_FILE_NAME)

pdf: html dir
	$(NODE) make_pdf.js $(DIST)/$(OUTPUT_NAME).html $(DIST)/$(OUTPUT_NAME).pdf
	open $(DIST)/$(OUTPUT_NAME).pdf
