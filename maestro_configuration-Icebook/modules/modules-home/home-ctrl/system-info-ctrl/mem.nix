# === system-info-ctrl/mem.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "mem";
      runtimeInputs = [ pkgs.procps ];
      text = ''
        exec free -h
      '';
    })
  ];
}
