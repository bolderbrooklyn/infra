{
  imports = [
    ./modules/alacritty
    ./modules/calibre
    ./modules/cursor
    ./modules/ghostty
    ./modules/kitty
    ./modules/neovide
    ./modules/qutebrowser
    ./modules/rio
    ./modules/vscode
    ./modules/warp-terminal
    ./modules/zed
  ];

  brooklyn.programs = {
    ghostty.enable = true;
    neovide.enable = true;
    rio.enable = true;
    vscode.enable = true;
    zed-editor.enable = true;
  };
}
