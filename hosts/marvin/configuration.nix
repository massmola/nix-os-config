# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "marvin";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable fakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  users.users.work = {
  isNormalUser = true;
  description = "work account";
  extraGroups = [ "wheel" "networkmanager" "docker"];  # Optional groups
  hashedPassword = "$6$9qX8k0blae/Ev1Vj$Uu6ptnWrQhyo6OnmKHXCGScw5nRdnGbKlxGJ1gDmKqyyvxDzfvW4dy/2nF4cfuuoNktBRmONPsjwOpbWambVB/";        # Use hashed password or `password` for plain text
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
    vscode
    git
    bat

    unzip         # extract files from .zip archives
    home-manager  # manage user configuration
    du-dust       # disk usage
    bat           # cat clone with wings
    htop          # interactive process viewer
    efitools      # EFI tools
    libfprint

    wget            # download files from the web
    curl            # transfer data with URLs
    netcat          # networking utility  
    kitty           # terminal emulator
    git             # version control
    xclip           # command line interface to the X11 clipboard
    wl-clipboard    # Wayland clipboard manager
    wireguard-tools # VPN
    filezilla       # FTP client
    python3         
    gnumake42       # make
    aria2           # download manager

            
    firefox-devedition-unwrapped
    firefox       # web browser
    tor-browser   # web browser
    thunderbird  # email client
    vscode          # code editor
    warp-terminal  # terminal
    telegram-desktop # chat
    
    # style
    swww    # for wallpapers  
    vlc 
  ];


  virtualisation = {
    # docker
    docker.enable = true;

    # waydroid
    waydroid.enable = true;
    lxd.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Start the driver at boot
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
