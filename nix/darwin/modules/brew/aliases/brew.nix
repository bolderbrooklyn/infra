{ ... }:
{
  home.shellAliases = {
    bb = "brew bundle";
    bbg = "brew bundle --global";
    brewc = "brew cleanup";
    brewh = "brew home";
    brewi = "brew info";
    brewI = "brew install";
    brewL = "brew leaves";
    brewl = "brew list";
    brewo = "brew outdated";
    brews = "brew search";
    brewu = "brew upgrade";
    brewx = "brew uninstall";

    caskh = "brew home --cask";
    caski = "brew info --cask";
    caskI = "brew install --cask";
    caskl = "brew list --cask";
    casko = "brew outdated --cask";
    casks = "brew search --cask";
    casku = "brew upgrade --cask";
    caskx = "brew uninstall --cask";
  };
}
