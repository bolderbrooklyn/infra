{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      buku
    ];
  };
}
