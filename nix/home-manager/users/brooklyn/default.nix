{ config, pkgs, ... }:
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
      crush.enable = true;
      eza.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = guiEnable;
      git.enable = true;
      gnupg.enable = true;
      neovide.enable = guiEnable;
      nvim.enable = true;
      obsidian.enable = guiEnable;
      opencode.enable = true;
      pi-coding-agent.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      television.enable = true;
      tmux.enable = true;
    };
  };

  programs = {
    devenv.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };

  home = {
    packages = with pkgs; [
      httpie
      yq
    ];

    shellAliases = {
      l = "ls -alh";
    };
  };
}
