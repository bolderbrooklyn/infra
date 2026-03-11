{ config, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./modules/ghostty
    ./modules/neovide
    ./modules/warp-terminal
    ./modules/zed
  ];

  brooklyn.programs = {
    ghostty.enable = true;
    neovide.enable = true;
    warp-terminal.enable = true;
    zed-editor.enable = true;
  };

  home-manager.users.${username} = {
    programs = {
      zathura.enable = true;
    };
  };
}
