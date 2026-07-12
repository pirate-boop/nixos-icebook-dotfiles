{ config, pkgs, ... }:

{
  # ==========================================
  # 1. ВКЛЮЧАЕМ КОМПОЗИТОР MANGO (По твоей доке)
  # ==========================================
  # Используем родную опцию из флейка, а не системный мусор
  programs.mango.enable = true;
  
  # Пакет подтянется автоматически (mango-nightly из флейка), 
  # переопределять package вручную НЕ НАДО.

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
  # 3. ЭКРАН ВХОДА (Display Manager)
  # ==========================================
  # Раз ты используешь дисплей-менеджер (SDDM/GDM), 
  # настраиваем автологин прямо в сессию mango, как написано в опции B
  services.displayManager = {
    defaultSession = "mango"; 
    autoLogin = {
      enable = true;
      user = "Kori"; # Твой юзернейм
    };
  };
}
