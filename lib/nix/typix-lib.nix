self: pkgs:
let
  inherit (self.inputs) typix;
  inherit (builtins) match elemAt;

  typixLib = typix.lib.${pkgs.stdenv.hostPlatform.system};
  fs = pkgs.lib.fileset;
  sources = pkgs.lib.pipe ../.. [
    (fs.fileFilter (f: f.name == "doc.typ" || f.name == "deck.typ" || f.name == "cs.typ"))
    fs.toList
    (map toString)
    (builtins.filter (n: !(pkgs.lib.hasInfix "template" n)))
    (map (match ".*/([^/]+/[^/]+.typ)$"))
    (map (pkgs.lib.flip elemAt 0))
  ];
  names = map (s: builtins.split "/" (elemAt (match "([^/]+/.*)\\.typ$" s) 0)) sources;
  fp = pkgs.lib.concatStringsSep ":" commonArgs.fontPaths;

  # TODO: override typst bin with typst-mathml
  commonArgs = {
    typstOpts = {
      root = ".";
      features = "html";
    };
    typstSource = "lib.typ";
    fontPaths = with pkgs; [
      "${nerd-fonts.jetbrains-mono}/share/fonts/truetype"
      "${fira-math}/share/fonts/opentype"
      "${fira-code}/share/fonts/truetype"
      "${nerd-fonts.arimo}/share/fonts/truetype"
      # "${texlivePackages.kpfonts}/share/fonts"
      "${xits-math}/share/fonts/opentype"
      "${noto-fonts}/share/fonts/noto"
    ];
    virtualPaths = [ ];
  };

  unpublished-typst-deps = import ./unpublished-typst-deps.nix self pkgs;
  extraArgs = {
    TYPST_PACKAGE_PATH = unpublished-typst-deps;
    # TODO:
    src = # typixLib.cleanTypstSource
      ../..;
    unstable_typstPackages = import ./typst-deps.nix;
  };
  watchArgs = {
    typstWatchCommand = "TYPST_PACKAGE_PATH=${unpublished-typst-deps} typst watch";
  };
in
{
  inherit
    commonArgs
    names
    extraArgs
    watchArgs
    fp
    typixLib
    sources
    ;
  devShells =
    let
      inherit (self.checks.${pkgs.stdenv.hostPlatform.system}) pre-commit-check;
      ds =
        full:
        typixLib.devShell {
          inherit (commonArgs) fontPaths virtualPaths;
          buildInputs = pre-commit-check.enabledPackages;
          inherit (pre-commit-check) shellHook;
          packages = [
            # merged: https://github.com/typst/typst/pull/7436
            # pkgs.typst-mathml
            pkgs.typst
            pkgs.tanki-rs
            pkgs.typstyle
          ]
          ++ (pkgs.lib.optionals full (builtins.attrValues self.packages.${pkgs.stdenv.hostPlatform.system}));

          env.TYPST_PACKAGE_PATH = unpublished-typst-deps;
        };
    in
    {
      full = ds true;
      default = ds false;
    };
}
