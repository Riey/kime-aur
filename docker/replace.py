#!/usr/bin/env python

from sys import stdin
import subprocess

md5 = subprocess.Popen("makepkg -g", shell=True, stdout=subprocess.PIPE)
pkgbuild = open("PKGBUILD", "r")
temp = open("PKGBUILD.replace", "w")

while True:
    line = pkgbuild.readline()

    if not line: break

    if line.startswith('md5'):
        while not ')' in line:
            line = pkgbuild.readline()

        for line in stdin:
            temp.write(line)
        pass
    else:
        temp.write(line)

pkgbuild.close()
temp.close()

