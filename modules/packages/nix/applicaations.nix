{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    exercism
    gimp
    _1password-cli
    chatgpt
    brave
  ];
}
