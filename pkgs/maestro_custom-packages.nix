{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ../pkgs/zen-browser.nix { })
    (pkgs.callPackage ../pkgs/noutube-desktop.nix { })
    (pkgs.callPackage ../pkgs/onlyoffice.nix { })
  ];
}
