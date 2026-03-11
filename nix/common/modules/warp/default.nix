{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
{
  options.programs.warp-terminal = {
    enable = lib.mkEnableOption "warp-terminal";
  };

  config = lib.mkIf config.programs.warp-terminal.enable (
    {
      home-manager.users.${config.common.username} = {
        home.packages = lib.mkIf (!isDarwin) (
          with pkgs;
          [
            warp-terminal
          ]
        );
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "warp" ];
    }
  );
}
