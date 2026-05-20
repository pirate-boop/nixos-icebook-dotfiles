{ pkgs, config, ... }: {
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];

  # Нативный автомат для MTP в окружении Niri
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{ID_MTP_DEVICE}=="1", TAG+="systemd", ENV{SYSTEMD_USER_WANTED}+="mtp-automount.service"
  '';

  systemd.user.services.mtp-automount = {
    description = "Циклический автоклининг и монтирование MTP через GVFS";
    
    script = ''
      # 1. Даем полсекунды на стабилизацию порта
      ${pkgs.coreutils}/bin/sleep 0.5

      # 2. Жёстко вычищаем из GVFS сессии все зависшие «призраки» прошлых подключений
      # Это решает проблему "Адрес уже примонтирован" при перетыкании шнура
      ${pkgs.glib}/bin/gio mount -u -f mtp://* 2>/dev/null || true

      # 3. Даем команду на свежее монтирование
      ${pkgs.glib}/bin/gio mount -m
    '';

    serviceConfig = {
      Type = "oneshot";
      # Позволяет службе мгновенно перезапускаться при повторном udev-событии,
      # полностью стирая из памяти Systemd информацию о том, как завершился прошлый запуск
      RemainAfterExit = false;
    };
  };
}
