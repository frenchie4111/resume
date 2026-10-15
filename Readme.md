# Resume: MD to PDF

Yet another MD to PDF project. Decided to start a new one because none of the ones I could find
worked the way I wanted.

This project uses pandoc and headless chrome to convert markdown into pdfs. It is designed
to support both an html and pdf version of your resume.

https://resume.mikelyons.org/

It is also intended to support per-company cover letters and resume versions.

## Dependencies

pandoc — install via your package manager (`brew install pandoc` on macOS,
`apt-get install pandoc` on Debian/Ubuntu). Note: pandoc 3.x renamed
`--self-contained` to `--embed-resources`; until the Makefile is updated,
stick to a pandoc 2.x release. The repo's `setup.sh` installs one for you.

Node dependencies — run `setup.sh`, or manually:

```
corepack enable
yarn install
```

`yarn install` also downloads a compatible Chrome build for puppeteer on
first run (see [Puppeteer's docs](https://pptr.dev/)); the PDF build needs
that browser available.

If you want to use `make watch` you will also need python and `nodemon`

```
npm install -g nodemon
```
