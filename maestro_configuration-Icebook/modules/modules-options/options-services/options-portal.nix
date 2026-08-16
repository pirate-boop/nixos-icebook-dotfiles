{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome 
    ];
    config.common.default = [ "gnome" "gtk" ];
    config.common."org.freedesktop.impl.portal.FileChooser" = "gtk";
    config.niri.default = [ "gnome" "gtk" ];
    config.niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
  };
  services.gnome.gnome-keyring.enable = true;
}
