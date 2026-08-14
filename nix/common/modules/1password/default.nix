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
  options.brooklyn.programs._1password = {
    enable = lib.mkEnableOption "1password";
  };

  config = lib.mkIf config.brooklyn.programs._1password.enable (
    {
      programs._1password.enable = !isDarwin;

      programs._1password-gui = {
        enable = !isDarwin;
      }
      // lib.mkIf (!isDarwin) (
        lib.optionalAttrs (lib.hasAttr "polkitPolicyOwners" config.programs._1password-gui) {
          polkitPolicyOwners = [ username ];
        }
      );

      home-manager.sharedModules = [ ./hm.nix ];
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [
        {
          name = "1password";
          args.appdir = "/Applications";
        }
      ];
    }
  );
}
