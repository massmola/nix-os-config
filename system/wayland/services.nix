{pkgs, ...}: {
  systemd.user.services = { 

  };

  services.displayManager = {
    sddm = {
      enable = true;
      theme = "sugar-candy";
    };
  };

  services = {
    xserver = { 
      # Enable the X11 windowing system.
      enable = true;
      videoDrivers = [ "amdgpu" ];

      # Enable the GNOME Desktop Environment.
      # desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
    };
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };
  
}