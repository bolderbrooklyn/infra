{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cascadia-code
  ];

  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./zed.nix
  ];
}
