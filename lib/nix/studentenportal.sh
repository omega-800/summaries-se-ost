#!/usr/bin/env bash

set -eu

show_help() {
  printf "
  Usage: studentenportal [options...]
  -e              update existing
  -n              push new
  -p <password>   password
  -u <username>   username
  -i <id>         studentenportal id
  -o <url>        base url to original files
  "
  exit 0
}

do_update=0
do_post=0
username=''
password=''
sid=''
origurl=''
while getopts "neu:p:i:o:" opt; do
  case "$opt" in
  u) username="$OPTARG"   ;;
  p) password="$OPTARG"   ;;
  i) sid="$OPTARG"        ;;
  o) origurl="$OPTARG"    ;;
  e) do_update=1          ;;
  n) do_post=1            ;;
  *) show_help            ;;
  esac
done

[ -n "$username" ] && [ -z "$sid" ] && printf "If -u is set then -i must be set as well\n" && exit 1
[ -n "$username" ] && [ -z "$password" ] && printf "If -u is set then -p must be set as well\n" && exit 1
[ -n "$sid" ] && [ -z "$username" ] && printf "If -i is set then -u must be set as well\n" && exit 1

[ $do_update = 0 ] && [ $do_post = 0 ] && printf "Running in test mode (not publishing or updating anything)\n"

[ -z "$username" ] && username="georgiy.shevoroshkin"
[ -z "$sid" ] && sid="5904"
[ -z "$password" ] && password="$(pass school/studentenportal)"
[ -z "$origurl" ] && origurl="https://www.github.com/omega-800/summaries-se-ost"

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
  if [ "$do_post" = 1 ]; then
    curl -sL "$spapi" -XPOST \
      -u"$username:$password" \
      -F"name=$1" \
      -F"description=$2" \
      -F"dtype=$3" \
      -F"category=$5" \
      -F"license=1" \
      -F"public=true" \
      -F"document=@$4" 
    printf "Published: %s\n" "$1"
  else
    printf "Would publish: %s\n" "$1"
  fi
}

update() {
  if [ "$do_update" = 1 ]; then
    curl -sL "$spapi/$6" -XPATCH \
      -u"$username:$password" \
      -F"name=$1" \
      -F"description=$2" \
      -F"dtype=$3" \
      -F"category=$5" \
      -F"license=1" \
      -F"public=true" \
      -F"document=@$4" 
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
      ghurl="$origurl/$lfile"
      desc="$ntype for \"$name\" from $semester. Written in: [$language]. Up-to-date version can be found on github: $ghurl"
      title="$module - $semester - $ntype"
      online="$(curl -sL "$spapi?uploader=$sid&name=$(urlencode "$title")" | yq -Pocsv '.results.[0] | [.category, .id]')"
      readarray -d "," -t online_info <<<"$online"
      if [ ${#online_info[@]} = 2 ] && [ "${online_info[0]}" != 'null' ] && [ "${online_info[1]}" != 'null' ]; then
        update "$title" "$desc" "$dtype" "$lfile" "${online_info[0]}" "$(echo "${online_info[1]}" | tr -d '\n')"
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
