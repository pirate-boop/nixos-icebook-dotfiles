{ pkgs, ... }:

let
  version = "0.4.3";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-${arch}.deb";
  
  # Используем чистый hex-хеш в атрибуте sha256, как ты и указал
  debHash = if arch == "amd64" then 
    "35dbc9c1987c63e71ecd59b98926c4b8a9d56d1fecfdb08f60ed1fc6524709e5" 
  else 
    "6ac07de2856f3bde6c9bd8cf0d9d7e5db9aff9c0f0a02d3cf35c4ed7dd04771b";

in
pkgs.stdenvNoCC.mkDerivation {
  pname = "fptn-client";
  inherit version;

  src = pkgs.fetchurl {
    url = debUrl;
    sha256 = debHash;
  };

  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
  
  # Отключаем автоматическую обертку Qt, так как мы создаем свою изолированную среду
  dontWrapQtApps = true;

  buildInputs = with pkgs; [
    libx11 libxext libxrender libxcomposite libxdamage libxfixes 
    libxrandr libxcursor libxcb xkeyboardconfig wayland
    gtk3 qt5.qtbase qt5.qtwayland
    stdenv.cc.cc.lib
  ];

  # ЗОЛОТОЙ СТАНДАРТ: распаковываем .deb сразу напрямую в $out
  # Это на 100% исключает ошибки cp и проблемы с путями
  unpackPhase = ''
    dpkg-deb -x $src $out
  '';

  installPhase = ''
    runHook preInstall

    # Надежно переименовываем оригинальный бинарник
    if [ -f $out/bin/fptn ]; then
      mv $out/bin/fptn $out/bin/fptn-original
    elif [ -f $out/bin/fptn-client ]; then
      mv $out/bin/fptn-client $out/bin/fptn-original
    fi

    # Создаем скрипт-обертку для изолированного X11-окна с треем
    cat > $out/bin/fptn-tray-window << 'EOF'
#!/bin/sh
DISPLAY_NUM=1
while [ -e /tmp/.X11-unix/X$DISPLAY_NUM ]; do
  DISPLAY_NUM=$((DISPLAY_NUM + 1))
done

echo "Starting mini X11 environment with system tray on display :$DISPLAY_NUM..."

XEPHYR_BIN="${pkgs.xorg-server}/bin/Xephyr"
$XEPHYR_BIN -ac -screen 1024x768 -reset -terminate :$DISPLAY_NUM &
XEPHYR_PID=$!
sleep 1

cleanup() {
  kill $XEPHYR_PID 2>/dev/null
}
trap cleanup EXIT

export DISPLAY=:$DISPLAY_NUM

${pkgs.openbox}/bin/openbox &
sleep 0.5

TRAYER_BIN="${pkgs.trayer}/bin/trayer"
$TRAYER_BIN --edge top --align right --widthtype request --padding 6 --transparent true --alpha 0 --tint 0x000000 --heighttype pixel --height 24 &
sleep 0.5

echo "Starting FPTN Client inside nested environment..."
$out/bin/fptn-original "$@"
EOF
    chmod +x $out/bin/fptn-tray-window

    mkdir -p $out/share/applications
    cat > $out/share/applications/fptn-tray-window.desktop << 'EOF'
[Desktop Entry]
Name=FPTN Client (with System Tray)
Comment=FPTN VPN running in a lightweight isolated X11 window with tray support
Exec=fptn-tray-window
Icon=network-vpn
Type=Application
Categories=Network;VPN;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "FPTN VPN Client (wrapped in minimal X11 env with system tray support)";
    homepage = "https://github.com/fptn-project/fptn";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "fptn-tray-window";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
