{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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

