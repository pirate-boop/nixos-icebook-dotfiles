{ ... }: {
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="22d9", ATTR{idProduct}=="2765", \
    TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="mtp-phone.service"
  '';
}
