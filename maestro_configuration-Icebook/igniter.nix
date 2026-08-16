#****************************************************************#
# |============================================================| #
# |MAESTRO —KORI-ISEBOOK                                       | #
# |============================================================| #
#  Ryzen 7 8845HS / Radeon 780M / 24GB / NVMe 1TB              #
#  Niri + Noctalia, ZSH, SystemD-boot                           #
#****************************************************************#
{ config, pkgs, inputs, ... }: {
  imports = [
    ./modules/system/maestro_system.nix                      # system core
    ./modules/system-packages/maestro_system-packages.nix    # nixpkgs-packages
    ./modules/flake-packages/maestro_flake-packages.nix      # flake-pkgs
    ./modules/options/maestro_options.nix                  # programs & services
    ./modules/system/fonts/maestro_fonts.nix                 # fonts
    ./modules/environment/maestro_environment.nix            # env vars & XDG defaults
    ./modules/aliases/maestro_aliases.nix                    # aliases
  ];
}
