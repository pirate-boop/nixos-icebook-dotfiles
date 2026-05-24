# maestro_configuration-Icebook/modules/system/keyboard/keyd.nix
{ pkgs, ... }: {
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      settings = {
        main = {
          fn = "layer(media)";
        };

        media = {
          f1 = "sleep";
          f2 = "brightnessdown";
          f3 = "brightnessup";
          f4 = "exec niri msg action fullscreen-window";
          f5 = "exec ${pkgs.writeShellScript "toggle-touchpad" ''
            #!/usr/bin/env bash
            STATE_FILE="/tmp/touchpad_disabled"

            if [ -f "$STATE_FILE" ]; then
              rm -f "$STATE_FILE"
              notify-send "✅ Touchpad Enabled" "Сенсорная панель включена"
            else
              touch "$STATE_FILE"
              notify-send "❌ Touchpad Disabled" "Сенсорная панель выключена"
            fi
          ''}";
          f6 = "mute";
          f7 = "volumedown";
          f8 = "volumeup";
          f9 = "exec brightnessctl --class=leds set 0%+";
          f10 = "exec qalculate-gtk";
          f11 = "exec thunderbird";
          f12 = "exec noctalia-shell ipc call sessionMenu toggle";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    keyd
    #brightnessctl
    #libnotify   # для notify-send
  ];
}
