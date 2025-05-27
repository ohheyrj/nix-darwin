{ pkgs, custom-nix-packages, ... }:

{
  environment.systemPackages = [
    custom-nix-packages.packages.${pkgs.system}.garmin-basecamp
  ];
}
