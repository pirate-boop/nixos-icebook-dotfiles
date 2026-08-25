# ── Steam & Gaming ─────────────────────────────────────────────
{ pkgs, ... }: {
  
  programs.steam = {
    enable = true;
    # Enable firewall rules for Steam Remote Play / Local transfers if needed
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  programs.xwayland.enable = true;
  
  # Note: In NixOS, it is highly recommended to keep the base X server enabled 
  # even on pure Wayland setups. Xwayland and some Display Managers rely on it.
  services.xserver.enable = true; 
}
