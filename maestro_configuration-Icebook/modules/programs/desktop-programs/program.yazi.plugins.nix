programs.yazi = {
  enable = true;

  plugins = with pkgs.yaziPlugins; {
    mount = mount;
    bookmarks = bookmarks;
    smart-enter = smart-enter;
  };
};
