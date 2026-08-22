{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-9.15.9"
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools    # WireGuard CLI утилиты
    wireguard-go       # Userspace WireGuard (Go)
    # amnezia-vpn        # AmneziaVPN client
    # v2raya           # V2Ray GUI
    # xray             # Xray core
    # mullvad-vpn      # Mullvad
    linux-wifi-hotspot
    daed
    flclashx
  ];

  # Automatic download and linking of geodatabases for dead
  environment.etc = {
    "dae-wing/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
    "dae-wing/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
  };
}
