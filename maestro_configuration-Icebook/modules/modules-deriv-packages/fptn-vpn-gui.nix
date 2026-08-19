{ pkgs, ... }:

let
  version = "0.4.3";
  # Автоматически определяем архитектуру (amd64 или arm64)
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-${arch}.deb";
  
  # Хеш для amd64. Если у тебя aarch64 (Apple Silicon / Raspberry Pi), замени на второй хеш
  debHash = if arch == "amd64" then 
    "sha256-35dbc9c1987c63e71ecd59b98926c4b8a9d56d1fecfdb08f60ed1fc6524709e5" 
  else 
    "sha256-6ac07de2856f3bde6c9bd8cf0d9d7e5db9aff9c0f0a02d3cf35c4ed7dd04771b";

in
pkgs.stdenvNoCC.mkDerivation {
  pname = "fptn-client";
  inherit version;

  src = pkgs.fetchurl {
    url = debUrl;
    sha256 = debHash;
  };

  # dpkg для распаковки .deb, autoPatchelfHook для починки библиотек NixOS
  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
  
  # Базовый набор X11 и графических библиотек. 
  # Если при запуске не хватит какой-то конкретной .so, autoPatchelfHook об этом честно скажет.
  buildInputs = with pkgs; [
    xorg.libX11 xorg.libXext xorg.libXrender xorg.libXcomposite
    xorg.libXdamage xorg.libXfixes xorg.libXrandr xorg.libXcursor
    xorg.libxcb xkeyboardconfig wayland
    gtk3 qt5.qtbase qt5.qtwayland
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    # Копируем содержимое deb пакета в $out
    cp -r usr/* $out/

    # Переименуем оригинальный бинарник, чтобы он не конфликтовал с нашей оберткой
    # (Проверь, что бинарник называется именно fptn. Если fptn-client, поправь имя здесь и ниже)
    mv $out/bin/fptn $out/bin/fptn-original 2>/dev/null || mv $out/bin/fptn-client $out/bin/fptn-original

    # Создаем надежный скрипт-обертку для запуска во вложенном X-сервере (Xephyr)
    cat > $out/bin/fptn-xephyr << EOF
#!/bin/sh
# Находим свободный номер дисплея, чтобы не конфликтовать с другими запущенными X-серверами
DISPLAY_NUM=1
while [ -e /tmp/.X11-unix/X$DISPLAY_NUM ]; do
  DISPLAY_NUM=$((DISPLAY_NUM + 1))
done

echo "Starting nested Xephyr on display :$DISPLAY_NUM..."
# -reset -terminate автоматически закрывает Xephyr, когда клиент отключается
${pkgs.xorg.xephyr}/bin/Xephyr -ac -screen 1024x768 -reset -terminate :$DISPLAY_NUM &
XEPHYR_PID=$!

# Даем Xephyr секунду на инициализацию
sleep 1

echo "Starting FPTN Client..."
# Запускаем само приложение внутри нового дисплея
DISPLAY=:$DISPLAY_NUM $out/bin/fptn-original "\$@"

# На случай, если Xephyr не закрылся автоматически флагом -terminate
kill $XEPHYR_PID 2>/dev/null
EOF
    chmod +x $out/bin/fptn-xephyr

    # Создаем .desktop файл для удобного запуска из меню приложений (Rofi, Wofi, GNOME, KDE и т.д.)
    mkdir -p $out/share/applications
    cat > $out/share/applications/fptn-xephyr.desktop << EOF
[Desktop Entry]
Name=FPTN Client (Nested X11)
Comment=FPTN VPN Client running in a safe nested Xephyr window
Exec=fptn-xephyr
Icon=network-vpn
Type=Application
Categories=Network;VPN;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "FPTN VPN Client (wrapped in nested Xephyr for maximum X11 compatibility)";
    homepage = "https://github.com/fptn-project/fptn";
    license = licenses.unfree; # Уточни лицензию, если она известна (часто проприетарная)
    platforms = platforms.linux;
    mainProgram = "fptn-xephyr";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
