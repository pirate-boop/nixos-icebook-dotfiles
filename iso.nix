{ pkgs, ... }: {
  imports = [
    ./maestro_configuration-Icebook/modules/modules-system/core/bcachefs.nix
  ];
  
  nixpkgs.hostPlatform = "x86_64-linux";
  
  # Минимальная ISO с bcachefs
  isoImage.isoBaseName = "nixos-bcachefs";
  isoImage.edition = "bcachefs";
}