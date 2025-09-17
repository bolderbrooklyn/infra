{
  lib,
  options,
  pkgs,
  ...
}:
let
  useBrew = pkgs.stdenv.isDarwin;
in
{
  programs.opencode = {
    enable = true;
    package = if useBrew then null else pkgs.opencode;

    settings = {
      theme = "catppuccin";
    };
  };
}
// lib.mkIf useBrew (
  lib.optionalAttrs (builtins.hasAttr "homebrew" options) {
    homebrew.brews = [
      "opencode"
    ];
  }
)
