{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Wayland базовые ───────────────────────────
    wayland
    wayland-utils
    wayland-protocols
    xwayland

    # ── Niri утилиты ─────────────────────────────
    quickshell                 # основа для Noctalia shell
                               # dotfiles Noctalia → ~/.config/quickshell/
    fuzzel                     # лаунчер (рекомендован для Niri)
    # rofi                       # альтернативный лаунчер

    # ── Экран блокировки ──────────────────────────
    # swaylock                   # стандартная блокировка для wlroots/niri

    # ── Нотификации ───────────────────────────────
    # mako                       # легковесные уведомления для Wayland
    libnotify

    # ── Трей / апплеты ────────────────────────────
    # networkmanagerapplet
    # blueman                    # Bluetooth GUI

    # ── Темы / курсоры / иконки ───────────────────
    papirus-icon-theme
    bibata-cursors
    adw-gtk3
    gnome-themes-extra

    # ── Qt/GTK интеграция ─────────────────────────
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    adwaita-qt
    nwg-look                   # GTK settings GUI

    # ── Clipboard ─────────────────────────────────
    cliphist
    wl-clipboard

    # ── Скриншоты ─────────────────────────────────
    grim                       # снимок экрана Wayland
    slurp                      # выбор области

    # ── Прочее UI ─────────────────────────────────
    wlogout                    # меню выхода
    swayosd                    # OSD громкость/яркость

    # ── Waybar (резерв если noctalia не заведётся) ─
    # waybar
    # noctalia-shell
  ];
}
