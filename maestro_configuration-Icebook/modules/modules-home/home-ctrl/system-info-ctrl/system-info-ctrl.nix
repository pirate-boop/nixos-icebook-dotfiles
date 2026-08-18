{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "system-info-ctrl";
      text = ''
        echo "disk"
        echo "fetch"
        echo "kill9"
        echo "mem"
        echo "ports"
        echo "psg"
        echo "sysinfo"
        echo "temps"
      '';
    })
  ];
}
