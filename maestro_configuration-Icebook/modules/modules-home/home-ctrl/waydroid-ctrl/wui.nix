{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "wui";
      runtimeInputs = [ pkgs.waydroid ];
      text = ''
        exec waydroid show-full-ui
      '';
    })
  ];
}
