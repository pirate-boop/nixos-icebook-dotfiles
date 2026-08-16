#****************************************************************#
# |============================================================| #
# | MTP AUTOMOUNT DAEMON — Полный автомат для телефона/планшета | #
# |============================================================| #
#  Слушит D-Bus, монтирует по unix-device, делает симлинк        #
#  в ~/mtp-phones при подключении и сносит его при отключении.   #
#****************************************************************#
{ pkgs, ... }: {

  systemd.user.services.mtp-automount-daemon = {
    Unit = {
      Description = "Фоновый мониторинг, автомонтирование MTP и создание симлинка";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      # pkgs.writeScript создаёт чистый исполняемый файл без лишних вложенных папок bin/
      ExecStart = pkgs.writeScript "mtp-automount-script" ''
        #!/bin/sh
        GVFS_DIR="/run/user/1000/gvfs"
        LINK_DIR="$HOME/mtp-phones"

        # Функция управления ярлыком (симлинком)
        manage_symlink() {
          # Удаляем старую ссылку, если она застряла
          rm -f "$LINK_DIR"
          
          # Ищем актуальную папку mtp в gvfs
          MTP_FOLDER=$(ls -d $GVFS_DIR/mtp* 2>/dev/null | head -n 1)
          
          # Если нашли — создаем стабильную ссылку в хомяке
          if [ -n "$MTP_FOLDER" ]; then
            ln -s "$MTP_FOLDER" "$LINK_DIR"
          fi
        }

        # Проверяем при старте (вдруг девайс уже был воткнут до запуска сервиса)
        manage_symlink

        # Запускаем бесконечный мониторинг событий gvfs
        ${pkgs.glib}/bin/gio monitor -v | while read -r line; do
          
          # ТРИГГЕР НА ПОДКЛЮЧЕНИЕ ТЕЛЕФОНА/ПЛАНШЕТА
          if echo "$line" | ${pkgs.gnugrep}/bin/grep -q "Volume added.*MTP"; then
            sleep 1
            # Вытягиваем динамический путь unix-device на лету
            DEV_PATH=$(${pkgs.glib}/bin/gio mount -l -i | ${pkgs.gnugrep}/bin/grep -A 5 "GProxyVolumeMonitorMTP" | ${pkgs.gnugrep}/bin/grep "unix-device:" | ${pkgs.gawk}/bin/awk -F"'" '{print $2}')
            if [ -n "$DEV_PATH" ]; then
              ${pkgs.glib}/bin/gio mount -d "$DEV_PATH"
              sleep 1
              manage_symlink
            fi
          fi

          # ТРИГГЕР НА ОТКЛЮЧЕНИЕ (выдернули провод)
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
