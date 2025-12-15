{
  description = "typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
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
            (fs.fileFilter (f: f.name == "doc.typ" || f.name == "cs.typ"))
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
            ;
        in
        {
          default = typixLib.devShell {
            inherit (commonArgs) fontPaths virtualPaths;
            packages = [
              pkgs.typstyle
              watch-all
            ];
          };
        }
      );
      apps = eachSystem (
        pkgs:
        let
          inherit (pkgs.lib) listToAttrs;
          inherit (typixPkgs pkgs)
            names
            typixLib
            commonArgs
            ;
        in
        listToAttrs (
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
        )
      );
    };
}
