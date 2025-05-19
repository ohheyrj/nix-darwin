{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    black
    devenv
    gitkraken
    go
    graphviz
    nodejs_22
    pipenv
    pre-commit
    statix
    ngrok
    undmg
  ];
}
