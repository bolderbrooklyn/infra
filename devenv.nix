{ pkgs, ... }:
{
  packages = with pkgs; [
    gnumake
    nil
    nixd
    nixfmt-rfc-style
  ];
}
