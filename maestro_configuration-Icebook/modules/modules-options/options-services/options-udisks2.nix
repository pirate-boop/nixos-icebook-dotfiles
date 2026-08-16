{ ... }: {
  services.udisks2.enable = true;
  services.udisks2.settings = {
    "mount_options.conf" = {
      defaults = {
        ntfs_defaults = "uid=$UID,gid=$GID,windows_names";
      };
    };
  };
}
