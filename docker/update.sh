#!/bin/bash

function setsrcinfo() {
    cd $1
    sed "s/^md5.*/$(makepkg -g)/" -i PKGBUILD
    makepkg --nobuild --noconfirm
    makepkg --printsrcinfo > ./.SRCINFO
    cd ..
}

setsrcinfo kime
setsrcinfo kime-bin
setsrcinfo kime-git

