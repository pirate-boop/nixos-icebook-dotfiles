{ pkgs, ... }:

let
  version = "0.4.3";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-${arch}.deb";
  
  # Чистый hex-хеш для атрибута sha256 (без префиксов, как требует Nix)
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
  
  # Отключаем стандартную Qt-обертку Nix, так как мы контролируем окружение вручную
  dontWrapQtApps = true;

  buildInputs = with pkgs; [
    libx11 libxext libxrender libxcomposite libxdamage libxfixes 
    libxrandr libxcursor libxcb xkeyboardconfig
    gtk3 qt5.qtbase qt5.qtwayland
    stdenv.cc.cc.lib
  ];

  # Распаковываем deb во временную директорию сборки, а не напрямую в $out
  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    # Явно создаем нужные директории в $out
    mkdir -p $out/bin $out/share/applications $out/share/icons

    # Корректно копируем содержимое из извлеченного usr/ в $out
    cp -r usr/bin/* $out/bin/
    cp -r usr/share/* $out/share/

    # Переименовываем оригинальный бинарник
    if [ -f $out/bin/fptn ]; then
      mv $out/bin/fptn $out/bin/fptn-original
    elif [ -f $out/bin/fptn-client ]; then
      mv $out/bin/fptn-client $out/bin/fptn-original
    fi

    # СОВРЕМЕННОЕ РЕШЕНИЕ: Xwayland + xembed-sni-proxy
    # Это стандартный способ запускать X11-приложения с треем в Wayland без вложенных WM
    cat > $out/bin/fptn-wayland << 'EOF'
#!/bin/sh
# Запускаем мост для трансляции X11-трея в современный Wayland SNI (Status Notifier Item)
${pkgs.xembed-sni-proxy}/bin/xembed-sni-proxy &
PROXY_PID=$!

# Гарантированно очищаем фоновый процесс при закрытии приложения
cleanup() {
  kill $PROXY_PID 2>/dev/null
}
trap cleanup EXIT

# Принудительно указываем Qt использовать X11 (через Xwayland). 
# Это обходит хардкод разработчика и гарантирует корректную отрисовку трей-иконки.
export QT_QPA_PLATFORM=xcb

echo "Starting FPTN Client via Xwayland with modern SNI proxy..."
$out/bin/fptn-original "$@"
EOF
    chmod +x $out/bin/fptn-wayland

    # Создаем .desktop файл для меню приложений
    cat > $out/share/applications/fptn-wayland.desktop << 'EOF'
[Desktop Entry]
Name=FPTN Client (Wayland Compatible)
Comment=FPTN VPN with X11 tray icon bridged to native Wayland
Exec=fptn-wayland
Icon=network-vpn
Type=Application
Categories=Network;VPN;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "FPTN VPN Client (with xembed-sni-proxy for seamless Wayland tray support)";
    homepage = "https://github.com/fptn-project/fptn";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "fptn-wayland";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
