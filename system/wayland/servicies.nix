{pkgs, user, ...}: {
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
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
  
}