{ pkgs, ... }:
let
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
in
{
  programs.yazi = {
    enable = true;
    inherit plugins;

    initLua = ''
      local plugins = {${builtins.concatStringsSep ", " (map (n: "\"${n}\"") (builtins.attrNames plugins))}}
      for _, name in ipairs(plugins) do
        local ok, mod = pcall(require, name)
        if ok and type(mod.setup) == "function" then
          pcall(mod.setup, mod, {})
        end
      end
    '';
  };
}
