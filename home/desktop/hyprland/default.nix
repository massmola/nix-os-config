{
  pkgs,
  lib,
  inputs,
  theme,
  ...
}:
with lib; let
  # mkService = lib.recursiveUpdate {
  #   Unit.PartOf = ["graphical-session.target"];
  #   Unit.After = ["graphical-session.target"];
  #   Install.WantedBy = ["graphical-session.target"];
  # };
in {
  imports = [
    # ./binds.nix 
    # ./config.nix 
    # ./rules.nix
  ];
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

  wayland.windowManager.hyprland = {
    enable = true;
  };

  
  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = ["graphical-session-pre.target"];
  #   };
  # };
}
