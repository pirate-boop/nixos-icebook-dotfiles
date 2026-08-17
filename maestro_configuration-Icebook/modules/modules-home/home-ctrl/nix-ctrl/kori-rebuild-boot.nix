{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kori-rebuild-boot";
      text = ''
        exec sudo nixos-rebuild boot --flake "/etc/nixos#$(hostname)"
      '';
    })
  ];
}
