#****************************************************************#
# |============================================================| #
# |SWAYIDLE — автоблокировка + lock перед suspend              | #
# |============================================================| #
#  5 мин бездействия  → hyprlock (блокировка экрана)           #
#  10 мин бездействия → suspend (сон)                          #
#  before-sleep       → hyprlock (блокировка ПЕРЕД сном)       #
#                                                                #
#  Запускается через niri config.kdl:                           #
#  spawn-at-startup "swayidle" "-w" ...                         #
#****************************************************************#
{ pkgs, ... }: {

  services.swayidle = {
    enable = true;

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
