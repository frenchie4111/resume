default:
	pandoc -c style.css --self-contained -t html5 -o Resume.html Resume.md
	open Resume.html

watch:
	nodemon -x "make default"

pdf:
	pandoc -c style.css --self-contained -t html Resume.md | wkhtmltopdf - Resume.pdf
	open Resume.pdf
