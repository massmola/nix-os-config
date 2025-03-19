# --------------------------------------------------------------
# This Home Manager configuration is shared between all hosts.
# --------------------------------------------------------------

{ pkgs, config, ... }:

{
  dconf = {
    enable = true;

    settings = {
      # Enables dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # Enables fractional scaling and sets it on 1.7 for my 2k monitor
      "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
      "org/gnome/desktop/interface".scaling-factor = 1.7;



    }
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Adds the 'hello' command to your environment. It prints a friendly
    # "Hello, world!" when run.
    hello

    # Cybersecurity tools
    wireshark # network analysis
    burpsuite # web app pentesting
    ngrok # tunneling

    # Gaming tools
    protonup # proton updater

    # Learning tools
    obsidian # note taking

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/spatola/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {

  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "MassimiIano";
    userEmail = "massimiliano.mola.bzs@gmail.com";
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      ".venv/"
      ".vscode/"
      "node_modules"
      "result"
      "result-*"
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      delta = {
        options.map-styles = "bold purple => syntax #ca9ee6, bold cyan => syntax #8caaee";
        line-numbers = true;
      };
    };

    aliases = {
      essa = "push --force";
      co = "checkout";
      fuck = "commit --amend -m";
      c = "commit -m";
      ca = "commit -am";
      forgor = "commit --amend --no-edit";
      graph = "log --all --decorate --graph --oneline";
      oops = "checkout --";
      l = "log";
      r = "rebase";
      s = "status --short";
      d = "diff";
      st = "status";
      br = "branch";
    };
  };

  # adds the develop shortkut to access my development shells
  programs.bash = {
    enable = true;
    initExtra = ''
      develop() {
        nix develop "github:massmola/nix-flakes#$1"
      }
    '';
  };

  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace'";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
