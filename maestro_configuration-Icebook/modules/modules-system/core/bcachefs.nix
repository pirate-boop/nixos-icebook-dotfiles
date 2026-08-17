{ pkgs, ... }: {
  boot.supportedFilesystems = [ "bcachefs" ];
  boot.initrd.supportedFilesystems = [ "bcachefs" ];
  
  environment.systemPackages = with pkgs; [
    bcachefs-tools
  ];
}
