{ config, pkgs, ... }:
{
  home-manager.users.${config.common.username} = {
    home.packages = with pkgs; [
      kubectl
      kubernetes-helm
    ];

    programs.k9s.enable = true;

    programs.kubecolor = {
      enable = true;
      enableAlias = true;
    };
  };
}
