# alisa_waydroid_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_waydroid = ''
      echo -e "${b}--- [ Waydroid (Android) Handbook ] ---${res}"

      echo -e "${g}── Управление сессией ─────────────────────────────────────────${res}"
      echo -e "  ${y}wstart${res}     — запустить сессию Waydroid"
      echo -e "  ${y}wstop${res}      — остановить сессию"

      echo -e "\n${g}── Графический интерфейс ──────────────────────────────────────${res}"
      echo -e "  ${y}wui${res}        — показать полный интерфейс Android (UI)"

      echo -e "\n${b}Совет:${res} Если приложения не запускаются, проверь статус сессии через ${y}wstart${res}."
    '';
  };
}
