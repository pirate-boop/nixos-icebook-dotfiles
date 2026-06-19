{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wireguard-tools    # WireGuard CLI утилиты
    wireguard-go       # Userspace WireGuard (Go)
    # amnezia-vpn        # AmneziaVPN клиент
    # v2raya           # V2Ray GUI (если нужен)
    # xray             # Xray core
    # mullvad-vpn      # Mullvad (если подпишешься)
    linux-wifi-hotspot
    daed
  ];

  # Автоматическое скачивание и линкование баз гео-данных для daed
  environment.etc = {
    "dae-wing/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
    "dae-wing/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
  };
}
