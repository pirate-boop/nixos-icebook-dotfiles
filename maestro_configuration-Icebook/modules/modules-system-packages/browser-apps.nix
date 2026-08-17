{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Основной браузер ──────────────────────────    
    #vivaldi
    #vivaldi-ffmpeg-codecs  # для видео на YouTube и прочих сайтах
    # google-chrome              # основной (allowUnfree = true)

    # ── Резерв ────────────────────────────────────
    # firefox                    # когда Chrome тупит
    # chromium                   # тест / без Google services
  ];
}
