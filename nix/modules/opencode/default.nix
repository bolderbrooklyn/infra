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

      settings = {
        autoupdate = false;
        default_agent = "plan";
        theme = "catppuccin";

        keybinds = {
          input_submit = "super+return,return";
        };

        plugin = [
          "opencode-gemini-auth@latest"
        ];
      };
    };
  };
}
