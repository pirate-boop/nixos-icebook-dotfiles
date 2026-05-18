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
  # RDNA3 tweaks
  boot.kernelParams = [

    # меньше графических артефактов на некоторых ноутбуках
    "amdgpu.dcdebugmask=0x10"

    # больше shared memory под iGPU
    "amdgpu.gttsize=8192"

    # чуть лучше latency/input responsiveness
    "threadirqs"
  ];

  # Mesa / RADV env vars
  environment.variables = {

    # async shader compilation
    RADV_PERFTEST = "gpl,nggc";

    # Wayland
    MOZ_ENABLE_WAYLAND = "1";

    # Vulkan shader cache
    AMD_VULKAN_ICD = "RADV";
  };

  # Управление питанием (Zen4 — amd-pstate активный режим)
  powerManagement.enable       = true;
  # powerManagement.cpuFreqGovernor = "schedutil";
  services.power-profiles-daemon.enable = true;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
}
