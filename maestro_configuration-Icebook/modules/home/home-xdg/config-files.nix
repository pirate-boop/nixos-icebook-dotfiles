{ ... }: {
  xdg.configFile."niri/config.kdl".source = ../.dotfiles/.config/niri/config.kdl; xdg.configFile."niri/config.kdl".force = true;
  xdg.configFile."yazi/yazi.toml".source = ../.dotfiles/.config/yazi/yazi.toml;
  xdg.configFile."hypr/hyprlock.conf".source = ../.dotfiles/.config/hypr/hyprlock.conf;
}
