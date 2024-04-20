{
  config,
  theme,
  lib,
  ...
}: let
  pointer = config.home.pointerCursor;
in {
  wayland.windowManager.hyprland = with theme.colors; {
    settings = {

      # This configuration sets up the "exec-once" list, which contains a series of commands to be executed once during system startup.

      # exec-once = [
        # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # This command updates the activation environment for D-Bus, setting the WAYLAND_DISPLAY and XDG_CURRENT_DESKTOP variables for systemd.

        # set cursor for HL itself
        # "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
        # This command sets the cursor for the Hyprland application, using the values of the "pointer.name" and "pointer.size" variables.

        # foot terminal server
        # "${lib.optionalString config.programs.foot.server.enable ''run-as-service 'foot --server''}"
        # This command starts the foot terminal server as a service, if enabled in the configuration.
      # ];

      # Gestures Configuration
      # - workspace_swipe: Enables workspace switching through swipe gestures.
      # - workspace_swipe_forever: Allows continuous workspace switching through swipe gestures.

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      # XWayland Configuration
      # - force_zero_scaling: Forces zero scaling for XWayland windows.

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          clickfinger_behavior = true;
          tap-to-click = ture;
          scroll_factor = 0.5;
        };
      };

      decoration = {
        # fancy corners
        rounding = 7;

        # blur
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
        };
      };

      misc = {
        # disable redundant renders
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;

        vfr = true;

        # window swallowing
        enable_swallow = true; # hide windows that spawn other windows
        swallow_regex = "^(foot)$";

        # dpms
        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action
        disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
      };

      animations = {
        enabled = true;
        first_launch_animation = false;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border,1,10,default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces,1,4,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = false;
        preserve_split = "yes";
        no_gaps_when_only = false;
      };

      "$kw" = "dwindle:no_gaps_when_only";
    };
  };
}
