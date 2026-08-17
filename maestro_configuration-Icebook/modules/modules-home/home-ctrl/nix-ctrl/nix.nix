{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "nix";
      runtimeInputs = [ pkgs.coreutils ];
      text = ''
        cd /etc/nixos && exec "$SHELL"
      '';
    })
  ];
}
