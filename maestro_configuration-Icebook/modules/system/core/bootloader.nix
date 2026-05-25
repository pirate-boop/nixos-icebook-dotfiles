#****************************************************************#
# |============================================================| #
# |BOOTLOADER — GRUB2 + Persona 5 Navi theme                  | #
# |============================================================| #
#  Загрузчик: GRUB2 (EFI, тема Persona 5 Royal - Navi)        #
#  Откат:     последние 10 поколений в меню GRUB               #
#  Устройство: nodev (EFI-режим, не BIOS)                      #
#****************************************************************#
{ pkgs, ... }: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";       # явно указываем, нужно для GRUB
    };

    timeout = 5;                        # 5 сек на выбор (тема красивая, есть что посмотреть)

    systemd-boot.enable = false;        # выключаем systemd-boot

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";                 # EFI-режим: диск не указываем
      efiInstallAsRemovable = true;     # пишет в /EFI/BOOT/BOOTX64.EFI
                                        # ← страховка: если прошивка забудет запись
                                        #   о nixos в NVRAM — всё равно загрузится

      configurationLimit = 10;          # 10 поколений в меню, не все 92

      # Persona 5 Royal — тема Navi
      # fetchzip стрипает ./navi/ → theme.txt лежит прямо в store path
      theme = pkgs.fetchzip {
        url = "https://github.com/SiriusAhu/Persona_5_Royal_Grub_Themes/releases/download/v1.0/navi.tar.gz";
        sha256 = "0zd3yh04xg44vp4v7a03kv1p0nwlk2clkn1r0jimnd8sxxvqbalg";
      };
    };
  };
}
