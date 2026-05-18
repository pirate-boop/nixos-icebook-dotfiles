#****************************************************************#
# |============================================================| #
# |NETWORKING                                                  | #
# |============================================================| #
#****************************************************************#
{ ... }: {
  networking.hostName = "Kori-Icebook";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  # networking.hosts = { "198.18.4.40" = [ "steamdeckrepo.com" ]; };
  services.resolved.enable = true;
  networking.firewall.enable = false;
}
