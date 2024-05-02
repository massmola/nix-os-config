{pkgs, lib, ...}: {

  services = {
    # for desktop environments
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon android-udev-rules];

    # collects messages from the kernel, early boot stages, and system processes, as well as any messages sent to syslog
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    # manage disk drives and related devices
    udisks2.enable = true;

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  systemd = {
    # Fedora enables these options by default. See the 10-oomd-* files here:
    # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
    oomd.enableRootSlice = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # system-wide programs
  environment.systemPackages = with pkgs; [
    wget
    netcat
    kitty
    curl
    git 
    du-dust
    unzip
    bat # cat clone with wings
    xclip # command line interface to the X11 clipboard
    wl-clipboard # Wayland clipboard manager
    # for cyberchallenge
    pkgs.wireguard-tools
    filezilla
    # login theme
    python3
    (callPackage ./sugar-candy.nix{}).sddm-sugar-candy-theme
    libsForQt5.qt5.qtgraphicaleffects
    # for games
    mangohud # display fps and other info
  ];

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  programs = {
    # enable steam
    steam.enable = true;
    steam.gamescopeSession.enable = true; # enable gamescope for steam

    # enable gamemode
    gamemode.enable = true;
  
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}