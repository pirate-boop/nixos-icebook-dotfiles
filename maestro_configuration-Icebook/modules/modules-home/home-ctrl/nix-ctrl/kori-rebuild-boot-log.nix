{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kori-rebuild-boot-log";
      text = ''
        exec sudo nixos-rebuild boot --flake "/etc/nixos#$(hostname)" --show-trace
      '';
    })
  ];
}
