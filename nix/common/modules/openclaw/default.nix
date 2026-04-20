{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (config.common) username;
in
{
  options.brooklyn.programs.openclaw = {
    enable = lib.mkEnableOption "openclaw";
  };

  config = lib.mkIf config.brooklyn.programs.openclaw.enable {
    home-manager.users.${username} =
      { ... }:
      {
        imports = [
          inputs.nix-openclaw.homeManagerModules.openclaw
        ];

        programs.openclaw = {
          enable = true;
          documents = ./config;

          config = {
            gateway.mode = "local";

            # Placeholder configuration
            # channels.telegram = {
            #   tokenFile = "/path/to/telegram-token";
            #   allowFrom = [ 12345678 ];
            # };
          };

          bundledPlugins = {
            summarize.enable = true;
            peekaboo.enable = false; # Currently broken for x86_64-linux upstream
          };
        };
      };
  };
}
