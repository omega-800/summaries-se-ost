#!/usr/bin/env bash

[ -z "$1" ] && printf "Usage: todos <semester>" && exit 1
while read -r line; do
  dir="''${line/info.typ/}"
  rg todo "$dir" -I 
done <<< $(rg "$1" . -g 'info.typ' -l)
