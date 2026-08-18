{ pkgs, ... }: {
  imports = [
    ./fptn-vpn-cli.nix
    ./SDL_GameControllerDB.nix
  ];
  environment.systemPackages = [
    # Вызываем наш файл как функцию, передавая ему pkgs
    (pkgs.callPackage ./lfff-gui.nix { })
    
    # ... остальные твои пакеты
  ];
}
