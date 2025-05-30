#!/usr/bin/env bash
set -euo pipefail

# Builds full repo in clean chroot. Requires devtools package.
# The completed package repository is placed in repo/ directory.
PKGS=(
	sdk openlibm libcxx fast_float
	bzip2 zlib xz zstd libarchive libdeflate
	libressl
	libevent libiconv libfribidi libpsl
	libconfig json-c tinyxml2 libxml2 expat jansson
	miniupnpc
	file
	sqlite libmicrohttpd libmicrodns
	libnfs libsmb2 libssh2
	libpng libjpeg-turbo libwebp giflib
	freetype harfbuzz fontconfig
	libsamplerate libsodium libogg libvorbis flac opus
	mpg123 lame libmad a52dec faad2 libsndfile
	libass
	libvpx libmpeg2 libtheora
	enet glm
	SDL2 SDL2_mixer SDL2_ttf SDL2_image SDL2_net SDL2_gfx
	imgui lua luajit curl ffmpeg SDL2_kitchensink
	elfldr shsrv klogsrv ftpsrv gdbsrv websrv
	offact lakesnes fbneo eduke32 scummvm mednafen lbreakouthd
	#devilutionx
)

mkdir -p repo chroot
repo-add repo/ps5-payload-dev.db.tar.gz
mkarchroot -M makepkg.conf chroot/root base-devel || echo skipping mkarchroot
for pkg in "${PKGS[@]}"; do
	pushd $pkg
	makechrootpkg -r ../chroot -- -cisr
	repo-add ../repo/ps5-payload-dev.db.tar.gz *.pkg.tar.gz
	mv *.pkg.tar.gz ../repo/
	popd
done
