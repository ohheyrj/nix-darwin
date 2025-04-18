{ config, pkgs, ... }:

{
  home.username = "richard";
  home.stateVersion = "24.11";
  home.homeDirectory = /Users/richard;
  programs.home-manager.enable = true;
  imports = [
    ./zsh.nix
  ];
}
