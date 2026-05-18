{ ... }: {
  environment.sessionVariables = {
    # Явно указывает, что текущая сессия — Wayland.
    XDG_SESSION_TYPE = "wayland";

    # Идентификатор текущего рабочего стола для xdg-desktop-portal.
    XDG_CURRENT_DESKTOP = "niri";

    # Указывает на использование конкретной среды рабочего стола.
    XDG_SESSION_DESKTOP = "niri";
  };
}
