{ pkgs, ... }:

let
  version = "0.4.3";
  arch = if pkgs.stdenv.hostPlatform.isAarch64 then "arm64" else "amd64";
  
  debUrl = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-${arch}.deb";
  
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

  nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook makeWrapper ];
  
  # Используем новые имена пакетов (без префикса xorg.), чтобы убрать варнинги
  buildInputs = with pkgs; [
    libx11 libxext libxrender libxcomposite libxdamage libxfixes 
    libxrandr libxcursor libxcb xkeyboardconfig wayland
    gtk3 qt5.qtbase qt5.qtwayland
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    runHook preInstall

    cp -r usr/* $out/
    mv $out/bin/fptn $out/bin/fptn-original 2>/dev/null || mv $out/bin/fptn-client $out/bin/fptn-original

    # Создаем скрипт "Микро-рабочего стола": Xephyr + Openbox + Trayer + Приложение
    cat > $out/bin/fptn-tray-window << 'EOF'
#!/bin/sh
# Находим свободный дисплей
DISPLAY_NUM=1
while [ -e /tmp/.X11-unix/X$DISPLAY_NUM ]; do
  DISPLAY_NUM=$((DISPLAY_NUM + 1))
done

echo "Starting mini X11 environment with system tray on display :$DISPLAY_NUM..."

# ИСПРАВЛЕНО: pkgs.xorg.xephyr (он всё еще там, в отличие от библиотек)
${pkgs.xorg.xephyr}/bin/Xephyr -ac -screen 1024x768 -reset -terminate :$DISPLAY_NUM &
XEPHYR_PID=$!
sleep 1

# Функция для чистой уборки процессов при выходе
cleanup() {
  kill $XEPHYR_PID 2>/dev/null
}
trap cleanup EXIT

# 2. Запускаем всё внутри этого дисплея
export DISPLAY=:$DISPLAY_NUM

# Легкий оконный менеджер (почти не жрет ресурсов)
${pkgs.openbox}/bin/openbox &
sleep 0.5

# Демон системного трея (панелька сверху справа, где появится иконка FPTN)
${pkgs.trayer}/bin/trayer --edge top --align right --widthtype request --padding 6 --transparent true --alpha 0 --tint 0x000000 --
