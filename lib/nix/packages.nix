pkgs: {
  crop-pdf = pkgs.writeShellApplication {
    text = ''
      [ -z "$1" ] && printf "Usage: crop-pdf <infile> <outfile>?" && exit 1

      outfile="''${2:-rotated.pdf}"
      tmpfile="$(mktemp --suffix .pdf)"

      ${pkgs.ghostscript}/bin/gs                \
        -o "$tmpfile"                           \
        -sDEVICE=pdfwrite                       \
        -c "[/CropBox [90 110 540 725]"         \
        -c " /PAGES pdfmark"                    \
        -dFirstPage=2                           \
        -f "$1"

      # TODO: how the frick do i do this with ghostscript
      ${pkgs.texlivePackages.pdfjam}/bin/pdfjam \
        --nup 2x1 --landscape --suffix 2up      \
        --outfile "$outfile" "$tmpfile"
    '';
    name = "crop-pdf";
  };
  init-semester = pkgs.writeShellApplication {
    # TODO: zsh
    text = ''
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
    '';
    name = "init-semester";
    excludeShellChecks = [
      "SC2034"
      "SC2296"
      "SC2206"
    ];
  };
  todos = pkgs.writeShellApplication {
    text = ''
      [ -z "$1" ] && printf "Usage: todos <semester>" && exit 1
      while read -r line; do
        dir="''${line/info.typ/}"
        rg todo "$dir" -I 
      done <<< $(rg "$1" . -g 'info.typ' -l)
    '';
    name = "todos";
    excludeShellChecks = [ "SC2046" ];
  };
  studentenportal =
    pkgs.runCommand "studentenportal"
      {
        nativeBuildInputs = with pkgs; [ makeWrapper ];
      }
      ''
        mkdir -p $out/bin
        install -m +x ${./studentenportal.sh} $out/bin/studentenportal
        wrapProgram $out/bin/studentenportal \
          --prefix PATH : ${
            pkgs.lib.makeBinPath (
              with pkgs;
              [
                curl
                yq-go
              ]
            )
          }
      '';
}
