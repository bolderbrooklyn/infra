{ pkgs, ... }:
{
  packages = with pkgs; [
    gnumake
    home-manager
    nixd
    nixfmt
    statix
  ];
}
