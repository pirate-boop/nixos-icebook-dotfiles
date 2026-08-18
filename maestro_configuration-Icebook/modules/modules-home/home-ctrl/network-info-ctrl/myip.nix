{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "myip";
      runtimeInputs = [ pkgs.iproute2 pkgs.curl pkgs.coreutils ];
      text = ''
        echo "lan:"
        ip -brief -4 addr
        echo "wan: $(curl -s --max-time 5 https://ifconfig.me)"
      '';
    })
  ];
}
