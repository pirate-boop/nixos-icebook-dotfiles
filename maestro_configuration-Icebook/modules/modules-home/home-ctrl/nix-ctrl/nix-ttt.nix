{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "nix-ttt";
      runtimeInputs = [ pkgs.coreutils ];
      text = ''
        cd /etc/nixos && exec ttt
      '';
    })
  ];
}
