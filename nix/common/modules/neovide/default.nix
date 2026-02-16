{ config, ... }:
let
  inherit (config.common) username;
in
{
  home-manager.users.${username} = {
    programs.neovide = {
      enable = true;
    };
  };
}
