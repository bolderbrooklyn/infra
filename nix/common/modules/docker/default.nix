{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.docker.enable = lib.mkEnableOption "docker" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.docker.enable {
    home-manager.users.${config.common.username} = {
      home.packages = with pkgs; [
        docker
        docker-buildx
        docker-compose
        docker-credential-helpers
      ];
    };
  };
}
