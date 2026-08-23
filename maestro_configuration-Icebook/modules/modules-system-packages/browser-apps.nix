{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Основной браузер ──────────────────────────    
    #vivaldi
    #vivaldi-ffmpeg-codecs  # для видео на YouTube и прочих сайтах
    vivaldi-snapshot
    # google-chrome              # основной (allowUnfree = true)
    floorp-bin
    #orion-browser
    firefox
    # ── Резерв ────────────────────────────────────
    # firefox                    # когда Chrome тупит
    # chromium                   # тест / без Google services
    brave
  ];
}
