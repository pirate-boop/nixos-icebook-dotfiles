{ ... }:
let
  fileManager = "org.gnome.Nautilus.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "inode/directory"         = fileManager;
    "application/x-directory" = fileManager;
  };
}

