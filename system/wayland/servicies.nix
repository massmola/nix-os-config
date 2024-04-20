{pkgs, ...}: {
  systemd.user.services = { 
    polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    xserver = { 
      # Enable the X11 windowing system.
      enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
  
     };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
  
}