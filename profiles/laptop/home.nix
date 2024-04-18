{ config, pkgs, user, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "spatola";
  home.homeDirectory = "/home/spatola";

  #   wayland.windowManager.hyprland.settings = {
  #   decoration = {
  #     shadow_offset = "0 5";
  #     "col.shadow" = "rgba(00000099)";
  #   };

  #   "$mod" = "SUPER";

  #   bindm = [
  #     # mouse movements
  #     "$mod, mouse:272, movewindow"
  #     "$mod, mouse:273, resizewindow"
  #     "$mod ALT, mouse:272, resizewindow"
  #   ];

  
  programs.git = {
    enable = true;
    userName = "assimiIiano";
    userEmail = "massimiliano.mola.bzs@gmail.com";
    aliases = {
      pu = "push";
      cm = "commit -m";
      st = "status";
      co = "checkout";
    };
  };


  home.stateVersion = "23.11"; 
  programs.home-manager.enable = true;
}
