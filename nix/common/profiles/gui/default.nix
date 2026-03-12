{ config, ... }:
let
  inherit (config.common) username;
in
{
  imports = [
    ./modules/alacritty
    ./modules/calibre
    ./modules/ghostty
    ./modules/kitty
    ./modules/neovide
    ./modules/vscode
    ./modules/warp-terminal
    ./modules/zed
  ];

  brooklyn.programs = {
    neovide.enable = true;
    vscode.enable = true;
    warp-terminal.enable = true;
    zed-editor.enable = true;
  };

  home-manager.users.${username} = {
    programs = {
      zathura.enable = true;
    };
  };
}
