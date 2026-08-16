{ ... }:
let
  videoPlayer = "mpv.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "video/mp4"       = videoPlayer;
    "video/mkv"       = videoPlayer;
    "video/x-matroska" = videoPlayer;
    "video/webm"      = videoPlayer;
    "video/avi"       = videoPlayer;
    "video/x-msvideo" = videoPlayer;
    "video/mpeg"      = videoPlayer;
    "video/quicktime" = videoPlayer;
    "video/x-flv"     = videoPlayer;
    "video/3gpp"      = videoPlayer;
    "video/ogg"       = videoPlayer;
    "video/x-ms-wmv"  = videoPlayer;
  };
}

