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
    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        wayland = true;
      };
    # displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    };
    # mullvad-vpn.enable = true;
    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "Hyprland";
    #       user = "spatola";
    #     };
    #   default_session = initial_session;
    # };
  };

  #   security.polkit.enable = true;
  #   # Reboot/poweroff for unprivileged users
  #   security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (
  #       subject.isInGroup("users")
  #         && (
  #           action.id == "org.freedesktop.login1.reboot" ||
  #           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
  #           action.id == "org.freedesktop.login1.power-off" ||
  #           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
  #         )
  #       )
  #     {
  #       return polkit.Result.YES;
  #     }
  #   })
  # '';

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
  };
}