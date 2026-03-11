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
  imports = [ ../font ];

  options.brooklyn.programs.zed-editor.enable = lib.mkEnableOption "zed-editor";

  config = lib.mkIf config.brooklyn.programs.zed-editor.enable (
    {
      home-manager.users.${username} = {
        home.shellAliases.zed = lib.mkIf (!isDarwin) "zeditor";

        programs.zed-editor = {
          enable = true;
          package = lib.mkIf isDarwin null;

          mutableUserDebug = false;
          mutableUserKeymaps = false;
          mutableUserSettings = false;
          mutableUserTasks = false;

          extraPackages = lib.mkIf (!isDarwin) (
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
              default_profile = "ask";
              play_sound_when_agent_done = true;
              use_modifier_to_send = true;
            };

            agent_servers = {
              gemini.ignore_system_version = false;
            };

            always_treat_brackets_as_autoclosed = true;
            auto_signature_help = true;
            base_keymap = "Atom";
            buffer_font_family = font.name;
            buffer_font_size = font.size;

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

            theme = {
              mode = "system";
            };

            title_bar.show_branch_icon = true;

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
                "ctrl-/" = "workspace::ToggleBottomDock";
              };
            }
            {
              context = "vim_mode == normal";
              use_key_equivalents = true;
              bindings = {
                "alt-j" = "editor::MoveLineDown";
                "alt-k" = "editor::MoveLineUp";
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
            {
              context = "Dock || Terminal || Editor";
              use_key_equivalents = true;
              bindings = {
                "ctrl-h" = "workspace::ActivatePaneLeft";
                "ctrl-j" = "workspace::ActivatePaneDown";
                "ctrl-k" = "workspace::ActivatePaneUp";
                "ctrl-l" = "workspace::ActivatePaneRight";
              };
            }
          ];
        };
      };
    }
    // lib.optionalAttrs isDarwin {
      homebrew.casks = [ "zed" ];
    }
  );
}
