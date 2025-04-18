{ config, pkgs, ... }:

{
  home = {
    username = "richard";
    stateVersion = "24.11";
    homeDirectory = /Users/richard;
  };
  programs.home-manager.enable = true;
  imports = [
    ./zsh.nix
  ];
}
