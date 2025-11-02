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

      typixPkgs =
        pkgs:
        let
          typixLib = typix.lib.${pkgs.system};
          fs = pkgs.lib.fileset;
          sources = pkgs.lib.pipe ./. [
            (fs.fileFilter (f: f.name == "doc.typ"))
            fs.toList
            (map builtins.toString)
            (map (n: builtins.match ".*/([^/]+/[^/]+.typ)$" n))
            (map (n: builtins.elemAt n 0))
          ];
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
          inherit typixLib commonArgs extraArgs;
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
    };
}
