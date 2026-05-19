{ ... }: {
  imports = [
    ./system-tools-programs/maestro_system-tools-programs.nix
    ./gaming-programs/maestro_gaming-programs.nix
    ./desktop-programs/maestro_desktop-programs.nix
    ./services/maestro_services.nix
    ./wm-programs/maestro_wm-programs.nix
  ];
}
