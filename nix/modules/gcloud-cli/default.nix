{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      google-cloud-sdk
      google-cloud-sql-proxy
    ];
  };
}
