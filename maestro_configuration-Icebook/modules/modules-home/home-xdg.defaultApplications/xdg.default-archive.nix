{ ... }:
let
  archiver = "file-roller.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "application/zip"             = archiver;
    "application/x-tar"           = archiver;
    "application/x-7z-compressed" = archiver;
    "application/x-rar"           = archiver;
    "application/gzip"            = archiver;
    "application/x-bzip2"         = archiver;
    "application/x-xz"            = archiver;
    "application/x-lzma"          = archiver;
    "application/zstd"            = archiver;
  };
}

