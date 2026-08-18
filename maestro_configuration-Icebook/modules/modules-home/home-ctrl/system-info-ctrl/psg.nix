# === system-info-ctrl/psg.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "psg";
      runtimeInputs = [ pkgs.procps pkgs.gnugrep ];
      text = ''
        ps aux | grep --color=auto "$@"
      '';
    })
  ];
}
