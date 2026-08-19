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

  # Добавляем libcap для использования команды setcap
  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper libcap ];
  
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

    # ГЛАВНОЕ РЕШЕНИЕ: Выдаем бинарнику точечные права на управление сетью.
    # CAP_NET_ADMIN позволяет создавать TUN/TAP интерфейсы без полных прав root.
    # CAP_NET_RAW позволяет работать с сырыми сетевыми пакетами.
    # Это позволяет GUI запускаться от обычного пользователя, идеально работая в Wayland и трее.
    setcap cap_net_admin,cap_net_raw+ep $out/bin/fptn-original

    # Создаем простую обертку, которая гарантирует использование Xwayland для совместимости трея
    cat > $out/bin/fptn << 'EOF'
#!/bin/sh
export QT_QPA_PLATFORM=xcb
export GDK_BACKEND=x11
exec $out/bin/fptn-original "$@"
EOF
    chmod +x $out/bin/fptn

    cat > $out/share/applications/fptn.desktop << 'EOF'
[Desktop Entry]
Name=FPTN Client
Comment=FPTN VPN Client (runs as user with network capabilities)
Exec=fptn
Icon=network-vpn
Type=Application
Categories=Network;VPN;
Terminal=false
EOF

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "FPTN VPN Client (uses Linux capabilities instead of full root)";
    homepage = "https://github.com/fptn-project/fptn";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "fptn";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
