# === modules-system/extra-disks.nix ===
{ ... }:
let
  disk = "nvme0n1";
  win-label = "win-shared";
  data-label = "data";
in
{
  fileSystems."/mnt/${disk}/${win-label}" = {
    device = "/dev/disk/by-label/${win-label}";
    fsType = "ntfs3";
    options = [ "nofail" "uid=1000" "gid=100" ];
  };

  fileSystems."/mnt/${disk}/${data-label}" = {
    device = "/dev/disk/by-label/${data-label}";
    fsType = "bcachefs";
  };
}
