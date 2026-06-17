{ pkgs, ... }:

let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
  };

in {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Обязательно для SDDM, если выключен X-сервер
    theme = "sddm-astronaut-theme";
    
    extraPackages = [
      custom-sddm-astronaut
      pkgs.kdePackages.qtmultimedia
    ];
  };
}
