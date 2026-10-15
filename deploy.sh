#!/bin/bash
# Build the resume and push the artifacts to the gh-pages branch.
# Fails loudly — a half-successful deploy is worse than a failed one.
set -euo pipefail

# Fetch the gh-pages ref so the worktree can attach (actions/checkout only
# fetches the branch being built).
git fetch origin gh-pages
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

if [ ! -d "gh-pages" ]; then
    mkdir -p gh-pages
    git worktree add gh-pages origin/gh-pages
fi

# Branch name: CI runs from a detached HEAD, so fall back to the pushed ref.
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" = "HEAD" ]; then
    CURRENT_BRANCH=$(git rev-parse --short HEAD)
    if [ "$GITHUB_REF" = "refs/heads/master" ]; then
        CURRENT_BRANCH="master"
    fi
fi

OUTPUT_FILENAME_HTML="Resume-${CURRENT_BRANCH}.html"
OUTPUT_FILENAME_PDF="Mike-Lyons-Resume-${CURRENT_BRANCH}.pdf"

if [ "$CURRENT_BRANCH" = "master" ]; then
    OUTPUT_FILENAME_HTML="index.html"
    OUTPUT_FILENAME_PDF="Mike-Lyons-Resume.pdf"
fi

echo "$OUTPUT_FILENAME_HTML"
echo "$OUTPUT_FILENAME_PDF"

make pdf_make html_browser

# Sanity-check the build before publishing anything.
[ -s "dist/Resume.pdf" ] || { echo "deploy: dist/Resume.pdf missing or empty" >&2; exit 1; }
[ -s "dist/ResumeBrowser.html" ] || { echo "deploy: dist/ResumeBrowser.html missing or empty" >&2; exit 1; }

cp dist/Resume.pdf "gh-pages/$OUTPUT_FILENAME_PDF"
sed -e "s/Resume.pdf/${OUTPUT_FILENAME_PDF}/g" dist/ResumeBrowser.html > dist/ResumeBrowserLink.html
cp dist/ResumeBrowserLink.html "gh-pages/$OUTPUT_FILENAME_HTML"
cp dist/*.js gh-pages/

cd gh-pages
git add .
if git diff --cached --quiet; then
    echo "no changes to deploy"
else
    git commit -m "Automated Deploy"
    git push origin HEAD:gh-pages
fi
