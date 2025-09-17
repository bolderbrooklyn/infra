{ lib, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then null else pkgs.opencode;

    settings = {
      theme = "catppuccin";
    };
  };
}
// lib.mkIf pkgs.stdenv.isDarwin {
  homebrew.brews = [
    "opencode"
  ];
}
