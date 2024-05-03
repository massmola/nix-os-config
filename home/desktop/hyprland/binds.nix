{
  config,
  lib,
  ...
}: let
  mod = "SUPER";
  modshift = "${mod}SHIFT";
in {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "${mod},MINUS,killactive"
        "${mod}, Q, exex, kitty"
        "${mod}, F, exec, firefox"

        "${mod},H,movefocus,l"
        "${mod},L,movefocus,r"
        "${mod},K,movefocus,u"
        "${mod},J,movefocus,d"

        "${modshift},G,changegroupactive," # switch within the active group
        "${mod},V,togglefloating," # toggle floating for the focused window
        "${mod},up,fullscreen," # fullscreen focused window
      ];

  };
}
