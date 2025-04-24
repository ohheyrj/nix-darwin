{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ggshield
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

