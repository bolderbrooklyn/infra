{
  inputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
{
  options.brooklyn.programs.warp-terminal = {
    enable = lib.mkEnableOption "warp-terminal";
  };

  config = lib.mkIf config.brooklyn.programs.warp-terminal.enable {
    home.packages = lib.mkIf (!isDarwin) (
      with pkgs;
      [
        warp-terminal
      ]
    );

    home.file."${config.home.homeDirectory}/.config/warp/themes" = lib.mkIf config.catppuccin.enable {
      source = "${inputs.catppuccin-warp}/themes";
      recursive = true;
    };
  };
}
