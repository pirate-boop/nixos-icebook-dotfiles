# === system-info-ctrl/kill9.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kill9";
      runtimeInputs = [ pkgs.procps ];
      text = ''
        exec kill -9 "$@"
      '';
    })
  ];
}
