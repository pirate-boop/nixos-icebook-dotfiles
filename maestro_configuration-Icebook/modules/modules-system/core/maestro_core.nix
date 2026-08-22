#*************************************************************| #
#|============================================================| #
#|SYSTEM — conductor of system modules                        | #
#|============================================================| #
#*************************************************************| #
{ config, pkgs, inputs, ... }: {
  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
    ./performance.nix
    ./bootloader.nix
    ./bcachefs.nix
    ./extra-disks.nix
  ];
}
