{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.fish.enable = lib.mkEnableOption "fish" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.fish.enable {
    home.packages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.fishPlugins.macos ];

    programs.fish = {
      enable = true;

      functions = {
        fish_greeting = "";

        fish_title = ''
          set -q argv[1]; or set argv fish
          echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
        '';

        lw = ''
          ls -alh (which $argv[1])
        '';

        take = ''
          mkdir -p $argv[1]
          cd $argv[1]
        '';
      };

      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
  };
}
