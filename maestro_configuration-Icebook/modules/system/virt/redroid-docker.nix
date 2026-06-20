{ config, pkgs, ... }:

{
  # Включаем Docker-движок
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  # Описание контейнера Redroid (NDK + Magisk + GApps)
  virtualisation.oci-containers.containers.redroid = {
    image = "erstt/redroid:12.0.0_ndk_magisk_litegapps_ChromeOS"; 
    ports = [ "5555:5555" ];
    
    volumes = [
      "/var/lib/redroid:/data"
    ];

    extraOptions = [
      "--privileged"
      "--device=/dev/dri:/dev/dri" # Твоя графика Radeon 780M
      
      # Перенесли сюда как честные устройства ядра
      "--device=/dev/binderfs/binder:/dev/binder"
      "--device=/dev/binderfs/hwbinder:/dev/hwbinder"
      "--device=/dev/binderfs/vndbinder:/dev/vndbinder"
    ];

    cmd = [
      "androidboot.redroid_gpu_mode=host"
      "androidboot.hardware=redroid"
      
      # Подгоняем под дисплей твоего Icebook (1920x1200)
      "androidboot.redroid_width=1920"
      "androidboot.redroid_height=1200"
      "androidboot.redroid_fps=90"
      "androidboot.redroid_dpi=280"
      
      # Разрешаем подмену мемфд для новых ядер
      "androidboot.use_memfd=1"
      
      # Настройки рута
      "ro.secure=0"
      "ro.debuggable=1"
    ];
  };

  # Автоматически выставляем права 666 при загрузке системы для работы Binder в контейнере
  systemd.services.fix-binder-permissions = {
    description = "Set world-writable permissions for binderfs devices";
    after = [ "local-fs.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/chmod 666 /dev/binderfs/binder /dev/binderfs/hwbinder /dev/binderfs/vndbinder";
      RemainAfterExit = true;
    };
  };

  # Системный софт для вывода экрана
  environment.systemPackages = with pkgs; [
    scrcpy
    android-tools
    sqlite
  ];
}
