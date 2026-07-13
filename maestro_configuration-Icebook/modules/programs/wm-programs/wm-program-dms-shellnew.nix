{ config, pkgs, inputs, ... }:

{

  # ==========================================
  # 1. ОБОЛОЧКА: Dank Material Shell
  # ==========================================
  programs.dms-shell = {
    enable = true;
    enableDynamicTheming = true;     
    enableSystemMonitoring = true;    
    enableAudioWavelength = true;     
    enableClipboardPaste = true;      
    enableCalendarEvents = true;      
    enableVPN = true;                
    systemd.enable = true;
    systemd.restartIfChanged = true;  
  };
}
