#****************************************************************#
# |============================================================| #
# |USER ACCOUNT                                                | #
# |============================================================| #
#****************************************************************#
{ pkgs, ... }: {
  users.users.kori = {
    isNormalUser = true;
    home = "/home/kori";
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
}
