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
  # 3. АВТОСТАРТ ЧЕРЕЗ HOME MANAGER (По твоей доке)
  # ==========================================
  # Добавляем скрипт автозапуска прямо в домашнюю конфигурацию
  home-manager.users.Kori = {
    wayland.windowManager.mango = {
      enable = true;
      autostart_sh = ''
        dms-shell &
      '';
    };
  };

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
