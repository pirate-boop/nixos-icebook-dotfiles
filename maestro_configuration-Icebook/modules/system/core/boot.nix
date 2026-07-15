{ pkgs, config, ... }: {
  boot = {
    #bootspec.enable = true;
    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "ext4" "btrfs" "xfs" ];
      kernelModules = [ "amdgpu" ];
    };
    supportedFilesystems = [ "ntfs" "exfat" "vfat" ];
    kernelPackages =
      pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_zen;
    consoleLogLevel = 3;
    kernelParams = [
      "amd_pstate=active"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "mem_sleep_default=deep"
    ];
    # plymouth.enable = true;
  };
  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];
}
