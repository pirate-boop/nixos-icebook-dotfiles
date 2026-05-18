{ inputs, pkgs, config, ... }: {
  imports = [
    ./home-programs/maestro_home-programs.nix
    ./home-xdg/maestro_home-xdg.nix
    ./home-xdg.defaultApplications/maestro_home-xdg.defaultApplications.nix
    ./home-services/maestro_home-services.nix
    ./home-symlinks/maestro_home-symlinks.nix
    ./home-variables/maestro_home-variables.nix
  ];

  home.username      = "kori";
  home.homeDirectory = "/home/kori";
  home.stateVersion  = "25.11";
  home.packages      = [];
  programs.home-manager.enable = true;
}
