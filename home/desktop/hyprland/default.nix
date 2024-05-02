{
  pkgs,
  lib,
  inputs,
  theme,
  ...
}:
with lib; let
  # This code defines a function called `mkService` that creates a NixOS service.
  # The service is configured to be a part of the `graphical-session.target` unit,
  # and it should be started after the `graphical-session.target` unit is started.
  # Additionally, the service is set to be installed and wanted by the `graphical-session.target` unit.

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
  home.packages = with pkgs;
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

  # systemd.user.services = {
  #   swaybg = mkService {
  #     Unit.Description = "Wallpaper chooser";
  #     Service = {
  #       ExecStart = "${lib.getExe pkgs.swaybg} -i ${theme.wallpaper}";
  #       Restart = "always";
  #     };
  #   };
  # };
}
