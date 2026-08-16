{ pkgs, lib, ... }:

let
  # Вот твои плавающие переменные. 
  # Выйдет новая версия — просто меняешь строки тут, и они сами подставятся ниже.
  version = "0.4.3";
  sha256 = "sha256:9f63f642fc286b5c61a3b2ffff4a3962009c3d99f1e4f560664864c69ae3b816";

  fptn-client-cli = pkgs.stdenv.mkDerivation {
    pname = "fptn-client-cli";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-cli-${version}-ubuntu22.04-amd64.deb";
      inherit sha256;
    };

    nativeBuildInputs = [
      pkgs.dpkg
      pkgs.autoPatchelfHook
    ];

    buildInputs = [
      pkgs.glibc
      pkgs.gcc.cc.lib
      pkgs.openssl
    ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      if [ -d "usr/bin" ]; then
        cp -r usr/bin/* $out/bin/
      fi
      runHook postInstall
    '';

    meta = {
      description = "Censorship-resistant VPN client (CLI version)";
      homepage = "https://github.com/fptn-project/fptn";
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
    };
  };
in
{
  # Поскольку твой маэстро импортирует этот файл, 
  # модуль сам чисто регистрирует пакет в системе.
  environment.systemPackages = [ fptn-client-cli ];
}
