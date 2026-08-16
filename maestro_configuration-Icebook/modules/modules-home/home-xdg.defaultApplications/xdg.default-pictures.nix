{ ... }:
let
  imageViewer = "org.gnome.Loupe.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "image/png"    = imageViewer;
    "image/jpeg"   = imageViewer;
    "image/gif"    = imageViewer;
    "image/webp"   = imageViewer;
    "image/svg+xml" = imageViewer;
    "image/bmp"    = imageViewer;
    "image/tiff"   = imageViewer;
  };
}
