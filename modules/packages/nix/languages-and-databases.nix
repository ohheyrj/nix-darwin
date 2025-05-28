{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Database - Postgres
    postgresql_16

    # Language - Go
    go

    # Language - Node
    nodejs_22

    # Language - Python
    python313
    python313Packages.pip
  ];
}
