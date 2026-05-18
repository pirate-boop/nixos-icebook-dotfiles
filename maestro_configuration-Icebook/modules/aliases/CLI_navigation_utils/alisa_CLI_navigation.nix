# alisa_CLI_navigation.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_cli = ''
      echo -e "${b}--- [ CLI Navigation Handbook ] ---${res}"

      echo -e "${g}── Просмотр файлов (eza) ──────────────────────────────────────${res}"
      echo -e "  ${y}ll${res}      — подробный список (иконки, git, группы)"
      echo -e "  ${y}la${res}      — показать скрытые файлы"
      echo -e "  ${y}lt${res}      — дерево папок (глубина 2 уровня)"

      echo -e "\n${g}── Перемещение ────────────────────────────────────────────────${res}"
      echo -e "  ${y}..${res}      — на уровень вверх"
      echo -e "  ${y}...${res}     — на два уровня вверх"

      echo -e "\n${b}Tip:${res} Используй ${y}lt${res}, если забыл структуру подпапок."
    '';
  };
}
