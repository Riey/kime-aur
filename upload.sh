#!/usr/bin/env bash

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
    if [[ -z "$(git status --porcelain)" ]]; then
        echo Nothing to commit
    else
        git commit -am "$VER" || true
        git push || true
    fi
    cd ..
}

docker build --tag kime-aur:latest .
docker rm kime-aur || true
docker run --name kime-aur kime-aur:latest
copyfrom kime
copyfrom kime-bin
copyfrom kime-git
docker rm kime-aur || true

