{ pkgs, ... }:

{
  # Enable driftwm compositor
  programs.driftwm.enable = true;

  # Enable XWayland satellite if needed (enabled by default)
  # programs.xwayland.enable = true;
}
