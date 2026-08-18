# === system-info-ctrl/ports.nix ===
{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ports";
      runtimeInputs = [ pkgs.iproute2 ];
      text = ''
        exec ss -tulnp
      '';
    })
  ];
}
