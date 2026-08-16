{ inputs, pkgs, ... }: { environment.systemPackages = [ inputs.ttt.packages.${pkgs.stdenv.hostPlatform.system}.default ]; }
