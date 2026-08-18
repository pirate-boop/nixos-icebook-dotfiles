{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "wstop";
      runtimeInputs = [ pkgs.waydroid ];
      text = ''
        exec waydroid session stop
      '';
    })
  ];
}
