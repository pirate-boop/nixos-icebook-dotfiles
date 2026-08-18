{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "ping8";
      runtimeInputs = [ pkgs.iputils ];
      text = ''
        exec ping 8.8.8.8
      '';
    })
  ];
}
