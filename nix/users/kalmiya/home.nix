{ pkgs, ... }:
{
  home = {
    username = "kalmiya";
    homeDirectory = "/home/kalmiya";

    packages = [ pkgs.llm-agents.hermes-agent ];

    stateVersion = "26.05";
  };
}
