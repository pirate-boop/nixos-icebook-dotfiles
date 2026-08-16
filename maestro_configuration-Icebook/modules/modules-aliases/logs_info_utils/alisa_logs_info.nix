# alisa_logs_info.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_logs = ''
      echo -e "${b}--- [ System Logs Handbook ] ---${res}"

      echo -e "${g}── Journalctl (Системный журнал) ─────────────────────────────${res}"
      echo -e "  ${y}jctl${res}       — journalctl -xe (ошибки и конец лога)"
      echo -e "  ${y}jctlu${res}      — journalctl -xe -u [service] (логи конкретного юнита)"
      echo -e "  ${y}jf${res}         — journalctl -f (живой поток логов / follow)"

      echo -e "\n${b}Пример:${res} ${y}jctlu bluetooth${res} — посмотреть, почему отвалился синезуб."
    '';
  };
}
