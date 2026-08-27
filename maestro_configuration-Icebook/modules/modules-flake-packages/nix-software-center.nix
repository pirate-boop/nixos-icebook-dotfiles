# { inputs, config, lib, pkgs, ... }: { environment.systemPackages = with pkgs; [ inputs.nix-software-center.packages.${stdenv.hostPlatform.system}.default ]; }
