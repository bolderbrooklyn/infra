{
  config,
  lib,
  pkgs,
  ...
}:
let
  useCask = pkgs.stdenv.isDarwin;
in
{
  imports = [ ../font ];

  home-manager.users.${config.common.username} = {
    home.shellAliases.zed = lib.mkIf (!useCask) "zeditor";

    programs.zed-editor = {
      enable = true;
      package = lib.mkIf useCask null;

      extraPackages = lib.mkIf (!useCask) (
        with pkgs;
        [
          nil
          nixd
          nixfmt-rfc-style
          nodejs
          statix
        ]
      );

      userSettings = {
        agent = {
          default_model = {
            model = "claude-sonnet-4";
            provider = "copilot_chat";
          };
          use_modifier_to_send = true;
        };
        agent_servers.gemini.ignore_system_version = false;
        always_treat_brackets_as_autoclosed = true;
        auto_signature_help = true;
        base_keymap = "Atom";
        buffer_font_family = config.gui.font.name;
        buffer_font_size = config.gui.font.size;
        code_actions_on_format = {
          "source.fixAll" = true;
          "source.organizeImports" = true;
        };
        diagnostics = {
          inline = {
            enabled = true;
          };
        };
        features = {
          edit_prediction_provider = "copilot";
        };
        file_scan_exclusions = [
          "**/.devenv"
          "**/.direnv"
          "**/.git"
          "**/.svn"
          "**/.hg"
          "**/.jj"
          "**/.repo"
          "**/CVS"
          "**/.DS_Store"
          "**/Thumbs.db"
          "**/.classpath"
          "**/.settings"
        ];
        icon_theme = lib.mkForce {
          mode = "system";
          dark = "Catppuccin Mocha";
          light = "Catppuccin Latte";
        };
        indent_guides = {
          coloring = "indent_aware";
        };
        inlay_hints = {
          enabled = true;
          show_other_hints = false;
          show_type_hints = false;
        };
        journal = {
          hour_format = "hour24";
          path = "~/Documents";
        };
        languages = {
          Python = {
            language_servers = [
              "..."
              "ruff"
              "!pyright"
            ];
            formatter = [
              {
                language_server = {
                  name = "ruff";
                };
              }
            ];
          };
          Ruby = {
            language_servers = [
              "ruby-lsp"
              "rubocop"
              "!solargraph"
              "!sorbet"
              "!steep"
              "..."
            ];
          };
        };
        lsp = {
          nil.settings = {
            nix.flake.autoArchive = true;
          };
        };
        line_indicator_format = "short";
        minimap = {
          display_in = "all_editors";
          show = "always";
        };
        preview_tabs = {
          enable_keep_preview_on_code_navigation = true;
          enable_preview_from_file_finder = true;
        };
        project_panel = {
          hide_root = true;
        };
        relative_line_numbers = "enabled";
        seed_search_query_from_cursor = "selection";
        show_whitespaces = "boundary";
        tabs = {
          activate_on_close = "left_neighbour";
          file_icons = true;
          git_status = true;
          show_diagnostics = "all";
        };
        terminal = {
          line_height = "comfortable";
        };
        theme = lib.mkForce {
          mode = "system";
          dark = "Catppuccin Mocha";
          light = "Catppuccin Latte";
        };
        use_smartcase_search = true;
        vim = {
          use_smartcase_find = true;
        };
        vim_mode = true;
      };

      userKeymaps = [
        {
          context = "Editor";
          use_key_equivalents = true;
          bindings = {
            "cmd-i" = "assistant::InlineAssist";
          };
        }
        {
          context = "Workspace && !Terminal";
          use_key_equivalents = true;
          bindings = {
            "cmd-ctrl-r" = "task::Spawn";
          };
        }
        {
          context = "vim_mode == visual";
          use_key_equivalents = true;
          bindings = {
            "shift-s" = [
              "vim::PushAddSurrounds"
              { }
            ];
          };
        }
      ];
    };
  };
}
