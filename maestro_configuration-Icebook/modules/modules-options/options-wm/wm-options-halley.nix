{ pkgs, inputs, ... }:

{
  # Enable Halley compositor configuration
  programs.halley = {
    enable = true;
    package = inputs.halley.packages.${pkgs.system}.halley-unstable;
  };
}
