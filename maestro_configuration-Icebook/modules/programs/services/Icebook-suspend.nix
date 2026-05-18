#****************************************************************#
# |============================================================| #
# |SUSPEND — крышка ноутбука → сон                             | #
# |============================================================| #
#  logind видит событие Lid closed, но не действует без явного  #
#  указания HandleLidSwitch. Niri не блокирует lid — только     #
#  power-key. Если logind не сработает, фоллбэк через niri     #
#  config.kdl: switch-events { lid-close { spawn "systemctl"   } #
#  "suspend"; } }                                               #
#****************************************************************#
{ ... }: {

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };

}
