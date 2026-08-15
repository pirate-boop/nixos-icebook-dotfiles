{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "zen-browser";
  version = "1.21.14b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-x86_64.AppImage";
    hash = ""; # первый билд упадёт и покажет правильный hash — вставь его сюда
  };

  extraPkgs = pkgs: with pkgs; [
    alsa-lib nss nspr at-spi2-core cups dbus expat
    libdrm libxkbcommon mesa cairo pango gtk3
  ];

  meta = with lib; {
    description = "Zen Browser";
    platforms = [ "x86_64-linux" ];
  };
}
