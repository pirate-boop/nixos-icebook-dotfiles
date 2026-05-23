{ pkgs, ... }:

{
  # =========================================================================
  # 1. СТЕК РАЗРАБОТКИ RUST
  # =========================================================================
  home.packages = with pkgs; [
    rust-src         #
    rust-motd        # Beautiful, useful MOTD generation with zero runtime dependencies
    rustc            # Safe, concurrent, practical language (wrapper script)
    cargo            # Пакетный менеджер, сборщик и генератор проектов
    cargo-edit       # Utility for managing cargo dependencies from the command line
    cargo-watch      # Cargo subcommand for watching over Cargo project's source
    cargo-audit      # Audit Cargo.lock files for crates with security vulnerabilities
    cargo-nextest    # Next-generation test runner for Rust projects
    cargo-expand     # Cargo subcommand to show result of macro expansion
    # rustup           # Rust toolchain installer
    rust-analyzer    # Языковой сервер (LSP) — выдает подсказки и автокомплит в редакторах
    rustfmt          # Утилита для автоматического форматирования кода по стандартам
    clippy           # Официальный продвинутый линтер (подсказывает, как улучшить код)
    
    
    # Системные зависимости для успешной сборки
    gcc              # Стандартный линкер, без которого Cargo не сможет собрать исполняемый файл
    gnumake          # Часто нужен для сборки сторонних зависимостей (крейтов)
    mold             # Faster drop-in replacement for existing Unix linkers (unwrapped)
  ];

  # =========================================================================
  # 2. ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ (Опционально)
  # =========================================================================
  home.sessionVariables = {
    # Заставляем Cargo складывать глобальные бинарники в стандартное место,
    # и добавляем этот путь в PATH вашего шелла (если это еще не сделано автоматически)
    CARGO_HOME = "$HOME/.cargo";
  };

  # =========================================================================
  # 3. ДЕКЛАРАТИВНОЕ СОЗДАНИЕ ВОРКСПЕЙСА
  # =========================================================================
  # Чтобы папка создалась сама при применении конфигурации, 
  # мы закинем туда пустой файл .gitkeep. Чисто, элегантно, по-никсовому.
  home.file."development/rust-projects/.gitkeep".text = "";
}
