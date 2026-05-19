{ pkgs, config, ... }: {
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];
}
