{
  config,
  lib,
  pkgs,
  ...
}:
let
  baseOhMyOpenAgent = builtins.fromJSON (builtins.readFile ./oh-my-openagent.base.jsonc);
in
{
  options.brooklyn.programs.opencode = {
    enable = lib.mkEnableOption "opencode";

    ohMyOpenAgentOverrides = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Per-host overrides deep-merged into oh-my-openagent.jsonc on top of oh-my-openagent.base.jsonc.";
    };
  };

  config = lib.mkIf config.brooklyn.programs.opencode.enable {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;

      extraPackages = with pkgs; [
        bun
        nodejs-slim
      ];

      settings = {
        autoupdate = false;
        formatter = { };
        lsp = { };

        plugin = [
          "oh-my-openagent@latest"
        ];
      };

      tui = {
        theme = lib.mkForce "catppuccin-mocha";
      };
    };

    xdg.configFile."opencode/tui.json".force = true;

    xdg.configFile."opencode/oh-my-openagent.jsonc".text = builtins.toJSON (
      lib.recursiveUpdate baseOhMyOpenAgent config.brooklyn.programs.opencode.ohMyOpenAgentOverrides
    );
  };
}
