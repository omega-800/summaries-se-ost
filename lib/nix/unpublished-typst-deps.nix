self: pkgs:
let
  inherit (self.inputs)
    pt3d
    cntopo
    tanki
    mltyp
    ;
in
pkgs.lib.escapeShellArg "${pkgs.linkFarm "unpublished-typst-packages" {
  "local/pt3d/0.0.1" = pt3d;
  "local/cntopo/0.1.0" = cntopo;
  "local/tanki/0.0.1" = tanki;
  "local/mltyp/0.1.0" = mltyp;
}}"
