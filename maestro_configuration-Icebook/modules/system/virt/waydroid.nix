{ ... }: {
  virtualisation.waydroid.enable = true;
  #networking.firewall.trustedIterfaces = ["waydroid0"];
  boot.kernel.sysctl = {
   "net.ipv4.ip_forward" = 1;
   "net.ipv4.conf.all.forwarding" = 1;
   "net.ipv6.conf.all.forwarding" = 1;
  };
  systemd.services.waydroid-container.serviceConfig = {
  Delegate = true;
  CPUAccounting = true;
  MemoryAccounting = true;
  TaskAccounting = true;
  };
}
