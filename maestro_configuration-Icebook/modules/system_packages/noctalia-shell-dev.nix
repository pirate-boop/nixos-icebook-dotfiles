{ inputs, pkgs, ... }: # Убедись, что на входе в файл есть inputs!
{
  environment.systemPackages = [
    # Вместо старого pkgs.noctalia-qs пишем это:
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
