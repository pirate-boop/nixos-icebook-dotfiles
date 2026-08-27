{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.lfff.packages.${stdenv.hostPlatform.system}.default  
    inputs.lfff.packages.${stdenv.hostPlatform.system}.lfff-cli
  ];
}
