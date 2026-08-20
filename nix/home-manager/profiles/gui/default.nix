{ lib, ... }: {
  imports = [
    ./modules/ghostty
    ./modules/neovide
  ];

  options.brooklyn.gui.enable = lib.mkEnableOption "gui";
}
