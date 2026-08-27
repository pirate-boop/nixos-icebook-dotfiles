{ inputs, ... }:

{
  # 1. Register option structure in Home Manager
  imports = [
    inputs.proton-flavors.homeManagerModules.default
  ];

  # 2. Enable all Proton runners into compatibilitytools.d
  programs.proton-flavors.enable = true;
}
