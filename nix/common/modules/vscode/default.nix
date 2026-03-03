{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
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
          arrterian.nix-env-selector
          esbenp.prettier-vscode
          jnoortheen.nix-ide
          mkhl.direnv
          ms-azuretools.vscode-containers
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode.remote-explorer
          vscodevim.vim
        ];

        userSettings = {
          "editor.autoIndentOnPaste" = true;
          "editor.bracketPairColorization.enabled" = true;
          "editor.fontSize" = font.size;
          "editor.fontFamily" = font.name;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.guides.bracketPairs" = "active";
          "editor.lineHeight" = 1.618;
          "editor.lineNumbers" = "relative";
          "editor.renderWhitespace" = "boundary";
          "json.schemaDownload.trustedDomains" = {
            "https://esm.sh" = true;
            "https://json-schema.org/" = true;
            "https://json.schemastore.org/" = true;
            "https://raw.githubusercontent.com/" = true;
            "https://schemastore.azurewebsites.net/" = true;
            "https://www.schemastore.org/" = true;
          };
          "terminal.integrated.fontSize" = font.size;
          "terminal.integrated.lineHeight" = 1.309;
          "vim.hlsearch" = true;
          "vim.showMarksInGutter" = true;
        };
      };
    };
  };
}
// lib.optionalAttrs isDarwin {
  home-manager.users.${username} = {
    targets.darwin.defaults = {
      "com.microsoft.VSCode" = {
        ApplePressAndHoldEnabled = false;
      };
    };
  };
}
