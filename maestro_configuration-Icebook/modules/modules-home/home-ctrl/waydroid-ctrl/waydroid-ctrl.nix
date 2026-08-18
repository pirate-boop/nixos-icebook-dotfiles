{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "waydroid-ctrl";
      text = ''
        echo "wstart"
        echo "wstop"
        echo "wui"
      '';
    })
  ];
}
