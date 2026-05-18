# alisa_network_info_utils.nix
{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_network = ''
      echo -e "${b}--- [ Network Info Handbook ] ---${res}"

      echo -e "${g}── Внешние данные ─────────────────────────────────────────────${res}"
      echo -e "  ${y}myip${res}     — узнать свой внешний IP (через ifconfig.me)"

      echo -e "\n${g}── Проверка связи ─────────────────────────────────────────────${res}"
      echo -e "  ${y}ping8${res}    — пинг до Google (8.8.8.8)"

      echo -e "\n${b}Совет:${res} Если интернета нет, начни с ${y}ping8${res}, чтобы понять — проблема в DNS или в канале."
    '';
  };
}
