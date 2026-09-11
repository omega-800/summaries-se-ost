#!/usr/bin/env bash

csrfmiddlewaretoken=''
sessionid=''
csrftoken=''

# TODO:
publish() {
  :
}

# TODO:
update() {
  # 1: rheki
  # 2: 2862
  # 3: RheKI - HS 2025 - Summary Doc
  # 4: Updated versions on github ${url}
  # 5: 1582
  # 6: 1
  # 7: RheKoI/doc.pdf
  # TODO: file gh url
  curl "https://studentenportal.ch/dokumente/$1/$2/edit/" -XPOST \
    -F"csrfmiddlewaretoken=$csrfmiddlewaretoken" \
    -F"name=$3" \
    -F"description=$4" \
    -F"category=$5" \
    -F"dtype=$6" \
    -F"license=1" \
    -F"public=on" \
    -F"document=@$7" \
    -H"Cookie: sessionid=$sessionid; csrftoken=$csrftoken"
  # -H"Content-Type: multipart/form-data"
}

dothething() {
  while read -r info; do
    local path mod smod module name semester language
    path="${info:2}"
    mod="${path%/*}"
    smod="TODO"
    module="$(sed -n 's/\s*module:\s*"\(.*\)",/\1/p')"
    name="$(sed -n 's/\s*name:\s*"\(.*\)",/\1/p')"
    semester="$(sed -n 's/\s*semester:\s*"\(.*\)",/\1/p')"
    language="$(sed -n 's/\s*language:\s*"\(.*\)",/\1/p')"
    language="${language:-de}"
    for t in cs.pdf doc.pdf deck.apkg; do
      local id category dtype type ghurl title desc lfile
      id="TODO"
      category="TODO"
      dtype=""
      type=""
      if [ "$t" = "deck.apkg" ]; then
        dtype="4"
        type="Anki Deck"
      else
        dtype="1"
        if [ "$t" = "cs.pdf" ]; then
          type="Cheatsheet"
        else
          type="Summary Doc"
        fi
      fi
      ghurl="https://www.github.com/omega-800/summaries-se-ost/$t"
      title="$module - $semester - $type"
      desc="$type for \"$name\" from $semester. Written in: [$language]. Up-to-date version can be found on github: $ghurl"
      lfile="$mod/$t"
      if [ "$id" != "" ]; then
        update "$smod" "$id" "$title" "$desc" "$category" "$dtype" "$lfile"
      else
        # publish "$smod" "$id" "$title" "$desc" "$category" "$dtype" "$lfile"
        :
      fi
    done
  done < <(find . -type f -name 'info.typ' -not -path "./template/*")
}
