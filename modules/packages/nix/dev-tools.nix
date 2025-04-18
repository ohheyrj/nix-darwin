{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    black
    devenv
    go
    nodejs_22
    pipenv
    pre-commit
  ];
}
