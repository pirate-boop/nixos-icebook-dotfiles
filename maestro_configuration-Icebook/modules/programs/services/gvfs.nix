{ pkgs, config, ... }: {
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];

  # 1. Говорим udev запускать наш сервис при подключении ЛЮБОГО MTP устройства
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{ID_MTP_DEVICE}=="1", ACTION=="add", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}+="automount-mtp.service"
  '';

  # 2. Описываем сам Systemd-сервис для твоего юзера
  systemd.user.services.automount-mtp = {
    description = "Универсальный автоматический монтировщик MTP устройств";
    documentation = [ "https://github.com/pirate-boop/nixos-icebook-dotfiles" ];
    
    serviceConfig = {
      Type = "oneshot";
      # Наша рабочая команда. Обязательно указываем полные пути к бинарникам через pkgs
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.glib}/bin/gio mount -d $(${pkgs.glib}/bin/gio mount -l -i | ${pkgs.gnugrep}/bin/grep -A 5 \"GProxyVolumeMonitorMTP\" | ${pkgs.gnugrep}/bin/grep \"unix-device:\" | ${pkgs.gawk}/bin/awk -F\"'\" \"{print \\$2}\")'";
      RemainAfterExit = false;
    };
  };
}
