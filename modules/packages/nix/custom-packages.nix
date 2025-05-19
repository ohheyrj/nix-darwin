{ myrepo, ... }: {
  environment.systemPackages = with myrepo; [
    kobo-desktop
{ pkgs, custom-nix-packages, ... }:

{
  environment.systemPackages = [
    custom-nix-packages.packages.${pkgs.system}.kobo-desktop
  ];
}
