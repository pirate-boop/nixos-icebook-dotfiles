{ pkgs, config, ... }:

{
  # Display manager and GNOME desktop module
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Optional key management GUI (keyring service itself is auto-enabled)
  programs.seahorse.enable = true;

  # Remove unwanted GNOME default packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-user-docs
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    geary
    totem
  ]);

  # Essential tweak tools and extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
    
    # Extensions for tiling & canvas hybrid workflow
    gnomeExtensions.paperwm
    gnomeExtensions.tiling-assistant
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
  ];
}
