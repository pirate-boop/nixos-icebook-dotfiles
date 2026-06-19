{ config, pkgs, ... }:

{
  # 1. Включаем службу v2rayA на движке xray
  services.v2raya.enable = true;
  services.v2raya.cliPackage = pkgs.xray;

  # 2. Прямо при загрузке ноута втыкаем нужные модули ядра в память
  boot.kernelModules = [ 
    "nf_tproxy_ipv4" 
    "nf_tproxy_ipv6" 
    "nft_tproxy" 
    "xt_TPROXY" 
  ];

  # 3. Разрешаем пересылку пакетов на уровне ядра (без этого TProxy сдохнет)
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # 4. Даем изолированной службе доступ к сетевым бинарникам
  systemd.services.v2raya.path = with pkgs; [
    nftables
    iptables
    iproute2
  ];

  # 5. Открываем только порт веб-интерфейса
  networking.firewall.allowedTCPPorts = [ 2017 ];
}
