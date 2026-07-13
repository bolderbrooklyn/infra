{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.kubectl.enable = lib.mkEnableOption "kubectl";

  config = lib.mkIf config.brooklyn.programs.kubectl.enable {
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
  };
}
