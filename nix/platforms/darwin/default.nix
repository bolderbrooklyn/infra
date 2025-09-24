{ config, ... }:
let
  username = config.common.username;
in
{
  imports = [
    ./home.nix
    ../common
    ../../modules/1password
    ../../modules/alacritty
    ../../modules/brew
    ../../modules/buku
    ../../modules/colima
    ../../modules/gemini-cli
    ../../modules/ghostty
    ../../modules/kubectl
    ../../modules/mise
    ../../modules/nushell
    ../../modules/opencode
    ../../modules/xonsh
    ../../modules/zed
  ];

  system.stateVersion = 6;

  system.primaryUser = username;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
