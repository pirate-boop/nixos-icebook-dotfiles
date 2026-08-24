{ inputs, ... }: {
  imports = [
    inputs.driftwm.nixosModules.default
    ./wm-options-driftwm.nix
    ./wm-options-niri.nix
    inputs.halley.nixosModules.default
    ./wm-options-halley.nix
    #./wm-options-dms-shell.nix
    #./wm-options-hyprland.nix
    #./wm-options-mango.nix
    ./wm-options-noctalia-shell.nix
    ./wm-options-gnome.nix
  ];
}
