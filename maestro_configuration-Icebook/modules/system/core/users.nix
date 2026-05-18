#****************************************************************#
# |============================================================| #
# |USER ACCOUNT                                                | #
# |============================================================| #
#****************************************************************#
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
    ];
  };
  #users.users.kori.password = "donatwwww12";
  #users.users.root.password = "donatwwww12";
}
