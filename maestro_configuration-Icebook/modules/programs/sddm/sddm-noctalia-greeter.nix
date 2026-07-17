{ inputs, pkgs, ... }:
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  programs.noctalia-greeter = {
    enable = true;
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      keyboard = {
        layout = "us,ru";
      };
    };
  };
}
