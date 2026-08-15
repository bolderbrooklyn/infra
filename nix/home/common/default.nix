{
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../../common/modules/1password/hm.nix
    ../../common/modules/agent-instructions/hm.nix
    ../../common/modules/antigravity-cli/hm.nix
    ../../common/modules/bat/hm.nix
    ../../common/modules/btop/hm.nix
    ../../common/modules/buku/hm.nix
    ../../common/modules/catppuccin/hm.nix
    ../../common/modules/claude-code/hm.nix
    ../../common/modules/codex/hm.nix
    ../../common/modules/copilot-cli/hm.nix
    ../../common/modules/crush/hm.nix
    ../../common/modules/devenv/hm.nix
    ../../common/modules/docker/hm.nix
    ../../common/modules/eza/hm.nix
    ../../common/modules/fd/hm.nix
    ../../common/modules/fish/hm.nix
    ../../common/modules/fzf/hm.nix
    ../../common/modules/gcloud-cli/hm.nix
    ../../common/modules/git/hm.nix
    ../../common/modules/gnupg/hm.nix
    ../../common/modules/kubectl/hm.nix
    ../../common/modules/mise/hm.nix
    ../../common/modules/nushell/hm.nix
    ../../common/modules/nvim/hm.nix
    ../../common/modules/opencode/hm.nix
    ../../common/modules/openssh/hm.nix
    ../../common/modules/pi-coding-agent/hm.nix
    ../../common/modules/powershell/hm.nix
    ../../common/modules/rg/hm.nix
    ../../common/modules/starship/hm.nix
    ../../common/modules/tmux/hm.nix
    ../../common/modules/xonsh/hm.nix
    ../../common/modules/yazi/hm.nix
    ../../common/modules/zsh/hm.nix
    ../../common/profiles/gui/modules/alacritty/hm.nix
    ../../common/profiles/gui/modules/calibre/hm.nix
    ../../common/profiles/gui/modules/cursor/hm.nix
    ../../common/profiles/gui/modules/font/hm.nix
    ../../common/profiles/gui/modules/ghostty/hm.nix
    ../../common/profiles/gui/modules/kitty/hm.nix
    ../../common/profiles/gui/modules/neovide/hm.nix
    ../../common/profiles/gui/modules/obsidian/hm.nix
    ../../common/profiles/gui/modules/qutebrowser/hm.nix
    ../../common/profiles/gui/modules/rio/hm.nix
    ../../common/profiles/gui/modules/vscode/hm.nix
    ../../common/profiles/gui/modules/warp-terminal/hm.nix
    ../../common/profiles/gui/modules/zed/hm.nix
  ];

  options.common = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "brooklyn";
    };
  };

  config.nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        inherit (prev.lixPackageSets.latest)
          lix
          ;
      })
      inputs.llm-agents.overlays.shared-nixpkgs
      inputs.nix-obsidian-extensions.overlays.default
    ];
  };
}
