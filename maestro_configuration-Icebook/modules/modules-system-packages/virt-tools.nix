{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── VM Management ──────────────────────────────
    virt-manager
    virt-viewer       # SPICE/VNC client for VM
    virtio-win        # VirtIO drivers for Windows VMs

    # ── QEMU utilities ───────────────────────────────
    qemu_kvm
    swtpm             # TPM emulation (required for Win11)
    OVMFFull          # UEFI firmware

    # ── Looking Glass (single-GPU passthrough) ────
    # Allows you to see the Windows VM screen on the host
    # via shared memory without a second monitor
    looking-glass-client

    # ── Waydroid utilities ──────────────────────────
    waydroid
    wl-clipboard

    # ── Docker (optional, for work) ──────────
    docker
    docker-compose
  ];
}
