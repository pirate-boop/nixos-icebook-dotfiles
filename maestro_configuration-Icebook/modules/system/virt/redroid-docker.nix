{ config, pkgs, ... }:

{
  # Включаем Docker
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  # Подгружаем модули ядра хоста для Android IPC
  boot.kernelModules = [ "binder_linux" ];
  boot.kernelParams = [ "binder.devices=binder,vndbinder,pwbinder,hwbinder" ];

  # Описание контейнера
  virtualisation.oci-containers.containers.redroid = {
    # Берем стабильный NDK образ с Magisk и GApps на базе Android 12
    image = "erstt/redroid:12.0.0_ndk_magisk_litegapps_ChromeOS"; 
    
    ports = [ "5555:5555" ];
    
    volumes = [
      "/var/lib/redroid:/data" # Здесь будут жить твои игры и данные аккаунтов
    ];

    extraOptions = [
      "--privileged"
      "--device=/dev/dri:/dev/dri" # Проброс твоей встройки AMD 780M
    ];

    cmd = [
      "androidboot.redroid_gpu_mode=host" # Включаем аппаратный рендеринг на GPU хоста
      "androidboot.hardware=redroid"
      
      # Подгоняем под дисплей твоего Icebook (1920x1200, 165Hz)
      "androidboot.redroid_width=1920"
      "androidboot.redroid_height=1200"
      "androidboot.redroid_fps=90"        # 90 кадров для баланса плавности и жора батареи
      "androidboot.redroid_dpi=280"       # Плотность пикселей, чтобы интерфейс не был мелким
      
      # Переменные отладки и рута
      "ro.secure=0"
      "ro.debuggable=1"
    ];
  };

  # Системные пакеты для вывода экрана и дебага
  environment.systemPackages = with pkgs; [
    #scrcpy
    android-tools
    sqlite # Понадобится для вытаскивания Google ID
  ];
}
