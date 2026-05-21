# ── Steam ────────────────────────────────────────────────────
{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = false;
    extest.enable = false;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  programs.xwayland.enable = true;
  services.xserver.enable = true;
}
