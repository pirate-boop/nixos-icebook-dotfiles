{ config, pkgs, ... }:

{
  # ==========================================
  # 1. ОСНОВА: Включение композитора
  # ==========================================
  programs.mangowc.enable = true;
  # programs.mangowc.package = pkgs.mangowc; # Нужен только если собираешь из кастомного оверлея
  programs.mangowc.package = true;

  # ==========================================
  # 2. ОБОЛОЧКА: Dank Material Shell и фичи
  # ==========================================
  programs.dms-shell = {
    enable = true;
    
    # Встроенные фичи, которые сделают «красиво» и юзабельно
    enableDynamicTheming = true;     # Тот самый Material You / пресеты в один клик
    enableSystemMonitoring = true;    # Виджеты процессов и загрузки железа
    enableAudioWavelength = true;     # Визуализатор/управление звуком
    enableClipboardPaste = true;      # Работа с буфером обмена
    enableCalendarEvents = true;      # Календарь в шторке
    enableVPN = false;                # Включи (true), если управляешь VPN из панели

    # Управление жизненным циклом через systemd
    systemd.enable = true;
    systemd.restartIfChanged = true;  # Перезапускать панель на лету при изменении конфига NixOS
  };

  # ==========================================
  # 3. ПЛАГИНЫ: Раскладка клавиатуры
  # ==========================================
  # Прописываем плагин переключения, о котором ты говорил
  programs.dms-shell.plugins."layout-switcher" = {
    enable = true;
    # src = pkgs.fetchFromGitHub { ... }; # Укажи источник, если плагина нет в самом пакете
  };

  # ==========================================
  # 4. ЭКРАН ВХОДА (Опционально)
  # ==========================================
  # Включай ЭТОТ блок только если хочешь, чтобы при загрузке ноута 
  # тебя встречал родной dms-дисплей-менеджер вместо твоего текущего greetd/sddm.
  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "mangowc"; # Запускать экран входа именно внутри манго
  #   logs.save = true;            # Сохранять логи гритера, если что-то пойдет не так
  #   logs.path = "/var/log/dms-greeter.log";
  # };
}
