{ ... }: {
  programs.zsh.shellAliases = {
    # ── Rebuild ───────────────────────────────────────────────────
    # Полный цикл: настройка git, pull конфига и пересборка системы.
    nixos_rebuild = ''
      sudo git -C /etc/nixos config core.editor hx \
      && sudo git config --global --add safe.directory /etc/nixos \
      && cd /etc/nixos \
      && sudo git pull \
      && sudo nixos-rebuild switch --flake /etc/nixos#Kori-Icebook
    '';
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#Kori-Icebook";                                                 # Быстрая пересборка системы из flake.
    rebuild_boot = "sudo nixos-rebuild boot --flake /etc/nixos#Kori-Icebook";                                              # Пересборка и установка как основной системы для следующей загрузки.
    rebuild_test = "sudo nixos-rebuild test --flake /etc/nixos#Kori-Icebook";                                              # Тестовая пересборка без изменения загрузчика (до первого ребута).

    # ── Конфиг ────────────────────────────────────────────────────
    nconf  = "sudo nano /etc/nixos/maestro_configuration-Icebook/igniter.nix";                                            # Редактирование главного файла конфигурации (igniter.nix).
    nflake = "sudo hx /etc/nixos/flake.nix";                                                                        # Редактирование файла flake.nix
    ndir   = "cd /etc/nixos";                                                                                         # Быстрый переход в директорию с конфигами /etc/nixos

    # ── Garbage collection ────────────────────────────────────────
    gc     = "sudo nix-collect-garbage -d";                                                                           # Удаление старых поколений системы от имени sudo (очистка места).
    gcgen  = "sudo nix-collect-garbage --delete-older-than 7d && sudo nixos-rebuild boot --flake /etc/nixos#Kori-Icebook"; # Удаление поколений старше 7 дней и обновление загрузчика.
    ngc    = "nix-collect-garbage -d";                                                                                # Обычная очистка мусора пользователя

    # ── Nix store / профиль ───────────────────────────────────────
    nix_size = "du -sh /nix/store | sort -h";                                                                         # Вывод размера хранилища /nix/store, отсортированный по весу.
    nopt   = "nix store optimise";                                                                                    # Оптимизация хранилища (замена дубликатов жесткими ссылками)

    # ── Flake ─────────────────────────────────────────────────────
    flake_update = "cd /etc/nixos && sudo nix flake update";                                                          # Обновление всех входных параметров (inputs) во flake.
    flake_check  = "cd /etc/nixos && nix flake check";                                                                # Проверка целостности и корректности flake.

    # ── Пакеты ────────────────────────────────────────────────────
    nsh    = "nix-shell -p";                                                                                          # Запуск временной оболочки с указанным пакетом.
    nrun   = "nix run nixpkgs#";                                                                                      # Быстрый запуск программы из nixpkgs без установки.
  };
}
