{ ... }: {
  imports = [
    ./options-system-tools/maestro_options-system-tools.nix
    ./options-gaming/maestro_options-gaming.nix
    ./options-desktop/maestro_options-desktop.nix
    ./options-services/maestro_options-services.nix
    ./options-wm/maestro_options-wm.nix
    ./options-sddm/maestro_options-sddm.nix
  ];
}
