{ inputs, pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "FernBLZ";
    size = 24;
    package = inputs.anime-cursors.packages.${pkgs.stdenv.hostPlatform.system}.FernBLZ;
  };
}
