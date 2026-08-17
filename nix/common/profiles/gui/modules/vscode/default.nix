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
  imports = [
    ../font
    ../../../../modules/catppuccin
  ];

  options.brooklyn.programs.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf config.brooklyn.programs.vscode.enable (
    {
      home-manager.users.${username} = {
        programs.vscode = {
          enable = true;
          package = lib.mkIf isDarwin null;

          profiles.default = {
            enableExtensionUpdateCheck = true;
            enableMcpIntegration = true;
            enableUpdateCheck = true;

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
      }
      // lib.mkIf isDarwin {
        targets.darwin.defaults = {
          "com.microsoft.VSCode" = {
            ApplePressAndHoldEnabled = false;
          };
        };
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "visual-studio-code" ];
    }
  );
}
