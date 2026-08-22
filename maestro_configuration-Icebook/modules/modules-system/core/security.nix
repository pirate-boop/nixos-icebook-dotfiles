{ ... }:
{
  boot.kernel.sysctl = {
    # Отключаем Magic SysRq (защита от физического вмешательства)
    "kernel.sysrq" = 0;

    ## TCP Hardening (Защита сети)
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;

    ## TCP Optimization (Internet Speedup)
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  # Loading a module to accelerate TCP
  boot.kernelModules = [ "tcp_bbr" ];

  security = {
    pam.services.hyprlock.text = "auth include login";
    pam.services.niri-lock.text = "auth include login";


    # Needed for smooth audio operation (Pipewire) without stuttering
    rtkit.enable = true;

    # Disable password prompt for sudo (wheel group)
    sudo.wheelNeedsPassword = false;
  };

  security.sudo.extraConfig = ''
  Defaults env_keep += "EDITOR VISUAL"
'';
  #systemd.user.services.niri.serviceConfig.NoNewPrivileges = false;
}
