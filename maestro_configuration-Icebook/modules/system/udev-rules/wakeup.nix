{ config, lib, pkgs, ... }:

{
  services.udev.extraRules = ''
    # Отключаем пробуждение от Wi-Fi адаптера (Realtek RTL8852BE)
    ACTION=="add", SUBSYSTEM=="pci", DRIVERS=="rtw89_pci|rtw89_8852be", ATTR{power/wakeup}="disabled"

    # Отключаем пробуждение от NVMe SSD (Patriot P320)
    ACTION=="add", SUBSYSTEM=="pci", KERNELS=="0000:01:00.0", ATTR{power/wakeup}="disabled"

    # Гасим пробуждение на самих PCIe мостах GPP1 и GPP6
    ACTION=="add", SUBSYSTEM=="pci", KERNELS=="0000:00:01.2", ATTR{power/wakeup}="disabled"
    ACTION=="add", SUBSYSTEM=="pci", KERNELS=="0000:00:02.2", ATTR{power/wakeup}="disabled"
  '';
}
