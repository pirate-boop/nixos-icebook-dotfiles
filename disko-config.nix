{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-eui.00000000000000000026b73844346fd5";
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
                format = "bcachefs";
                mountpoint = "/";
                mountOptions = [ 
                  "noatime"
                  "compress=zstd"
                  "background_compression=zstd"
                ];
              };
            };
          };
        };
      };
    };
  };
}
