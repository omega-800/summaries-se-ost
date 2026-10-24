self: pkgs:
let
  inherit (builtins) elemAt;
  inherit (pkgs.lib) concatMapStringsSep;
  inherit (import ./typix-lib.nix self pkgs)
    commonArgs
    names
    extraArgs
    watchArgs
    fp
    typixLib
    sources
    ;
  unpublished-typst-deps = import ./unpublished-typst-deps.nix self pkgs;
in
{
  # FIXME: refactor this
  # FIXME: include typst deps in watch-open scripts
  watch-script = typixLib.watchTypstProject (commonArgs // watchArgs);
  compile-all = pkgs.writeShellApplication {
    text = "${pkgs.lib.concatMapStringsSep "; " (
      typstSource:
      let
        p = typixLib.buildTypstProjectLocal (
          commonArgs
          // extraArgs
          // {
            inherit typstSource;
            typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
          }
        );
      in
      "echo '--- building ${typstSource} ---'; ${pkgs.lib.getExe p}"
    ) (builtins.filter (s: !(pkgs.lib.hasInfix "deck" s)) sources)}";
    name = "compile-all";
  };
  watch-all = pkgs.writeShellApplication {
    text = "(trap 'kill 0' SIGINT; ${
      pkgs.lib.concatMapStringsSep " & " pkgs.lib.getExe (
        map (
          typstSource:
          typixLib.watchTypstProject (
            commonArgs
            // watchArgs
            // {
              inherit typstSource;
              typstOutput = (pkgs.lib.removeSuffix ".typ" typstSource) + ".pdf";
            }
          )
        ) sources
      )
    })";
    name = "watch-all";
  };
  build-web = pkgs.writeShellApplication {
    text = ''
      export TYPST_FONT_PATHS="${pkgs.lib.escapeShellArg fp}"
      export TYPST_PACKAGE_PATH="${unpublished-typst-deps}"
      export PATH="${pkgs.typst}/bin:$PATH"

      ${
        self.packages.${pkgs.stdenv.hostPlatform.system}.shiroa
      }/bin/shiroa build --path-to-root /summaries-se-ost/ --root . --mode static-html --package-path "${unpublished-typst-deps}"
    '';
    name = "build-web";
  };
  genanki = pkgs.writeShellApplication {
    # imagine being in a contest of most unmaintainable codebase and your opponent is me
    text = concatMapStringsSep "\n" (
      path:
      let
        type = elemAt path 2;
        dir = elemAt path 0;
        typstSource = "${dir}/${type}.typ";
      in
      ''
        export TYPST_FONT_PATHS="${pkgs.lib.escapeShellArg fp}"
        export TYPST_PACKAGE_PATH="${unpublished-typst-deps}"
        export PATH="${pkgs.typst}/bin:$PATH"
        echo "--- generating ${typstSource} ---"
        ${pkgs.tanki-rs}/bin/tanki-rs ${typstSource} --root . 
      ''
    ) (builtins.filter (path: (elemAt path 2) == "deck") names);
    name = "genanki";
  };
}
// (pkgs.lib.listToAttrs (
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
      value = pkgs.writeShellApplication {
        text = ''
          (trap 'kill 0' SIGINT; ${pkgs.zathura}/bin/zathura "${typstOutput}" &
          ${
            typixLib.watchTypstProject (
              commonArgs
              // watchArgs
              // {
                inherit typstSource typstOutput;
              }
            )
          }/bin/typst-watch)
        '';
        name = pname;
      };
    }
  ) names
))
// (pkgs.lib.listToAttrs (
  map (
    path:
    let
      type = elemAt path 2;
      dir = elemAt path 0;
      name = dir + "-apkg";
      pname = "apkg-${name}";

      typstSource = "${dir}/${type}.typ";
    in
    {
      inherit name;
      value = pkgs.writeShellApplication {
        # imagine being in a contest of most hacky codebase and your opponent is me
        text = ''
          TYPST_PACKAGE_PATH=${unpublished-typst-deps} PATH=${pkgs.typst}/bin:$PATH ${pkgs.tanki-rs}/bin/tanki-rs ${typstSource} --root . 
        '';
        name = pname;
      };
    }
  ) (builtins.filter (path: (elemAt path 2) == "deck") names)
))
