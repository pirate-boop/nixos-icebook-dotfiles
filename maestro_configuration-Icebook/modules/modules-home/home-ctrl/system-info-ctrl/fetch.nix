# === system-info-ctrl/fetch.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "fetch";
      runtimeInputs = [ pkgs.fastfetch ];
      text = ''
        exec fastfetch
      '';
    })
  ];
}
