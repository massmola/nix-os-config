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

      # Disables atomic mode setting for WLR DRM.
      WLR_DRM_NO_ATOMIC = "1";

      # Enables automatic scaling of screen elements in Qt applications.
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";

      # Specifies the Qt platform plugin to use, which can be either Wayland or XCB.
      QT_QPA_PLATFORM = "wayland;xcb";

      # Enables compatibility with Qt.
      DISABLE_QT_COMPAT = "0";

      # Disables window decorations for Qt applications running on Wayland.
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Enables Wayland support for Mozilla applications.
      MOZ_ENABLE_WAYLAND = "1";

      # Specifies the Wayland backend to use for WLR (Window Layout Renderer).
      WLR_BACKEND = "vulkan";

      # Specifies the renderer to use for WLR (Window Layout Renderer).
      WLR_RENDERER = "vulkan";

      # Specifies the session type to use, which is Wayland in this case.
      XDG_SESSION_TYPE = "wayland";

      # Specifies the video driver to use for SDL (Simple DirectMedia Layer), which is Wayland in this case.
      SDL_VIDEODRIVER = "wayland";

      # Specifies the backend to use for Clutter, a graphical toolkit, which is Wayland in this case.
      CLUTTER_BACKEND = "wayland";
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

}