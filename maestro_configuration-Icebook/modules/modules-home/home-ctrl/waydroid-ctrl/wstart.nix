{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "wstart";
      runtimeInputs = [ pkgs.waydroid ];
      text = ''
        exec waydroid session start
      '';
    })
  ];
}
