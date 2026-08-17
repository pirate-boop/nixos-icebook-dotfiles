{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "kori-rebuild-switch-log";
      text = ''
        exec sudo nixos-rebuild switch --flake "/etc/nixos#$(hostname)" --show-trace
      '';
    })
  ];
}
