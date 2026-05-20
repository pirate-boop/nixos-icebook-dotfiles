#****************************************************************#
# |============================================================| #
# |BOOT — загрузчик и ядро                                     | #
# |============================================================| #
#  Загрузчик: systemd-boot (проще и надёжнее для ноута)        #
#  Ядро: CachyOS (из chaotic-nyx оверлея)                      #
#  Plymouth: включён для красивого сплэша                       #
#****************************************************************#
{ pkgs, config, ... }: {
  boot = {
    bootspec.enable = true;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "ext4" "btrfs" "xfs" ];
      kernelModules = [ "amdgpu" ];  # ранняя загрузка для Plymouth
    };
    supportedFilesystems = [ "ntfs" "exfat" "vfat" ];

    # CachyOS ядро (оптимизировано под современное железо)
    # Требует chaotic-nyx overlay в nixpkgs.nix
    # Если chaotic не подключён — заменить на pkgs.linuxPackages_latest
    # kernelPackages = pkgs.linuxPackages_cachyos;
    kernelPackages = 
      pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_zen;

    consoleLogLevel = 3;
    kernelParams = [
      # "quiet"
      # "splash"
      "amd_pstate=active"         # активный режим P-State для Zen4 (лучше производительность/батарея)
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "amdgpu.ppfeaturemask=0xfffd7fff"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;

      # systemd-boot — стандартный выбор для ноутов с UEFI
      systemd-boot = {
        enable = true;
        configurationLimit = 10;   # хранить 10 последних конфигураций
        editor = false;            # отключить редактор cmdline (безопасность)
      };

      grub.enable = false;
    };

    # plymouth.enable = true;
  };

  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];
}
