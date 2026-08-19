{ pkgs, ... }: {
  imports = [
    ./fptn-vpn-cli.nix
    ./SDL_GameControllerDB.nix
    #./fptn-vpn-gui.nix
  ];
  environment.systemPackages = [
    # Вызываем наш файл как функцию, передавая ему pkgs
    (pkgs.callPackage ./lfff-gui.nix { })
    (pkgs.callPackage ./modules-deriv-packages/fptn-vpn-gui.nix { })
    
  ];
}
