{ ... }: {
  environment.sessionVariables = {
    # Принудительно запускает Qt-приложения в Wayland, с откатом на X11 при ошибке.
    QT_QPA_PLATFORM = "wayland;xcb";

    # Отключает системные заголовки окон для Qt, чтобы Niri сама ими управляла.
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Включает автоматическое масштабирование интерфейса для High-DPI мониторов.
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # Указывает GTK использовать Wayland (с поддержкой X11 через XWayland).
    GDK_BACKEND = "wayland,x11";

    # Устанавливает конкретную тему оформления для GTK3 приложений.
    GTK_THEME = "adw-gtk3";

    # Фикс для Java-приложений (JetBrains IDE), чтобы они не отрисовывали пустые окна.
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
