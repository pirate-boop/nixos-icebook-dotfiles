{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.waydroid-script.packages.${pkgs.system}.default
  ];
}
