{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.lfff.packages.${pkgs.system}.default  
    inputs.lfff.packages.${pkgs.system}.lfff-cli
  ];
}
