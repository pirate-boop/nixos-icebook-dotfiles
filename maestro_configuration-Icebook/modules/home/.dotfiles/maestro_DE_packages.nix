#****************************************************************#
# |============================================================| #
# |DE PACKAGES — дирижёр                                       | #
# |============================================================| #
#  illogical-impulse ставится через home-manager (см. home.nix)  #
#  Здесь — системные зависимости которые illogical требует        #
#  на уровне NixOS (не home-manager)                             #
#  Структура папки:                                               #
#    hyprland/     → keybinds.nix, monitors.nix, rules.nix       #
#    illogical/    → кастомные конфиги после первой настройки     #
#    Wallpapers/   → обои, импорт через home-manager              #
#****************************************************************#
{ pkgs, ... }: {
  imports = [
    # Hyprland конфиги (через home-manager, не здесь)
    # Пока пусто — hyprland конфиги пишутся в home/
  ];

  # Системные зависимости illogical-impulse
  environment.systemPackages = with pkgs; [
    # ── Python для скриптов illogical ────────────
    (python3.withPackages (ps: with ps; [
      pillow        # анализ обоев (цветовая схема)
      pywal         # pywal/wal для тем
      materialyoucolor  # Material You цвета
    ]))

    # ── Qt6 модули (нужны QuickShell) ─────────────
    qt6.qtpositioning
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtsvg
    qt6.qtdeclarative

    # ── Прочие зависимости ────────────────────────
    imagemagick   # обработка изображений
    swww          # динамические обои Wayland
    matugen       # Material You генератор тем
  ];
}
