# home-programs/mango-wc.nix
{ inputs, pkgs, ... }:
{
  imports = [ inputs.mango.hmModules.mango ];

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      bind=SUPER,t,spawn,wezterm
      bind=SUPER,q,killclient,
      bind=SUPER,d,spawn,wmenu-run -l 10
    '';
    autostart_sh = ''
      dms run &
      swaybg -i ~/wallpapers/current.png &
    '';
  };
}
