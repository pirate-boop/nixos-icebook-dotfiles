{ pkgs, ... }: {
  xdg.configFile."niri/config.kdl".source = ../.dotfiles/.config/niri/config.kdl; xdg.configFile."niri/config.kdl".force = true;
  xdg.configFile."yazi/yazi.toml".source = ../.dotfiles/.config/yazi/yazi.toml;
  xdg.configFile."hypr/hyprlock.conf".source = ../.dotfiles/.config/hypr/hyprlock.conf;
  xdg.configFile."yazi/plugins" = {
    source = pkgs.symlinkJoin {
      name = "yazi-plugins";
      paths = [
        pkgs.yaziPlugins.mount
        pkgs.yaziPlugins.gitui
        pkgs.yaziPlugins.chmod
        # Добавляй сюда остальные плагины из pkgs.yaziPlugins
      ];
    };
  };
}
