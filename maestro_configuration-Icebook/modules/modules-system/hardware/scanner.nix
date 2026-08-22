{ pkgs, ... }:

{
  # Enable SANE service and Epson v2 backends
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epsonscan2 ];
  };
  
  services.udev.packages = [ pkgs.epsonscan2 ];
  # User groups for scanner and printing access
  #users.users.Kori.extraGroups = [ "scanner" "lp" ];
}
