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

    ## TCP Optimization (Ускорение интернета)
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  # Загружаем модуль для ускорения TCP
  boot.kernelModules = [ "tcp_bbr" ];

  security = {
    # Чтобы блокировщики экрана (hyprlock, niri-lock) могли тебя пустить обратно
    pam.services.hyprlock.text = "auth include login";
    pam.services.niri-lock.text = "auth include login"; # Добавил для Niri


    # Нужен для плавной работы звука (Pipewire) без заиканий
    rtkit.enable = true;

    # Отключаем запрос пароля для sudo (группа wheel)
    # Удобно, но будь осторожен — любая прога сможет выполнить sudo без спроса
    sudo.wheelNeedsPassword = false;
  };

  security.sudo.extraConfig = ''
  Defaults env_keep += "EDITOR VISUAL"
'';
  #systemd.user.services.niri.serviceConfig.NoNewPrivileges = false;
}
