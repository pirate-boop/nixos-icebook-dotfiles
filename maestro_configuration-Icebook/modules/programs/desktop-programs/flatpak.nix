{ pkgs, ... }: {
  # Включаем системный демон Flatpak
  services.flatpak.enable = true;

  # Базовые утилиты и графический магазин
  environment.systemPackages = with pkgs; [
    flatpak
    gnome-software  # Графический магазин приложений
  ];

  # Блок xdg.portal полностью удален, так как он декларативно
  # настроен в твоем модуле modules/programs/services/portal.nix

  # Декларативное добавление ВСЕХ основных репозиториев
  systemd.services.configure-flatpak-repos = {
    description = "Автоматическое добавление репозиториев Flatpak";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # 1. Основной стабильный Flathub (Steam, Zoom, Discord и т.д.)
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

      # 2. Flathub Beta (резервный репозиторий с бета-версиями софта)
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/repo/flathub-beta.flatpakrepo

      # 3. GNOME Nightly (официальный репозиторий приложений GNOME)
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
    '';
  };
}
