{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # htop                   # Interactive process viewer
    htop-vim                 # Interactive process viewer, with vim-style keybindings
    btop                     # Monitor of resources
    # bottom                   # Cross-platform graphical process/system monitor with a customizable interface
    fastfetch                # Actively maintained, feature-rich and performance oriented, neofetch like system information tool
    # zigfetch                 # Minimal neofetch/fastfetch like system information tool
    inxi                     # Full featured CLI system information tool
    lshw                     # Provide detailed information on the hardware configuration of the machine
    # lshw-gui                 # Provide detailed information on the hardware configuration of the machine
    pciutils                 # Collection of programs for inspecting and manipulating configuration of PCI devices
    usbutils                 # Tools for working with USB devices, such as lsusb
    mission-center
  ];
}
