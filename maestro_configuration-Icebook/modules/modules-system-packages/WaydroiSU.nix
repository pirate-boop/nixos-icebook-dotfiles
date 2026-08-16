{ pkgs, ... }:

let
  wsu = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "waydroidsu";
    version = "0.1.2";

    src = pkgs.fetchurl {
      url = "https://github.com/mistrmochov/WaydroidSU/releases/download/${version}/wsu-${version}-1-x86_64-archlinux.pkg.tar.zst";
      sha256 = "sha256-dVIDiWfmLAv5G+08utOZlJvuDxpHk+o8lrx3Wa3zUIQ=";
    };

    nativeBuildInputs = with pkgs; [
      zstd
      libarchive
    ];

    unpackPhase = ''
      tar --use-compress-program=unzstd -xvf $src
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp usr/bin/wsu $out/bin/
    '';
  };
in
{
  environment.systemPackages = [ wsu ];
}
