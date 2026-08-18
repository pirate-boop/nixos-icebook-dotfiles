{ config, ... }: {
  #home.file."removable_devices".source = config.lib.file.mkOutOfStoreSymlink "/run/media/kori";
  home.file."nix-conf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
  home.file."Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/maestro_configuration-Icebook/modules/home/.dotfiles/Wallpapers";
  home.file."nvme0n1".source = config.lib.file.mkOutOfStoreSymlink "/mnt/nvme0n1";
}
