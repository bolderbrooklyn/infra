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
      home-manager.sharedModules = [ ./hm.nix ];
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "warp" ]; # installing nix package gives error about requiring hfs on macos
    }
  );
}
