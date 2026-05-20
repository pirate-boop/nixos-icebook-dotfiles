{ pkgs, ... }: {
  #--NIRI--
  xdg.configFile."niri/config.kdl".source = ../.dotfiles/.config/niri/config.kdl; xdg.configFile."niri/config.kdl".force = true;

  #--HYPRLOCK--
  xdg.configFile."hypr/hyprlock.conf".source = ../.dotfiles/.config/hypr/hyprlock.conf;

  #--YAZI--
  xdg.configFile."yazi/yazi.toml".source = ../.dotfiles/.config/yazi/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ../.dotfiles/.config/yazi/keymap.toml
  xdg.configFile."yazi/plugins/mount.yazi".source = "${pkgs.yaziPlugins.mount}/share/yazi/plugins/mount";
  
}
