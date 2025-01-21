{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    postgresql_16
    mysql84
  ];
}
