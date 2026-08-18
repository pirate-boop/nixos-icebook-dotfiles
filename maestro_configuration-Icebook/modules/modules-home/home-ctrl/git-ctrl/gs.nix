# === modules-home/home-ctrl/git-ctrl/gs.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "gs";
      runtimeInputs = [ pkgs.git ];
      text = ''
        exec git status
      '';
    })
  ];
}
