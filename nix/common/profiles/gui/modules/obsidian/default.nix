{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  imports = [
    ../font
  ];

  options.brooklyn.programs.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.brooklyn.programs.obsidian.enable {
    home-manager.users.${username} = {
      programs.obsidian = {
        inherit (config.brooklyn.programs.obsidian) enable;

        cli.enable = true;

        defaultSettings = {
          app = {
            alwaysUpdateLinks = true;
            promptDelete = false;
            useMarkdownLinks = true;
            useTab = false;
            vimMode = true;
          };

          appearance = {
            monospaceFontFamily = font.name;
            translucency = true;
          };

          communityPlugins = with pkgs.obsidianPlugins; [
            iconic
            mcp-tools-istefox
            new-tab-plus
            obsidian-excalidraw-plugin
            realclaudian
            smart-connections
            tasknotes
          ];

          corePlugins = [
            {
              name = "sync";
              enable = false;
            }
          ];
        };
      };
    };
  };
}
