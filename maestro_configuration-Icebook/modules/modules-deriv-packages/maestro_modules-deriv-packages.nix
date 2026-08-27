{ pkgs, ... }: {
  imports = [
    ./fptn-vpn-cli.nix
    ./SDL_GameControllerDB.nix
    #./fptn-vpn-gui.nix
  ];
  environment.systemPackages = [
    #(pkgs.callPackage ./lfff-gui.nix { })
    #(pkgs.callPackage ./helium-browser.nix { })
    #(pkgs.callPackage ./fptn-vpn-gui.nix { })
    
  ];
}
