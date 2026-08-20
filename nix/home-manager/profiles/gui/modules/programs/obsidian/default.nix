{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.brooklyn) font;
in
{
  options.brooklyn.programs.obsidian.enable = lib.mkEnableOption "obsidian";

  config.programs.obsidian = {
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
}
