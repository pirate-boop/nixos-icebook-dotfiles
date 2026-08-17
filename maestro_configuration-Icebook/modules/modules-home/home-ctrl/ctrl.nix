{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ctrl";
      text = ''
        echo "nix-ctrl"
        echo "jj-ctrl"
      '';
    })
  ];
}
