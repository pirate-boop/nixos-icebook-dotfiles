{ ... }: {
  # Раскомментируй когда найдешь PCI ID: lspci -nn | grep -E "RTX|NVIDIA"
  # boot.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ]; [cite: 26]

  # boot.extraModprobeConfig = ''
  #   options vfio-pci ids=10de:XXXX,10de:XXXX
  # ''; [cite: 27]
}
