# Добавляем inputs в фигурные скобки сверху
{ config, pkgs, inputs, ... }:

{
  # Явно импортируем модуль из флейка прямо здесь
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  # ==========================================
  # 1. ВКЛЮЧАЕМ КОМПОЗИТОР MANGO (По твоей доке)
  # ==========================================
  programs.mango.enable = true;
  
  # ... весь остальной твой код ниже без изменений ...
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

  services.displayManager = {
    defaultSession = "mango"; 
    autoLogin = {
      enable = true;
      user = "Kori";
    };
  };
}
