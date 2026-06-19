{ ... }: {
  imports = [
    ./amnezia-vpn.nix
    #./program.yazi.plugins.nix
    #./zoom-program.nix
    ./flatpak.nix
    ./fptn-vpn-cli.nix
    ./throne-vpn.nix
    ./gnunet.nix
    #./v2raya-tproxy.nix
  ];
}
