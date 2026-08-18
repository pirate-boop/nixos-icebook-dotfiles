# modules-deriv-packages/lfff-gui.nix
{ pkgs, ... }:

let
  version = "2.6.0";
  
  buildInputs = with pkgs; [
    fontconfig
    freetype
    libGL
    libxkbcommon
    wayland
    libx11
    libxcursor
    libxi
    libxrandr
    libxcb
    libxcb-util
    libxcb-keysyms
    libxcb-wm
    alsa-lib
    dbus
    openssl
    stdenv.cc.cc.lib
  ];

  assets = pkgs.fetchFromGitHub {
    owner = "mrFrok";
    repo = "LibreFastbootFirmwareFlasher";
    rev = "v${version}";
    hash = "sha256-mI4s4X/npYgQPn4HBpOi6pokg71yQ4aQozx/Qqg5eq8=";
  };
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "lfff-gui";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v${version}/lfff-gui-linux-x86_64.tar.gz";
    hash = "sha256-hQTncpv0fiAZv7L6KS5EmSNQhBLxgjiDf7OrRmwnXqQ=";
  };

  nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper ];
  inherit buildInputs;

  unpackPhase = ''
    tar xzf $src
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/share/icons/hicolor/scalable/apps

    install -Dm755 lfff-gui $out/bin/lfff-gui
    install -Dm644 ${assets}/lfff-gui.desktop $out/share/applications/lfff-gui.desktop
    install -Dm644 ${assets}/lfff-gui.svg $out/share/icons/hicolor/scalable/apps/lfff-gui.svg

    # GOD-TIER WRAP:
    # 1. Чиним шрифты и библиотеки (autoPatchelfHook + LD_LIBRARY_PATH)
    # 2. Подсовываем payload-dumper-go (Go), aria2 и android-tools.
    #    МЫ НАМЕРЕННО НЕ ИСПОЛЬЗУЕМ pkgs.payload_dumper (Python), 
    #    так как он несовместим с аргументами Rust-приложения и ломается на protobuf >= 4.0.
    #    Приложение само извлечёт payload.bin и скормит его Go-версии.
    wrapProgram $out/bin/lfff-gui \
      --set FONTCONFIG_FILE ${pkgs.fontconfig.out}/etc/fonts/fonts.conf \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs} \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.payload-dumper-go pkgs.aria2 pkgs.android-tools ]}

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Android firmware flasher via fastboot (GUI)";
    homepage = "https://github.com/mrFrok/LibreFastbootFirmwareFlasher";
    license = licenses.gpl3;
    platforms = platforms.linux;
    mainProgram = "lfff-gui";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
