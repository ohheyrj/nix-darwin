{ myrepo, ... }: {
  environment.systemPackages = with myrepo; [
    kobo-desktop
{ pkgs, custom-nix-packages, ... }:

{
  environment.systemPackages = [
    custom-nix-packages.packages.${pkgs.system}.kobo-desktop
    custom-nix-packages.packages.${pkgs.system}.chatterino  
    custom-nix-packages.packages.${pkgs.system}.garmin-basecamp
    custom-nix-packages.packages.${pkgs.system}.openaudible
    custom-nix-packages.packages.${pkgs.system}.ps-remote-play
  ];
}
