{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brightnessctl            # This program allows you read and control device brightness
    playerctl                # Command-line utility and library for controlling media players that implement MPRIS
    xdg-utils                # Set of command line tools that assist applications with a variety of desktop integration tasks
    libnotify                # Library that sends desktop notifications to a notification daemon
    wl-clipboard             # Command-line copy/paste utilities for Wayland
    cliphist                 # Wayland clipboard manager
    grim                     # Grab images from a Wayland compositor
    slurp                    # Select a region in a Wayland compositor
    swappy                   # Wayland native snapshot editing tool, inspired by Snappy on macOS
  ];
}
