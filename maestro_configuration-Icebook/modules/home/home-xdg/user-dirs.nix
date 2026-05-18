{ config, ... }: {
  xdg = {
    enable = true;
    userDirs = {
      download  = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      pictures  = "${config.home.homeDirectory}/Pictures";
      videos    = "${config.home.homeDirectory}/Videos";
      music     = "${config.home.homeDirectory}/Music";
    };
  };
}
