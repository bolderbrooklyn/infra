{ config, ... }:
let
  guiEnable = config.brooklyn.gui.enable;
in
{
  imports = [
    ../..
  ];

  brooklyn = {
    catppuccin.enable = true;

    programs = {
      bat.enable = true;
      btop.enable = true;
      eza.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = guiEnable;
      git.enable = true;
      neovide.enable = guiEnable;
      nvim.enable = true;
      obsidian.enable = guiEnable;
      pi-coding-agent.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      tmux.enable = true;
    };
  };

  programs = {
    devenv.enable = true;
    zoxide.enable = true;
  };
}
