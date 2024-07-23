{pkgs, ...}: {

  services = {
    xserver = { 
      enable = true;

      displayManager.gdm = {
        enable = true;  
        wayland = true; 
      };

      desktopManager.gnome.enable = true;

      # Configure keymap
      xkb.layout = "us";
      xkb.variant = "";
    };
  };
}