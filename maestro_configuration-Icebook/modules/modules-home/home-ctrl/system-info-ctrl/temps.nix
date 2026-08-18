# === system-info-ctrl/temps.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "temps";
      runtimeInputs = [ pkgs.procps pkgs.lm_sensors ];
      text = ''
        exec watch -n 2 sensors
      '';
    })
  ];
}
