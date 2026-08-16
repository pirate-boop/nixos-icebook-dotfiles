{ inputs, pkgs, ... }: { environment.systemPackages = [ inputs.scrcpy-gui.packages.${pkgs.stdenv.hostPlatform.system}.default ]; }
