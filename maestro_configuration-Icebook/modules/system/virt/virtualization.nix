#****************************************************************#
# |============================================================| #
# |VIRTUALIZATION — libvirtd, QEMU, Waydroid                  | #
# |============================================================| #
#  virt-manager доступен через programs.virt-manager.enable    #
#  VFIO не нужен — нет дискретной GPU на ноуте                 #
#****************************************************************#
{ pkgs, ... }: {

  # ── libvirtd + QEMU ────────────────────────────────────────────
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package    = pkgs.qemu_kvm;
      runAsRoot  = true;
      swtpm.enable = true;          # TPM для Windows 11
      vhostUserPackages = [ pkgs.virtiofsd ]
    };
  };
  
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  
  # ── Автозапуск сети libvirt (default NAT) ──────────────────────
  systemd.services.libvirt-network-default = {
    description = "Start default libvirt network";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = with pkgs; [ libvirt ];
    script = ''
      virsh net-autostart default 2>/dev/null || true
      virsh net-start default 2>/dev/null || true
    '';
    preStop = ''
      virsh net-destroy default 2>/dev/null || true
    '';
  };
  
  # ── Waydroid (Android контейнер) ────────────────────────────────
  # virtualisation.waydroid.enable = true;
  
  # Примечание: boot.kernelParams (iommu и т.д.) НЕ прописываем здесь —
  # на ноутбуке без дискретной GPU VFIO не нужен.
  # Если нужен будет passthrough USB устройств — добавить intel_iommu=on
  # в system/core/boot.nix → kernelParams
  # ── Redroid (Android в Docker) ─────────────────────────────────
  virtualisation.docker.enable = true;

  systemd.mounts = [{
    what = "binder";
    where = "/dev/binderfs";
    type = "binder";
    wantedBy = [ "multi-user.target" ];
  }];
}
