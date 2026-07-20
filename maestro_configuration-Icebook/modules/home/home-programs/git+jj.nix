{ pkgs, ... }: {

  # 1. Локальные утилиты для пользователя Kori
  home.packages = with pkgs; [
    gh # Нужен для HTTPS-авторизации
  ];

  # 2. Родная декларативная настройка Git
  programs.git = {
    enable = true;
    userName = "Kori";
    userEmail = "pirate-boop@users.noreply.github.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      core.quotepath = false;
      credential.helper = [
        "${pkgs.gh}/bin/gh auth credential-helper"
        "store"
      ];
    };
  };

  # 3. Полная конфигурация Jujutsu со всеми твоими опциями
  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu; # Используем штатный пакет из nixpkgs

    # Твоя опция для ediff (включаем интеграцию)
    # Уровень уверенности (Средний): если HM ругнется на тип данных, замени на ediff.enable = true;
    ediff = { }; 

    settings = {
      user = {
        name = "Kori";
        email = "pirate-boop@users.noreply.github.com";
      };
      git = {
        private-commits = "none";
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
    enableJujutsuIntegration = true; # Подключаем дельту к jj
  };

  # 6. Интеграция с Mergiraf (умный синтаксический мерж конфликтов)
  # Уровень уверенности (Высокий): Опция из свежих релизов HM
  programs.mergiraf = {
    enable = true;
    enableJujutsuIntegration = true; # Автоматически прописывает mergiraf как merge-tool для jj
  };

  # 7. Интерактивный TUI интерфейс для JJ
  programs.jjui = {
    enable = true;
  };
}
