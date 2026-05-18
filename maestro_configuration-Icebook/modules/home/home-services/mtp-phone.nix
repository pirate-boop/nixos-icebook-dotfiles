{ pkgs, ... }: {
  systemd.user.services.mtp-phone = {
    Unit.Description = "Mount RMX3701";
    Service = {
      Type      = "simple";
      ExecStart = "${pkgs.go-mtpfs}/bin/go-mtpfs %h/phone_rmx3701";
      ExecStop  = "${pkgs.fuse}/bin/fusermount -u %h/phone_rmx3701";
    };
  };
}
