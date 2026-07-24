{ pkgs, ... }:
{
  home = {
    username = "kalmiya";
    homeDirectory = "/home/kalmiya";

    packages = with pkgs; [
      git
      nodejs
      python
      uv
      llm-agents.hermes-agent
    ];

    stateVersion = "26.05";
  };
}
