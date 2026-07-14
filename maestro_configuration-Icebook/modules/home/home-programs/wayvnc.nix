{ pkgs, lib, config, ... }:

let
  # Путь к файлу пароля в твоем домашнем каталоге
  vncPasswdFile = "${config.home.homeDirectory}/.config/wayvnc/passwd";

  # ==========================================================
  # БИНАРНИКИ ПРОГРАММ (Доступны глобально)
  # ==========================================================

  # 1. Программа для запуска по USB (порт 5901, без пароля)
  wayvnc-usb = pkgs.writeShellScriptBin "wayvnc-usb" ''
    echo "Создаю виртуальный экран в Niri (1920x1080)..."
    niri msg action create-headless-output 1920 1080
    
    echo "Запускаю WayVNC по USB на порту 5901..."
    RIGHT_PANE=$(wezterm cli split-pane --right --percent 50)
    wezterm cli send-text --pane-id "$RIGHT_PANE" "${pkgs.wayvnc}/bin/wayvnc -o headless-0 -S 0.0.0.0 -p 5901; echo; echo '=== VNC (USB) сессия завершена ==='; read"
  '';

  # 2. Программа для запуска по Wi-Fi (порт 5900, с проверкой/запросом пароля)
  wayvnc-wifi = pkgs.writeShellScriptBin "wayvnc-wifi" ''
    CONFIG_DIR="$HOME/.config/wayvnc"
    PASSWD_FILE="$CONFIG_DIR/passwd"

    # Если пароля нет — запрашиваем его создание
    if [ ! -f "$PASSWD_FILE" ]; then
        echo "=== Первый запуск: настройка VNC-пароля для Wi-Fi ==="
        mkdir -p "$CONFIG_DIR"
        while true; do
            read -s -p "Введите новый VNC-пароль: " pass1
            echo ""
            read -s -p "Повторите пароль: " pass2
            echo ""
            if [ "$pass1" = "$pass2" ]; then
                echo "$pass1" > "$PASSWD_FILE"
                chmod 600 "$PASSWD_FILE"
                echo "✅ Пароль сохранен!"
                break
            else
                echo "❌ Пароли не совпадают. Попробуйте еще раз."
                echo ""
            fi
        done
    fi

    echo "Создаю виртуальный экран в Niri (1920x1080)..."
    niri msg action create-headless-output 1920 1080

    echo "Запускаю защищенный WayVNC на порту 5900 (конфиг Home Manager)..."
    RIGHT_PANE=$(wezterm cli split-pane --right --percent 50)
    wezterm cli send-text --pane-id "$RIGHT_PANE" "${pkgs.wayvnc}/bin/wayvnc; echo; echo '=== VNC (Wi-Fi) сессия завершена ==='; read"
  '';

  # 3. Программа для сброса забытого пароля
  wayvnc-restore-passwd = pkgs.writeShellScriptBin "wayvnc-restore-passwd" ''
    PASSWD_FILE="$HOME/.config/wayvnc/passwd"
    if [ -f "$PASSWD_FILE" ]; then
        rm -f "$PASSWD_FILE"
        echo "✅ VNC-пароль сброшен."
        echo "При следующем запуске 'wayvnc-wifi' система попросит задать новый."
    else
        echo "ℹ️ Пароль еще не был настроен."
    fi
  '';
in
{
  # ==========================================================
  # ДЕКЛАРАТИВНЫЕ ОПЦИИ WAYVNC
  # ==========================================================
  services.wayvnc = {
    enable = true;
    package = pkgs.wayvnc;
    autoStart = false; # НЕ запускаем автостартом как фоновую службу Systemd
    systemdTarget = "niri-session.target";

    settings = {
      address = "0.0.0.0";
      port = 5900;
      output = "headless-0";
      unencrypted_auth = true;
      password_file = vncPasswdFile;
    };
  };

  # ==========================================================
  # РЕГИСТРАЦИЯ ПРОГРАММ В СИСТЕМЕ
  # ==========================================================
  home.packages = [
    wayvnc-usb
    wayvnc-wifi
    wayvnc-restore-passwd
  ];
}
