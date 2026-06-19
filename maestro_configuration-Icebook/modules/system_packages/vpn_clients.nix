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
}
