{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "noutube-desktop";
  version = "0.2.13";

  src = fetchurl {
    url = "https://github.com/nonbili/NouTube-Desktop/releases/download/v${version}/NouTube-${version}.AppImage";
    hash = "sha256:a8d5ce3f54655107fb60932f1ad01c130c70ca588bca2758308a9d0f57285dc3";
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
