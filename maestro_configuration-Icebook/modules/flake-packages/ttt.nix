{ pkgs, inputs, ... }: {
  environment.systemPackages = [
    # Вытягиваем дефолтный пакет из флейка ttt под архитектуру твоего процессора
    inputs.ttt.packages.${pkgs.system}.default
  ];
}
