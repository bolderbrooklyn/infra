{ pkgs, ... }:
{
  home-manager.users.kalmiya = {
    home = {
      packages = with pkgs; [
        _1password-cli
        fd
        ffmpeg
        git
        gnumake
        jq
        libffi
        llvm
        nodejs
        python3
        ripgrep
        uv
      ];

      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;

    xdg = {
      enable = true;
      localBinInPath = true;
    };
  };
}
