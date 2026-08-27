{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.lfff.packages.${pkgs.stdenv.hostPlatform.system}.default  
    inputs.lfff.packages.${pkgs.stdenv.hostPlatform.system}.lfff-cli
  ];
}
