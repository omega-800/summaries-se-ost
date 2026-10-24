{
  description = "typst development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    tanki = {
      url = "github:omega-800/tanki";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cntopo = {
      url = "github:omega-800/cntopo-typ";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pt3d = {
      url = "github:omega-800/pt3d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      tanki,
      pre-commit-hooks,
      treefmt-nix,
      self,
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
              overlays = [
                # tanki.overlays.typst-mathml
                tanki.overlays.tanki
                self.overlays.shiroa
              ];
            }
          )
        );
      treefmt = eachSystem (
        pkgs:
        treefmt-nix.lib.evalModule pkgs (_: {
          projectRootFile = "flake.nix";
          programs = {
            typstyle.enable = true;
            # markdown
            mdformat.enable = true;
            # nix
            nixfmt.enable = true;
            statix.enable = true;
            # TODO: plantuml
          };
          settings.formatter.typstyle = {
            wrapText = true;
            lineWidth = 80;
          };
        })
      );
    in
    {
      devShells = eachSystem (pkgs: (import ./lib/nix/typix-lib.nix self pkgs).devShells);

      overlays =
        let
          shiroa = _: prev: {
            # TODO: should only be for x86 as long as not compiled per arch
            inherit (self.packages.${prev.stdenv.hostPlatform.system}) shiroa;
          };
        in
        {
          inherit shiroa;
          default = shiroa;
        };

      packages = nixpkgs.lib.foldr nixpkgs.lib.recursiveUpdate { } [
        (eachSystem (import ./lib/nix/typst-packages.nix self))
        (eachSystem (import ./lib/nix/packages.nix))
        {
          x86_64-linux =
            let
              pkgs = import nixpkgs {
                system = "x86_64-linux";
                config = { };
                overlays = [ ];
              };
              version = "0.4.0-rc2"; # UwU <3
              pname = "shiroa";

              shiroa-pkg = pkgs.stdenv.mkDerivation {
                inherit version pname;
                src = pkgs.fetchurl {
                  url = "https://github.com/Myriad-Dreamin/${pname}/releases/download/v${version}/shiroa-x86_64-unknown-linux-gnu.tar.gz";
                  sha256 = "sha256-NjdYpnR+6s22OGNNzO4Xe7nMjS6DAbxuwdSPokF5Lw8=";
                };
                dontConfigure = true;
                dontBuild = true;
                dontFixup = true;
                unpackPhase = ''
                  tar -xzf "$src"
                '';
                installPhase = ''
                  mkdir -p "$out/bin"
                  file="$(find . -type f -name ${pname} -exec grep -rIL . "{}" \;)"
                  if [ -e "$file" ]; then
                    cp "$file" "$out/bin"
                  else
                    printf "no binary found"
                    exit 1
                  fi
                '';
              };
              shiroa = pkgs.buildFHSEnv {
                name = "shiroa";
                runScript = "${shiroa-pkg}/bin/shiroa";
              };
            in
            {
              inherit shiroa;
              default = shiroa;
              # a wrapper over a wrapper of a wrapper -- nice
              shiroa-wrapped = pkgs.writeShellApplication {
                name = "shiroa";
                text = ''
                  TYPST_PACKAGE_PATH="${
                    import ./lib/nix/unpublished-typst-deps.nix self pkgs
                  }" ${shiroa}/bin/shiroa "$@"
                '';
              };
            };
        }
      ];

      apps = eachSystem (
        pkgs:
        pkgs.lib.mapAttrs (_: drv: {
          type = "app";
          program = "${drv}${drv.passthru.exePath or "/bin/${drv.pname or drv.name}"}";
        }) self.packages.${pkgs.stdenv.hostPlatform.system}
      );

      formatter = eachSystem (pkgs: treefmt.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);

      checks = eachSystem (pkgs: {
        pre-commit-check = pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
          # TODO: filter src
          src = ./.;
          hooks = {
            treefmt = {
              enable = true;
              packageOverrides.treefmt = self.formatter.${pkgs.stdenv.hostPlatform.system};
            };
          };
        };
      });

      # githubActions = nix-github-actions.lib.mkGithubMatrix {
      #   checks =
      #     let
      #       onlySupported = nixpkgs.lib.getAttrs [
      #         "x86_64-linux"
      #         # TODO: typix support
      #         # "aarch64-darwin"
      #       ];
      #     in
      #     (onlySupported self.checks) // (onlySupported self.packages);
      # };
    };
}
