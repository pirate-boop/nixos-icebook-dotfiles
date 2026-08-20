{ ... }: {
  imports = [
    ./configuration.nix
    ./disko.nix
    ./chaotic.nix
    ./home-manager.nix
    ./vivaldi-snapshot
  ];
}
