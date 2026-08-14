{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.gcloud-cli.enable = lib.mkEnableOption "gcloud-cli";

  config = lib.mkIf config.brooklyn.programs.gcloud-cli.enable {
    home.packages = with pkgs; [
      google-cloud-sdk
      google-cloud-sql-proxy
    ];
  };
}
