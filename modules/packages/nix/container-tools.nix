{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dive
    docker-compose
    trivy
  ];
}
