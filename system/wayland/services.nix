{pkgs, ...}: {
  
  # use sddm for login
  services.displayManager = {
    sddm = {
      enable = true;
      theme = "sugar-candy";
    };
  };

  services = {
    xserver = { 
      enable = true;
      videoDrivers = [ "amdgpu" ];  # 

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;

      # Configure keymap
      xkb.layout = "us";
      xkb.variant = "";
    };

    # Configuration for the GNOME services in Wayland environment.
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };
  
}