{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # disabled-by-restore: старые UUID больше не используются — разметку делает disko,
  # монтирование — по partlabel (имена = <диск>-<раздел> из disko-config.nix).
  fileSystems."/" =
    { device = "/dev/disk/by-partlabel/main-root";
      fsType = "xfs";
      options = [ "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partlabel/main-ESP";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-partlabel/second-data";
      fsType = "xfs";
      options = [ "noatime" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-partlabel/main-swap"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
