{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    postgresql_14
    postgresql_16
  ];
}
