{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.niri}/bin/niri msg action switch-layout 0; dms ipc call lock lock";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors 2>/dev/null || true";
      }
    ];
  };
}
