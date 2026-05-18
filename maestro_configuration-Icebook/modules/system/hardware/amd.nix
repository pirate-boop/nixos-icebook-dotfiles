#****************************************************************#
# |============================================================| #
# |AMD — Ryzen 7 8845HS + Radeon 780M (RDNA3)                 | #
# |============================================================| #
#  Драйвер: amdgpu (open source, встроен в ядро)               #
#  OpenCL: через ROCm (для compute задач)                       #
#  VA-API: radeonsi (аппаратное декодирование видео)            #
#  Микрокод: обновляется автоматически                          #
#****************************************************************#
{ pkgs, ... }: {

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.amdgpu = {
    initrd.enable    = true;   # ранняя загрузка amdgpu в initrd
    opencl.enable    = true;   # OpenCL через ROCm (GPGPU, стриминг)
    # amdvlk.enable    = false;  # false = используем radv (mesa) — стабильнее
  };

  hardware.graphics = {
    enable      = true;
    enable32Bit = true;        # Steam / Wine / Proton
    extraPackages = with pkgs; [
      rocmPackages.clr          # OpenCL runtime
      libvdpau-va-gl            # VDPAU через VA-API
      libva-vdpau-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
    ];
  };

  # Микрокод CPU
  hardware.cpu.amd.updateMicrocode = true;

  # Управление питанием (Zen4 — amd-pstate активный режим)
  powerManagement.enable       = true;
  # powerManagement.cpuFreqGovernor = "schedutil";
  services.power-profiles-daemon.enable = true;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
}
