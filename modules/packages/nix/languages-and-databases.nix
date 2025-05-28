{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Database - Postgres
    postgresql_16

    # Language - Python
    python313
    python313Packages.pip
  ];
}
