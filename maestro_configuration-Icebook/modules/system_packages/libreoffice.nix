{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── LibreOffice ───────────────────────────────
    libreoffice-qt-fresh
    hunspellDicts.ru_RU    # русская проверка орфографии
    hunspellDicts.en_US    # английская
  ];
}
