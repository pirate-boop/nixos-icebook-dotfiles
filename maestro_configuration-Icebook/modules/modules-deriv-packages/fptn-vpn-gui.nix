{ pkgs, ... }:

let
  version = "0.4.3";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-${arch}.deb";
  
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
  
  # Отключаем стандартную Qt-обертку Nix
  dontWrapQtApps = true;

  buildInputs = with pkgs; [
    libx11 libxext libxrender libxcomposite libxdamage libxfixes 
    libxrandr libxcursor libxcb xkeyboardconfig
    gtk3 qt5.qtbase qt5.qtwayland
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/share/icons

    cp -r usr/bin/* $out/bin/
    cp -r usr/share/* $out/share/

    if [ -f $out/bin/fptn ]; then
      mv $out/bin/fptn $out/bin/fptn-original
    elif [ -f $out/bin/fptn-client ]; then
      mv $out/bin/fptn-client $out/bin/fptn-original
    fi

    # МАГИЯ ДЛЯ МОНОЛИТНЫХ ROOT-ПРИЛОЖЕНИЙ:
    # Создаем обертку, которая запрашивает права root через Polkit (pkexec),
    # но ПРИНУДИТЕЛЬНО пробрасывает переменные окружения твоей пользовательской сессии,
    # чтобы root-процесс мог отрисовать окно в твоем Wayland/X11.
    cat > $out/bin/fptn << 'EOF'
#!/bin/sh
# Собираем необходимые переменные окружения для отрисовки GUI от root
ENV_VARS="DISPLAY=$DISPLAY"
[ -n "$XAUTHORITY" ] && ENV_VARS="$ENV_VARS XAUTHORITY=$XAUTHORITY"
[ -n "$WAYLAND_DISPLAY" ] && ENV_VARS="$ENV_VARS WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
[ -n "$XDG_RUNTIME_DIR" ] && ENV_VARS="$ENV_VARS XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
[ -n "$XDG_SESSION_TYPE" ] && ENV_VARS="$ENV_VARS XDG_SESSION_TYPE=$XDG_SESSION_TYPE"

# Принудительно указываем Qt использовать X11 (через Xwayland), 
# так как это самый надежный способ для legacy-приложений с треем
ENV_VARS="$ENV_VARS QT_QPA_PLATFORM=xcb"
ENV_VARS="$ENV_VARS GDK_BACKEND=x11"

# Запускаем оригинальный бинарник через pkexec (запрос пароля) с проброшенными переменными
exec pkexec env $ENV_VARS $out/bin/fptn-original "$@"
EOF
    chmod +x $out/bin/fptn

    # .desktop файл теперь просто вызывает нашу умную обертку
    cat > $out/share/applications/fptn.desktop << 'EOF'
[Desktop Entry]
Name=FPTN Client
Comment=FPTN VPN Client (requires root, runs via Polkit)
Exec=fptn
Icon=network-vpn
Type=Application
Categories=Network;VPN;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "FPTN VPN Client (monolithic root wrapper with Xwayland compatibility)";
    homepage = "https://github.com/fptn-project/fptn";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "fptn";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
