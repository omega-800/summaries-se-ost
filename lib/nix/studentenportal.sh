#!/usr/bin/env bash

set -eu

show_help() {
  printf "
  Usage: studentenportal [options...]
  -u     update existing
  -p     push new
  "
  exit 0
}

do_update=0
do_post=0
while getopts "u?p?" opt; do
  case "$opt" in
  u)
    do_update=1
    ;;
  p)
    do_post=1
    ;;
  *)
    show_help
    ;;
  esac
done

spapi='https://studentenportal.ch/api/v1/documents'
spapicat='https://studentenportal.ch/api/v1/documentcategories'

urlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for ((pos = 0; pos < strlen; pos++)); do
    c=${string:$pos:1}
    case "$c" in
    [-_.~a-zA-Z0-9]) o="$c" ;;
    *)
      printf -v o '%%%02x' "'$c"
      ;;
    esac
    encoded+="$o"
  done
  echo "$encoded"
}

publish() {
  cmd="$(
    cat <<EOF
curl "$spapi" -XPOST \
    -u"georgiy.shevoroshkin:$(pass school/studentenportal)" \
    -F"name=$(urlencode "$1")" \
    -F"description=$(urlencode "$2")" \
    -F"dtype=$3" \
    -F"category=$5" \
    -F"license=1" \
    -F"public=true" \
    -F"document=@./$4" 
EOF
  )$"
  if [ "$do_post" = 1 ]; then
    # exec "$cmd"
    printf "Published: %s\n" "$1"
  else
    printf "Would publish: %s\n" "$1"
  fi
}

update() {
  cmd="$(
    cat <<EOF
curl "$spapi/$6" -XPATCH \
    -u"georgiy.shevoroshkin:$(pass school/studentenportal)" \
    -F"name=$(urlencode "$1")" \
    -F"description=$(urlencode "$2")" \
    -F"dtype=$3" \
    -F"category=$5" \
    -F"license=1" \
    -F"public=true" \
    -F"document=@./$4" 
EOF
  )"
  if [ "$do_update" = 1 ]; then
    # exec "$cmd"
    printf "Updated: %s\n" "$1"
  else
    printf "Would update: %s\n" "$1"
  fi
}

dothething() {
  find . -type f -name 'info.typ' \( -not -path "./template/*" -and -not -path "./EC/*" -and -not -path "./LinAlg/*" \) | while read -r info; do
    local path mod module name semester language
    path="${info:2}"
    mod="${path%/*}"
    module="$(sed -n 's/\s*module:\s*"\(.*\)",/\1/p' "$path")"
    name="$(sed -n 's/\s*name:\s*"\(.*\)",/\1/p' "$path")"
    semester="$(sed -n 's/\s*semester:\s*"\(.*\)",/\1/p' "$path")"
    semester="${semester:0:2} 20${semester:2:2}"
    language="$(sed -n 's/\s*language:\s*"\(.*\)",/\1/p' "$path")"
    language="${language:-de}"
    for t in cs.pdf doc.pdf deck.apkg; do
      local dtype ntype ghurl title desc lfile online online_info mod_online
      lfile="$mod/$t"
      [ -f "$lfile" ] || continue
      printf "[M] %s [F] %s \n" "$mod" "$t"
      dtype=""
      ntype=""
      if [ "$t" = "deck.apkg" ]; then
        dtype="4"
        ntype="Auto-generated anki deck"
      else
        dtype="1"
        if [ "$t" = "cs.pdf" ]; then
          ntype="CheatSheet"
        else
          ntype="Summary Doc"
        fi
      fi
      ghurl="https://www.github.com/omega-800/summaries-se-ost/$lfile"
      desc="$ntype for \"$name\" from $semester. Written in: [$language]. Up-to-date version can be found on github: $ghurl"
      title="$module - $semester - $ntype"
      online="$(curl -sL "$spapi?uploader=5904&name=$(urlencode "$title")" | yq -Pocsv '.results.[0] | [.category, .id]')"
      readarray -d "," -t online_info <<<"$online"
      if [ ${#online_info[@]} = 2 ] && [ "${online_info[0]}" != 'null' ] && [ "${online_info[1]}" != 'null' ]; then
        update "$title" "$desc" "$dtype" "$lfile" "${online_info[0]}" "${online_info[1]}"
      else
        spmod="$(sed -n 's/\s*sp:\s*"\(.*\)",/\1/p' "$path")"
        [ -z "$spmod" ] && spmod="$mod"
        mod_online="$(curl -sL "$spapicat?name=$(urlencode "$spmod")" | yq -Pocsv '.results.[0].id')"
        publish "$title" "$desc" "$dtype" "$lfile" "$mod_online"
      fi
    done
  done
}

dothething
