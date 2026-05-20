{ pkgs, config, ... }: {
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];

  # Нативный автомат для MTP в окружении Niri
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{ID_MTP_DEVICE}=="1", TAG+="systemd", ENV{SYSTEMD_USER_WANTED}+="mtp-automount.service"
  '';

  systemd.user.services.mtp-automount = {
    description = "Автоматическое монтирование смартфонов (MTP) через GVFS";
    script = ''
      ${pkgs.coreutils}/bin/sleep 1
      ${pkgs.glib}/bin/gio mount -m
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false;
    };
  };
}
