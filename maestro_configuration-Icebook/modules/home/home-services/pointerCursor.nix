{ inputs, pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "FernBLZ";
    size = 24;
    package = inputs.anime-cursors.packages.${pkgs.system}.FernBLZ;
  };
}
