{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.lfff.packages.${pkgs.system}.default
  ];
}
