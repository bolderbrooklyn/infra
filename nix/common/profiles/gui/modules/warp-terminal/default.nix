{
  inputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
in
{
  options.brooklyn.programs.warp-terminal = {
    enable = lib.mkEnableOption "warp-terminal";
  };

  config = lib.mkIf config.brooklyn.programs.warp-terminal.enable (
    {
      home-manager.users.${username} =
        { config, ... }:
        let
          warpDir = "${config.home.homeDirectory}/${if isDarwin then "." else ".config/"}warp";
        in
        {
          home.packages = lib.mkIf (!isDarwin) (
            with pkgs;
            [
              warp-terminal
            ]
          );

          home.file."${warpDir}/themes" = lib.mkIf config.catppuccin.enable {
            source = "${inputs.catppuccin-warp}/themes";
            recursive = true;
          };
        };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "warp" ]; # installing nix package gives error about requiring hfs on macos
    }
  );
}
