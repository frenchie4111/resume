#!/bin/bash

if [ ! -d "gh-pages" ]; then
    mkdir -p gh-pages
    git worktree add gh-pages gh-pages
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

OUTPUT_FILENAME_HTML="Resume-${CURRENT_BRANCH}.html"
OUTPUT_FILENAME_PDF="Mike-Lyons-Resume-${CURRENT_BRANCH}.pdf"

if [ $CURRENT_BRANCH = "master" ]; then
    OUTPUT_FILENAME_HTML="index.html"
    OUTPUT_FILENAME_PDF="Mike-Lyons-Resume.pdf"
fi

echo $OUTPUT_FILENAME_HTML
echo $OUTPUT_FILENAME_PDF

make pdf_make html_browser

cp dist/Resume.pdf gh-pages/$OUTPUT_FILENAME_PDF
cat dist/ResumeBrowser.html | sed -e "s/Resume.pdf/$(OUTPUT_FILENAME_PDF)/g"
cp dist/ResumeBrowser.html gh-pages/$OUTPUT_FILENAME_HTML

cd gh-pages
git add .
git commit -m "Automated Deploy"
git push origin gh-pages
