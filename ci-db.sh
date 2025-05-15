#!/usr/bin/env bash

PKGS=(sdk openlibm libcxx fast_float
     )

sudo pacman --noconfirm --remove ps5-payload-dev
mkdir -p repo

for PKG in ${PKGS[*]} ; do
    pushd $PKG || exit 1
    rm -f *.pkg.tar.gz
    rm -rf src pkg
    makepkg -cisf --noconfirm || exit 1
    mv ps5-payload-*.pkg.tar.gz ../repo || exit 1
    popd
done
repo-add repo/ps5-payload-dev.db.tar.gz repo/*.pkg.tar.gz
