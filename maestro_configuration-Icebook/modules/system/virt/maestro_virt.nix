{ config, pkgs, inputs, ... }: {
  imports = [
    ./looking-glass.nix
    ./qemu.nix
    ./vfio.nix
    ./virtualization.nix
    ./waydroid.nix
  ];
}
