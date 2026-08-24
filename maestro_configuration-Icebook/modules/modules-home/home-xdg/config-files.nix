{ pkgs, ... }: {
  #--NIRI--
  xdg.configFile."niri/config.kdl".source = ../.dotfiles/.config/niri/config.kdl; xdg.configFile."niri/config.kdl".force = true;
  
  xdg.configFile."mango/config.conf".source = ../.dotfiles/.config/mango/config.conf; xdg.configFile."mango/config.conf".force = true;
  #--HYPRLOCK--
  xdg.configFile."hypr/hyprlock.conf".source = ../.dotfiles/.config/hypr/hyprlock.conf;
  #--UMBRIEL--
  xdg.configFile."umbriel/config.toml".source = ../.dotfiles/.config/umbriel/config.toml; xdg.configFile."umbriel/config.toml".force = true;

  

  #--YAZI--
  xdg.configFile."yazi/yazi.toml".source = ../.dotfiles/.config/yazi/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ../.dotfiles/.config/yazi/keymap.toml;
  # xdg.configFile."yazi/init.lua".source = ../.dotfiles/.config/yazi/init.lua;
  
  # xdg.configFile."yazi/plugins/mount.yazi".source = "${pkgs.yaziPlugins.mount}/share/yazi/plugins/mount";
  
}
