# alisa_niri_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_niri = ''
      echo -e "${b}--- [ Niri WM Handbook ] ---${res}"

      echo -e "${g}── Состояние и окна ───────────────────────────────────────────${res}"
      echo -e "  ${y}nw${res}     — список мониторов (outputs)"
      echo -e "  ${y}ws${res}     — список рабочих столов"
      echo -e "  ${y}win${res}    — список открытых окон"
      echo -e "  ${y}act${res}    — список всех доступных действий"

      echo -e "\n${g}── Скриншоты ──────────────────────────────────────────────────${res}"
      echo -e "  ${y}ns${res}     — интерактивный скриншот (выбор области)"
      echo -e "  ${y}nss${res}    — скриншот всего экрана"
      echo -e "  ${y}nsw${res}    — скриншот активного окна"

      echo -e "\n${g}── Управление ─────────────────────────────────────────────────${res}"
      echo -e "  ${y}qui${res}    — выход из Niri"
      echo -e "  ${y}tki${res}    — заблокировать/разблокировать хоткеи (для VM)"

      echo -e "\n${b}Tip:${res} Используй ${y}win${res}, чтобы быстро найти ID залипшего окна."
    '';
  };
}
