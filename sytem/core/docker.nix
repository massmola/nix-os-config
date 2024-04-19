{nixpkgs, self, user, ...}:
{
  virtualisation.docker.enable = true;
  users.users.spatola.extraGroups = [ "docker" ];
}