{ config, pkgs, ... }:

let
  # Создаем лаконичную переменную с путем к скрипту
  niri-focus = "${config.home.homeDirectory}/.local/bin/niri-focus-nth.sh";
in
{
  # 1. Сам скрипт (с исправленным багом $3 -> $4)
  home.file.".local/bin/niri-focus-nth.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      N=$1
      OUTPUT=$(${pkgs.niri}/bin/niri msg windows)

      CUR_WS=$(echo "$OUTPUT" | awk '
      /\(focused\)/ { found=1 }
      found && /Workspace ID:/ { print $3; exit }
      ')

      TARGET=$(echo "$OUTPUT" | awk -v ws="$CUR_WS" -v col="$N" '
      /^Window ID/ { id=$3; gsub(/:/,"",id) }
      /Workspace ID:/ { cur_ws=$3 }
      /Scrolling position:/ {
          c=$4; gsub(/,/,"",c)
          if (cur_ws == ws && c == col) print id
      }
      ' | head -1)

      [ -n "$TARGET" ] && ${pkgs.niri}/bin/niri msg action focus-window --id "$TARGET"
    '';
  };

  # Здесь можно передать переменную `niri-focus` в твой конфиг Niri, 
  # если ты генерируешь niri.kdl через home-manager, например:
  # xdg.configFile."niri/config.kdl".text = '' ... spawn "${niri-focus}" "1" ... '';
}
