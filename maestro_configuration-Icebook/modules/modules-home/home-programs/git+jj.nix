{ pkgs, ... }: {

  # 1. Локальные утилиты для пользователя Kori
  home.packages = with pkgs; [
    gh # Нужен для HTTPS-авторизации
  ];

  # 2. Родная декларативная настройка Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Kori";
      user.email = "pirate-boop@users.noreply.github.com";
      init.defaultBranch = "main";
      core.quotepath = false;
      credential.helper = "store";
    };
  };

  # 3. Полная конфигурация Jujutsu со всеми твоими опциями
  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu;

    settings = {
      user = {
        name = "Kori";
        email = "pirate-boop@users.noreply.github.com";
      };
      git = {
        private-commits = "none()";
      };
      ui = {
        editor = "editor";
      };
    };
  };

  # 4. Интеграция с Difftastic (структурные диффы)
  programs.difftastic = {
    enable = true;
    jujutsu.enable = true;
  };

  # 5. Интеграция с Delta (красивая подсветка изменений)
  programs.delta = {
    enable = true;
    enableJujutsuIntegration = false;
  };

  # 6. Интеграция с Mergiraf (умный синтаксический мерж конфликтов)
  programs.mergiraf = {
    enable = true;
    enableJujutsuIntegration = true;
  };

  # 7. Интерактивный TUI интерфейс для JJ
  programs.jjui = {
    enable = true;
  };
}
