{ pkgs, ... }:
{
  home-manager.users.kalmiya.home = {
    packages = with pkgs; [
      _1password-cli
      fd
      ffmpeg
      git
      jq
      nodejs
      python3
      ripgrep
      uv
    ];

    stateVersion = "26.05";
  };
}
