{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
    home.sessionVariables = {
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;

      extraPackages = with pkgs; [
        ast-grep
        cargo
        go
        icu
        imagemagick
        lua5_1
        luarocks
        lynx
        markdownlint-cli2
        marksman
        nil
        nixfmt
        pkg-config
        python3
        rubocop
        ruby-lsp
        shfmt
        sqlite
        statix
        stylua
        plantuml
        tree-sitter
        unzip
        wget

        nodePackages.prettier

        (lib.mkIf (!pkgs.stdenv.isDarwin) llvm)
      ];

      extraLuaPackages =
        ps: with ps; [
          tiktoken_core
        ];

      extraWrapperArgs = [
        "--suffix"
        "PKG_CONFIG_PATH"
        ":"
        "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" [ pkgs.imagemagick.dev ]}"
      ];
    };

    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
