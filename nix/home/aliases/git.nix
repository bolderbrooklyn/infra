{ ... }:
let
  _git_status_ignore_submodules = "none";
in
{
  home.shellAliases = {
    __git_branch_current = "git rev-parse --abbrev-ref HEAD";

    # Git
    g = "git";

    # Branch (b)
    gb = "git branch";
    gba = "git branch --all --verbose";
    gbc = "git checkout -b";
    gbd = "git branch --delete";
    gbD = "git branch --delete --force";
    gbl = "git branch --verbose";
    gbL = "git branch --all --verbose";
    gbm = "git branch --move";
    gbM = "git branch --move --force";
    gbr = "git branch --move";
    gbR = "git branch --move --force";
    gbs = "git show-branch";
    gbS = "git show-branch --all";
    gbv = "git branch --verbose";
    gbV = "git branch --verbose --verbose";
    gbx = "git branch --delete";
    gbX = "git branch --delete --force";

    # Commit (c)
    gc = "git commit --verbose";
    gca = "git commit --verbose --all";
    gcm = "git commit --message";
    gcS = "git commit -S --verbose";
    gcSa = "git commit -S --verbose --all";
    gcSm = "git commit -S --message";
    gcam = "git commit --all --message";
    gco = "git checkout";
    gcO = "git checkout --patch";
    gcf = "git commit --amend --reuse-message HEAD";
    gcSf = "git commit -S --amend --reuse-message HEAD";
    gcF = "git commit --verbose --amend";
    gcSF = "git commit -S --verbose --amend";
    gcp = "git cherry-pick --ff";
    gcP = "git cherry-pick --no-commit";
    gcr = "git revert";
    gcR = "git reset \"HEAD^\"";
    gcs = "git show";
    gcsS = "git show --pretty=short --show-signature";
    gcl = "git-commit-lost";
    gcy = "git cherry -v --abbrev";
    gcY = "git cherry -v";

    # Conflict (C)
    gCl = "git --no-pager diff --name-only --diff-filter=U";
    gCa = "git add $(gCl)";
    gCe = "git mergetool $(gCl)";
    gCo = "git checkout --ours --";
    gCO = "gCo $(gCl)";
    gCt = "git checkout --theirs --";
    gCT = "gCt $(gCl)";

    # Data (d)
    gd = "git ls-files";
    gdc = "git ls-files --cached";
    gdx = "git ls-files --deleted";
    gdm = "git ls-files --modified";
    gdu = "git ls-files --other --exclude-standard";
    gdk = "git ls-files --killed";
    gdi = "git status --porcelain --short --ignored | sed -n \"s/^!! //p\"";

    # Fetch (f)
    gf = "git fetch";
    gfa = "git fetch --all";
    gfc = "git clone";
    gfcr = "git clone --recurse-submodules";
    gfm = "git pull";
    gfr = "git pull --rebase";

    # Flow (F)
    gFi = "git flow init";
    gFf = "git flow feature";
    gFb = "git flow bugfix";
    gFl = "git flow release";
    gFh = "git flow hotfix";
    gFs = "git flow support";

    gFfl = "git flow feature list";
    gFfs = "git flow feature start";
    gFff = "git flow feature finish";
    gFfp = "git flow feature publish";
    gFft = "git flow feature track";
    gFfd = "git flow feature diff";
    gFfr = "git flow feature rebase";
    gFfc = "git flow feature checkout";
    gFfm = "git flow feature pull";
    gFfx = "git flow feature delete";

    gFbl = "git flow bugfix list";
    gFbs = "git flow bugfix start";
    gFbf = "git flow bugfix finish";
    gFbp = "git flow bugfix publish";
    gFbt = "git flow bugfix track";
    gFbd = "git flow bugfix diff";
    gFbr = "git flow bugfix rebase";
    gFbc = "git flow bugfix checkout";
    gFbm = "git flow bugfix pull";
    gFbx = "git flow bugfix delete";

    gFll = "git flow release list";
    gFls = "git flow release start";
    gFlf = "git flow release finish";
    gFlp = "git flow release publish";
    gFlt = "git flow release track";
    gFld = "git flow release diff";
    gFlr = "git flow release rebase";
    gFlc = "git flow release checkout";
    gFlm = "git flow release pull";
    gFlx = "git flow release delete";

    gFhl = "git flow hotfix list";
    gFhs = "git flow hotfix start";
    gFhf = "git flow hotfix finish";
    gFhp = "git flow hotfix publish";
    gFht = "git flow hotfix track";
    gFhd = "git flow hotfix diff";
    gFhr = "git flow hotfix rebase";
    gFhc = "git flow hotfix checkout";
    gFhm = "git flow hotfix pull";
    gFhx = "git flow hotfix delete";

    gFsl = "git flow support list";
    gFss = "git flow support start";
    gFsf = "git flow support finish";
    gFsp = "git flow support publish";
    gFst = "git flow support track";
    gFsd = "git flow support diff";
    gFsr = "git flow support rebase";
    gFsc = "git flow support checkout";
    gFsm = "git flow support pull";
    gFsx = "git flow support delete";

    # Grep (g)
    gg = "git grep";
    ggi = "git grep --ignore-case";
    ggl = "git grep --files-with-matches";
    ggL = "git grep --files-without-matches";
    ggv = "git grep --invert-match";
    ggw = "git grep --word-regexp";

    # Index (i)
    gia = "git add";
    giA = "git add --patch";
    giu = "git add --update";
    gid = "git diff --no-ext-diff --cached";
    giD = "git diff --no-ext-diff --cached --word-diff";
    gii = "git update-index --assume-unchanged";
    giI = "git update-index --no-assume-unchanged";
    gir = "git reset";
    giR = "git reset --patch";
    gix = "git rm -r --cached";
    giX = "git rm -rf --cached";

    # Log (l)
    gl = "git log";
    gls = "git log --stat";
    gld = "git log --stat --patch --full-diff";
    glo = "git log --pretty=custom-oneline";
    glg = "git log --all --graph --pretty=custom-oneline";
    glb = "git log --pretty=custom-brief";
    glc = "git shortlog --summary --numbered";

    # Merge (m)
    gm = "git merge";
    gmC = "git merge --no-commit";
    gmF = "git merge --no-ff";
    gma = "git merge --abort";
    gmt = "git mergetool";

    # Push (p)
    gp = "git push";
    gpf = "git push --force-with-lease";
    gpF = "git push --force";
    gpa = "git push --all";
    gpA = "git push --all && git push --tags";
    gpt = "git push --tags";
    gpc = "git push --set-upstream origin $(__git_branch_current 2> /dev/null)";
    gpp = "git pull origin $(__git_branch_current 2> /dev/null) && git push origin (__git_branch_current 2> /dev/null)";

    # Rebase (r)
    gr = "git rebase";
    gra = "git rebase --abort";
    grc = "git rebase --continue";
    gri = "git rebase --interactive";
    grs = "git rebase --skip";

    # Remote (R)
    gR = "git remote";
    gRl = "git remote --verbose";
    gRa = "git remote add";
    gRx = "git remote rm";
    gRm = "git remote rename";
    gRu = "git remote update";
    gRp = "git remote prune";
    gRs = "git remote show";
    gRb = "git-hub-browse";

    # Stash (s)
    gs = "git stash";
    gsa = "git stash apply";
    gsx = "git stash drop";
    gsX = "git-stash-clear-interactive";
    gsl = "git stash list";
    gsL = "git-stash-dropped";
    gsd = "git stash show --patch --stat";
    gsp = "git stash pop";
    gsr = "git-stash-recover";
    gss = "git stash save --include-untracked";
    gsS = "git stash save --patch --no-keep-index";
    gsw = "git stash save --include-untracked --keep-index";

    # Submodule (S)
    gS = "git submodule";
    gSa = "git submodule add";
    gSf = "git submodule foreach";
    gSi = "git submodule init";
    gSI = "git submodule update --init --recursive";
    gSl = "git submodule status";
    gSm = "git-submodule-move";
    gSs = "git submodule sync";
    gSu = "git submodule update --recursive";
    gSU = "git submodule foreach git pull origin master";
    gSx = "git-submodule-remove";

    # Tag (t)
    gt = "git tag";
    gtl = "git tag -l";
    gts = "git tag -s";
    gtv = "git verify-tag";

    # Working Copy (w)
    gws = "git status --ignore-submodules=${_git_status_ignore_submodules} --short";
    gwS = "git status --ignore-submodules=${_git_status_ignore_submodules}";
    gwd = "git diff --no-ext-diff";
    gwD = "git diff --no-ext-diff --word-diff";
    gwr = "git reset --soft";
    gwR = "git reset --hard";
    gwc = "git clean -n";
    gwC = "git clean -f";
    gwx = "git rm -r";
    gwX = "git rm -rf";
  };
}
