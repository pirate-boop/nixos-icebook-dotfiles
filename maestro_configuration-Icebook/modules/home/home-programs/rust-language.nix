{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # ─────────────
    # Rust toolchain
    # ─────────────
    rustup
    rust-analyzer

    # ─────────────
    # Linker / compiler
    # ─────────────
    clang
    lld
    mold

    # ─────────────
    # Build dependencies
    # ─────────────
    pkg-config
    openssl
    sqlite
    zlib

    # ─────────────
    # Cargo utilities
    # ─────────────
    bacon
    cargo-edit
    cargo-watch
    cargo-expand
    cargo-nextest
    cargo-audit
    cargo-outdated
    cargo-deny

    # ─────────────
    # Debugging / profiling
    # ─────────────
    gdb
    lldb
    hyperfine

    # flamegraph support
    cargo-flamegraph
    linuxPackages.perf

    # ─────────────
    # Extra useful tools
    # ─────────────
    just
    jq
    ripgrep
    fd
    eza
  ];

  # ─────────────
  # Rust environment
  # ─────────────
  home.sessionVariables = {
    EDITOR = "hx";

    # faster linking
    RUSTFLAGS = "-C link-arg=-fuse-ld=mold";

    # use clang linker
    CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER = "clang";
  };

  # ─────────────
  # Rust projects workspace
  # ─────────────
  home.file."development/rust-projects/.gitkeep".text = "";

  # ─────────────
  # Cargo config
  # ─────────────
  xdg.configFile."cargo/config.toml".text = ''
    [build]
    rustflags = ["-C", "link-arg=-fuse-ld=mold"]

    [target.x86_64-unknown-linux-gnu]
    linker = "clang"

    [term]
    verbose = false
  '';

  # ─────────────
  # Direnv support
  # ─────────────
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
