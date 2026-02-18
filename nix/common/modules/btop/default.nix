{ config, ... }:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    programs.btop = {
      enable = true;

      settings = {
        vim_keys = true;
      };
    };
  };
}
