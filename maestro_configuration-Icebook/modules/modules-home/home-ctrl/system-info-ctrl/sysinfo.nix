# === system-info-ctrl/sysinfo.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "sysinfo";
      runtimeInputs = [ pkgs.inxi ];
      text = ''
        exec inxi -Fzx
      '';
    })
  ];
}
