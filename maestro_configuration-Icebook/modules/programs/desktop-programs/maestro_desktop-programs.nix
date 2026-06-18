{ ... }: {
  imports = [
    ./amnezia-vpn.nix
    #./program.yazi.plugins.nix
    #./zoom-program.nix
    ./flatpak.nix
    ./fptn-vpn-cli.nix
    ./throne-vpn.nix
  ];
}
