{
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  inherit (config.common) username;
in
with lib;
{
  imports = [ ../font ];

  home-manager.users.${username} = {
    home.shellAliases.zed = mkIf (!isDarwin) "zeditor";

    programs.zed-editor = {
      enable = true;
      package = mkIf isDarwin null;

      extraPackages = mkIf (!isDarwin) (
        with pkgs;
        [
          nil
          nixd
          nixfmt
          nodejs
          statix
        ]
      );

      userSettings = {
        agent = {
          always_allow_tool_actions = true;
          default_model = {
            model = "claude-sonnet-4.5";
            provider = "copilot_chat";
          };
          default_profile = "ask";
          play_sound_when_agent_done = true;
          use_modifier_to_send = true;
        };

        agent_servers = {
          gemini.ignore_system_version = false;

          OpenCode = {
            type = "custom";
            command = "opencode";
            args = [ "acp" ];
          };
        };

        always_treat_brackets_as_autoclosed = true;
        auto_signature_help = true;
        base_keymap = "Atom";
        buffer_font_family = config.gui.font.name;
        buffer_font_size = config.gui.font.size;

        code_actions_on_format = {
          "source.fixAll" = true;
          "source.organizeImports" = true;
        };

        diagnostics.inline.enabled = true;

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

        icon_theme = mkForce {
          mode = "system";
          dark = "Catppuccin Mocha";
          light = "Catppuccin Latte";
        };

        indent_guides.coloring = "indent_aware";

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
          CSS = {
            language_servers = [ "tailwindcss-language-server" ];
          };
          Python = {
            language_servers = [
              "..."
              "ruff"
              "!pyright"
            ];
            formatter = [
              {
                language_server.name = "ruff";
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

        line_indicator_format = "short";

        lsp = {
          nil.settings = {
            nix.flake.autoArchive = true;
          };
        };

        minimap = {
          display_in = "all_editors";
          show = "always";
        };

        preview_tabs = {
          enable_keep_preview_on_code_navigation = true;
          enable_preview_from_file_finder = true;
        };

        project_panel.hide_root = true;
        relative_line_numbers = "enabled";
        seed_search_query_from_cursor = "selection";
        show_whitespaces = "boundary";

        tabs = {
          activate_on_close = "left_neighbour";
          file_icons = true;
          git_status = true;
          show_diagnostics = "all";
        };

        terminal.line_height = "comfortable";

        theme = mkForce {
          mode = "system";
          dark = "Catppuccin Mocha (Blur)";
          light = "Catppuccin Latte (Blur)";
        };

        use_smartcase_search = true;
        vim.use_smartcase_find = true;
        vim_mode = true;
      };

      userKeymaps = [
        {
          context = "Workspace";
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
// optionalAttrs isDarwin {
  homebrew.casks = [ "zed" ];
}
