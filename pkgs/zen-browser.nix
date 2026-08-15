{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "zen-browser";
  version = "1.21.14b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-x86_64.AppImage";
    hash = "sha256:dbcd14d59a2c368d11b7ec30f37e8401557d6e135d4f3627dfc38e0c1134045d";
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
