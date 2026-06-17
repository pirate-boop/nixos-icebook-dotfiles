{ pkgs, ... }:

let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };

in {
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    
    extraPackages = [
      custom-sddm-astronaut
      pkgs.kdePackages.qtmultimedia
    ];
  };
}
