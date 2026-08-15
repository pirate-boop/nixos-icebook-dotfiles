{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "noutube-desktop";
  version = "0.2.13";

  src = fetchurl {
    url = "https://github.com/nonbili/NouTube-Desktop/releases/download/v${version}/NouTube-${version}.AppImage";
    hash = "";
  };

  extraPkgs = pkgs: with pkgs; [
    alsa-lib nss nspr at-spi2-core cups dbus expat
    libdrm libxkbcommon mesa
  ];

  meta = with lib; {
    description = "NouTube Desktop";
    platforms = [ "x86_64-linux" ];
  };
}
