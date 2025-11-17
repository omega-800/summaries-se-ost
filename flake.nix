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
            (fs.fileFilter (f: f.name == "doc.typ"))
            fs.toList
            (map toString)
            (map (n: match ".*/([^/]+/[^/]+.typ)$" n))
            (map (n: elemAt n 0))
          ];
          names = map (s: elemAt (match "([^/]+)/.*\\.typ$" s) 0) sources;
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
            unstable_typstPackages = [ ];
          };
        in
        {
          inherit typixLib commonArgs extraArgs names;
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
              pkgs.typstfmt
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
            name:
            let
              typstSource = "${name}/doc.typ";
              typstOutput = "${name}/doc.pdf";
            in
            {
              inherit name;
              value = mkApp (
                pkgs.writeShellApplication {
                  text = "${pkgs.writeShellScript "watch-${name}-with-zathura" ''
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
                  name = "typst-watch-open-${name}";
                }
              );
            }
          ) names
        )
      );
    };
}
