{
  config,
  inputs,
  lib,
  ...
}: {
  options.brooklyn.programs.openclaw = {
    enable = lib.mkEnableOption "openclaw";

    user = lib.mkOption {
      type = lib.types.str;
      default = config.common.username;
      description = "User account to enable openclaw for";
    };
  };

  config = lib.mkIf config.brooklyn.programs.openclaw.enable {
    nixpkgs.overlays = [
      inputs.nix-openclaw.overlays.default
    ];

    home-manager.users.${config.brooklyn.programs.openclaw.user} =
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
