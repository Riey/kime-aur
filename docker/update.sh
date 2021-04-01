#!/bin/bash

function setsrcinfo() {
    cd $1
    makepkg -g | python ../replace.py
    cat PKGBUILD.replace
    mv PKGBUILD.replace PKGBUILD
    makepkg --nobuild --noconfirm
    makepkg --printsrcinfo > ./.SRCINFO
    cd ..
}

setsrcinfo kime
setsrcinfo kime-bin
setsrcinfo kime-git

