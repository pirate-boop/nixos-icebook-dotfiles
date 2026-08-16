#****************************************************************#
# |============================================================| #
# |INPUT — libinput, udev, геймпады                            | #
# |============================================================| #
#  GameSir G8+ BT MAC: A0:5A:5E:58:52:A1                         #
#****************************************************************#
{ pkgs, ... }: {
  services.libinput.enable = true;

  # udev правило для геймпадов — доступ без sudo
  services.udev.extraRules = ''
    # GameControllers — read/write для группы input
    SUBSYSTEM=="input", GROUP="input", MODE="0664"
    SUBSYSTEM=="hidraw", GROUP="input", MODE="0664"

    # GameSir G8+ и другие геймпады через Bluetooth
    SUBSYSTEM=="input", ATTRS{name}=="*GameSir*", GROUP="input", MODE="0664"
  '';

  # xpadneo для Xbox-совместимых геймпадов через BT
  hardware.xpadneo.enable = true;
}
