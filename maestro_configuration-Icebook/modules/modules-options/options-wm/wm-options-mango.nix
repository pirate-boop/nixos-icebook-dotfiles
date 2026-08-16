{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  # ==========================================
  # 1. СИСТЕМНЫЙ МОДУЛЬ MANGO
  # ==========================================
  programs.mango.enable = true;

  # ==========================================
  # 2. ОБОЛОЧКА: Dank Material Shell
  # ==========================================
  programs.dms-shell = {
    enable = true;
    enableDynamicTheming = true;     
    enableSystemMonitoring = true;    
    enableAudioWavelength = true;     
    enableClipboardPaste = true;      
    enableCalendarEvents = true;      
    enableVPN = false;                
    systemd.enable = true;
    systemd.restartIfChanged = true;  
  };

  # ==========================================
  # 3. ДЕКЛАРАТИВНЫЙ АВТОСТАРТ НА ДИСКЕ
  # ==========================================
  # Создаем скрипт автозапуска напрямую для пользователя Kori
  # NixOS положит этот файл ровно туда, куда нужно mango
 

  # ==========================================
  # 4. ЭКРАН ВХОДА
  # ==========================================
  services.displayManager = {
    defaultSession = "mango"; 
    autoLogin = {
      enable = true;
      user = "Kori";
    };
  };
}
