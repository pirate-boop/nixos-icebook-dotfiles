{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    theme = "lonely";
    themePackages = [
      (pkgs.stdenv.mkDerivation {
        pname = "plymouth-theme-lonely";
        version = "1.0";

        src = pkgs.fetchFromGitHub {
          owner = "AntarcDev";
          repo = "lonely";
          rev = "main";
          sha256 = "sha256-5J5VyVtuQOYZKv/h1MsqhscRj3pil+G/tDgZmOHXj7g=";
        };

        # Исправляем пути прямо во время установки пакета
        installPhase = ''
          mkdir -p $out/share/plymouth/themes/lonely
          cp -r * $out/share/plymouth/themes/lonely/
          
          # Находим файл настроек темы и меняем /usr/share на путь к $out в Nix Store
          if [ -f $out/share/plymouth/themes/lonely/lonely.plymouth ]; then
            substituteInPlace $out/share/plymouth/themes/lonely/lonely.plymouth \
              --replace "/usr" "$out"
          fi
        '';
      })
    ];
  };

  hardware.amdgpu.initrd.enable = true;
}
