# alisa_system_info_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_system = ''
      echo -e "${b}--- [ System Info & Monitoring Handbook ] ---${res}"

      echo -e "${g}── Общая информация ──────────────────────────────────────────${res}"
      echo -e "  ${y}fetch${res}      — краткая сводка системы (fastfetch)"
      echo -e "  ${y}sysinfo${res}    — полный отчет по железу (inxi)"

      echo -e "\n${g}── Ресурсы и температура ─────────────────────────────────────${res}"
      echo -e "  ${y}mem${res}        — использование ОЗУ"
      echo -e "  ${y}disk${res}       — свободное место на дисках"
      echo -e "  ${y}temps${res}      — мониторинг датчиков (sensors)"

      echo -e "\n${g}── Видеокарта (NVIDIA) ───────────────────────────────────────${res}"
      echo -e "  ${y}gpu${res}        — текущий статус GPU"
      echo -e "  ${y}gpuwatch${res}   — живой мониторинг нагрузки видеокарты"

      echo -e "\n${g}── Сеть и процессы ───────────────────────────────────────────${res}"
      echo -e "  ${y}ports${res}      — открытые порты и соединения"
      echo -e "  ${y}psg [имя]${res}  — поиск процесса через grep"
    '';
  };
}
