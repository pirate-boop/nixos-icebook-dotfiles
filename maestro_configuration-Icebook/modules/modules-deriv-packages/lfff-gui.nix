# modules-deriv-packages/lfff-gui.nix
{ pkgs, ... }:

let
  version = "2.6.0";
  
  # Эти библиотеки нужны для работы. autoPatchelfHook автоматически 
  # найдет их в Nix Store и пропишет в бинарник.
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
  ];
in
# PRO MOVE 1: stdenvNoCC — мы ничего не компилируем, не качаем gcc зря
pkgs.stdenvNoCC.mkDerivation {
  pname = "lfff-gui";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v${version}/lfff-gui-linux-x86_64.tar.gz";
    hash = "sha256-hQTncpv0fiAZv7L6KS5EmSNQhBLxgjiDf7OrRmwnXqQ=";
  };

  assets = pkgs.fetchFromGitHub {
    owner = "mrFrok";
    repo = "LibreFastbootFirmwareFlasher";
    rev = "v${version}";
    hash = "sha256-..."; # <-- Nix попросит этот хеш при первом билде
  };

  # PRO MOVE 2: autoPatchelfHook чинит ELF-заголовки, makeWrapper на всякий случай
  nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper ];
  
  # Передаем библиотеки, чтобы autoPatchelfHook знал, где их искать
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

    # Wrap теперь нужен только если нужно форсировать специфичные переменные окружения.
    # autoPatchelfHook уже сделал 99% работы по библиотекам.
    wrapProgram $out/bin/lfff-gui \
      --set FONTCONFIG_FILE ${pkgs.fontconfig.out}/etc/fonts/fonts.conf

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Android firmware flasher via fastboot (GUI)";
    homepage = "https://github.com/mrFrok/LibreFastbootFirmwareFlasher";
    license = licenses.gpl3;
    platforms = platforms.linux;
    mainProgram = "lfff-gui";
    
    # PRO MOVE 3: Явное указание для аудиторов безопасности Nixpkgs
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
