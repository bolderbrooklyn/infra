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
      package = inputs.llm-agents.packages.${pkgs.system}.opencode;

      settings = {
        autoupdate = false;
        default_agent = "plan";
        theme = "catppuccin";

        keybinds = {
          input_submit = "super+return,return";
        };
      };
    };
  };
}
