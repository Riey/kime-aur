#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: upload.sh <version>"
    exit 0
fi

VER=$1
sed -i "s/pkgver=.*/pkgver=$VER/" ./kime/PKGBUILD
sed -i "s/pkgver=.*/pkgver=$VER/" ./kime-bin/PKGBUILD

function copyfrom() {
    cd $1
    docker cp kime-aur:/home/aur/work/$1/PKGBUILD .
    docker cp kime-aur:/home/aur/work/$1/.SRCINFO .
    git commit -am "$VER" || true
    git push || true
    cd ..
}

docker build --tag kime-aur:latest .
docker rm kime-aur || true
docker run --name kime-aur kime-aur:latest
copyfrom kime
copyfrom kime-bin
copyfrom kime-git
docker rm kime-aur || true

