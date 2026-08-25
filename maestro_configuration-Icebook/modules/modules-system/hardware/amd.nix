{ pkgs, ... }: {

  # Early AMDGPU loading for proper KMS and Wayland initialization
  hardware.amdgpu = {
    initrd.enable = true;
  };

  # Graphics stack (Modern module for NixOS 26.05)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Crucial for Steam, Proton, and Wine

    extraPackages = with pkgs; [
      rocmPackages.clr # OpenCL runtime for compute tasks
    ];
    
    # Note: Native VA-API for RDNA3 (Radeon 780M) is provided automatically 
    # by Mesa (radeonsi). Legacy VDPAU wrappers are intentionally omitted.
  };

  # CPU Microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # Kernel parameters
  boot.kernelParams = [
    "threadirqs" # Improves system responsiveness and input latency
    # "amdgpu.dcdebugmask=0x40010" # Uncomment ONLY if experiencing screen flickering
  ];

  # Environment variables
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # Native Wayland support for Firefox/Thunderbird
  };

  # Power management
  # Note: Manual cpuFreqGovernor is removed to prevent conflicts with PPD.
  # On Zen 4 (Ryzen 7 8845HS), power-profiles-daemon dynamically manages 
  # amd-pstate (active mode) and EPP profiles via D-Bus.
  services.power-profiles-daemon.enable = true;

  # Boot modules
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
}
