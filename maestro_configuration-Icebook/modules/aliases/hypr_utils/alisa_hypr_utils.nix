# alisa_hypr_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_hypr = ''
      echo -e "${b}--- [ Hyprland Handbook ] ---${res}"

      echo -e "${g}── Управление сессией ─────────────────────────────────────────${res}"
      echo -e "  ${y}hypr_reload${res}  — перезагрузить конфигурацию"

      echo -e "\n${g}── Информация и мониторинг ────────────────────────────────────${res}"
      echo -e "  ${y}hypr_mon${res}     — список и параметры мониторов"
      echo -e "  ${y}hypr_cl${res}      — список всех открытых окон (клиентов)"

      echo -e "\n${b}Tip:${res} Если окно ведет себя странно, проверь его класс через ${y}hypr_cl${res}."
    '';
  };
}
