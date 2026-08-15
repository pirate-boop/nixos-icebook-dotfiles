{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix                   # генерируется nixos-generate-config
    ./maestro_configuration-Icebook/igniter.nix
    ./pkgs/maestro_custom-packages.nix
  ];
}
