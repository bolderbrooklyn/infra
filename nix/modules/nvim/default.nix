{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${config.common.username} = {
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
        imagemagick
        lua5_1
        luarocks
        lynx
        markdownlint-cli2
        nil
        nixd
        nixfmt-rfc-style
        python3
        ruby
        shfmt
        sqlite
        stylua
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
    };

    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
