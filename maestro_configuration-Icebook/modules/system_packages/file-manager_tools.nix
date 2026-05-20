{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #  nemo-with-extensions     # File browser for Cinnamon
    yazi                     # TUI файл-менеджер
    # nautilus               # GUI (GTK, работает в Hyprland)
    # nautilus-open-any-terminal
    # sushi
    code-nautilus
    kdePackages.dolphin    # File manager by KDE
    kdePackages.dolphin-plugins
    thunar
    thunar-volman        # автомонтирование
    thunar-archive-plugin # правый клик → архивы
    thunar-media-tags-plugin # теги медиа файлов
    thunar-vcs-plugin    # git интеграция
  ];
}
