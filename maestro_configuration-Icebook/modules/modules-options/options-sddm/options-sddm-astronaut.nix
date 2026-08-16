{ pkgs, ... }:

let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };
in {
  # Добавляем тему в системные пакеты, чтобы SDDM её видел
  environment.systemPackages = [
    custom-sddm-astronaut
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";

    # Здесь оставляем только зависимости
    extraPackages = [
      pkgs.kdePackages.qtmultimedia
    ];
  };
}
