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
          # Временная заглушка. При сборке Nix выдаст ошибку и покажет правильный хэш (SRI), который нужно будет вставить сюда.
          sha256 = "sha256-5J5VyVtuQOYZKv/h1MsqhscRj3pil+G/tDgZmOHXj7g=";
        };

        # Копируем всё содержимое репозитория прямо в системную директорию тем Plymouth
        installPhase = ''
          mkdir -p $out/share/plymouth/themes/lonely
          cp -r * $out/share/plymouth/themes/lonely/
        '';
      })
    ];
  };

  # Ранняя инициализация видеодрайвера AMD, чтобы анимация загрузки подхватывала родное разрешение экрана сразу, без морганий
  hardware.amdgpu.initrd.enable = true;
}
