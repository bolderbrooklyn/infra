{
  config,
  pkgs,
  agenix,
  ...
}:
{
  imports = [
    agenix.homeManagerModules.default
    ../../common
  ];

  common.username = "brooklyn";

  brooklyn.programs = {
    pi-coding-agent.enable = true;
  };

  home = {
    username = "brooklyn";
    homeDirectory = "/home/brooklyn";
    stateVersion = "26.05";
  };

  age.identityPaths = [
    "${config.home.homeDirectory}/.ssh/id_ed25519"
  ];

  home.shellAliases = {
    l = "ls -alh";
  };

  home.packages = with pkgs; [
    httpie
    pkg-config
  ];

  programs = {
    home-manager.enable = true;

    git.settings = {
      core.sshCommand = "/mnt/c/Windows/System32/OpenSSH/ssh.exe";
      gpg.ssh.program =
        "/mnt/c/Users/jesse/AppData/Local/Microsoft/WindowsApps/op-ssh-sign-wsl.exe";
    };

    ssh = {
      enable = true;
    };

    zoxide.enable = true;
  };

  services.home-manager = {
    autoExpire.enable = true;
  };

  xdg = {
    enable = true;
    localBinInPath = true;
  };
}
