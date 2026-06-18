{ config, pkgs, ... }:

{
  # Включаем сам демон
  services.gnunet.enable = true;
  
  # Используем стандартный стабильный пакет
  services.gnunet.package = pkgs.gnunet;

  # Снимаем ограничения скорости (ставим по 50 Мбит/с)
  services.gnunet.load.maxNetDownBandwidth = 50000000;
  services.gnunet.load.maxNetUpBandwidth = 50000000;

  # Выделяем под децентрализованный файлообмен 4 Гб
  services.gnunet.fileSharing.quota = 4096;

  # CLI-пакет для управления из терминала
  environment.systemPackages = [ pkgs.gnunet ];
}
