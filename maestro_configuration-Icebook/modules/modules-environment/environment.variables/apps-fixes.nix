{ ... }: {
  environment.sessionVariables = {
    # Включает нативную поддержку Wayland в Firefox (вместо работы через XWayland).
    MOZ_ENABLE_WAYLAND = "1";

    # Масштабирование интерфейса Steam (1 — стандарт, можно менять на 1.25, 1.5 и т.д.)
    STEAM_FORCE_DESKTOPUI_SCALING = "1";

    # Ручная база маппинга кнопок геймпада (Steam обычно сам всё подхватывает)
    SDL_GAMECONTROLLERCONFIG = "";
  };
}
