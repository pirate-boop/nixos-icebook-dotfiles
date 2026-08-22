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

  # User permissions for hardware scanning
  #users.users.Kori.extraGroups = [ "scanner" "lp" ];
}
