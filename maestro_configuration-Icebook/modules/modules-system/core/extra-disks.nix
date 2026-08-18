# === modules-system/extra-disks.nix ===
{ ... }:
let
  win-label = "win-shared";
  data-label = "data";
in
{
  fileSystems."/mnt/${win-label}" = {
    device = "/dev/disk/by-label/${win-label}";
    fsType = "ntfs3";
    options = [ "nofail" "uid=1000" "gid=100" ];
  };

  fileSystems."/${data-label}" = {
    device = "/dev/disk/by-label/${data-label}";
    fsType = "bcachefs";
  };
}
