{ pkgs, ... }:

{
  # Enable SANE scanning support with Epson v2 backend and non-free plugin
  hardware.sane = {
    enable = true;
    extraBackends = [
      (pkgs.epsonscan2.override { withPlugin = true; })
    ];
  };

  # Enable Avahi service to resolve mDNS and prevent epsonscan2 search timeouts
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Register udev rules for USB scanner device access
  services.udev.packages = [
    pkgs.epsonscan2
    pkgs.sane-backends
  ];

  # Grant scanner and printer access to the main user
  #users.users.Kori.extraGroups = [ "scanner" "lp" ];
}
