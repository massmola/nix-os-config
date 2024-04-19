{config, pkgs, user, ...}:
{
  programs.zsh.enable = true;
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.description;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [   ];
  };
}