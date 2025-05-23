# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "marvin";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable fakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spatola = {
    isNormalUser = true;
    description = "spatola";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    packages = with pkgs; [

    ];
  };

  users.users.ict = {
    isNormalUser = true;
    description = "ICT";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ]; # Optional groups
    hashedPassword = "$6$9qX8k0blae/Ev1Vj$Uu6ptnWrQhyo6OnmKHXCGScw5nRdnGbKlxGJ1gDmKqyyvxDzfvW4dy/2nF4cfuuoNktBRmONPsjwOpbWambVB/"; # Use hashed password or `password` for plain text
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [ libglvnd  ]);
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # essentials
    vim
    gh          # github cli
    glab        # giglab cli
    powershell  # powershell for linux
    bat         # cat clone with wings

    # system

    dconf
    unzip         # extract files from .zip archives
    home-manager  # manage user configuration
    du-dust       # disk usage
    bat           # cat clone with wings
    htop          # interactive process viewer
    efitools      # EFI tools
    libfprint

    # devtools
    wget              # download files from the web
    curl              # transfer data with URLs
    netcat            # networking utility
    git               # version control
    xclip             # command line interface to the X11 clipboard
    wl-clipboard      # Wayland clipboard manager
    wireguard-tools   # VPN
    filezilla         # FTP client
    gnumake42         # make
    aria2             # download manager
    direnv            # environment switcher (mainly for vscode enviroments)
    nixfmt-rfc-style  # nix formatter

    firefox           # web browser
    tor-browser       # web browser
    brave
    (pkgs.warp-terminal.override { waylandSupport = true; }) # terminal

    # style
    swww # for wallpapers
    vlc

    # social
    discord # chat client
    telegram-desktop # chat
    signal-desktop # chat

    # gaming
    bastet              # tetris
    teams-for-linux     # microsoft teams
    lutris

    wineWowPackages.stable
  ];



  environment.sessionVariables = {
    VSCODE_ENABLE_FEATURES = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    OZONE_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    WGPU_BACKEND = "vulkan";
    WINIT_UNIX_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ nerd-fonts.fira-code ];
  };

  hardware.graphics.enable = true;

  virtualisation = {
    # docker
    docker.enable = true;

    # waydroid
    waydroid.enable = true;
    lxd.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "spatola" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };


  # remove old nixos generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  # reduces disk space usage
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
