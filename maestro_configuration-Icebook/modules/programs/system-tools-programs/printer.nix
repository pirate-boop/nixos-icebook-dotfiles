{ pkgs, ... }: {
  # 1. Включаем службу печати CUPS и добавляем драйверы HP
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # 2. Включаем службу сканирования SANE и прокидываем туда бэкенд HP
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplip ];
  };

  # 3. Добавляем утилиты в систему для проведения тестов
  environment.systemPackages = with pkgs; [
    hplip          # Содержит утилиты диагностики hp-setup, hp-check
    simple-scan    # Легкий графический сканер для проверки МФУ
  ];
}
