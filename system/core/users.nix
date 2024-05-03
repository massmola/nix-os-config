{config, pkgs, user, ...}:
{
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.description;
    extraGroups = [
      "wheel"
      "gitea"
      "docker"
      "systemd-journal"
      "vboxusers"
      "audio"
      "plugdev"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
      "power"
      "nix"
      "adbusers"
    ];
    packages = with pkgs; [   ];
  };
}