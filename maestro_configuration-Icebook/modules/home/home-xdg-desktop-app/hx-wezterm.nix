{ config, pkgs, ... }:

{
  xdg.desktopEntries = {
    # Имя ярлыка в системе (будет hx-wezterm.desktop)
    hx-wezterm = {
      name = "Helix (WezTerm)";
      
      # Твоя команда запуска с флагом %f для передачи открываемого файла
      exec = "wezterm start -- hx %f"; 
      
      terminal = false;
      categories = [ "Utility" "TextEditor" ];
      mimeType = [ "text/plain" ];
    };
  };
}
