{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    # Вместо старого pkgs.noctalia-qs пишем это:
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
