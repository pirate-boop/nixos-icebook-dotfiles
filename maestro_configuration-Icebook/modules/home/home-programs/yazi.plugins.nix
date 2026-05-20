{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;

    plugins = with pkgs.yaziPlugins; {
      gvfs = gvfs;
      diff = diff;
      drag = drag;
      glow = glow;
      jjui = jjui;
      nord = nord;
      ouch = ouch;
      sudo = sudo;
      yafg = yafg;
      chmod = chmod;
      dupes = dupes;
      gitui = gitui;
      mount = mount;
      piper = piper;
      rsync = rsync;
      restore = restore;
      yatline = yatline;
      mime-ext = mime-ext;
      bookmarks = bookmarks;
      smart-enter = smart-enter;
      nav-parent-panel = nav-parent-panel;
      close-and-restore-tab = close-and-restore-tab;
      toggle-pane = toggle-pane;
      rich-preview = rich-preview;
      smart-filter = smart-filter;
      wl-clipboard = wl-clipboard;
    };

    # Автоматически генерирует init.lua для каждого плагина
    initLua = builtins.concatStringsSep "\n" (
      map (name: ''require("${name}"):setup()'') (builtins.attrNames plugins)
    );
  };
}
