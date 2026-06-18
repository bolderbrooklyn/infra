{
  config,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    home.packages = with pkgs.llm-agents; [
      crush
    ];

    xdg.configFile.crush = {
      source = ./config/crush;
      recursive = true;
    };
  };
}
