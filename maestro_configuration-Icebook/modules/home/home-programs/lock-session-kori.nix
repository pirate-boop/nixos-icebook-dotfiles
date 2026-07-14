{ pkgs, ... }: # Твой существующий заголовок файла (он у тебя уже есть)

{
  # ... какие-то твои настройки ...

  environment.systemPackages = [
    # Твои другие системные пакеты...

    (pkgs.writeShellScriptBin "lock-session-kori" ''
      # 1. Принудительно сбрасываем раскладку на английский (us — индекс 0)
      ${pkgs.niri}/bin/niri msg action set-layout-index 0

      # 2. Вызываем блокировку Dank Material Shell
      dms ipc call lock lock
    '')
  ];
}
