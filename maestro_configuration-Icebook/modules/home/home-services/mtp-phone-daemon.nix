{ pkgs, ... }: {
  systemd.user.services.mtp-automount-daemon = {
    Unit = {
      Description = "Фоновый мониторинг, автомонтирование MTP и создание симлинка";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = pkgs.writeScriptBin "mtp-mon" ''
        #!/bin/sh
        GVFS_DIR="/run/user/1000/gvfs"
        LINK_DIR="$HOME/mtp-phones"

        # Функция для наведения порядка с симлинками
        manage_symlink() {
          # Удаляем старый битый симлинк, если он остался
          rm -f "$LINK_DIR"
          
          # Ищем внутри gvfs папку, которая начинается с mtp
          MTP_FOLDER=$(ls -d $GVFS_DIR/mtp* 2>/dev/null | head -n 1)
          
          if [ -n "$MTP_FOLDER" ]; then
            ln -s "$MTP_FOLDER" "$LINK_DIR"
          fi
        }

        # Первичная проверка при старте сервиса (вдруг телефон уже торчит)
        manage_symlink

        # Мониторим шину на добавление и удаление устройств
        ${pkgs.glib}/bin/gio monitor -v | while read -r line; do
          
          # ТРИГГЕР НА ПОДКЛЮЧЕНИЕ
          if echo "$line" | ${pkgs.gnugrep}/bin/grep -q "Volume added.*MTP"; then
            sleep 1
            DEV_PATH=$(${pkgs.glib}/bin/gio mount -l -i | ${pkgs.gnugrep}/bin/grep -A 5 "GProxyVolumeMonitorMTP" | ${pkgs.gnugrep}/bin/grep "unix-device:" | ${pkgs.gawk}/bin/awk -F"'" '{print $2}')
            if [ -n "$DEV_PATH" ]; then
              ${pkgs.glib}/bin/gio mount -d "$DEV_PATH"
              sleep 1
              manage_symlink
            fi
          fi

          # ТРИГГЕР НА ОТКЛЮЧЕНИЕ (выдернули шнур)
          if echo "$line" | ${pkgs.gnugrep}/bin/grep -qE "Volume removed|Drive disconnected"; then
            manage_symlink
          fi

        done
      '';
      Restart = "always";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
