{ lib
, stdenv
, fetchurl
, dpkg
, autoPatchelfHook
, glibc
, gcc
, openssl
, version ? "0.4.0"
, sha256 ? "0914cc6d50eb5ac6c443aabfb05891fc20e0623d2db8d1296f0b28945eb0319f"
}:

stdenv.mkDerivation {
  pname = "fptn-client-cli";
  inherit version;

  src = fetchurl {
    url = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-cli-${version}-ubuntu22.04-amd64.deb";
    inherit sha256;
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    glibc
    gcc.cc.lib
    openssl
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
}
