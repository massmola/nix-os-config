{
  pkgs,
  lib,
  inputs,
  theme,
  ...
}:{

  wayland.windowManager.hyprland.enable = true;
  
  imports = [
    # ./binds.nix 
    # ./config.nix 
    # ./rules.nix
  ];
  
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
  
  # home.packages = with pkgs;
  # with inputs.hyprcontrib.packages.${pkgs.system}; [
    # libnotify
    # wf-recorder
    # brightnessctl
    # pamixer
    # python39Packages.requests
    # slurp
    # grim
    # hyprpicker
    # swappy
    # grimblast
    # hyprpicker
    # wl-clip-persist
    # wl-clipboard
    # pngquant
    # cliphist
  # ];


  
  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = ["graphical-session-pre.target"];
  #   };
  # };
}
