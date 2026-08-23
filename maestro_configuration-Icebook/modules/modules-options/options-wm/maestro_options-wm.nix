{ inputs, ... }: {
  imports = [
    inputs.driftwm.nixosModules.default
    ./wm-options-driftwm.nix
    ./wm-options-niri.nix
    #./wm-options-dms-shell.nix
    #./wm-options-hyprland.nix
    #./wm-options-mango.nix
    ./wm-options-noctalia-shell.nix
  ];
}
