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
      
      # Возвращаем сюда! Bind mount сохраняет контекст файловой системы ядра
      "/dev/binderfs/binder:/dev/binder"
      "/dev/binderfs/hwbinder:/dev/hwbinder"
      "/dev/binderfs/vndbinder:/dev/vndbinder"
    ];

    extraOptions = [
      "--privileged"
      "--device=/dev/dri:/dev/dri" # Твоя графика Radeon 780M работает через device отлично
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

  # Этот сервис критически важен: он даёт права ДО того, как Docker подхватит эти файлы в volumes
  systemd.services.fix-binder-permissions = {
    description = "Set world-writable permissions for binderfs devices";
    before = [ "docker-redroid.service" ];
    requiredBy = [ "docker-redroid.service" ];
    after = [ "local-fs.target" ];
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
