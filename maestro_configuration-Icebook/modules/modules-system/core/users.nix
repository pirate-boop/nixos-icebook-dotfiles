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

  # /etc/nixos is always owned by Kori: on every boot and every
  # ​​nixos-rebuild switch, the permissions are forcibly restored,
  # even if some sudo script made the folder root-owned
  system.activationScripts.etcNixosOwnership = {
    deps = [ "etc" "users" ];
    text = ''
      chown -R kori:users /etc/nixos || true
    '';
  };

  # A data drive always belongs to the user: it survives rebuilds and is automatically repaired after reformatting.
  system.activationScripts.dataOwnership = {
    deps = [ "etc" "users" ];
    text = ''
      chown kori:users /mnt/nvme0n1/data || true
    '';
  };
}
