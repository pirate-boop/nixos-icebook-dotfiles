{ pkgs, ... }:

{
  # Display manager and GNOME desktop module
  services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Optional key management GUI
  programs.seahorse.enable = true;

  # Remove unwanted GNOME default packages (all apps are top-level pkgs)
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    cheese
    gnome-music
    epiphany
    geary
    totem
  ];

  # Essential tweak tools and extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    dconf-editor
    gnome-control-center
    
    # Extensions for tiling & canvas hybrid workflow
    gnomeExtensions.arcmenu
    gnomeExtensions.paperwm
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
  ];
}
