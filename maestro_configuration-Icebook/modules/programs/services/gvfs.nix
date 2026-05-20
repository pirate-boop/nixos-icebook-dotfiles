{ pkgs, config, ... }: {
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];
  services.devmon.enable = true;  # на всякий случай, если пригодится

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{ID_MTP_DEVICE}=="1", ACTION=="add", TAG+="systemd", ENV{SYSTEMD_USER_WANTED}+="mtp-automount@$devnode.service"
  '';

  systemd.user.services."mtp-automount@" = {
    description = "Монтирование MTP устройства %I";
    bindsTo = [ "gvfs-daemon.service" ];
    after = [ "gvfs-daemon.service" ];

    script = ''
      # Даём время на инициализацию
      sleep 1
      # Монтируем конкретное устройство, переданное udev
      ${pkgs.glib}/bin/gio mount -d /dev/%I
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false;
    };
  };
}
