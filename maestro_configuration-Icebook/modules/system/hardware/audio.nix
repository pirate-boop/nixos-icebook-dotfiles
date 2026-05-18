#****************************************************************#
# |============================================================| #
# |AUDIO — PipeWire                                            | #
# |============================================================| #
{ ... }: {
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;

  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;   # Wine/Proton
    pulse.enable      = true;
    jack.enable       = true;
    wireplumber.enable = true;
  };
}
