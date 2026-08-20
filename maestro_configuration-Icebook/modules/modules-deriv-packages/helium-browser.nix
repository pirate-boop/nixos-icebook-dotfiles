{ pkgs, ... }:

let
  version = "0.15.5.1";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-bin_${version}-1_${arch}.deb";
  
  debHash = if arch == "amd64" then 
    "8c5e6a3d878289baee16aa87fb49619fa9f675fe4adf5c556da53bc61f418e83" 
  else 
    "68b2cee1d2b1674920aed7c35243b67d04e3e8f552f61596e5603bd2469bfb7a";

in
pkgs.stdenvNoCC.mkDerivation {
  pname = "helium-browser";
  inherit version;

  src = pkgs.fetchurl {
    url = debUrl;
    sha256 = debHash;
  };

  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
  
  buildInputs = with pkgs; [
    libx11 libxcomposite libxdamage libxext libxfixes libxrandr
    libxcb libxrender libxkbcommon wayland
    gtk3 nss nspr alsa-lib cups dbus expat libdrm
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/share/icons

    # 1. Безусловно копируем всё из usr/bin, не предполагая конкретных имен файлов
    if [ -d usr/bin ]; then
      cp -r usr/bin/. $out/bin/
    fi

    # 2. Находим любой исполняемый файл в $out/bin и создаем для него алиас helium-browser
    MAIN_BIN=$(find $out/bin -maxdepth 1 -type f -executable | head -n 1)
    if [ -n "$MAIN_BIN" ]; then
      makeWrapper "$MAIN_BIN" "$out/bin/helium-browser"
    else
      echo "ERROR: No executable found in usr/bin"
      exit 1
    fi

    # 3. Копируем метаданные (иконки и desktop-файлы), если они есть
    [ -d usr/share/applications ] && cp -r usr/share/applications/. $out/share/applications/
    [ -d usr/share/icons ] && cp -r usr/share/icons/. $out/share/icons/

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Private, fast, and honest web browser based on ungoogled-chromium";
    homepage = "https://helium.computer/";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "helium-browser";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
