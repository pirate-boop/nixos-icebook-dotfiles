{ config, pkgs, inputs, ... }:

{
  # Забираем дефолтный пакет из инпута scrcpy-gui под  архитектуру (x86_64-linux)
  environment.systemPackages = [
    inputs.scrcpy-gui.packages.${pkgs.system}.default
  ];
}
