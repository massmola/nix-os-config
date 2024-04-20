# FILEPATH: /home/spatola/nix/home/desktop/tofi/default.nix

# This Nix expression defines the configuration for the Tofi application.
# Tofi is a command-line tool that allows users to select and copy emojis.
# The configuration includes the installation of the Tofi package and a custom shell script called "tofi-emoji".
# The "tofi-emoji" script reads a file containing emojis, prompts the user to select an emoji, copies it to the clipboard, and displays a notification.
# The configuration also sets various properties for the Tofi user interface, such as the size, font, colors, and padding.

{
  pkgs,
  theme,
  ...
}: let
  tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
    #!/bin/sh
    cat ${./emojis} | tofi --prompt-text "Emoji: " | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
in {
  home.packages = [pkgs.tofi tofi-emoji];
  xdg.configFile."tofi/config".text = with theme.colors; ''
    anchor = center
    width = 500
    height = 300
    horizontal = false
    font-size = 14
    prompt-text = "Run "
    font = monospace
    ascii-input = false
    outline-width = 5
    outline-color = #${surface0}
    border-width = 2
    border-color = #${accent}
    background-color = #${base}
    text-color = #${text}
    selection-color = #${accent}
    min-input-width = 120
    late-keyboard-init = true
    result-spacing = 10
    padding-top = 15
    padding-bottom = 15
    padding-left = 15
    padding-right = 15
  '';
}
