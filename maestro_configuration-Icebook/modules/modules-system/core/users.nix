#****************#
# |============================================================| #
# |USER ACCOUNT                                                | #
# |============================================================| #
#****************#
{ pkgs, ... }: {
  users.users.kori = {
    isNormalUser = true;
    description  = "Kori";
    shell        = pkgs.zsh;
    linger       = true;
    extraGroups  = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "input"
      "video"
      "render"
      "seat"
      "audio"
      "gamemode"
      "fuse"
      "users"
      "kvm"
      "plugdev"
      "gnunet"
    ];
  };

  # /etc/nixos всегда принадлежит юзеру: на каждом boot и каждом
  # nixos-rebuild switch права принудительно возвращаются,
  # даже если какой-то sudo-скрипт сделал папку root-овской
  system.activationScripts.etcNixosOwnership = {
    deps = [ "etc" "users" ];
    text = ''
      chown -R kori:users /etc/nixos || true
    '';
  };
}
