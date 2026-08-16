{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, wrapGAppsHook
, alsa-lib
, atk
, cairo
, cups
, dbus
, dbus-glib
, ffmpeg
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gtk3
, libglvnd
, libjack2
, libkrb5
, libnotify
, libpulseaudio
, libdrm
, mesa
, nspr
, nss
, pango
, pipewire
, udev
, xorg
, wayland
, libwebp
, libevent
, libvpx
, icu
, sqlite
, gtk4
, ...
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.21.14b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper wrapGAppsHook ];

  buildInputs = [
    stdenv.cc.cc.lib alsa-lib atk cairo cups dbus dbus-glib ffmpeg
    fontconfig freetype gdk-pixbuf glib gtk3 libglvnd libjack2
    libkrb5 libnotify libpulseaudio libdrm mesa nspr nss pango
    pipewire udev wayland libwebp libevent libvpx icu sqlite gtk4
    xorg.libX11 xorg.libXcomposite xorg.libXdamage xorg.libXext
    xorg.libXfixes xorg.libXrandr xorg.libxcb xorg.libxshmfence
    xorg.libXtst
  ];

  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/zen-browser
    cp -r zen/* $out/lib/zen-browser/ 2>/dev/null || cp -r * $out/lib/zen-browser/

    mkdir -p $out/bin
    makeWrapper $out/lib/zen-browser/zen $out/bin/zen \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --set MOZ_ENABLE_WAYLAND 1 \
      --set MOZ_USE_XINPUT2 1

    mkdir -p $out/share/applications
    cat > $out/share/applications/zen-browser.desktop <<EOF
    [Desktop Entry]
    Name=Zen Browser
    Exec=$out/bin/zen %u
    Icon=zen-browser
    Type=Application
    Categories=Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
    EOF

    mkdir -p $out/share/icons/hicolor/128x128/apps
    for size in 16 32 48 64 128; do
      icon="$out/lib/zen-browser/browser/chrome/icons/default/default''${size}.png"
      [ -f "$icon" ] && cp "$icon" "$out/share/icons/hicolor/''${size}x''${size}/apps/zen-browser.png"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Zen Browser";
    homepage = "https://zen-browser.app/";
    license = licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
