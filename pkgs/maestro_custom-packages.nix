{ pkgs, ... }:

{
  imports = [ ./fptn-vpn.nix ];

  environment.systemPackages = [
    (pkgs.callPackage ./zen-browser.nix { })
    (pkgs.callPackage ./noutube-desktop.nix { })
    (pkgs.callPackage ./onlyoffice.nix { })
  ];
}
