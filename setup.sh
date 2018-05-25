#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    brew cask install pandoc
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    wget https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-1-amd64.deb
    sudo dpkg -i pandoc-2.2.1-1-amd64.deb
    rm pandoc-2.2.1-1-amd64.deb
fi

npm install -g nodemon
npm installs
