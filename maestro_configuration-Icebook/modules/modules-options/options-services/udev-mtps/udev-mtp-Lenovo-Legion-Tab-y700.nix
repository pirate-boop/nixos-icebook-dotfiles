{ pkgs, ... }: {
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="17ef", ATTR{idProduct}=="7ed6", \
    RUN+="${pkgs.bash}/bin/bash -c 'mkdir -p /run/media/kori/lenovo_y700 && ${pkgs.jmtpfs}/bin/jmtpfs /run/media/kori/lenovo_y700'"
  '';
}
