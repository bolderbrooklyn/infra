{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.brooklyn.programs.docker.enable {
    home.packages = with pkgs; [
      docker
      docker-buildx
      docker-compose
      docker-credential-helpers
    ];
  };
}
