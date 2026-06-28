{ config, pkgs, ... }:

{
  xdg.desktopEntries = {
    # Имя ярлыка в системе (будет ttt-wezterm.desktop)
    ttt-wezterm = {
      name = "ttt (WezTerm)";
      
      # Запуск WezTerm с выполнением команды ttt и пробросом пути к файлу (%f)
      exec = "wezterm start -- ttt %f"; 
      
      terminal = false; # false, потому что wezterm сам является терминалом
      categories = [ "Utility" "TextEditor" ];
      mimeType = [ "text/plain" ];
    };
  };
}
