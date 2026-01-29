{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    programs.opencode = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;

      rules = ./config/AGENTS.md;

      settings = {
        autoupdate = false;
        theme = "catppuccin";
        model = "google/gemini-3-pro-preview";

        keybinds = {
          input_submit = "super+return,return";
        };

        plugin = [
          "@tmegit/opencode-worktree-session@latest"
          "opencode-gemini-auth@latest"
          "opencode-wakatime@latest"
          "oh-my-opencode@latest"
        ];
      };
    };

    xdg.configFile."opencode/oh-my-opencode.json" = {
      source = ./config/oh-my-opencode.json;
    };
  };
}
