{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.pi-coding-agent.enable = lib.mkEnableOption "pi-coding-agent";

  config = lib.mkIf config.brooklyn.programs.pi-coding-agent.enable {
    home-manager.users.${config.common.username} = { config, ... }: {
      home.file."${config.programs.pi-coding-agent.configDir}/mcp.json".text = builtins.toJSON {
        mcpServers = {
          context-mode = {
            command = "context-mode";
          };
        };
      };

      programs.pi-coding-agent = {
        enable = true;
        package = pkgs.llm-agents.pi;

        extraPackages = with pkgs; [
          nodejs
          bun
        ];

        settings = {
          collapseChangelog = true;
          defaultModel = "MiniMax-M3";
          defaultProvider = "minimax";
          defaultThinkingLevel = "high";
          quietStartup = true;
          terminal.showTerminalProgress = true;
          theme = "dark";

          packages = [
            "npm:@gotgenes/pi-permission-system"
            "npm:@hypabolic/pi-hypa"
            "npm:@plannotator/pi-extension"
            "npm:bigpowers"
            "npm:context-mode"
            "npm:pi-hashline-edit-pro"
            "npm:pi-hermes-memory"
            "npm:pi-lens"
            "npm:pi-mcp-adapter"
            "npm:pi-simplify"
            "npm:pi-subagents"
            "npm:pi-web-access"
            "npm:pi-workflow-engine"
          ];
        };
      };
    };
  };
}
