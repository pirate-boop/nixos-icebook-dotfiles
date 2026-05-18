#****************************************************************#
# |AMD — Radeon 780M (RDNA3) Wayland рендеринг                 | #
#****************************************************************#
{ ... }: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL              = "1";        # Chromium/Electron → Wayland
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Electron явно на Wayland

    # VA-API аппаратное декодирование видео (AMD)
    LIBVA_DRIVER_NAME           = "radeonsi"; # Mesa VA-API для AMD

    # Mesa/RADV Vulkan
    AMD_VULKAN_ICD              = "RADV";     # использовать RADV (Mesa), не AMDVLK
  };
}
