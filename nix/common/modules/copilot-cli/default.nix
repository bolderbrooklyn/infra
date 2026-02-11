{
  config,
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      copilot-cli
    ];
  };
}
