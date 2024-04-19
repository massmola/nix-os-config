{nixpkgs, self, ...}:
{
  virtualisation.docker.enable = true;
  users.users.spatola.extraGroups = [ "docker" ];
}