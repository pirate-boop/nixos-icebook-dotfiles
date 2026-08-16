{ pkgs, lib, ... }:

let
  # Вот твои плавающие переменные. 
  # Выйдет новая версия — просто меняешь строки тут, и они сами подставятся ниже.
  version = "0.4.0";
  sha256 = "0914cc6d50eb5ac6c443aabfb05891fc20e0623d2db8d1296f0b28945eb0319f";

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
