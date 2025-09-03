{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cascadia-code
  ];

  imports = [
    ./ghostty.nix
    ./zed.nix
  ];
}
