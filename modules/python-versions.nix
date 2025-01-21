{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python39
    python310
  ];
}
