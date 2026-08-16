# alisa_git_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_git = ''
      echo -e "${b}--- [ Git Helpers Handbook ] ---${res}"

      echo -e "${g}── Статус и изменения ─────────────────────────────────────────${res}"
      echo -e "  ${y}gs${res}     — git status (краткий статус репозитория)"
      echo -e "  ${y}ga${res}     — git add (подготовка файлов к коммиту)"
      echo -e "  ${y}gl${res}     — git log --oneline --graph (красивое дерево коммитов)"

      echo -e "\n${g}── Работа с коммитами и удаленкой ─────────────────────────────${res}"
      echo -e "  ${y}gc_ \"сообщение\"${res} — git commit -m (создать коммит)"
      echo -e "  ${y}gp${res}             — git push (отправить в репозиторий)"

      echo -e "\n${b}Совет:${res} Используй ${y}gs${res} перед каждым ${y}ga${res}, чтобы не закинуть лишнего."
    '';
  };
}
