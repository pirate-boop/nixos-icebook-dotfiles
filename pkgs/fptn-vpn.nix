{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper
, qt6, xorg, libxkbcommon
, pkgs
}:

let
  fptnClient = stdenv.mkDerivation rec {
    pname = "fptn-client";
    version = "0.4.3";

    src = fetchurl {
      url = "https://github.com/fptn-project/fptn/releases/download/${version}/fptn-client-${version}-ubuntu22.04-amd64.deb";
      hash = "";
    };

    nativeBuildInputs = [ dpkg autoPatchelfHook makeWrapper ];

    buildInputs = with xorg; [
      qt6.qtbase
      qt6.qtwayland
      libxcb libxkbcommon
      libXcursor libXi libXrender libXtst
      libSM libICE
    ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out
      cp -r opt $out/
      mkdir -p $out/bin
      makeWrapper $out/opt/fptn/fptn-client $out/bin/fptn-client \
        --set QT_PLUGIN_PATH "$out/opt/fptn/qt6/plugins" \
        --set QT_QPA_PLATFORM xcb
    '';

    meta = with lib; {
      description = "FPTN VPN client";
      platforms = [ "x86_64-linux" ];
    };
  };

  openVpnDesktop = pkgs.writeShellApplication {
    name = "open-vpn-desktop";
    runtimeInputs = with pkgs; [
      xorg.xorgserver
      xfce.xfwm4
      xfce.xfce4-panel
      xfce.xfdesktop
      xfce.xfsettingsd
      xfce.xfconf
      lxqt.lxqt-policykit
      dbus
      procps
      coreutils
      gnugrep
      fptnClient
    ];
    text = ''
      pkill -9 xfwm4 xfce4-panel xfdesktop xfsettingsd xfconfd Xephyr lxqt-policykit-agent 2>/dev/null || true
      sleep 1

      Xephyr :10 -br -ac -noreset -screen 1920x1080 -title "VPN Desktop" &
      XEPHYR_PID=$!
      sleep 2

      env -i HOME="$HOME" USER="$USER" \
        PATH=/run/current-system/sw/bin:/usr/bin:/bin \
        DISPLAY=:10 \
        XDG_SESSION_TYPE=x11 \
        XDG_CURRENT_DESKTOP=XFCE \
        XDG_CONFIG_HOME="$HOME/.config" \
        dbus-launch --exit-with-session bash -c '
          xfconfd &
          sleep 1
          xfwm4 --compositor=off &
          sleep 1
          xfsettingsd &
          xfdesktop &
          xfce4-panel &
          lxqt-policykit-agent &
          sleep 2
          sudo fptn-client
        '

      kill "$XEPHYR_PID" 2>/dev/null || true
      pkill -9 xfwm4 xfce4-panel xfdesktop xfsettingsd xfconfd lxqt-policykit-agent 2>/dev/null || true
    '';
  };
in
{
  environment.systemPackages = [ openVpnDesktop ];

  xdg.desktopEntries.vpn-desktop = {
    name = "VPN Desktop";
    genericName = "Isolated X11 environment for FPTN VPN";
    exec = "${openVpnDesktop}/bin/open-vpn-desktop";
    icon = "network-vpn";
    categories = [ "Network" ];
    terminal = false;
  };
}
