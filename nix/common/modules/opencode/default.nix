{
  config,
  lib,
  pkgs,
  ...
}:
let
  opencodePackage = pkgs.llm-agents.opencode;
in
{
  imports = [
    ../catppuccin
    ../../profiles/gui/modules/warp-terminal
  ];

  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = opencodePackage;
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
  };
}
