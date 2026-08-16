#****************************************************************#
# |============================================================| #
# |MAESTRO —KORI-ISEBOOK                                       | #
# |============================================================| #
#  Ryzen 7 8845HS / Radeon 780M / 24GB / NVMe 1TB              #
#  Niri + Noctalia, ZSH, SystemD-boot                           #
#****************************************************************#
{ config, pkgs, inputs, ... }: {
  imports = [
    ./modules/modules-system/maestro_modules-system.nix                      # system core
    ./modules/modules-system-packages/maestro_modules-system-packages.nix    # nixpkgs-packages
    ./modules/modules-flake-packages/maestro_modules-flake-packages.nix      # flake-pkgs
    ./modules/modules-options/maestro_modules-options.nix                  # programs & services
    ./modules/modules-system/fonts/maestro_modules-fonts.nix                 # fonts
    ./modules/modules-environment/maestro_modules-environment.nix            # env vars & XDG defaults
    ./modules/modules-aliases/maestro_modules-aliases.nix                    # aliases
  ];
}
