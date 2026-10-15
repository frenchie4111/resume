#!/usr/bin/env bash
# Install system + node dependencies for building the resume.

# pandoc: any 2.x works (the Makefile uses --self-contained, which pandoc 3.x
# renamed to --embed-resources — don't jump to 3.x without updating the Makefile).
if [ "$(uname)" == "Darwin" ]; then
    brew install pandoc
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get update
    sudo apt-get install -y pandoc
fi

corepack enable
yarn install

# For `make watch` only
npm install -g nodemon
