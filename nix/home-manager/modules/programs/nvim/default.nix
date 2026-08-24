{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.brooklyn.programs.nvim.enable = lib.mkEnableOption "nvim";

  config = lib.mkIf config.brooklyn.programs.nvim.enable {
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
        ghostscript
        go
        grpcurl
        icu
        imagemagick
        lua5_1
        luarocks
        lynx
        mermaid-cli
        nixd
        nixfmt
        pkg-config
        plantuml
        postgresql_18
        python3
        rust-analyzer
        shfmt
        sqlite
        statix
        tectonic
        texliveBasic
        tree-sitter
        unzip
        websocat
        wget

        texlivePackages.biber
        texlivePackages.latexmk

        (lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) llvm)
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

      initLua = ''
        require("config.lazy")
      '';
    };

    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
