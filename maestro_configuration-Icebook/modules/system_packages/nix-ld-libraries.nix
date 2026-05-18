{ pkgs, ... }: {
  programs.nix-ld.libraries = with pkgs; [
    # ── Базовые библиотеки (Glibc, GCC) ───────────────────
    stdenv.cc.cc
    glibc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat

    # ── Графика и интерфейс (Нужно для Noctalia/Niri) ─────
    libGL
    libGLU
    libuuid
    # libfeatures
    libdrm
    libxkbcommon
    wayland
    mesa
    pipewire        # для звука/шаринга в плагинах
    fontconfig
    freetype

    # ── GTK / Gnome библиотеки (Часто нужны Polkit/UI) ────
    glib
    gtk3
    cairo
    gdk-pixbuf
    pango
    at-spi2-atk
    dbus

    # ── Системные зависимости ─────────────────────────────
    udev
    systemd
    libusb1
    libcap
    util-linux
  ];
}
