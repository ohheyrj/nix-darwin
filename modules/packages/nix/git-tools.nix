{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ggshield
    gh
    ghq
    gitleaks
    gitlint
    gitmoji-cli
    glab
    bfg-repo-cleaner
    lazygit
    mr
  ];
}

