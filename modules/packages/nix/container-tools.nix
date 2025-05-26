{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dive
    trivy
    podman
    podman-tui
    podman-compose
    lens # Outdated
  ];
}
