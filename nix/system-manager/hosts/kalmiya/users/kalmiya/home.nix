{ pkgs, ... }:
{
  home-manager.users.kalmiya.home = {
    packages = with pkgs; [
      git
      nodejs
      python3
      uv
      llm-agents.hermes-agent
    ];

    stateVersion = "26.05";
  };
}
