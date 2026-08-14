{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  cfg = config.brooklyn.programs.cursor;
in
with lib;
{
  options.brooklyn.programs.cursor = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    cli.enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (
    {
      home-manager.sharedModules = [ ./hm.nix ];
    }
    // optionalAttrs isDarwin {
      homebrew.casks = [ "cursor" ];
    }
  );
}
