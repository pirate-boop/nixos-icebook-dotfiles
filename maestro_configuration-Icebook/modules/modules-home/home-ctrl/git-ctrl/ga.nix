# === modules-home/home-ctrl/git-ctrl/ga.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ga";
      runtimeInputs = [ pkgs.git ];
      text = ''
        exec git add -A
      '';
    })
  ];
}
