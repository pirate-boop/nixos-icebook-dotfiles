# controllers.nix
# Full gamepad support: kernel joystick interface, udev rules for
# Steam/DS4/Xbox-style controllers, and an up-to-date SDL2
# gamecontrollerdb so Wine/Proton games recognize any pad out of the box.
{ pkgs, ... }:

{
  # Legacy joystick API (/dev/input/js*) that some Wine/Proton titles
  # still expect alongside evdev.
  boot.kernelModules = [ "joydev" ];

  # Standard udev rules covering DualShock/DualSense/Xbox/Switch-style
  # controllers, plus generic game.rules for anything HID-compliant.
  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    antimicrox
    SDL2
  ];

  # Ship a current SDL_GameControllerDB so any pad (including less common
  # ones like GameSir in DirectInput/DS4 mode) maps correctly for every
  # SDL2-based game/Wine/Proton process, system-wide.
  environment.etc."sdl/gamecontrollerdb.txt".source =
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/mdqinc/SDL_GameControllerDB/master/gamecontrollerdb.txt";
      sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

  environment.sessionVariables.SDL_GAMECONTROLLERCONFIG_FILE =
    "/etc/sdl/gamecontrollerdb.txt";
}
