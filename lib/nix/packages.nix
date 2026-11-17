pkgs:
let
  wrap =
    path: name: deps:
    pkgs.runCommand name
      {
        nativeBuildInputs = with pkgs; [ makeWrapper ];
      }
      ''
        mkdir -p $out/bin
        install -m +x ${path} $out/bin/${name}
        wrapProgram $out/bin/${name} \
          --prefix PATH : ${pkgs.lib.makeBinPath deps}
      '';
in
{
  crop-pdf = wrap ../scripts/crop-pdf.sh "crop-pdf" (
    with pkgs;
    [
      ghostscript
      texlivePackages.pdfjam
    ]
  );
  init-semester = wrap ../scripts/init-semester.sh "init-semester" [ ];
  todos = wrap ../scripts/todos.sh "todos" [ pkgs.ripgrep ];
  studentenportal = wrap ../scripts/studentenportal.sh "studentenportal" (
    with pkgs;
    [
      curl
      yq-go
    ]
  );
}
