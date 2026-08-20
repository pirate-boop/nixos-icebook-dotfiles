{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "nconf";
      runtimeInputs = [ pkgs.coreutils ];
      text = ''
        cd /etc/nixos && exec "$SHELL"
      '';
    })
  ];
}
