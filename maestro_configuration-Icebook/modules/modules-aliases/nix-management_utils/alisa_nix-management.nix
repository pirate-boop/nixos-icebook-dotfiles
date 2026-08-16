{ shellColors, ... }:
let
  inherit (shellColors) b g y res;
in {
  programs.zsh.shellAliases = {
    alisa_nix-management = ''
      echo -e "${b}--- [ Nix Management Handbook ] ---${res}"

      echo -e "${g}── Rebuild (Сборка системы) ───────────────────────────────────${res}"
      echo -e "  ${y}nixos_rebuild${res}"
      echo "    └ Команда: sudo git -C /etc/nixos config core.editor nano && sudo git config --global --add safe.directory /etc/nixos && cd /etc/nixos && sudo git pull && sudo nixos-rebuild switch --flake /etc/nixos#KORI-PC"
      echo "    └ Суть: Полный цикл: настройка git, pull конфига и пересборка системы."

      echo -e "  ${y}rebuild${res}"
      echo "    └ Команда: sudo nixos-rebuild switch --flake /etc/nixos#KORI-PC"
      echo "    └ Суть: Быстрая пересборка системы из flake."

      echo -e "  ${y}rebuild_boot${res}"
      echo "    └ Команда: sudo nixos-rebuild boot --flake /etc/nixos#KORI-PC"
      echo "    └ Суть: Пересборка и установка как основной системы для следующей загрузки."

      echo -e "  ${y}rebuild_test${res}"
      echo "    └ Команда: sudo nixos-rebuild test --flake /etc/nixos#KORI-PC"
      echo "    └ Суть: Тестовая пересборка без изменения загрузчика (до первого ребута)."

      echo -e "\n${g}── Конфиг ────────────────────────────────────────────────────${res}"
      echo -e "  ${y}nconf${res}"
      echo "    └ Команда: sudo nano /etc/nixos/head_configuration-MY-PC/==head==.nix"
      echo "    └ Суть: Редактирование главного файла конфигурации (==head==.nix)."

      echo -e "  ${y}nflake${res}"
      echo "    └ Команда: sudo nano /etc/nixos/flake.nix"
      echo "    └ Суть: Редактирование файла flake.nix."

      echo -e "  ${y}ndir${res}"
      echo "    └ Команда: cd /etc/nixos"
      echo "    └ Суть: Быстрый переход в директорию с конфигами /etc/nixos."

      echo -e "\n${g}── Garbage collection (Очистка) ──────────────────────────────${res}"
      echo -e "  ${y}gc${res}"
      echo "    └ Команда: sudo nix-collect-garbage -d"
      echo "    └ Суть: Удаление старых поколений системы от имени sudo."

      echo -e "  ${y}ngc${res}"
      echo "    └ Команда: nix-collect-garbage -d"
      echo "    └ Суть: Обычная очистка мусора пользователя."

      echo -e "  ${y}gcgen${res}"
      echo "    └ Команда: sudo nix-collect-garbage --delete-older-than 7d && sudo nixos-rebuild boot --flake /etc/nixos#KORI-PC"
      echo "    └ Суть: Удаление поколений старше 7 дней и обновление загрузчика."

      echo -e "\n${g}── Nix store / профиль ───────────────────────────────────────${res}"
      echo -e "  ${y}nix_size${res}"
      echo "    └ Команда: du -sh /nix/store | sort -h"
      echo "    └ Суть: Вывод размера хранилища /nix/store, отсортированный по весу."

      echo -e "  ${y}nopt${res}"
      echo "    └ Команда: nix store optimise"
      echo "    └ Суть: Оптимизация хранилища (замена дубликатов жесткими ссылками)."

      echo -e "\n${g}── Flake ─────────────────────────────────────────────────────${res}"
      echo -e "  ${y}flake_update${res}"
      echo "    └ Команда: cd /etc/nixos && sudo nix flake update"
      echo "    └ Суть: Обновление всех входных параметров (inputs) во flake."

      echo -e "  ${y}flake_check${res}"
      echo "    └ Команда: cd /etc/nixos && nix flake check"
      echo "    └ Суть: Проверка целостности и корректности flake."

      echo -e "\n${g}── Пакеты ────────────────────────────────────────────────────${res}"
      echo -e "  ${y}nsh${res}"
      echo "    └ Команда: nix-shell -p [пакет]"
      echo "    └ Суть: Запуск временной оболочки с указанным пакетом."

      echo -e "  ${y}nrun${res}"
      echo "    └ Команда: nix run nixpkgs#[пакет]"
      echo "    └ Суть: Быстрый запуск программы из nixpkgs без установки."
    '';
  };
}
