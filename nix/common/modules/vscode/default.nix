{ config, pkgs, ... }:
let
  inherit (config.common) username;
  inherit (config.gui) font;
in
{
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;

      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableMcpIntegration = true;
        enableUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
        ];

        userSettings = {
          "editor.autoIndentOnPaste" = true;
          "editor.fontSize" = font.size;
          "editor.fontFamily" = font.name;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.lineNumbers" = "relative";
          "json.schemaDownload.trustedDomains" = {
            "https://schemastore.azurewebsites.net/" = true;
            "https://raw.githubusercontent.com/" = true;
            "https://www.schemastore.org/" = true;
            "https://json.schemastore.org/" = true;
            "https://json-schema.org/" = true;
            "https://esm.sh" = true;
          };
          "vim.hlsearch" = true;
          "vim.showMarksInGutter" = true;
        };
      };
    };
  };
}
