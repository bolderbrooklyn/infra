{ pkgs, ... }:
{
  packages = with pkgs; [
    gnumake
    nixd
    nixfmt
    statix
  ];
}
