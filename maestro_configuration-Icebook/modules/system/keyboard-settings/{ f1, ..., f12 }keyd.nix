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
          f4 = "exec niri msg action fullscreen-window";     # настоящий fullscreen
          f5 = "exec ~/.local/bin/toggle-touchpad.sh";       # touchpad toggle
          f6 = "mute";
          f7 = "volumedown";
          f8 = "volumeup";
          f9 = "exec brightnessctl --class=leds set 0%+";   # цикл подсветки клавиатуры
          f10 = "exec qalculate-gtk";
          f11 = "exec thunderbird";
          f12 = "exec noctalia-shell ipc call sessionMenu toggle";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    keyd
    brightnessctl
  ];
}
