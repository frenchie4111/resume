#!/bin/bash

make html_browser pdf_make
cd dist/ && python3 -m http.server
