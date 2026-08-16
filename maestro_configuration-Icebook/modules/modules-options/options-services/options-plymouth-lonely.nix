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

        # Возвращаем патч! Он Обязателен, чтобы заменить /usr на путь в Nix Store
        installPhase = ''
          mkdir -p $out/share/plymouth/themes/lonely
          cp -r * $out/share/plymouth/themes/lonely/
          
          if [ -f $out/share/plymouth/themes/lonely/lonely.plymouth ]; then
            substituteInPlace $out/share/plymouth/themes/lonely/lonely.plymouth \
              --replace "/usr" "$out"
          fi
        '';
      })
    ];
  };

  # Силовая подгрузка драйвера AMD в initrd для борьбы с задержкой заставки
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.amdgpu.initrd.enable = true;
}
