{ ... }: {
  imports = [
    ./git-ctrl/maestro_git-ctrl.nix
    ./jj-ctrl/maestro_jj-ctrl.nix
    ./nix-ctrl/maestro_nix-ctrl.nix
    ./ctrl.nix
    ./sync-hash-ctrl/sync-hash-ctrl.nix
    ./network-info-ctrl/maestro_network-info-ctrl.nix
    ./system-info-ctrl/maestro_system-info-ctrl.nix
    ./waydroid-ctrl/maestro_waydroid.nix
  ];
}
