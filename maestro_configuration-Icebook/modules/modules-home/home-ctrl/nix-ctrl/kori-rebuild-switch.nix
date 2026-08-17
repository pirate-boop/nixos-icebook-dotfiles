{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kori-rebuild-switch";
      text = ''
        exec sudo nixos-rebuild switch --flake "/etc/nixos#$(hostname)"
      '';
    })
  ];
}
