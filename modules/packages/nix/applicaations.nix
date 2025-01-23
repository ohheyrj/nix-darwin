{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    exercism
    _1password-cli
  ];
}
