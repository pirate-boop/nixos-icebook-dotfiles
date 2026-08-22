{ pkgs, ... }:

{
  # SANE scanner configuration
  hardware.sane = {
    enable = true;
    extraBackends = [
      (pkgs.epsonscan2.override { withNonFreePlugins = true; })
    ];
  };

  # Avahi service to resolve mDNS and prevent search timeouts
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Udev rules for scanner access
  services.udev.packages = [
    pkgs.epsonscan2
    pkgs.sane-backends
  ];
  services.udev.extraRules = ''
  ATTRS{idVendor}=="04b8", ATTRS{idProduct}=="013e", MODE="0666", GROUP="scanner"
'';
  # User permissions for hardware scanning
  #users.users.Kori.extraGroups = [ "scanner" "lp" ];
}
