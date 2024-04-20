
# This Nix expression configures the dunst notification daemon.
{
  pkgs,  # Nixpkgs package set
  theme,  # Theme configuration
  ...
}: let
  inherit (theme) x;  # Inherit the 'x' attribute from the theme configuration
in {
  services.dunst = {
    enable = true;  # Enable the dunst service
    package = pkgs.dunst.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        owner = "sioodmy";
        repo = "dunst";
        rev = "6477864bd870dc74f9cf76bb539ef89051554525";
        sha256 = "FCoGrYipNOZRvee6Ks5PQB5y2IvN+ptCAfNuLXcD8Sc=";
      };
    });
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;  # Icon theme package
      name = "Papirus";  # Icon theme name
    };
    settings = with theme.colors; {
      global = {
        frame_color = "#${pink}95";  # Color for the notification frame
        separator_color = x pink;  # Color for the separator
        width = 220;  # Width of the notification
        height = 280;  # Height of the notification
        offset = "0x15";  # Offset of the notification
        font = "Lexend 12";  # Font for the notification
        corner_radius = 10;  # Corner radius of the notification
        origin = "top-center";  # Origin of the notification
        notification_limit = 3;  # Maximum number of notifications to display
        idle_threshold = 120;  # Threshold for idle notifications
        ignore_newline = "no";  # Whether to ignore newlines in notifications
        mouse_left_click = "close_current";  # Action on left click
        mouse_right_click = "close_all";  # Action on right click
        sticky_history = "yes";  # Whether to keep notification history
        history_length = 20;  # Length of the notification history
        show_age_threshold = 60;  # Threshold for showing notification age
        ellipsize = "middle";  # Ellipsize mode for long notifications
        padding = 10;  # Padding of the notification
        always_run_script = true;  # Whether to always run notification script
        frame_width = 2;  # Width of the notification frame
        transparency = 10;  # Transparency of the notification
        progress_bar = true;  # Whether to show progress bar
        progress_bar_frame_width = 0;  # Width of the progress bar frame
        highlight = x pink;  # Color for highlighting notifications
      };
      fullscreen_delay_everything.fullscreen = "delay";  # Delay mode for fullscreen notifications
      urgency_low = {
        background = "#${base}83";  # Background color for low urgency notifications
        foreground = x text;  # Foreground color for low urgency notifications
        timeout = 5;  # Timeout for low urgency notifications
      };
      urgency_normal = {
        background = "#${base}83";  # Background color for normal urgency notifications
        foreground = "#c6d0f5";  # Foreground color for normal urgency notifications
        timeout = 6;  # Timeout for normal urgency notifications
      };
      urgency_critical = {
        background = "#${base}83";  # Background color for critical urgency notifications
        foreground = x text;  # Foreground color for critical urgency notifications
        frame_color = "#${red}80";  # Color for the notification frame in critical urgency notifications
        timeout = 0;  # Timeout for critical urgency notifications
      };
    };
  };
}
{
  pkgs,
  theme,
  ...
}: let
  inherit (theme) x;
in {
  services.dunst = {
    enable = true;
    package = pkgs.dunst.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        owner = "sioodmy";
        repo = "dunst";
        rev = "6477864bd870dc74f9cf76bb539ef89051554525";
        sha256 = "FCoGrYipNOZRvee6Ks5PQB5y2IvN+ptCAfNuLXcD8Sc=";
      };
    });
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
    settings = with theme.colors; {
      global = {
        frame_color = "#${pink}95";
        separator_color = x pink;
        width = 220;
        height = 280;
        offset = "0x15";
        font = "Lexend 12";
        corner_radius = 10;
        origin = "top-center";
        notification_limit = 3;
        idle_threshold = 120;
        ignore_newline = "no";
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        sticky_history = "yes";
        history_length = 20;
        show_age_threshold = 60;
        ellipsize = "middle";
        padding = 10;
        always_run_script = true;
        frame_width = 2;
        transparency = 10;
        progress_bar = true;
        progress_bar_frame_width = 0;
        highlight = x pink;
      };
      fullscreen_delay_everything.fullscreen = "delay";
      urgency_low = {
        background = "#${base}83";
        foreground = x text;
        timeout = 5;
      };
      urgency_normal = {
        background = "#${base}83";
        foreground = "#c6d0f5";
        timeout = 6;
      };
      urgency_critical = {
        background = "#${base}83";
        foreground = x text;
        frame_color = "#${red}80";
        timeout = 0;
      };
    };
  };
}
