{
  config,
  pkgs,
  inputs,
  ...
}:

let
  # Share R Markdown and editor packages between R and RStudio.
  rMarkdownPackages = with pkgs.rPackages; [
    rmarkdown
    knitr
    languageserver # VS Code completion, hover, and diagnostics.
  ];
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Linux 6.18.57 can load both ACPI button drivers, causing wake
  # notifications to trigger shutdown. Keep the normal button driver.
  boot.blacklistedKernelModules = [ "tiny_power_button" ];

  networking.hostName = "marvin";

  # Enable fakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Prebuilt packages for the llm-agents input (ChatGPT and OpenClaw).
  nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
  nix.settings.extra-trusted-public-keys = [
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Android container for the Hatch Dragons compatibility test.
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # Keep the classic D-Bus daemon so `nixos-rebuild switch` can continue
  # working after the 26.05 default changed to dbus-broker.
  services.dbus.implementation = "dbus";

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
  services.desktopManager.gnome.enable = true;

  services.displayManager = {
    gdm.enable = true;
  };

  # Fingerprint enrollment and authentication (including GNOME/GDM).
  services.fprintd.enable = true;

  # Keep working with the lid closed on AC; suspend on battery, including
  # when the charger is unplugged while the lid is already closed.
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "ignore";
  };

  # Work around a suspected suspend/session-freezer deadlock.
  # Oct 23-25 recovery logs repeatedly show user.slice failing to thaw.
  # Verify with a real suspend/resume cycle. Limit this to plain suspend;
  # hibernation keeps systemd's default session-freezing behavior.
  systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # touchpad and mouse support
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    cnijfilter2
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spatola = {
    isNormalUser = true;
    description = "spatola";
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "wireshark"
      "audio"
    ];
  };

  users.users.ict = {
    isNormalUser = true;
    description = "ICT";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "wireshark"
      "audio"
    ];
    hashedPassword = "$6$9qX8k0blae/Ev1Vj$Uu6ptnWrQhyo6OnmKHXCGScw5nRdnGbKlxGJ1gDmKqyyvxDzfvW4dy/2nF4cfuuoNktBRmONPsjwOpbWambVB/"; # Use hashed password or `password` for plain text
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  # Custom fingerprint driver and full GNOME support in gvfs.
  nixpkgs.overlays = [
    (final: prev: {
      # Use the restored upstream Brave recipe with this system's dependencies.
      # https://github.com/NixOS/nixpkgs/pull/584534
      brave = (prev.callPackage "${inputs.nixpkgs-fixes}/pkgs/applications/networking/browsers/brave" { }).brave;

      # The upstream recipe adds AWS-LC and other required system libraries.
      codex = prev.callPackage "${inputs.nixpkgs-fixes}/pkgs/by-name/co/codex/package.nix" { };

      # RStudio enumerates individual dictionaries; the aggregate repeats their
      # filenames and makes its dictionary symlink setup fail with "File exists".
      rstudio = prev.rstudio.override {
        hunspellDicts = builtins.removeAttrs prev.hunspellDicts [ "all" ];
      };

      # Goodix 27c6:5125 in this Huawei CREM-WXX9 is not supported upstream yet.
      # https://gitlab.freedesktop.org/libfprint/libfprint/-/merge_requests/648
      # Keep the driver's default guard against replacing an existing pairing;
      # do not set GOODIX5125_PROVISION_PSK=random here.
      libfprint = prev.libfprint.overrideAttrs (_: {
        version = "1.94.100-goodix5125";
        src = prev.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "Thomas97460";
          repo = "libfprint";
          rev = "8cef588bcf165ebf866bbb526b1d1f116888d4af";
          hash = "sha256-/M2Kp+gKptLconlInVEWLgG0YopgzhrIv355QBDmq3M=";
        };
      });

      gnome = prev.gnome.overrideScope (gfinal: gprev: {
        gvfs = gprev.gvfs.override {
          gnomeSupport = true;
        };
      });
    })
  ];
  programs.nix-ld.enable = true;
  # Enable Wireshark for network analysis
  programs.wireshark.enable = true;

  # direnv
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Programs
  environment.systemPackages = with pkgs; [
    # essentials
    vim
    gh # github cli
    glab # giglab cli
    oci-cli # Oracle Cloud Infrastructure CLI
    bat # cat clone with wings
    gnome-sound-recorder # audio recorder

    # system
    dconf
    jq
    unzip # extract files from .zip archives
    home-manager # manage user configuration
    dust # disk usage
    htop # interactive process viewer
    efitools # EFI tools
    libfprint

    # devtools
    wget # download files from the web
    curl # transfer data with URLs
    netcat # networking utility
    git # version control
    wl-clipboard # Wayland clipboard manager
    wireguard-tools # VPN
    openconnect # CLI client for AnyConnect-compatible VPNs
    networkmanager-openconnect # NetworkManager VPN service plugin
    filezilla # FTP client
    gnumake # make
    aria2 # download manager
    direnv # environment switcher (mainly for vscoide enviroments)
    nixfmt # nix formatter
    openssl # cryptography toolkit
    busybox # set of unix utilities
    codex # codex cli
    (let
      chatgpt = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt;
    in
      chatgpt.override {
        # The device-key native module needs TPM libraries missing upstream.
        chatgpt-unwrapped = chatgpt.unwrapped.overrideAttrs (old: {
          buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.tpm2-tss ];
        });
      })
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openclaw
    bubblewrap # required by codex
    micromamba
    python3
    (rWrapper.override { packages = rMarkdownPackages; })
    (rstudioWrapper.override { packages = rMarkdownPackages; })
    pandoc # Convert knitted Markdown into PDF via LaTeX.
    (texliveSmall.withPackages (
      ps: with ps; [
        framed
        titling
        upquote
        inconsolata
        fvextra
        xurl
        bookmark
      ]
    ))
    protege-distribution # ontology editor
    (pkgs.warp-terminal.override { waylandSupport = true; }) # terminal

    # web browsers
    brave
    firefox
    tor-browser # web browser
    google-chrome

    # office
    libreoffice

    # style
    awww # for wallpapers
    vlc # media player

    # social
    discord # chat client
    telegram-desktop # chat
    signal-desktop # chat
  ];

  # environment variables
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
    CHROME_BIN = "/run/current-system/sw/bin/google-chrome-stable";
    PUPPETEER_EXECUTABLE_PATH = "/run/current-system/sw/bin/google-chrome-stable";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ nerd-fonts.fira-code ];
  };

  # Enable OpenGL and Vulkan support
  hardware.graphics.enable = true;

  # docker
  virtualisation.docker = {
    enable = true;
    # Reclaim unused build cache automatically, targeting 10 GB of storage.
    daemon.settings.builder.gc = {
      enabled = true;
      defaultKeepStorage = "10GB";
    };
  };

  # Create a swap file
  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024; # 8GB swap file
    }
  ];

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

  programs.mtr.enable = true;

  # Create a symlink for codex to find bwrap
  system.activationScripts.bwrap-link = ''
    mkdir -p /usr/bin
    ln -sf ${pkgs.bubblewrap}/bin/bwrap /usr/bin/bwrap
  '';

  system.stateVersion = "23.11";

}
