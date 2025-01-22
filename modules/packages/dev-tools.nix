{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    black
    go
    nodejs_22
    pipenv
    pre-commit
  ];
}
