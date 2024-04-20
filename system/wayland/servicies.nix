{pkgs, ...}: {
  systemd.services = {
    # seatd = {
    #   enable = true;
    #   description = "Seat management daemon";
    #   script = "${pkgs.seatd}/bin/seatd -g wheel";
    #   serviceConfig = {
    #     Type = "simple";
    #     Restart = "always";
    #     RestartSec = "1";
    #   };
    #   wantedBy = ["multi-user.target"];
    # };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        wayland = true;
      }
    };
    # mullvad-vpn.enable = true;
    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "Hyprland";
    #       user = "spatola"; # TODO: Change this to your username
    #     };
    #     default_session = initial_session;
    #   };
    # };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
}