#!/usr/bin/env zsh

[ -z "$1" ] && printf "Usage: init-semester <infile>" && exit 1
while read -r line; do
  parts=(''${(@s:|:)line})
  mkdir "''${parts[2]:2}"
  cat << EOF > "''${parts[2]:2}/info.typ"
#let info = (
  module: "''${parts[2]:2}",
  name: "''${parts[1]}",
  semester: "HS26",
  language: "en",
)
EOF
done < "$1"
