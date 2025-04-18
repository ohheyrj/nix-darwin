{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    black
    devenv
    gitkraken
    go
    nodejs_22
    pipenv
    pre-commit
  ];
}
