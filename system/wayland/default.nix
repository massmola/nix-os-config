{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./services.nix
    ./pipewire.nix
  ];

  environment = {
    variables = {
      # Enables the Ozone Wayland backend for NixOS.
      NIXOS_OZONE_WL = "1";

      # Enables compatibility with Qt5.
      DISABLE_QT5_COMPAT = "0";

      # Specifies the GDK backend to use, which can be either Wayland or X11.
      GDK_BACKEND = "wayland,x11";

      # Enables Wayland support for the Anki application.
      ANKI_WAYLAND = "1";
      
      # Enables Wayland support for Mozilla applications.
      MOZ_ENABLE_WAYLAND = "1";

      # Specifies the Wayland backend to use for WLR (Window Layout Renderer).
      WLR_BACKEND = "vulkan";

      # Specifies the renderer to use for WLR (Window Layout Renderer).
      WLR_RENDERER = "vulkan";

      # Specifies the session type to use, which is Wayland in this case.
      XDG_SESSION_TYPE = "wayland";

      # Specifies the video driver to use for SDL (Simple DirectMedia Layer), which is Wayland in this case.
      SDL_VIDEODRIVEVER="wayland";
      SDL_VIDEODRIVER = "wayland";

      # Specifies the backend to use for Clutter, a graphical toolkit, which is Wayland in this case.
      CLUTTER_BACKEND = "wayland";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}