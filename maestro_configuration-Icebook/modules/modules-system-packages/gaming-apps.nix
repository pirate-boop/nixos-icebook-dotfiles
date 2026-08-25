{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Wine / Proton ─────────────────────────────
    wine-wayland
    winetricks
    protonup-qt

    # ── Лаунчеры ──────────────────────────────────
    #faugus-launcher
    lutris
    #(symlinkJoin {
    # name = "heroic";
    # paths = [ heroic ];
    # buildInputs = [ makeWrapper ];
    # postBuild = ''
    #  wrapProgram $out/bin/heroic \
    #  --add-flags "--ozone-platform=x11"
    # ''; 
    #})
    heroic             # Epic / GOG
    faugus-launcher
    bottles
    #brotato
    factorio-demo
    # ── Мониторинг производительности ─────────────
    mangohud
    goverlay

    # ── Геймпады ──────────────────────────────────
    antimicrox
    jstest-gtk

    # ── Игровые демоны / утилиты ──────────────────
    gamemode
    gamescope
    protonup-rs
    umu-launcher
    protonplus
    xwayland-satellite

    # ── Эмуляция ──────────────────────────────────
    ryubing # Experimental Nintendo Switch Emulator written in C# (community fork of Ryujinx)
  ];
}
