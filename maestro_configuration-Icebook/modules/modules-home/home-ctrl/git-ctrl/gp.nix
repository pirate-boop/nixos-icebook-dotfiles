# === modules-home/home-ctrl/git-ctrl/gp.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "gp";
      runtimeInputs = [ pkgs.git ];
      text = ''
        exec git push origin main
      '';
    })
  ];
}
