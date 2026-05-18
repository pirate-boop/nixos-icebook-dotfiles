{ ... }:
let
  audioPlayer = "io.bassi.Amberol.desktop";
in {
  xdg.mimeApps.defaultApplications = {
    "audio/mpeg"  = audioPlayer;
    "audio/flac"  = audioPlayer;
    "audio/ogg"   = audioPlayer;
    "audio/wav"   = audioPlayer;
    "audio/mp4"   = audioPlayer;
    "audio/aac"   = audioPlayer;
    "audio/opus"  = audioPlayer;
    "audio/x-m4a" = audioPlayer;
  };
}

