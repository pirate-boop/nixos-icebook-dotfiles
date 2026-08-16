{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  programs.noctalia-greeter = {
    enable = true;
    settings = {
      cursor = {
        theme = "FernBLZ";
        size = 24;
        path = "${inputs.anime-cursors.packages.${pkgs.system}.FernBLZ}/share/icons";
      };
      keyboard = {
        layout = "us,ru";
      };
    };
  };
}
