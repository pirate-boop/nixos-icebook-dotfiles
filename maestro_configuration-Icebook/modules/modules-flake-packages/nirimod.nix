{inputs, pkgs, ... }: { environment.systemPackages = [ inputs.nirimod.packages.${pkgs.stdenv.hostPlatform.system}.default ]; }
