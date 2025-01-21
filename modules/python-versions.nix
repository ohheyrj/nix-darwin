{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    python310
  ];
}
