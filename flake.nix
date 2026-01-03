{
  description = "typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typ2anki = {
      url = "github:sgomezsal/typ2anki";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      typ2anki,
      typix,
      ...
    }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [ ];
            }
          )
        );
      mkApp = drv: {
        type = "app";
        program = "${drv}${drv.passthru.exePath or "/bin/${drv.pname or drv.name}"}";
      };
      inherit (builtins) toString match elemAt;

      typixPkgs =
        pkgs:
        let
          typixLib = typix.lib.${pkgs.system};
          fs = pkgs.lib.fileset;
          sources = pkgs.lib.pipe ./. [
            (fs.fileFilter (f: f.name == "doc.typ" || f.name == "anki.typ" || f.name == "cs.typ"))
            fs.toList
            (map toString)
            (map (n: match ".*/([^/]+/[^/]+.typ)$" n))
            (map (n: elemAt n 0))
          ];
          names = map (s: builtins.split "/" (elemAt (match "([^/]+/.*)\\.typ$" s) 0)) sources;
          watchScriptsPerDoc = map (
            typstSource:
            typixLib.watchTypstProject (
              commonArgs
              // {
                inherit typstSource;
                typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
              }
            )
          ) sources;
          commonArgs = {
            typstOpts.root = ".";
            typstSource = "lib.typ";
            fontPaths = with pkgs; [
              "${nerd-fonts.jetbrains-mono}/share/fonts/truetype"
              "${fira-math}/share/fonts/opentype"
              "${fira-code}/share/fonts/truetype"
              "${nerd-fonts.arimo}/share/fonts/truetype"
            ];
            virtualPaths = [ ];
          };
          extraArgs = {
            src = typixLib.cleanTypstSource ./.;
            unstable_typstPackages = [
              # fletcher
              {
                name = "fletcher";
                version = "0.5.5";
                hash = "sha256-DeGisO6kYJShHkq4QZ60pFliyGtQd4/KOocToy2Om0k=";
              }
              {
                name = "cetz";
                version = "0.3.2";
                hash = "sha256-3Abz+31Y61rZUnnKlXayqIsEYEOaD47BQPUMwm0i0xA=";
              }
              {
                name = "oxifmt";
                version = "0.2.1";
                hash = "sha256-8PNPa9TGFybMZ1uuJwb5ET0WGIInmIgg8h24BmdfxlU=";
              }
              # typ2anki
              {
                name = "typ2anki";
                version = "0.1.0";
                hash = "sha256-qnYdimAUN5oDIb1b88XX3jsyF/XFq6Igt0AgoqEckLE=";
              }
              {
                name = "gentle-clues";
                version = "1.1.0";
                hash = "sha256-K6oZrb6GUevmEewHYGMC5DNbD3/xQHp46LOnzvt0HDY=";
              }
              {
                name = "linguify";
                version = "0.4.0";
                hash = "sha256-jQRIISzaoplQbeVgAJiQLT82Ee2zzDjmuLiNGAhs7f0=";
              }
              # muchpdf
              {
                name = "muchpdf";
                version = "0.1.2";
                hash = "sha256-dZTw44SVRqAM7QsncwBFSV/W8QY15cnl211ZXV35RPU=";
              }
            ];
          };
        in
        {
          inherit
            typixLib
            commonArgs
            extraArgs
            names
            ;
          build-drv = typixLib.buildTypstProject (commonArgs // extraArgs);
          build-script = typixLib.buildTypstProjectLocal (commonArgs // extraArgs);
          watch-script = typixLib.watchTypstProject commonArgs;
          watch-all = pkgs.writeShellApplication {
            text = "(trap 'kill 0' SIGINT; ${
              pkgs.lib.concatMapStringsSep " & " (s: "${s}/bin/typst-watch") watchScriptsPerDoc
            })";
            name = "typst-watch-all";
          };
          crop-pdf = pkgs.writeShellApplication {
            text = ''
              [ -z "$1" ] && printf "Usage: crop-pdf <infile> <outfile>?" && exit 1

              echo "$2"

              outfile="''${2:-rotated.pdf}"
              tmpfile="$(mktemp --suffix .pdf)"

              ${pkgs.ghostscript}/bin/gs        \
                -o "$tmpfile"                   \
                -sDEVICE=pdfwrite               \
                -c "[/CropBox [90 110 540 725]" \
                -c " /PAGES pdfmark"            \
                -dFirstPage=2                   \
                -f "$1"

              # TODO: how the frick do i do this with ghostscript
              ${pkgs.texlivePackages.pdfjam}/bin/pdfjam --nup 2x1 --landscape --suffix 2up --outfile "$outfile" "$tmpfile"
            '';
            name = "crop-pdf";
          };
        };
    in
    {
      devShells = eachSystem (
        pkgs:
        let
          inherit (typixPkgs pkgs)
            commonArgs
            watch-all
            typixLib
            build-script
            ;
        in
        {
          default = typixLib.devShell {
            inherit (commonArgs) fontPaths virtualPaths;
            packages = [
              (pkgs.rustPlatform.buildRustPackage (
                let
                  pname = "typ2anki";
                  version = "1.0.8";
                in
                {
                  inherit pname version;
                  src = pkgs.fetchCrate {
                    inherit pname version;
                    sha256 = "sha256-8vSrLP/dgzo71dQsaI4id006HpP+8JY5vnAZgypGD7M=";
                  };
                  cargoHash = "sha256-4s1hp+UxBkNqG9yLTzg7/OAu/mYhSSSjQIUmDHlOEy0=";
                }
              ))
              # TODO: PR
              # typ2anki.packages.${pkgs.system}.default
              pkgs.typstyle
              watch-all
              build-script
            ];
          };
        }
      );
      # FIXME: include typst deps in watch-open scripts
      apps = eachSystem (
        pkgs:
        let
          inherit (pkgs.lib) listToAttrs;
          inherit (typixPkgs pkgs)
            names
            typixLib
            commonArgs
            crop-pdf
            ;
        in
        {
          crop-pdf = mkApp crop-pdf;
        }
        // (listToAttrs (
          map (
            path:
            let
              type = elemAt path 2;
              dir = elemAt path 0;
              name = dir + (if type == "doc" then "" else "-${type}");
              pname = "watch-open-${name}";

              typstSource = "${dir}/${type}.typ";
              typstOutput = "${dir}/${type}.pdf";
            in
            {
              inherit name;
              value = mkApp (
                pkgs.writeShellApplication {
                  text = "${pkgs.writeShellScript pname ''
                    ${pkgs.zathura}/bin/zathura "${typstOutput}" &
                    ${
                      typixLib.watchTypstProject (
                        commonArgs
                        // {
                          inherit typstSource typstOutput;
                        }
                      )
                    }/bin/typst-watch
                  ''}";
                  name = pname;
                }
              );
            }
          ) names
        ))
      );
    };
}
