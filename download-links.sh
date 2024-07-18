#!/usr/bin/env bash

which wget >/dev/null

DOWNLOADS_ROOT="./tmp"

while read url; do
	filename="${url##*/}"
	echo "${url}"
	echo "${filename}"
	wget "${url}" -O "${DOWNLOADS_ROOT}/${filename}"
done <links.txt


