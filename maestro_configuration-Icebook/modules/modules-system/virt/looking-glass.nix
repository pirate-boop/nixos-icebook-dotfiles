{ ... }: {
  # Настройка общей памяти (закомментировано до активации VFIO)
  # systemd.tmpfiles.rules = [
  #   "f /dev/shm/looking-glass 0660 kori kvm -"
  # ]; [cite: 28]

  # services.udev.extraRules = ''
  #   SUBSYSTEM=="kvmfr", OWNER="kori", GROUP="kvm", MODE="0660"
  # ''; [cite: 29]
}
