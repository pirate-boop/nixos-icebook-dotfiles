{ pkgs, ... }:

let
  version = "0.15.5.1";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "x86_64";
  
  # Используем чистый tar.xz вместо deb-пакета
  tarballUrl = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-${arch}_linux.tar.xz";
  
  # Официальные sha256 хеши для tar.xz
  tarballHash = if arch == "x86_64" then 
    "f34a1ee1a6ab2e3109d92e3939512a37cfe68a2f0d230b525cc1589fc192fd97" 
  else 
    "d9323d0771a374de5e5a666a7e754e21f298c238eac21df8e5868ac7b5f64cfe";

in
pkgs.stdenvNoCC.mkDerivation {
  pname = "helium-browser";
  inherit version;

  src = pkgs.fetchurl {
    url = tarballUrl;
    sha256 = tarballHash;
  };

  nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper ];
  
  buildInputs = with pkgs; [
    ,libx11
    ,libxcomposite
    ,libxdamage
    ,libxext
    ,libxfixes
    ,libxrandr
    ,libxcb
    ,libxrender
    ,libxkbcommon
    ,wayland
    gtk3 nss nspr alsa-lib cups dbus expat libdrm libgbm.so.1
    stdenv.cc.cc.lib
  ];

  # Распаковываем в текущую директорию
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/share/icons

    # Находим распакованную папку (она называется примерно helium-0.15.5.1)
    HELIUM_DIR=$(find . -maxdepth 1 -type d -name "helium-*" | head -n 1)
    if [ -z "$HELIUM_DIR" ]; then
      HELIUM_DIR="."
    fi

    # Находим главный исполняемый файл и создаем удобный алиас
    if [ -f "$HELIUM_DIR/helium" ]; then
      install -Dm755 "$HELIUM_DIR/helium" "$out/bin/helium"
      makeWrapper "$out/bin/helium" "$out/bin/helium-browser"
    elif [ -f "$HELIUM_DIR/helium-browser" ]; then
      install -Dm755 "$HELIUM_DIR/helium-browser" "$out/bin/helium-browser"
    else
      MAIN_BIN=$(find "$HELIUM_DIR" -maxdepth 1 -type f -executable | head -n 1)
      if [ -n "$MAIN_BIN" ]; then
        install -Dm755 "$MAIN_BIN" "$out/bin/helium-browser"
      else
        echo "ERROR: No executable found in tarball"
        exit 1
      fi
    fi

    # Копируем метаданные (иконки и desktop-файлы), если они есть в архиве
    [ -d "$HELIUM_DIR/share/applications" ] && cp -r "$HELIUM_DIR/share/applications/." "$out/share/applications/"
    [ -d "$HELIUM_DIR/share/icons" ] && cp -r "$HELIUM_DIR/share/icons/." "$out/share/icons/"

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
