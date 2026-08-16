#****************************************************************#

#|============================================================|
#|SYSTEM — дирижёр системных модулей |
#|============================================================|
#****************************************************************#
{ config, pkgs, inputs, ... }: {
  imports = [
    ./core/maestro_core.nix                            # загрузчик, ядро, kernel params
    ./fonts/maestro_fonts.nix                          # пользователь kori
    ./hardware/maestro_hardware.nix                    # sysctl, PAM, sudo
    ./localization/maestro_localization.nix            # таймзона, локаль
    ./network/maestro_networking.nix                   # NetworkManager
    ./nix/maestro.nix                                  # nix daemon + flake settings
    ./shell/maestro_shell.nix                          # ZSH + oh-my-zsh
    ./virt/maestro_virt.nix                            # libvirtd, QEMU, Waydroid
    ./keyboard-settings/maestro_keyboard-settings.nix  # keyboard-settings
    ./udev-rules/maestro_udev-rules.nix
  ];
}
