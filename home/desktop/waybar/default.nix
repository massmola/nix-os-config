# FILEPATH: /home/spatola/Documents/nix/home/rice/waybar/default.nix

# This Nix expression defines the configuration for the Waybar status bar.
{
  pkgs,
  lib,
  ...
}:
{
  # Add the waybar-wttr module to the list of home packages.

  # Configure the Waybar program.
  programs.waybar = {
    enable = true;
    # style = import ./style.nix;
    # systemd = {
    #   enable = true;
    #   target = "hyprland-session.target";
    # };
  };
}
