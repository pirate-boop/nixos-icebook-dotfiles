{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.waydroid-script.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
