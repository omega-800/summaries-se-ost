#!/usr/bin/env bash

[ -z "$1" ] && printf "Usage: crop-pdf <infile> <outfile>?" && exit 1

outfile="''${2:-rotated.pdf}"
tmpfile="$(mktemp --suffix .pdf)"

gs                                        \
  -o "$tmpfile"                           \
  -sDEVICE=pdfwrite                       \
  -c "[/CropBox [90 110 540 725]"         \
  -c " /PAGES pdfmark"                    \
  -dFirstPage=2                           \
  -f "$1"

# TODO: how the frick do i do this with ghostscript
pdfjam                                    \
  --nup 2x1 --landscape --suffix 2up      \
  --outfile "$outfile" "$tmpfile"
