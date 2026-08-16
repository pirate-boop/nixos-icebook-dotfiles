{ pkgs, ... }: {
  # 1. Правильная структура включения Waydroid и указания пакета
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables; # Именно так мы указываем использовать nftables
  };
  # 2. systemPackages должен быть на верхнем уровне, не внутри waydroid!
  environment.systemPackages = with pkgs; [
    waydroid-helper
  ];

  networking.firewall.trustedInterfaces = ["waydroid0"];

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
