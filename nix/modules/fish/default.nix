{
  config,
  lib,
  pkgs,
  ...
}:
let
  fish = pkgs.fish;
  cfg = config.fish;
in
{
  options.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    defaultShell = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = cfg.enable;
      useBabelfish = true;
    };

    environment.shells = lib.mkIf cfg.defaultShell [ fish ];

    users.users.${config.common.username}.shell = lib.mkIf cfg.defaultShell fish;

    home-manager.users.${config.common.username} = {
      home.packages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.fishPlugins.macos ];

      programs.fish = {
        enable = cfg.enable;

        functions = {
          fish_greeting = "";
        };

        interactiveShellInit = ''
          string match -q "$TERM" alacritty; and not set -q TMUX; and exec tmux new-session -As0
          fish_vi_key_bindings
        '';
      };
    };
  };
}
