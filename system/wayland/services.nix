{pkgs, ...}: {
  
  # use sddm for login
  # services.displayManager = {
  #   sddm = {
  #     enable = true;
  #     theme = "sugar-candy";
  #   };
  # };

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

    # Configuration for the GNOME services in Wayland environment.
    gnome = {
      # gnome.sessionPath = [ mutter gnome-shell nautilus ];
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };
  
}