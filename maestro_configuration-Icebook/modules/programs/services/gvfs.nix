{ pkgs, config, ... }: {
  services.gvfs = {
    enable = true;
    package = pkgs.gvfs.override { mtp = true; };
  };
  services.udev.packages = [ pkgs.libmtp.out ];
  services.devmon.enable = true;
}
