{ pkgs, ... }:

let
  fptn = pkgs.callPackage ./fptn-vpn.nix { };
in
fptn // {
  environment.systemPackages = fptn.environment.systemPackages ++ [
    (pkgs.callPackage ./zen-browser.nix { })
    (pkgs.callPackage ./noutube-desktop.nix { })
    (pkgs.callPackage ./onlyoffice.nix { })
  ];
}
