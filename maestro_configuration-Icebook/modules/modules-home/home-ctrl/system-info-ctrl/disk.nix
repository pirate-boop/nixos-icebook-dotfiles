# === system-info-ctrl/disk.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "disk";
      runtimeInputs = [ pkgs.uutils-coreutils ];
      text = ''
        exec df -h
      '';
    })
  ];
}
