{ config, pkgs, ... }:

{
  xdg.desktopEntries = {
    daed = {
      name = "DAED Proxy";
      genericName = "eBPF Proxy Client";
      comment = "Запуск DAED Core в фоновом режиме";
      
      # Заменяем "sudo daed run" на "pkexec daed run"
      # pkexec вызовет графическое окошко пароля, а потом выполнит daed с аргументом run
      exec = "pkexec daed run"; 
      
      icon = "network-vpn";
      terminal = false; # Терминал не откроется, всё уйдет в фон
      categories = [ "Network" ];
    };
  };
}
