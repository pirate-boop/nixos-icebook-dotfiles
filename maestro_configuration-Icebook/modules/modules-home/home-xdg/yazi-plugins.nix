{ pkgs, config, ... }:

let
  # Собираем все плагины в одну папку
  yazi-plugins-bundle = pkgs.symlinkJoin {
    name = "yazi-plugins-bundle";
    paths = [
      pkgs.yaziPlugins.mount
      pkgs.yaziPlugins.gitui
      pkgs.yaziPlugins.chmod
      # Добавляй сюда любые из pkgs.yaziPlugins
    ];
  };
in
{
  home.activation.linkYaziPlugins = {
    # Скрипт срабатывает ПЕРЕД тем, как XDG всё разложит, или независимо
    # Делаем симлинк папки с плагинами туда, где их ждет Yazi
    data = ''
      mkdir -p "${config.xdg.configHome}/yazi/plugins"
      ln -sfn "${yazi-plugins-bundle}"/* "${config.xdg.configHome}/yazi/plugins/"
    '';
    after = [ "writeBoundary" ]; # Важно, чтобы папки успели создаться
  };
}
