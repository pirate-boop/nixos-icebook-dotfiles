{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # networkmanagerapplet     # NetworkManager control applet for GNOME
    iproute2                 # Collection of utilities for controlling TCP/IP networking and traffic control in Linux
    nmap                     # Free and open source utility for network discovery and security auditing
    traceroute               # Tracks the route taken by packets over an IP network
    # ipfetch                  # Neofetch but for ip addresses
    gnupg                    # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
    nftables                 # Project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    nftrace                  # Commodity tool to use nftables trace functionality
    waydroid-nftables        # Container-based approach to boot a full Android system on a regular GNU/Linux system
  ];
}
