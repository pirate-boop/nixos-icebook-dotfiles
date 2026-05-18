{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # ── Управление VM ─────────────────────────────
    virt-manager
    virt-viewer       # SPICE/VNC клиент для VM
    virtio-win        # VirtIO драйверы для Windows VM

    # ── QEMU утилиты ──────────────────────────────
    qemu_kvm
    swtpm             # эмуляция TPM (нужен для Win11)
    OVMFFull          # UEFI прошивка

    # ── Looking Glass (single-GPU passthrough) ────
    # Позволяет видеть экран Windows VM на хосте
    # через общую память без второго монитора
    looking-glass-client

    # ── Waydroid утилиты ──────────────────────────
    waydroid
    wl-clipboard      # уже в system-tools, дубль не страшен

    # ── Docker (опционально, для работы) ──────────
    docker
    docker-compose
  ];
}
