{ pkgs, ... }:

let
  # Создаем скрипт-пакет прямо в Nix. Имя команды будет строго "niri-focus"
  niri-focus = pkgs.writeShellScriptBin "niri-focus" ''
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
in
{
  # Добавляем этот скрипт в пакеты пользователя Home Manager.
  # После сборки команда "niri-focus" станет доступна глобально в системе.
  home.packages = [
    niri-focus
  ];
}
