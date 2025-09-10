{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      docker
      docker-buildx
      docker-compose
      docker-credential-helpers
    ];
  };
}
