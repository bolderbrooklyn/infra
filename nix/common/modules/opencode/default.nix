{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../catppuccin
    ../../profiles/gui/modules/warp-terminal
  ];

  options.brooklyn.programs.opencode = {
    enable = lib.mkEnableOption "opencode";

    ohMyOpenAgentOverrides = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Per-host overrides deep-merged into oh-my-openagent.jsonc on top of oh-my-openagent.base.jsonc.";
    };
  };

  config.home-manager.sharedModules = [ ./hm.nix ];
}
