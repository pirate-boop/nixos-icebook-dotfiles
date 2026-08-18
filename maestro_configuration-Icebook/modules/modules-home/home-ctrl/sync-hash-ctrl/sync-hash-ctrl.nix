# === modules-home/home-ctrl/sync-hash/sync-hash.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "sync-hash";
      runtimeInputs = [ pkgs.coreutils ];
      text = ''
        sha256sum | cut -c1-8
      '';
    })
  ];
}
