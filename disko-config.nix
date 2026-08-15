# Разметка двух дисков. Серийники подставь свои: с флешки выполни ls /dev/disk/by-id
let
  disk1 = "/dev/nvme1n1"; # система: ESP 512M + swap 16G + корень xfs
  disk2 = "/dev/nvme0n1"; # 300G под Windows (без форматирования) + остальное xfs в /data
in
{
  disko.devices = {
    disk = {
      main = {
        device = disk1;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0077" "dmask=0077" ];
              };
            };
            swap = {
              size = "16G";
              content = { type = "swap"; };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "xfs";
                mountpoint = "/";
                mountOptions = [ "noatime" ];
              };
            };
          };
        };
      };
      second = {
        device = disk2;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # Под Windows: создаётся, но НЕ форматируется — отформатирует установщик Windows
            win = {
              size = "300G";
              type = "0700";
            };
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "xfs";
                mountpoint = "/data";
                mountOptions = [ "noatime" ];
              };
            };
          };
        };
      };
    };
  };
}
