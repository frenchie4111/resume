# Resume: MD to PDF

Yet another MD to PDF project. Decided to start a new one because none of the ones I could find
worked the way I wanted.

This project uses pandoc and headless chrome to convert markdown into pdfs. It is designed
to support both an html and pdf version of your resume.

https://resume.mikelyons.org/

It is also intended to support per-company cover letters and resume versions.

## Dependencies

Install these on your system using your prefered package manager

```
pandoc

```

Install node packages

```
npm install
```

If you want to use `make watch` you will also need python and `nodemon`

```
npm install -g nodemon
```
