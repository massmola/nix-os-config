{pkgs, ...}: {

  services = {
    xserver = { 
      enable = true;

      displayManager.gdm = {
        enable = true;  
        wayland = true; 
        # gnome3.enable = true;
      };

      desktopManager.gnome.enable = true;

      # Configure keymap
      xkb.layout = "us";
      xkb.variant = "";
    };
  };
}