{ ... }: {
  imports = [
    ./system-tools-options/maestro_system-tools-options.nix
    ./gaming-options/maestro_gaming-options.nix
    ./desktop-options/maestro_desktop-options.nix
    ./services-options/maestro_services-options.nix
    ./wm-options/maestro_wm-options.nix
    ./sddm-options/maestro_sddm-options.nix
  ];
}
