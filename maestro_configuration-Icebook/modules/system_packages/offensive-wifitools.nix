{ config, pkgs, ... }:

{
  # 1. Пакеты для беспроводного аудита
  environment.systemPackages = with pkgs; [
    iw
    wirelesstools
    aircrack-ng
    wifite2
    hcxtools
    hcxdumptool
    hashcat
    
    # Дополнительный софт, что тебе посоветовали:
    reaverwps-t6x
    pixiewps
    bettercap
  ];

  # 2. Параноидальный режим: Автоматическое сокрытие MAC-адреса
  networking.networkmanager = {
    wifi.macAddress = "random";       # Смена MAC при каждом новом подключении к сети
    wifi.scanRandMacAddress = true;   # Маскировать MAC даже во время обычного сканирования эфира
  };
}
